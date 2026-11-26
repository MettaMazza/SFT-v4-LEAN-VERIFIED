import SFT.Chemistry.SequentialMechanism
namespace SFT.Chemistry.ReversibleKineticEquilibrium
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SequentialMechanism
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure RetainedDirectedTransition where
 transitionIdentity : HeldLabel
 entryState : HeldLabel
 exitState : HeldLabel
 orientation : HeldLabel
 conditionBoundary : HeldLabel
 observationStatus : HeldLabel
def makeDirectedTransition (identity entry exit orientation condition status : LabelInput) : Except String RetainedDirectedTransition := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-reversible-transition" then pure l else throw "reversible correspondence requires a registered directed transition"
  | .other=>throw "reversible correspondence requires a registered directed transition"
 let entry ← match entry with
  | .held l=>if Text.equal l.family "registered-reversible-state" then pure l else throw "a directed transition must retain two distinct registered states"
  | .other=>throw "a directed transition must retain two distinct registered states"
 let exit ← match exit with
  | .held l=>if Text.equal l.family "registered-reversible-state" then pure l else throw "a directed transition must retain two distinct registered states"
  | .other=>throw "a directed transition must retain two distinct registered states"
 if equalLabel entry exit then throw "a directed transition must retain two distinct registered states"
 let orientation ← match orientation with
  | .held l=>if Text.equal l.family "held-transition-orientation" then pure l else throw "transition direction is a held orientation, not a signed quantity"
  | .other=>throw "transition direction is a held orientation, not a signed quantity"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-reversible-condition" then pure l else throw "the reversible condition boundary must remain held"
  | .other=>throw "the reversible condition boundary must remain held"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-reversible-status" then pure l else throw "favorable, adverse and unresolved status must remain held"
  | .other=>throw "favorable, adverse and unresolved status must remain held"
 pure ⟨identity,entry,exit,orientation,condition,status⟩
structure CompleteReversiblePairGraph where
 pairIdentity : HeldLabel
 firstState : HeldLabel
 secondState : HeldLabel
 forwardTransition : RetainedDirectedTransition
 reverseTransition : RetainedDirectedTransition
def makeGraph (identity first second : LabelInput) (forward reverse : RetainedDirectedTransition) : Except String CompleteReversiblePairGraph := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-reversible-pair" then pure l else throw "reversible correspondence requires one registered state pair"
  | .other=>throw "reversible correspondence requires one registered state pair"
 let first ← match first with
  | .held l=>if Text.equal l.family "registered-reversible-state" then pure l else throw "a reversible pair requires two distinct registered states"
  | .other=>throw "a reversible pair requires two distinct registered states"
 let second ← match second with
  | .held l=>if Text.equal l.family "registered-reversible-state" then pure l else throw "a reversible pair requires two distinct registered states"
  | .other=>throw "a reversible pair requires two distinct registered states"
 if equalLabel first second then throw "a reversible pair requires two distinct registered states"
 if !(equalLabel forward.entryState first && equalLabel forward.exitState second && equalLabel reverse.entryState second && equalLabel reverse.exitState first) then
  throw "forward and reverse edges must close the same exact two-state graph"
 if equalLabel forward.orientation reverse.orientation then throw "forward and reverse held orientations must remain distinguishable"
 if !equalLabel forward.conditionBoundary reverse.conditionBoundary then throw "kinetic-equilibrium correspondence requires one exact held condition boundary"
 pure ⟨identity,first,second,forward,reverse⟩
structure ExactKineticEquilibriumCorrespondence where
 pairIdentity : HeldLabel
 recurrenceSupport : HeldLabel × HeldLabel
 directedTransitionWord : RetainedDirectedTransition × RetainedDirectedTransition
 graphEdgeCount : PositiveCount
 correspondenceIdentity : HeldLabel
inductive GraphInput where
 | graph (value : CompleteReversiblePairGraph)
 | other
def forcedReversibleKineticEquilibriumCorrespondence (input : GraphInput) : Except String ExactKineticEquilibriumCorrespondence := do
 let graph ← match input with
  | .graph g=>pure g
  | .other=>throw "correspondence requires one complete reversible pair graph"
 pure ⟨graph.pairIdentity,(graph.firstState,graph.secondState),(graph.forwardTransition,graph.reverseTransition),⟨2,by decide⟩,
  ⟨"exact-kinetic-equilibrium-correspondence","one-closed-pair-graph-supplies-directed-kinetic-occurrences-and-equilibrium-recurrence-support",rfl,rfl⟩⟩
structure RegisteredReversiblePair where
 sourceOccurrence : PositiveCount
 graph : CompleteReversiblePairGraph
def makePair (source : SequentialMechanism.CountInput) (graph : GraphInput) : Except String RegisteredReversiblePair := do
 let source ← match source with
  | .count n=>pure n
  | .other=>throw "reversible pair occurrence must be a positive count"
 let graph ← match graph with
  | .graph g=>pure g
  | .other=>throw "reversible family requires complete pair graphs"
 pure ⟨source,graph⟩
inductive PairInput where
 | pair (value : RegisteredReversiblePair)
 | other
structure CompleteReversibleFamily where
 orderedPairs : List RegisteredReversiblePair
def makeFamily (pairs : List PairInput) : Except String CompleteReversibleFamily := do
 if pairs.isEmpty then throw "a reversible family requires at least one complete pair"
 let pairs ← pairs.mapM fun row=>match row with
  | .pair p=>pure p
  | .other=>throw "a reversible family requires at least one complete pair"
 if !(pairs.zipIdx.all fun (p,i)=>p.sourceOccurrence.value==i+1) then throw "reversible pair occurrences must be complete and gap-free"
 let identities := pairs.map (fun p=>p.graph.pairIdentity)
 if (identities.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != pairs.length then
  throw "reversible pair identities must remain distinct"
 pure ⟨pairs⟩
def equalDirectedTransition (a b : RetainedDirectedTransition) : Bool :=
 equalLabel a.transitionIdentity b.transitionIdentity && equalLabel a.entryState b.entryState && equalLabel a.exitState b.exitState &&
 equalLabel a.orientation b.orientation && equalLabel a.conditionBoundary b.conditionBoundary && equalLabel a.observationStatus b.observationStatus
def equalCorrespondence (a b : ExactKineticEquilibriumCorrespondence) : Bool :=
 equalLabel a.pairIdentity b.pairIdentity && equalLabel a.recurrenceSupport.1 b.recurrenceSupport.1 && equalLabel a.recurrenceSupport.2 b.recurrenceSupport.2 &&
 equalDirectedTransition a.directedTransitionWord.1 b.directedTransitionWord.1 && equalDirectedTransition a.directedTransitionWord.2 b.directedTransitionWord.2 &&
 a.graphEdgeCount.value==b.graphEdgeCount.value && equalLabel a.correspondenceIdentity b.correspondenceIdentity
def appendReversiblePairPreservesCompleteFamily (family : CompleteReversibleFamily) (successor : RegisteredReversiblePair) : Except String Bool := do
 if successor.sourceOccurrence.value != family.orderedPairs.length+1 then throw "reversible successor must be the next positive source occurrence"
 let prior ← family.orderedPairs.mapM fun row=>forcedReversibleKineticEquilibriumCorrespondence (.graph row.graph)
 let extended ← makeFamily ((family.orderedPairs++[successor]).map PairInput.pair)
 let result ← extended.orderedPairs.mapM fun row=>forcedReversibleKineticEquilibriumCorrespondence (.graph row.graph)
 let retained := result.take prior.length
 pure (retained.length==prior.length && (retained.zip prior).all (fun (a,b)=>equalCorrespondence a b) && result.length==prior.length+1)
def witnessTransition (label entry exit orientation : String) (condition : String := "held-condition") : Except String RetainedDirectedTransition := do
 makeDirectedTransition (.held (← heldLabel "registered-reversible-transition" label))
  (.held (← heldLabel "registered-reversible-state" entry)) (.held (← heldLabel "registered-reversible-state" exit))
  (.held (← heldLabel "held-transition-orientation" orientation)) (.held (← heldLabel "held-reversible-condition" condition))
  (.held ⟨"held-reversible-status","retained",rfl,rfl⟩)
def witnessGraph (label first second : String) : Except String CompleteReversiblePairGraph := do
 makeGraph (.held (← heldLabel "registered-reversible-pair" label))
  (.held (← heldLabel "registered-reversible-state" first)) (.held (← heldLabel "registered-reversible-state" second))
  (← witnessTransition (Text.append label "-forward") first second "first-to-second")
  (← witnessTransition (Text.append label "-reverse") second first "second-to-first")
def base : Except String CompleteReversiblePairGraph := witnessGraph "pair-ab" "state-a" "state-b"
def baseResult : Except String ExactKineticEquilibriumCorrespondence := do
 forcedReversibleKineticEquilibriumCorrespondence (.graph (← base))
def sameGraphWitness : Except String Bool := do
 let r ← baseResult
 pure (equalLabel r.directedTransitionWord.1.entryState r.directedTransitionWord.2.exitState && equalLabel r.directedTransitionWord.1.exitState r.directedTransitionWord.2.entryState)
def kineticsWitness : Except String Bool := do
 let r ← baseResult
 pure (![r.directedTransitionWord.1.orientation].any (equalLabel r.directedTransitionWord.2.orientation))
def equilibriumWitness : Except String Bool := do
 let g ← base
 let r ← baseResult
 pure (equalLabel r.recurrenceSupport.1 g.firstState && equalLabel r.recurrenceSupport.2 g.secondState)
def successorWitness : Except String Bool := do
 let prior ← makePair (.count ⟨1,by decide⟩) (.graph (← base))
 let family ← makeFamily [.pair prior]
 let successor ← makePair (.count ⟨2,by decide⟩) (.graph (← witnessGraph "pair-cd" "state-c" "state-d"))
 appendReversiblePairPreservesCompleteFamily family successor
theorem sameGraph : sameGraphWitness=.ok true := rfl
theorem kinetics : kineticsWitness=.ok true := rfl
theorem equilibrium : equilibriumWitness=.ok true := rfl
theorem completeSuccessorFamily : successorWitness=.ok true := rfl
end SFT.Chemistry.ReversibleKineticEquilibrium
