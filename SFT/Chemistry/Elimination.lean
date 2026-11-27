import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.Elimination
open SFT.Host SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph
open AdditionTransform (sameLabels sameSupport sameSiteClass)
structure Result where
 reactionIdentity : HeldLabel
 source : State
 products : State
 productComponentCount : PositiveCount
 removedAdjacencies : List (HeldLabel × HeldLabel)
 removedBondCount : PositiveCount
 restoredMultiplicitySupports : List HeldLabel
 restoredLayerCount : PositiveCount
 productSiteClasses : List SiteClass
 relocatedSupports : List HeldLabel

def transform (reactionIdentity : HeldLabel) (source products : State) : Except String Result := do
 let inverse ← AdditionTransform.transform reactionIdentity products source
 if !sameLabels inverse.source.atoms source.atoms || !sameSupport (supports inverse.source) (supports source) then
  throw "elimination must retain every atom and held support occurrence"
 return ⟨reactionIdentity,source,products,inverse.sourceComponentCount,inverse.newAdjacencies,
  inverse.newBondCount,inverse.reducedMultiplicitySupports,inverse.reducedLayerCount,
  inverse.componentSiteClasses,inverse.relocatedSupports⟩

def extend (result : Result) (anchor freshAtom freshSupport : HeldLabel) : Except String Bool := do
 if !NucleophilicCarrier.contains result.products.atoms anchor || NucleophilicCarrier.contains result.products.atoms freshAtom then
  throw "elimination successor requires a retained anchor and fresh occurrence"
 let extension ← bond anchor freshAtom freshSupport
 let products ← state (← heldLabel "addition-state" (Text.append result.products.identity.label "-successor"))
  (result.products.atoms++[freshAtom]) (result.products.bonds++[extension]) result.products.freeSupports
 let source ← state (← heldLabel "addition-state" (Text.append result.source.identity.label "-successor"))
  (result.source.atoms++[freshAtom]) (result.source.bonds++[extension]) result.source.freeSupports
 let extended ← transform result.reactionIdentity source products
 return extended.productComponentCount.value == result.productComponentCount.value &&
  extended.removedAdjacencies.length == result.removedAdjacencies.length && (extended.removedAdjacencies.zip result.removedAdjacencies).all (fun (a,b) => NucleophilicCarrier.sameEdge a b) &&
  sameLabels extended.restoredMultiplicitySupports result.restoredMultiplicitySupports &&
  extended.productSiteClasses.length == result.productSiteClasses.length && (extended.productSiteClasses.zip result.productSiteClasses).all (fun (a,b) => sameSiteClass a b) &&
  sameLabels extended.relocatedSupports result.relocatedSupports &&
  (products.bonds.take (products.bonds.length-1)).length == result.products.bonds.length &&
  ((products.bonds.take (products.bonds.length-1)).zip result.products.bonds).all (fun (a,b) => sameBond a b) &&
  (source.bonds.take (source.bonds.length-1)).length == result.source.bonds.length &&
  ((source.bonds.take (source.bonds.length-1)).zip result.source.bonds).all (fun (a,b) => sameBond a b)

local infixr:65 " +++ " => Text.append
def makeState (label : String) (atoms : List HeldLabel) (bonds : List Bond) :=
 AdditionWitnesses.makeState label atoms bonds []
def additionWitness (site : String) (layers : Nat := 1) : Except String AdditionTransform.Result := do
 let left ← atom ("elim-" +++ site +++ "-left")
 let middle ← atom ("elim-" +++ site +++ "-middle")
 let right ← atom ("elim-" +++ site +++ "-right")
 let enteringLeft ← atom ("elim-" +++ site +++ "-enter-left")
 let enteringRight ← atom ("elim-" +++ site +++ "-enter-right")
 let atoms := [left,middle,right,enteringLeft,enteringRight]
 let baseLeft ← support ("elim-" +++ site +++ "-base-left")
 let baseRight ← support ("elim-" +++ site +++ "-base-right")
 let reduced ← (List.range layers).mapM fun n => support ("elim-" +++ site +++ "-layer-" +++ toString (n+1))
 let entering ← support ("elim-" +++ site +++ "-entering")
 let sourceBonds := [← bond left middle baseLeft,← bond middle right baseRight] ++
  (← reduced.mapM fun h => bond left middle h) ++ [← bond enteringLeft enteringRight entering]
 let (first,second) ← if Text.equal site "same" then pure (left,left)
  else if Text.equal site "adjacent" then pure (left,middle)
  else if Text.equal site "nonadjacent" then pure (left,right)
  else throw "unknown generated elimination site"
 let firstReduced ← match reduced with
  | [] => throw "tuple index out of range"
  | h::_ => pure h
 let terminalBonds := [← bond left middle baseLeft,← bond middle right baseRight,
  ← bond first enteringLeft firstReduced,← bond second enteringRight entering]
 let terminalBonds ← if layers>1 then do
  pure (terminalBonds ++ (← reduced.tail.mapM fun h => bond right enteringRight h))
  else pure terminalBonds
 AdditionTransform.transform (← heldLabel "registered-reaction" ("elim-" +++ site +++ "-inverse"))
  (← makeState ("elim-" +++ site +++ "-products") atoms sourceBonds)
  (← makeState ("elim-" +++ site +++ "-source") atoms terminalBonds)
def witnesses : Except String (List Bool) := do
 let sameAddition ← additionWitness "same"
 let adjacentAddition ← additionWitness "adjacent"
 let nonadjacentAddition ← additionWitness "nonadjacent"
 let same ← transform sameAddition.reactionIdentity sameAddition.terminal sameAddition.source
 let adjacent ← transform adjacentAddition.reactionIdentity adjacentAddition.terminal adjacentAddition.source
 let nonadjacent ← transform nonadjacentAddition.reactionIdentity nonadjacentAddition.terminal nonadjacentAddition.source
 let invalidRejected := match transform adjacent.reactionIdentity adjacent.source adjacent.source with
  | .error _ => true
  | .ok _ => false
 let classes := ([same,adjacent,nonadjacent].flatMap fun r => r.productSiteClasses).map fun row => row.label.label
 let anchor ← match nonadjacent.products.atoms with
  | _::a::_ => pure a
  | [] => throw "tuple index out of range"
  | [_] => throw "tuple index out of range"
 let successor ← extend nonadjacent anchor (← atom "elim-successor-atom") (← support "elim-successor-support")
 return [[same,adjacent,nonadjacent].all (fun r => r.removedBondCount.value == 2),
  sameLabels same.source.atoms same.products.atoms,
  sameSupport (supports adjacent.source) (supports adjacent.products),
  nonadjacent.removedAdjacencies.length == 2, adjacent.restoredLayerCount.value == 1,
  classes.all (fun c => ["same-site","adjacent-sites","non-adjacent-sites"].any (Text.equal c)) &&
   ["same-site","adjacent-sites","non-adjacent-sites"].all (fun c => classes.any (Text.equal c)),
  invalidRejected,successor]
end SFT.Chemistry.Elimination
