import SFT.Chemistry.AdditionTransform
import SFT.Chemistry.MolecularGraphEnumeration
namespace SFT.Chemistry.Rearrangement
open SFT.Host SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph
open AdditionTransform (sameLabels sameSupport)
abbrev Incidence := HeldLabel × HeldLabel
def incidence (state : State) (held : HeldLabel) : Except String Incidence :=
 match state.bonds.reverse.find? (fun b => DihedralTorsion.equalLabel b.heldSupport held) with
 | none => .error "held support has no closed incidence"
 | some b => .ok (endpoints b)
def atomIndex (ordering : List HeldLabel) (a : HeldLabel) : Except String Nat :=
 match ordering.zipIdx.find? (fun row => DihedralTorsion.equalLabel row.1 a) with
 | none => .error "atom is absent from the declared ordering"
 | some row => .ok row.2
def sameIndexEdge (a b : Nat × Nat) : Bool :=
 (a.1 == b.1 && a.2 == b.2) || (a.1 == b.2 && a.2 == b.1)
def unlabelledAdjacencies (state : State) (ordering : List HeldLabel) : Except String (List (Nat × Nat)) := do
 let pairs ← state.bonds.mapM fun b => do return (← atomIndex ordering b.left,← atomIndex ordering b.right)
 return pairs.foldl (fun acc e => if acc.any (sameIndexEdge e) then acc else acc++[e]) []
def mappedIndex (image : List Nat) (index : Nat) : Except String Nat :=
 match MolecularGraphEnumeration.atIndex image index with
 | none => .error "tuple index out of range"
 | some n => .ok n
def graphIsomorphic (source terminal : State) : Except String Bool := do
 if source.atoms.length != terminal.atoms.length || source.bonds.length != terminal.bonds.length then return false
 let sourceEdges ← unlabelledAdjacencies source source.atoms
 let terminalEdges ← unlabelledAdjacencies terminal terminal.atoms
 (MolecularGraphEnumeration.permutations (List.range source.atoms.length)).anyM fun image => do
  let mapped ← sourceEdges.mapM fun e => do return (← mappedIndex image e.1,← mappedIndex image e.2)
  return mapped.all (fun e => terminalEdges.any (sameIndexEdge e)) && terminalEdges.all (fun e => mapped.any (sameIndexEdge e))
def allIncidences : List HeldLabel → List Incidence
 | [] => []
 | a::rest => rest.map (fun b => (a,b)) ++ allIncidences rest
structure Result where
 reactionIdentity : HeldLabel
 source : State
 terminal : State
 movedSupports : List HeldLabel
 movedSupportCount : PositiveCount
 brokenIncidences : List Incidence
 formedIncidences : List Incidence
 candidateTargetIncidences : List (HeldLabel × List Incidence)
 pathClasses : List HeldLabel
 constitutionallyDegenerate : Bool

def transform (reactionIdentity : HeldLabel) (source terminal : State) : Except String Result := do
 if !Text.equal reactionIdentity.family "registered-reaction" then throw "rearrangement requires one registered reaction identity"
 if !sameLabels source.atoms terminal.atoms then throw "rearrangement must retain every atom occurrence in exact source order"
 if !sameSupport (supports source) (supports terminal) then throw "rearrangement must retain every held support occurrence"
 if (connectedComponents source).length != 1 || (connectedComponents terminal).length != 1 then
  throw "complete molecular rearrangement endpoints require one connected carrier"
 if !source.freeSupports.isEmpty || !terminal.freeSupports.isEmpty then
  throw "endpoint rearrangement records require every support incidence to be closed"
 let moved ← (supports source).filterM fun h => do
  return !NucleophilicCarrier.sameEdge (← incidence source h) (← incidence terminal h)
 let moved := sortLabels moved
 if moved.isEmpty then throw "rearrangement requires at least one exact adjacency change"
 let targets ← moved.mapM fun h => do
  let original ← incidence source h
  pure (h,(allIncidences source.atoms).filter fun e => !NucleophilicCarrier.sameEdge e original)
 let invalid ← targets.anyM fun (h,alternatives) => do
  let target ← incidence terminal h
  return !(alternatives.any (NucleophilicCarrier.sameEdge target))
 if invalid then throw "terminal incidence lies outside the complete generated alternative family"
 return ⟨reactionIdentity,source,terminal,moved,← count moved.length,
  ← moved.mapM (incidence source),← moved.mapM (incidence terminal),targets,
  [← heldLabel "rearrangement-path" "direct-held-support-relocation",← heldLabel "rearrangement-path" "opened-support-then-exact-reclosure"],
  ← graphIsomorphic source terminal⟩
def sameIncidences (xs ys : List Incidence) : Bool :=
 xs.length == ys.length && (xs.zip ys).all (fun (a,b) => NucleophilicCarrier.sameEdge a b)
def reverseReconstruction (result : Result) : Except String Bool := do
 let reverse ← transform result.reactionIdentity result.terminal result.source
 return sameLabels reverse.movedSupports result.movedSupports &&
  sameIncidences reverse.brokenIncidences result.formedIncidences &&
  sameIncidences reverse.formedIncidences result.brokenIncidences &&
  reverse.movedSupportCount.value == result.movedSupportCount.value
def extend (result : Result) (anchor freshAtom freshSupport : HeldLabel) : Except String Bool := do
 if !NucleophilicCarrier.contains result.source.atoms anchor || NucleophilicCarrier.contains result.source.atoms freshAtom then
  throw "rearrangement successor requires a retained anchor and fresh occurrence"
 let extension ← bond anchor freshAtom freshSupport
 let source ← state (← heldLabel "addition-state" (Text.append result.source.identity.label "-successor"))
  (result.source.atoms++[freshAtom]) (result.source.bonds++[extension]) result.source.freeSupports
 let terminal ← state (← heldLabel "addition-state" (Text.append result.terminal.identity.label "-successor"))
  (result.terminal.atoms++[freshAtom]) (result.terminal.bonds++[extension]) result.terminal.freeSupports
 let extended ← transform result.reactionIdentity source terminal
 return sameLabels extended.movedSupports result.movedSupports &&
  sameIncidences extended.brokenIncidences result.brokenIncidences && sameIncidences extended.formedIncidences result.formedIncidences &&
  (source.bonds.take (source.bonds.length-1)).length == result.source.bonds.length &&
  ((source.bonds.take (source.bonds.length-1)).zip result.source.bonds).all (fun (a,b) => sameBond a b) &&
  (terminal.bonds.take (terminal.bonds.length-1)).length == result.terminal.bonds.length &&
  ((terminal.bonds.take (terminal.bonds.length-1)).zip result.terminal.bonds).all (fun (a,b) => sameBond a b)
end SFT.Chemistry.Rearrangement
