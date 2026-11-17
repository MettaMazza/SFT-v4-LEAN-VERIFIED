import SFT.Chemistry.MulticentreSupport
namespace SFT.Chemistry.MolecularStateTransition
open SFT.Physics.CapabilityValues SFT.Host
open SFT.Chemistry.MulticentreSupport (sameLabel)

def forward : HeldLabel := ⟨"transition-orientation","forward-held",by rfl,by rfl⟩
def reverse : HeldLabel := ⟨"transition-orientation","reverse-held",by rfl,by rfl⟩
def bidirectional : HeldLabel := ⟨"transition-orientation","bidirectional-held",by rfl,by rfl⟩
def coupled : HeldLabel := ⟨"transition-orientation","coupled-without-direction",by rfl,by rfl⟩
def absent : HeldLabel := ⟨"transition-orientation","structurally-absent",by rfl,by rfl⟩

-- Preserve the source's identity test against its singleton EMPTY_ONE.
inductive Terminal where
 | state : HeldLabel → Terminal
 | emptyOne : Terminal
 | otherEmptyOne : String → Terminal
structure Transition where
 molecularCarrier : HeldLabel
 initialState : HeldLabel
 terminal : Terminal
 orientation : HeldLabel
 retainedRecord : HeldLabel

def terminalValue : Terminal → Value
 | .state x => .label x
 | .emptyOne => .emptyOne "empty-One"
 | .otherEmptyOne identity => .emptyOne identity

def terminalMatches : Terminal → HeldLabel → Bool
 | .state t,initial => sameLabel t initial
 | .emptyOne,_ => false
 | .otherEmptyOne _,_ => false

def construct (carrier initial : HeldLabel) (terminal : Terminal) (orientation record : HeldLabel) : Except String Transition := do
 if !Text.equal carrier.family "molecular-carrier" || !Text.equal initial.family "molecular-state" then
  throw "state transformation requires retained carrier and initial state"
 if !Text.equal record.family "transition-record" then
  throw "state transformation requires one retained observation record"
 if sameLabel orientation absent then
  match terminal with
  | .emptyOne => pure ()
  | .state _ => throw "absent transition must close its terminal coordinate structurally"
  | .otherEmptyOne _ => throw "absent transition must close its terminal coordinate structurally"
 else
  if !(sameLabel orientation forward || sameLabel orientation reverse || sameLabel orientation bidirectional || sameLabel orientation coupled) then
   throw "state transformation orientation is not generated"
  match terminal with
  | .state t =>
   if !Text.equal t.family "molecular-state" then
    throw "observed transformation requires a retained terminal state"
   if sameLabel t initial then throw "a transformation must retain a state distinction"
  | .emptyOne => throw "observed transformation requires a retained terminal state"
  | .otherEmptyOne _ => throw "observed transformation requires a retained terminal state"
 return ⟨carrier,initial,terminal,orientation,record⟩

def isObserved (t : Transition) : Bool := !sameLabel t.orientation absent

def observedTransition (m initial terminal : String) (orientation : HeldLabel) (record : String) : Except String Transition := do
 construct (← heldLabel "molecular-carrier" m) (← heldLabel "molecular-state" initial)
   (.state (← heldLabel "molecular-state" terminal)) orientation (← heldLabel "transition-record" record)

def absentTransition (m initial record : String) : Except String Transition := do
 construct (← heldLabel "molecular-carrier" m) (← heldLabel "molecular-state" initial)
   .emptyOne absent (← heldLabel "transition-record" record)

def composeTransitionPath (first second : Transition) : Except String (List Value) := do
 if !sameLabel first.molecularCarrier second.molecularCarrier || !isObserved first || !isObserved second then
  throw "transition composition requires two observed transformations on one carrier"
 if !terminalMatches first.terminal second.initialState then
  throw "transition path endpoints do not compose"
 return [.label first.molecularCarrier,.label first.initialState,terminalValue first.terminal,
   terminalValue second.terminal,.label first.orientation,.label second.orientation]

theorem compositionExact (first second : Transition) (word : List Value)
 (accepted : composeTransitionPath first second = .ok word) :
 word = [.label first.molecularCarrier,.label first.initialState,terminalValue first.terminal,
   terminalValue second.terminal,.label first.orientation,.label second.orientation] := by
 unfold composeTransitionPath at accepted
 cases guard : (!sameLabel first.molecularCarrier second.molecularCarrier || !isObserved first || !isObserved second) with
 | true => rw [guard] at accepted; cases accepted
 | false =>
  rw [guard] at accepted
  cases aligned : terminalMatches first.terminal second.initialState with
  | false => rw [aligned] at accepted; cases accepted
  | true => rw [aligned] at accepted; exact (Except.ok.inj accepted).symm

theorem matchingComposition (first second : Transition)
 (carrier : sameLabel first.molecularCarrier second.molecularCarrier = true)
 (firstObserved : isObserved first = true) (secondObserved : isObserved second = true)
 (aligned : terminalMatches first.terminal second.initialState = true) :
 composeTransitionPath first second = .ok [.label first.molecularCarrier,.label first.initialState,
   terminalValue first.terminal,terminalValue second.terminal,.label first.orientation,.label second.orientation] := by
 unfold composeTransitionPath
 rw [carrier,firstObserved,secondObserved,aligned]
 rfl

theorem composedWordLength (first second : Transition) (word : List Value)
 (accepted : composeTransitionPath first second = .ok word) : word.length = 6 := by
 rw [compositionExact first second word accepted]
 rfl

def observedWitness : Bool := match observedTransition "H2" "B" "C" bidirectional "B-C" with
 | .ok t => isObserved t
 | .error _ => false

def composedWitness : Bool := match observedTransition "H2" "B" "C" bidirectional "B-C",observedTransition "H2" "C" "X" forward "C-X" with
 | .ok first,.ok second => match composeTransitionPath first second with
   | .ok word => word.length == 6
   | .error _ => false
 | .error _,_ => false
 | .ok _,.error _ => false

def absentWitness : Bool := match absentTransition "H2" "X" "source-empty-transition-cell" with
 | .ok t => match t.terminal with
   | .emptyOne => !isObserved t
   | .state _ => false
   | .otherEmptyOne _ => false
 | .error _ => false

def mismatchWitness : Bool := match observedTransition "H2" "B" "C" bidirectional "B-C",observedTransition "H2" "E" "F" forward "E-F" with
 | .ok first,.ok second => match composeTransitionPath first second with
   | .error _ => true
   | .ok _ => false
 | .error _,_ => false
 | .ok _,.error _ => false

def selfWitness : Bool := match observedTransition "H2" "B" "B" forward "invalid" with
 | .error _ => true
 | .ok _ => false

set_option maxRecDepth 10000
set_option maxHeartbeats 20000000
theorem observedWitnessPassed : observedWitness = true := rfl
theorem composedWitnessPassed : composedWitness = true := rfl
theorem absentWitnessPassed : absentWitness = true := rfl
theorem mismatchWitnessPassed : mismatchWitness = true := rfl
theorem selfWitnessPassed : selfWitness = true := rfl
end SFT.Chemistry.MolecularStateTransition
