import SFT.Chemistry.Rearrangement
namespace SFT.Chemistry.RearrangementWitnesses
open SFT.Physics.CapabilityValues SFT.Host AdditionCarrier AdditionGraph Rearrangement
set_option maxRecDepth 20000
set_option maxHeartbeats 0
def singleMove : Except String Result := do
 transform (← heldLabel "registered-reaction" "rearr-single") (← state (← heldLabel "addition-state" "rearr-source") [(← atom "rearr-a"),(← atom "rearr-b"),(← atom "rearr-c"),(← atom "rearr-d")] [(← bond (← atom "rearr-a") (← atom "rearr-b") (← support "rearr-ab")),(← bond (← atom "rearr-b") (← atom "rearr-c") (← support "rearr-moving")),(← bond (← atom "rearr-c") (← atom "rearr-d") (← support "rearr-cd"))] []) (← state (← heldLabel "addition-state" "rearr-terminal") [(← atom "rearr-a"),(← atom "rearr-b"),(← atom "rearr-c"),(← atom "rearr-d")] [(← bond (← atom "rearr-a") (← atom "rearr-b") (← support "rearr-ab")),(← bond (← atom "rearr-a") (← atom "rearr-c") (← support "rearr-moving")),(← bond (← atom "rearr-c") (← atom "rearr-d") (← support "rearr-cd"))] [])
def threeMoves : Except String Result := do
 transform (← heldLabel "registered-reaction" "rearr-multi") (← state (← heldLabel "addition-state" "multi-source") [(← atom "multi-a"),(← atom "multi-b"),(← atom "multi-c"),(← atom "multi-d"),(← atom "multi-e")] [(← bond (← atom "multi-a") (← atom "multi-b") (← support "multi-base")),(← bond (← atom "multi-b") (← atom "multi-c") (← support "multi-first")),(← bond (← atom "multi-c") (← atom "multi-d") (← support "multi-second")),(← bond (← atom "multi-d") (← atom "multi-e") (← support "multi-third"))] []) (← state (← heldLabel "addition-state" "multi-terminal") [(← atom "multi-a"),(← atom "multi-b"),(← atom "multi-c"),(← atom "multi-d"),(← atom "multi-e")] [(← bond (← atom "multi-a") (← atom "multi-b") (← support "multi-base")),(← bond (← atom "multi-a") (← atom "multi-c") (← support "multi-first")),(← bond (← atom "multi-b") (← atom "multi-d") (← support "multi-second")),(← bond (← atom "multi-c") (← atom "multi-e") (← support "multi-third"))] [])
def degenerate : Except String Result := do
 transform (← heldLabel "registered-reaction" "rearr-degenerate") (← state (← heldLabel "addition-state" "deg-source") [(← atom "deg-a"),(← atom "deg-b"),(← atom "deg-c")] [(← bond (← atom "deg-a") (← atom "deg-b") (← support "deg-first")),(← bond (← atom "deg-b") (← atom "deg-c") (← support "deg-second")),(← bond (← atom "deg-a") (← atom "deg-c") (← support "deg-third"))] []) (← state (← heldLabel "addition-state" "deg-terminal") [(← atom "deg-a"),(← atom "deg-b"),(← atom "deg-c")] [(← bond (← atom "deg-a") (← atom "deg-c") (← support "deg-first")),(← bond (← atom "deg-a") (← atom "deg-b") (← support "deg-second")),(← bond (← atom "deg-b") (← atom "deg-c") (← support "deg-third"))] [])
def witnesses : Except String (List Bool) := do
 let single ← singleMove
 let multi ← threeMoves
 let degenerate ← degenerate
 let unchangedRejected := match transform single.reactionIdentity single.source single.source with
  | .error _ => true
  | .ok _ => false
 let compositionRejected := match (do
  let shortened ← state (← heldLabel "addition-state" "shortened")
   (single.source.atoms.take (single.source.atoms.length-1)) (single.source.bonds.take (single.source.bonds.length-1)) []
  transform single.reactionIdentity single.source shortened) with
  | .error _ => true
  | .ok _ => false
 let alternatives ← match single.candidateTargetIncidences with
  | [] => throw "tuple index out of range"
  | row::_ => pure row.2
 let anchor ← match single.source.atoms with
  | [] => throw "tuple index out of range"
  | a::_ => pure a
 let successor ← extend single anchor (← atom "rearr-successor-atom") (← support "rearr-successor-support")
 let firstFormed ← match single.formedIncidences with
  | [] => throw "tuple index out of range"
  | e::_ => pure e
 return [(connectedComponents single.source).length == (connectedComponents single.terminal).length && (connectedComponents single.terminal).length == 1,
  AdditionTransform.sameLabels single.source.atoms single.terminal.atoms && AdditionTransform.sameSupport (supports single.source) (supports single.terminal),
  single.movedSupportCount.value == 1 && !sameIncidences single.brokenIncidences single.formedIncidences,
  multi.movedSupportCount.value == 3,
  alternatives.length == 5 && alternatives.any (NucleophilicCarrier.sameEdge firstFormed),
  single.pathClasses.length == 2 && ((single.pathClasses.map HeldLabel.label).zip ["direct-held-support-relocation","opened-support-then-exact-reclosure"]).all (fun (a,b) => Text.equal a b),
  degenerate.constitutionallyDegenerate && degenerate.movedSupportCount.value == 3,
  ← reverseReconstruction multi,unchangedRejected,compositionRejected,successor]
end SFT.Chemistry.RearrangementWitnesses
