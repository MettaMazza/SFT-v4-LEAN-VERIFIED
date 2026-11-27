import SFT.Chemistry.AdditionGraph
namespace SFT.Chemistry.AdditionTransform
open SFT.Host SFT.Physics.CapabilityValues
open AdditionCarrier AdditionGraph
open DihedralTorsion (equalLabel)
open NucleophilicCarrier (contains sameEdge)
def sameLabels (xs ys : List HeldLabel) : Bool := xs.length == ys.length && (xs.zip ys).all (fun (x,y) => equalLabel x y)
def sameSupport (xs ys : List HeldLabel) : Bool := xs.all (contains ys) && ys.all (contains xs)
def bondBySupport (s : State) (held : HeldLabel) : Option Bond := (s.bonds.reverse.find? fun b => equalLabel b.heldSupport held)
def sameOptionalBond : Option Bond → Option Bond → Bool
 | none,none => true
 | some a,some b => sameBond a b
 | none,some _ | some _,none => false
def endpointSupports (s : State) (e : HeldLabel × HeldLabel) : List HeldLabel :=
 sortLabels ((s.bonds.filter fun b => sameEdge (endpoints b) e).map Bond.heldSupport)
def endpointKeys (s : State) : List (HeldLabel × HeldLabel) :=
 s.bonds.foldl (fun keys b => if keys.any (sameEdge (endpoints b)) then keys else keys ++ [endpoints b]) []
def orderedEndpoints (e : HeldLabel × HeldLabel) : HeldLabel × HeldLabel :=
 if Text.le e.1.label e.2.label then e else (e.2,e.1)
def edgeBefore (a b : HeldLabel × HeldLabel) : Bool :=
 let a := orderedEndpoints a; let b := orderedEndpoints b
 if Text.equal a.1.label b.1.label then Text.le a.2.label b.2.label else !(Text.le b.1.label a.1.label)
def componentOf (components : List (List HeldLabel)) (a : HeldLabel) : Nat := components.findIdx (fun c => contains c a)
def sourceComponents (s : State) : List (List HeldLabel) :=
 sortBy (fun a b =>
  (s.atoms.findIdx fun x => contains a x) ≤ (s.atoms.findIdx fun x => contains b x)) (connectedComponents s)
structure Result where
 reactionIdentity : HeldLabel
 source : State
 terminal : State
 sourceComponentCount : PositiveCount
 newAdjacencies : List (HeldLabel × HeldLabel)
 newBondCount : PositiveCount
 reducedMultiplicitySupports : List HeldLabel
 reducedLayerCount : PositiveCount
 componentSiteClasses : List SiteClass
 relocatedSupports : List HeldLabel
def transform (reactionIdentity : HeldLabel) (source terminal : State) : Except String Result := do
 if !Text.equal reactionIdentity.family "registered-reaction" then throw "addition requires one registered reaction identity"
 if !sameLabels source.atoms terminal.atoms then throw "every reactant atom occurrence must remain once in the product"
 if !sameSupport (supports source) (supports terminal) then throw "every held support occurrence must remain once in the product"
 let components := sourceComponents source
 if components.length < 2 || (connectedComponents terminal).length != 1 then throw "two or more complete source carriers must become one product"
 let sourceFree := source.freeSupports.map FreeSupport.heldSupport
 let terminalFree := terminal.freeSupports.map FreeSupport.heldSupport
 let changed := (supports source).filter fun h =>
  !sameOptionalBond (bondBySupport source h) (bondBySupport terminal h) || (contains sourceFree h != contains terminalFree h)
 let newAdjacencies := sortBy edgeBefore ((endpointKeys terminal).filter fun e => !(endpointKeys source).any (sameEdge e))
 if newAdjacencies.length != 2 then throw "the complete addition transform forms exactly two new adjacencies"
 let _ ← newAdjacencies.mapM fun e => do
  if componentOf components e.1 == componentOf components e.2 then throw "each new adjacency must join previously distinct source carriers"
  if (endpointSupports terminal e).isEmpty then throw "each new adjacency must carry a held support"
  pure ()
 let unchanged := (source.bonds.filter fun b => sameOptionalBond (some b) (bondBySupport terminal b.heldSupport)).map Bond.heldSupport
 let reduced := (source.bonds.filter fun b =>
  !sameOptionalBond (some b) (bondBySupport terminal b.heldSupport) && (endpointSupports source (endpoints b)).any (contains unchanged)).map Bond.heldSupport
 if reduced.isEmpty then throw "at least one exact source multiplicity layer must reduce"
 let siteClasses ← ((List.range components.length).mapM fun index => do
  let occurrences := (newAdjacencies.flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf components a == index)
  match occurrences with
  | a::b::rest =>
   if !rest.isEmpty then return []
   let separation ← shortestDistance source a b
   let label := match separation with
    | .emptyOne => "same-site"
    | .count n => if n.value == 1 then "adjacent-sites" else "non-adjacent-sites"
    | .otherEmptyOne _ => "non-adjacent-sites"
   let row ← siteClass (← count (index+1)) (← heldLabel "addition-site-class" label) separation
   pure [row]
  | [] => pure []
  | [_] => pure []).map List.flatten
 if siteClasses.isEmpty then throw "the complete transform must retain at least one exact attachment separation"
 return ⟨reactionIdentity,source,terminal,← count components.length,newAdjacencies,← count newAdjacencies.length,
  sortLabels reduced,← count reduced.length,siteClasses,sortLabels changed⟩
def sameSeparation : Separation → Separation → Bool
 | .emptyOne,.emptyOne => true
 | .count a,.count b => a.value == b.value
 | .otherEmptyOne a,.otherEmptyOne b => Text.equal a b
 | .emptyOne,.count _ | .emptyOne,.otherEmptyOne _ | .count _,.emptyOne | .count _,.otherEmptyOne _ | .otherEmptyOne _,.emptyOne | .otherEmptyOne _,.count _ => false
def sameSiteClass (a b : SiteClass) : Bool :=
 a.sourceComponentOrdinal.value == b.sourceComponentOrdinal.value && equalLabel a.label b.label && sameSeparation a.separation b.separation
def extend (result : Result) (anchor newAtom newSupport : HeldLabel) : Except String Bool := do
 if !contains result.source.atoms anchor || contains result.source.atoms newAtom then throw "addition successor requires one retained anchor and one fresh atom"
 let extension ← bond anchor newAtom newSupport
 let source ← state (← heldLabel "addition-state" (Text.append result.source.identity.label "-successor"))
  (result.source.atoms++[newAtom]) (result.source.bonds++[extension]) result.source.freeSupports
 let terminal ← state (← heldLabel "addition-state" (Text.append result.terminal.identity.label "-successor"))
  (result.terminal.atoms++[newAtom]) (result.terminal.bonds++[extension]) result.terminal.freeSupports
 let extended ← transform result.reactionIdentity source terminal
 return extended.sourceComponentCount.value == result.sourceComponentCount.value &&
  extended.newAdjacencies.length == result.newAdjacencies.length && (extended.newAdjacencies.zip result.newAdjacencies).all (fun (a,b) => sameEdge a b) &&
  sameLabels extended.reducedMultiplicitySupports result.reducedMultiplicitySupports &&
  extended.componentSiteClasses.length == result.componentSiteClasses.length && (extended.componentSiteClasses.zip result.componentSiteClasses).all (fun (a,b) => sameSiteClass a b) &&
  sameLabels extended.relocatedSupports result.relocatedSupports &&
  (source.bonds.take result.source.bonds.length).length == result.source.bonds.length &&
  ((source.bonds.take result.source.bonds.length).zip result.source.bonds).all (fun (a,b) => sameBond a b) &&
  (terminal.bonds.take result.terminal.bonds.length).length == result.terminal.bonds.length &&
  ((terminal.bonds.take result.terminal.bonds.length).zip result.terminal.bonds).all (fun (a,b) => sameBond a b)
end SFT.Chemistry.AdditionTransform
