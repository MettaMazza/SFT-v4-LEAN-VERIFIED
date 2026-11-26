import SFT.Chemistry.CompetingChannel
namespace SFT.Chemistry.SequentialMechanism
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure RetainedMechanismState where
 stateIdentity : HeldLabel
 occurrence : PositiveCount
 conditionIdentity : HeldLabel
 observationStatus : HeldLabel
def makeState (identity : LabelInput) (occurrence : CountInput) (condition status : LabelInput) : Except String RetainedMechanismState := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-mechanism-state" then pure l else throw "sequential mechanism requires a registered state identity"
  | .other=>throw "sequential mechanism requires a registered state identity"
 let occurrence ← match occurrence with
  | .count n=>pure n
  | .other=>throw "sequential mechanism requires a positive state occurrence"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-state-condition" then pure l else throw "sequential mechanism requires every state condition to remain held"
  | .other=>throw "sequential mechanism requires every state condition to remain held"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-observation-status" then pure l else throw "sequential mechanism requires measured, adverse or unresolved status"
  | .other=>throw "sequential mechanism requires measured, adverse or unresolved status"
 pure ⟨identity,occurrence,condition,status⟩
structure RetainedElementaryTransition where
 transitionIdentity : HeldLabel
 occurrence : PositiveCount
 entryStateIdentity : HeldLabel
 exitStateIdentity : HeldLabel
 conditionBoundary : HeldLabel
 transitionStatus : HeldLabel
def makeTransition (identity : LabelInput) (occurrence : CountInput) (entry exit condition status : LabelInput) : Except String RetainedElementaryTransition := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-elementary-transition" then pure l else throw "sequential mechanism requires a registered transition identity"
  | .other=>throw "sequential mechanism requires a registered transition identity"
 let occurrence ← match occurrence with
  | .count n=>pure n
  | .other=>throw "sequential mechanism requires a positive transition occurrence"
 let entry ← match entry with
  | .held l=>if Text.equal l.family "registered-mechanism-state" then pure l else throw "transition boundaries require registered state identities"
  | .other=>throw "transition boundaries require registered state identities"
 let exit ← match exit with
  | .held l=>if Text.equal l.family "registered-mechanism-state" then pure l else throw "transition boundaries require registered state identities"
  | .other=>throw "transition boundaries require registered state identities"
 if equalLabel entry exit then throw "an elementary transition must retain a state distinction"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-transition-condition" then pure l else throw "transition condition boundary must remain held"
  | .other=>throw "transition condition boundary must remain held"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-transition-status" then pure l else throw "transition status must remain held"
  | .other=>throw "transition status must remain held"
 pure ⟨identity,occurrence,entry,exit,condition,status⟩
inductive StateInput where
 | state (value : RetainedMechanismState)
 | other
inductive TransitionInput where
 | transition (value : RetainedElementaryTransition)
 | other
structure CompleteSequentialMechanism where
 reactionIdentity : HeldLabel
 orderedStates : List RetainedMechanismState
 orderedTransitions : List RetainedElementaryTransition
def makeMechanism (reaction : LabelInput) (states : List StateInput) (transitions : List TransitionInput) : Except String CompleteSequentialMechanism := do
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "registered-reaction" then pure l else throw "sequential mechanism requires a registered reaction"
  | .other=>throw "sequential mechanism requires a registered reaction"
 if states.length<2 then throw "sequential mechanism requires at least two retained states"
 let states ← states.mapM fun row=>match row with
  | .state row=>pure row
  | .other=>throw "sequential mechanism requires at least two retained states"
 if transitions.length != states.length-1 then throw "every adjacent retained state requires one elementary transition"
 let transitions ← transitions.mapM fun row=>match row with
  | .transition row=>pure row
  | .other=>throw "sequential mechanism transition word changed"
 if !(states.zipIdx.all fun (row,i)=>row.occurrence.value==i+1) then throw "state occurrence word must be complete and gap-free"
 if !(transitions.zipIdx.all fun (row,i)=>row.occurrence.value==i+1) then throw "transition occurrence word must be complete and gap-free"
 if !(((states.zip transitions).zip (states.drop 1)).all (fun ((a,e),b)=>equalLabel e.entryStateIdentity a.stateIdentity && equalLabel e.exitStateIdentity b.stateIdentity)) then
  throw "elementary transition does not meet its retained adjacent state boundaries"
 pure ⟨reaction,states,transitions⟩
inductive IntermediateCount where
 | positive (count : PositiveCount)
 | emptyOne
structure ExactSequentialComposition where
 reactionIdentity : HeldLabel
 initialState : RetainedMechanismState
 terminalState : RetainedMechanismState
 orderedStates : List RetainedMechanismState
 orderedTransitions : List RetainedElementaryTransition
 intermediateStates : List RetainedMechanismState
 transitionCount : PositiveCount
 intermediateCount : IntermediateCount
 compositionIdentity : HeldLabel
inductive MechanismInput where
 | mechanism (value : CompleteSequentialMechanism)
 | other
def forcedSequentialMechanismComposition (input : MechanismInput) : Except String ExactSequentialComposition := do
 let mechanism ← match input with
  | .mechanism m=>pure m
  | .other=>throw "sequential composition requires one complete mechanism word"
 let intermediate := (mechanism.orderedStates.drop 1).take (mechanism.orderedStates.length-2)
 let intermediateCount ← if intermediate.isEmpty then pure IntermediateCount.emptyOne else do
  pure (IntermediateCount.positive (← count intermediate.length))
 let first ← match mechanism.orderedStates.head? with | some s=>pure s | none=>throw "tuple index out of range"
 let last ← match mechanism.orderedStates.getLast? with | some s=>pure s | none=>throw "tuple index out of range"
 let transitionCount ← count mechanism.orderedTransitions.length
 pure ⟨mechanism.reactionIdentity,first,last,mechanism.orderedStates,mechanism.orderedTransitions,intermediate,transitionCount,intermediateCount,
  ⟨"exact-sequential-composition","every-state-edge-condition-status-and-shared-boundary-retained-once",rfl,rfl⟩⟩
def equalState (a b : RetainedMechanismState) : Bool :=
 equalLabel a.stateIdentity b.stateIdentity && a.occurrence.value==b.occurrence.value && equalLabel a.conditionIdentity b.conditionIdentity && equalLabel a.observationStatus b.observationStatus
def equalTransition (a b : RetainedElementaryTransition) : Bool :=
 equalLabel a.transitionIdentity b.transitionIdentity && a.occurrence.value==b.occurrence.value && equalLabel a.entryStateIdentity b.entryStateIdentity && equalLabel a.exitStateIdentity b.exitStateIdentity && equalLabel a.conditionBoundary b.conditionBoundary && equalLabel a.transitionStatus b.transitionStatus
def appendElementarySuccessorPreservesCompletePrefix (mechanism : CompleteSequentialMechanism) (state : RetainedMechanismState) (transition : RetainedElementaryTransition) : Except String Bool := do
 if state.occurrence.value != mechanism.orderedStates.length+1 then throw "successor state must be the next retained occurrence"
 if transition.occurrence.value != mechanism.orderedTransitions.length+1 then throw "successor transition must be the next retained occurrence"
 let last ← match mechanism.orderedStates.getLast? with | some s=>pure s | none=>throw "tuple index out of range"
 if !equalLabel transition.entryStateIdentity last.stateIdentity || !equalLabel transition.exitStateIdentity state.stateIdentity then
  throw "successor transition does not meet the prior terminal state"
 let prior ← forcedSequentialMechanismComposition (.mechanism mechanism)
 let extended ← makeMechanism (.held mechanism.reactionIdentity) ((mechanism.orderedStates++[state]).map StateInput.state)
  ((mechanism.orderedTransitions++[transition]).map TransitionInput.transition)
 let result ← forcedSequentialMechanismComposition (.mechanism extended)
 let states := result.orderedStates.take prior.orderedStates.length
 let transitions := result.orderedTransitions.take prior.orderedTransitions.length
 let intermediate := result.intermediateStates.take prior.intermediateStates.length
 pure (states.length==prior.orderedStates.length && (states.zip prior.orderedStates).all (fun (a,b)=>equalState a b) &&
  transitions.length==prior.orderedTransitions.length && (transitions.zip prior.orderedTransitions).all (fun (a,b)=>equalTransition a b) &&
  intermediate.length==prior.intermediateStates.length && (intermediate.zip prior.intermediateStates).all (fun (a,b)=>equalState a b))
def witnessState (name : String) (ordinal : Nat) : Except String RetainedMechanismState := do
 let identity ← heldLabel "registered-mechanism-state" name
 let occurrence ← count ordinal
 let condition ← heldLabel "held-state-condition" (Text.append "condition-" (toString ordinal))
 makeState (.held identity) (.count occurrence) (.held condition) (.held ⟨"held-observation-status","retained",rfl,rfl⟩)
def witnessTransition (name : String) (ordinal : Nat) (entry exit : String) : Except String RetainedElementaryTransition := do
 let identity ← heldLabel "registered-elementary-transition" name
 let occurrence ← count ordinal
 let entry ← heldLabel "registered-mechanism-state" entry
 let exit ← heldLabel "registered-mechanism-state" exit
 let condition ← heldLabel "held-transition-condition" (Text.append "boundary-" (toString ordinal))
 makeTransition (.held identity) (.count occurrence) (.held entry) (.held exit) (.held condition) (.held ⟨"held-transition-status","retained",rfl,rfl⟩)
def threeStateMechanism : Except String CompleteSequentialMechanism := do
 let a ← witnessState "state-a" 1
 let b ← witnessState "state-b" 2
 let c ← witnessState "state-c" 3
 let ab ← witnessTransition "edge-ab" 1 "state-a" "state-b"
 let bc ← witnessTransition "edge-bc" 2 "state-b" "state-c"
 makeMechanism (.held ⟨"registered-reaction","reaction-a",rfl,rfl⟩) [.state a,.state b,.state c] [.transition ab,.transition bc]
def completeWordWitness : Except String Bool := do
 let r ← forcedSequentialMechanismComposition (.mechanism (← threeStateMechanism))
 pure (r.orderedStates.length==3 && r.orderedTransitions.length==2)
def sharedBoundaryWitness : Except String Bool := do
 let r ← forcedSequentialMechanismComposition (.mechanism (← threeStateMechanism))
 pure (match r.orderedTransitions with | [a,b]=>equalLabel a.exitStateIdentity b.entryStateIdentity | [] | [_] | _::_::_::_=>false)
def intermediateWitness : Except String Bool := do
 let m ← threeStateMechanism
 let r ← forcedSequentialMechanismComposition (.mechanism m)
 pure (match r.intermediateStates,m.orderedStates.drop 1 with | [s],t::_=>equalState s t | [],_ | _::_::_,_ | [_],[]=>false)
def successorWitness : Except String Bool := do
 appendElementarySuccessorPreservesCompletePrefix (← threeStateMechanism) (← witnessState "state-d" 4) (← witnessTransition "edge-cd" 3 "state-c" "state-d")
theorem completeWord : completeWordWitness=.ok true := rfl
theorem sharedBoundary : sharedBoundaryWitness=.ok true := rfl
theorem retainedIntermediate : intermediateWitness=.ok true := rfl
theorem retainedSuccessorPrefix : successorWitness=.ok true := rfl
end SFT.Chemistry.SequentialMechanism
