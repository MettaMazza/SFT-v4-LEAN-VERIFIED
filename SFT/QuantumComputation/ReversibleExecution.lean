import SFT.QuantumComputation.ReversibleWitnesses
namespace SFT.QuantumComputation.ReversibleExecution
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleApplication

-- A derivation trace records actual successful source gate applications.
inductive Forward : State → List Gate → List State → State → Prop where
  | identity (state : State) : Forward state [] [] state
  | next (state result terminal : State) (gate : Gate) (gates : List Gate) (states : List State)
      (stateAdmitted : makeState state.branches state.phaseCycle = .ok state)
      (gateAdmitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
      (applied : applyGate state gate false = .ok result)
      (rest : Forward result gates states terminal) :
      Forward state (gate::gates) (state::states) terminal

inductive Backward : State → List Gate → State → Prop where
  | identity (state : State) : Backward state [] state
  | previous (state prior initial : State) (gate : Gate) (gates : List Gate)
      (applied : applyGate state (inverse gate) true = .ok prior)
      (rest : Backward prior gates initial) : Backward state (gate::gates) initial

theorem backwardSerial (terminal middle initial : State) (first second : List Gate)
    (one : Backward terminal first middle) (two : Backward middle second initial) :
    Backward terminal (first ++ second) initial := by
  induction one with
  | identity => exact two
  | previous state prior middle gate gates applied rest ih => exact .previous _ _ _ _ _ applied (ih two)

theorem completeInverse (initial terminal : State) (gates : List Gate) (states : List State)
    (trace : Forward initial gates states terminal) :
    ∃ reverseGates, Backward terminal reverseGates initial ∧ reverseGates.length = gates.length := by
  induction trace with
  | identity state => exact ⟨[],.identity state,rfl⟩
  | next state result terminal gate gates states stateAdmitted gateAdmitted applied rest ih =>
    obtain ⟨reverseGates,back,count⟩ := ih
    refine ⟨reverseGates ++ [gate],backwardSerial _ _ _ _ _ back
      (.previous result state state gate [] (applicationInverse state result gate stateAdmitted gateAdmitted applied) (.identity state)),?_⟩
    rw [SFT.Foundation.CommonRefinement.appendLength,count]
    rfl

theorem retainedPredecessorCount (initial terminal : State) (gates : List Gate) (states : List State)
    (trace : Forward initial gates states terminal) : states.length = gates.length := by
  induction trace with
  | identity => rfl
  | next _ _ _ _ _ _ _ _ _ _ ih => exact congrArg Nat.succ ih
def reverseOrder : List Gate → List Gate
  | [] => []
  | gate::rest => reverseOrder rest ++ [gate]

theorem exactInverseTrace (initial terminal : State) (gates : List Gate) (states : List State)
    (trace : Forward initial gates states terminal) : Backward terminal (reverseOrder gates) initial := by
  induction trace with
  | identity state => exact .identity state
  | next state result terminal gate gates states stateAdmitted gateAdmitted applied rest ih =>
    exact backwardSerial _ _ _ _ _ ih
      (.previous result state state gate [] (applicationInverse state result gate stateAdmitted gateAdmitted applied) (.identity state))

theorem forwardSerial (initial middle terminal : State) (first second : List Gate)
    (before after : List State) (one : Forward initial first before middle)
    (two : Forward middle second after terminal) : Forward initial (first ++ second) (before ++ after) terminal := by
  induction one with
  | identity => exact two
  | next state result middle gate gates states admitted valid applied rest ih =>
    exact .next _ _ _ _ _ _ admitted valid applied (ih two)

theorem stepRetainsCount (state result : State) (gate : Gate)
    (applied : applyGate state gate false = .ok result) : result.branches.length = state.branches.length :=
  transformedLength gate state.phaseCycle _ state.branches result.branches (applicationSource state result gate false applied).2.2

theorem fullSupportRetained (initial terminal : State) (gates : List Gate) (states : List State)
    (trace : Forward initial gates states terminal) : terminal.branches.length = initial.branches.length := by
  induction trace with
  | identity => rfl
  | next state result terminal gate gates states admitted valid applied rest ih =>
    exact ih.trans (stepRetainsCount state result gate applied)

theorem everyEarlierStateRetained (initial middle terminal : State) (first second : List Gate)
    (before after : List State) (one : Forward initial first before middle)
    (two : Forward middle second after terminal) (state : State) (held : state ∈ before) :
    ∃ states, Forward initial (first ++ second) states terminal ∧ state ∈ states :=
  ⟨before ++ after,forwardSerial _ _ _ _ _ _ _ one two,
   SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held⟩
end SFT.QuantumComputation.ReversibleExecution
