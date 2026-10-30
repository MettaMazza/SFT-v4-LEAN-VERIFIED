import SFT.InformationScience.QuantitySupport
import SFT.Mathematics.DiscreteComposition
import SFT.Mathematics.GeometryTopology
namespace SFT.QuantumComputation.ReversibleModel
open SFT.Mathematics.DiscreteObjects
abbrev Word := List String

structure Gate where
  wordMap : List (Word × Word)
  phaseSuccessors : List String
  deriving Repr

def validGate (gate : Gate) : Bool :=
  !gate.wordMap.isEmpty && distinct (gate.wordMap.map Prod.fst) &&
    distinct (gate.wordMap.map Prod.snd) && !gate.phaseSuccessors.isEmpty

def invertRows (rows : List (Word × Word)) : List (Word × Word) :=
  rows.map (fun row => (row.2,row.1))

def inverse (gate : Gate) : Gate := ⟨invertRows gate.wordMap, gate.phaseSuccessors⟩

theorem inverseSources (rows : List (Word × Word)) :
    (invertRows rows).map Prod.fst = rows.map Prod.snd := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.2) ih

theorem inverseTargets (rows : List (Word × Word)) :
    (invertRows rows).map Prod.snd = rows.map Prod.fst := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.1) ih

theorem inverseRowsTwice (rows : List (Word × Word)) : invertRows (invertRows rows) = rows := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row) ih

theorem inverseTwice (gate : Gate) : inverse (inverse gate) = gate := by
  cases gate with
  | mk rows successors =>
    change Gate.mk (invertRows (invertRows rows)) successors = Gate.mk rows successors
    rw [inverseRowsTwice]

theorem inverseNonempty (rows : List (Word × Word)) : (invertRows rows).isEmpty = rows.isEmpty := by
  cases rows <;> rfl

theorem inverseAdmission (gate : Gate) : validGate (inverse gate) = validGate gate := by
  unfold validGate inverse
  dsimp only
  rw [inverseSources,inverseTargets,inverseNonempty]
  cases gate.wordMap.isEmpty <;> cases distinct (gate.wordMap.map Prod.fst) <;>
    cases distinct (gate.wordMap.map Prod.snd) <;> cases gate.phaseSuccessors.isEmpty <;> rfl

theorem inverseRetainsPhaseTrace (gate : Gate) : (inverse gate).phaseSuccessors = gate.phaseSuccessors := rfl

def makeGate (rows : List (Word × Word)) (successors : List String) : Except String Gate :=
  if rows.isEmpty || !distinct (rows.map Prod.fst) || !distinct (rows.map Prod.snd) then
    .error "gate word map must be a finite bijection"
  else if successors.isEmpty then .error "gate phase action requires a generated successor trace"
  else .ok ⟨rows,successors⟩

theorem gateAdmission (gate : Gate) :
    makeGate gate.wordMap gate.phaseSuccessors = .ok gate ↔ validGate gate = true := by
  cases gate with
  | mk rows successors =>
    unfold makeGate validGate
    dsimp only
    cases rows.isEmpty <;> cases distinct (rows.map Prod.fst) <;>
      cases distinct (rows.map Prod.snd) <;> cases successors.isEmpty
    all_goals constructor <;> intro h
    all_goals first | rfl | (cases h; done)

theorem admittedInverse (gate : Gate)
    (accepted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate) :
    makeGate (inverse gate).wordMap (inverse gate).phaseSuccessors = .ok (inverse gate) :=
  (gateAdmission _).mpr ((inverseAdmission gate).trans ((gateAdmission _).mp accepted))

structure State where
  branches : List (Word × String)
  phaseCycle : List String
  deriving Repr

def support (state : State) : List Word := state.branches.map Prod.fst

def makeState (branches : List (Word × String)) (cycle : List String) : Except String State :=
  if branches.isEmpty || !distinct cycle || cycle.length < 2 then
    .error "state requires nonempty support and a nontrivial exact phase cycle"
  else if !distinct (branches.map Prod.fst) then .error "a branch word occurs twice"
  else if branches.any (fun row => !has cycle row.2) then
    .error "branch phase is outside the registered cycle"
  else .ok ⟨branches,cycle⟩

theorem admittedStateSupport (state : State)
    (accepted : makeState state.branches state.phaseCycle = .ok state) :
    distinct (support state) = true := by
  unfold makeState at accepted
  split at accepted
  · cases accepted
  · split at accepted
    · cases accepted
    · rename_i h
      cases e : distinct (support state) with
      | true => rfl
      | false =>
        have rejected : (!distinct (state.branches.map Prod.fst)) = true := by change (!distinct (support state)) = true; rw [e]; rfl
        exact False.elim (h rejected)

theorem admittedPhaseCycle (state : State)
    (accepted : makeState state.branches state.phaseCycle = .ok state) :
    state.branches.isEmpty = false ∧ distinct state.phaseCycle = true ∧ 2 ≤ state.phaseCycle.length := by
  unfold makeState at accepted
  split at accepted
  · cases accepted
  · rename_i h
    have nonempty : state.branches.isEmpty = false := by
      cases e : state.branches.isEmpty with
      | false => rfl
      | true => exact False.elim (h (by rw [e]; rfl))
    have unique : distinct state.phaseCycle = true := by
      cases e : distinct state.phaseCycle with
      | true => rfl
      | false => exact False.elim (h (by rw [e]; cases state.branches.isEmpty <;> rfl))
    have bound : ¬ state.phaseCycle.length < 2 := by
      intro low
      exact h (by rw [nonempty,unique]; exact decide_eq_true low)
    exact ⟨nonempty,unique,Nat.le_of_not_lt bound⟩

def phaseIndex (label : String) : List String → Option Nat
  | [] => none
  | first::rest => if first = label then some 0 else (phaseIndex label rest).map Nat.succ

def labelAt : List String → Nat → Option String
  | [], _ => none
  | first::_, 0 => some first
  | _::rest, .succ index => labelAt rest index

theorem indexReconstructs (cycle : List String) (phase : String) (index : Nat)
    (found : phaseIndex phase cycle = some index) : labelAt cycle index = some phase := by
  induction cycle generalizing index with
  | nil => cases found
  | cons first rest ih =>
    unfold phaseIndex at found
    split at found
    · rename_i same
      have eq : first = phase := same
      cases eq
      cases found
      rfl
    · cases prior : phaseIndex phase rest with
      | none => rw [prior] at found; cases found
      | some i => rw [prior] at found; cases found; exact ih i prior

def shiftPhase (cycle : List String) (shift : Nat) (phase : String) : Option String :=
  match phaseIndex phase cycle with
  | none => none
  | some index => labelAt cycle ((index + shift) % cycle.length)

def shiftBranches (cycle : List String) (shift : Nat) : List (Word × String) → Option (List (Word × String))
  | [] => some []
  | (word,phase)::rest => match shiftPhase cycle shift phase with
    | none => none
    | some result => match shiftBranches cycle shift rest with
      | none => none
      | some tail => some ((word,result)::tail)

theorem shiftRetainsSupport (cycle : List String) (shift : Nat) (branches shifted : List (Word × String))
    (accepted : shiftBranches cycle shift branches = some shifted) :
    shifted.map Prod.fst = branches.map Prod.fst := by
  induction branches generalizing shifted with
  | nil => cases accepted; rfl
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    unfold shiftBranches at accepted
    cases p : shiftPhase cycle shift phase with
    | none => rw [p] at accepted; cases shiftBranches cycle shift rest <;> cases accepted
    | some result =>
      rw [p] at accepted
      cases t : shiftBranches cycle shift rest with
      | none => rw [t] at accepted; cases accepted
      | some tail => rw [t] at accepted; cases accepted; exact congrArg (List.cons word) (ih tail t)

theorem phaseIndexExists (cycle : List String) (phase : String) (held : phase ∈ cycle) :
    ∃ index, phaseIndex phase cycle = some index := by
  induction cycle with
  | nil => cases held
  | cons first rest ih =>
    by_cases same : first = phase
    · refine ⟨0, ?_⟩
      unfold phaseIndex
      rw [ite_eq_left same]
    · have member : phase ∈ rest := by
        cases held with
        | head => exact False.elim (same rfl)
        | tail _ h => exact h
      obtain ⟨index,found⟩ := ih member
      refine ⟨index+1, ?_⟩
      unfold phaseIndex
      rw [ite_eq_right same,found]
      rfl

theorem labelAtExists (cycle : List String) (index : Nat) (bound : index < cycle.length) :
    ∃ phase, labelAt cycle index = some phase ∧ phase ∈ cycle := by
  induction cycle generalizing index with
  | nil => exact False.elim (Nat.not_lt_zero _ bound)
  | cons first rest ih =>
    cases index with
    | zero => exact ⟨first,rfl,.head _⟩
    | succ i =>
      obtain ⟨phase,found,member⟩ := ih i (Nat.lt_of_succ_lt_succ bound)
      exact ⟨phase,found,.tail _ member⟩

theorem shiftedPhaseExists (cycle : List String) (positive : 0 < cycle.length)
    (phase : String) (held : phase ∈ cycle) (shift : Nat) :
    ∃ result, shiftPhase cycle shift phase = some result ∧ result ∈ cycle := by
  obtain ⟨index,found⟩ := phaseIndexExists cycle phase held
  obtain ⟨result,selected,member⟩ := labelAtExists cycle ((index+shift)%cycle.length)
    (Nat.mod_lt _ positive)
  exact ⟨result,by unfold shiftPhase; rw [found]; exact selected,member⟩

def phaseAction (state : State) (steps : List String) : Except String State :=
  if steps.isEmpty then .error "phase action requires a generated nonempty successor trace"
  else match shiftBranches state.phaseCycle (steps.length % state.phaseCycle.length) state.branches with
    | none => .error "branch phase is outside the registered cycle"
    | some branches => makeState branches state.phaseCycle

theorem emptyPhaseTraceRejected (state : State) : phaseAction state [] =
    .error "phase action requires a generated nonempty successor trace" := rfl

theorem noOutsidePhases (cycle : List String) (branches : List (Word × String))
    (allHeld : ∀ row, row ∈ branches → row.2 ∈ cycle) :
    branches.any (fun row => !has cycle row.2) = false := by
  induction branches with
  | nil => rfl
  | cons row rest ih =>
    have head := (hasIff cycle row.2).mpr (allHeld row (.head _))
    have tail := ih (fun item member => allHeld item (.tail _ member))
    change (!has cycle row.2 || rest.any (fun row => !has cycle row.2)) = false
    rw [head,tail]
    rfl

theorem admittedPhaseMember (state : State)
    (accepted : makeState state.branches state.phaseCycle = .ok state) :
    ∀ row, row ∈ state.branches → row.2 ∈ state.phaseCycle := by
  unfold makeState at accepted
  split at accepted
  · cases accepted
  · split at accepted
    · cases accepted
    · split at accepted
      · cases accepted
      · rename_i clean
        have absent : state.branches.any (fun row => !has state.phaseCycle row.2) = false := by
          cases e : state.branches.any (fun row => !has state.phaseCycle row.2) with
          | false => rfl
          | true => exact False.elim (clean e)
        intro row member
        have extract : ∀ (rows : List (Word × String)),
            rows.any (fun row => !has state.phaseCycle row.2) = false →
            ∀ item, item ∈ rows → has state.phaseCycle item.2 = true := by
          intro rows
          induction rows with
          | nil => intro h item m; cases m
          | cons first rest ih =>
            intro h item m
            change (!has state.phaseCycle first.2 || rest.any (fun row => !has state.phaseCycle row.2)) = false at h
            cases e : has state.phaseCycle first.2 with
            | false => rw [e] at h; cases h
            | true =>
              rw [e] at h
              cases m with
              | head => exact e
              | tail _ m => exact ih h item m
        exact (hasIff _ _).mp (extract _ absent row member)

theorem shiftedBranchesExist (cycle : List String) (positive : 0 < cycle.length) (shift : Nat)
    (branches : List (Word × String)) (held : ∀ row, row ∈ branches → row.2 ∈ cycle) :
    ∃ shifted, shiftBranches cycle shift branches = some shifted ∧
      ∀ row, row ∈ shifted → row.2 ∈ cycle := by
  induction branches with
  | nil => exact ⟨[],rfl,fun row member => by cases member⟩
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    obtain ⟨result,hresult,resultHeld⟩ := shiftedPhaseExists cycle positive phase (held _ (.head _)) shift
    obtain ⟨tail,htail,tailHeld⟩ := ih (fun row member => held row (.tail _ member))
    refine ⟨(word,result)::tail, ?_, ?_⟩
    · unfold shiftBranches
      rw [hresult,htail]
    · intro row member
      cases member with
      | head => exact resultHeld
      | tail _ member => exact tailHeld row member

theorem supportEmpty (branches : List (Word × String)) :
    (branches.map Prod.fst).isEmpty = branches.isEmpty := by cases branches <;> rfl

theorem phaseActionPreserves (state : State) (steps : List String)
    (admitted : makeState state.branches state.phaseCycle = .ok state)
    (nonempty : steps.isEmpty = false) :
    ∃ result, phaseAction state steps = .ok result ∧ support result = support state ∧
      result.phaseCycle = state.phaseCycle ∧ makeState result.branches result.phaseCycle = .ok result := by
  have properties := admittedPhaseCycle state admitted
  have positive : 0 < state.phaseCycle.length := Nat.lt_of_lt_of_le (by decide : 0 < 2) properties.2.2
  obtain ⟨shifted,executed,phaseHeld⟩ := shiftedBranchesExist state.phaseCycle positive
    (steps.length % state.phaseCycle.length) state.branches (admittedPhaseMember state admitted)
  have same := shiftRetainsSupport _ _ _ _ executed
  have branchesNonempty : shifted.isEmpty = false := by
    rw [← supportEmpty shifted,same,supportEmpty state.branches]
    exact properties.1
  have distinctWords : distinct (shifted.map Prod.fst) = true := by
    rw [same]
    exact admittedStateSupport state admitted
  have phases := noOutsidePhases _ _ phaseHeld
  have cycleBound : decide (state.phaseCycle.length < 2) = false :=
    decide_eq_false (Nat.not_lt_of_ge properties.2.2)
  have made : makeState shifted state.phaseCycle = .ok ⟨shifted,state.phaseCycle⟩ := by
    unfold makeState
    rw [branchesNonempty,properties.2.1,cycleBound,distinctWords,phases]
    rfl
  refine ⟨⟨shifted,state.phaseCycle⟩, ?_, same, rfl, made⟩
  unfold phaseAction
  rw [nonempty,executed]
  exact made

theorem makeStateSource (branches : List (Word × String)) (cycle : List String) (state : State)
    (accepted : makeState branches cycle = .ok state) : state = ⟨branches,cycle⟩ := by
  unfold makeState at accepted
  split at accepted
  · cases accepted
  · split at accepted
    · cases accepted
    · split at accepted
      · cases accepted
      · cases accepted; rfl

def completeSupport (alphabet positions cycle : List String) : Except String State :=
  if alphabet.isEmpty || positions.isEmpty || !distinct alphabet || !distinct positions then
    .error "support requires unique generated alphabet and positions"
  else match cycle with
    | [] => .error "IndexError: tuple index out of range"
    | first::_ => makeState
        ((SFT.InformationScience.QuantitySupport.words alphabet positions.length).map (fun word => (word,first))) cycle

theorem labelledSupport (words : List Word) (phase : String) :
    (words.map (fun word => (word,phase))).map Prod.fst = words := by
  induction words with
  | nil => rfl
  | cons word rest ih => exact congrArg (List.cons word) ih

theorem completeSupportWords (alphabet positions cycle : List String) (state : State)
    (accepted : completeSupport alphabet positions cycle = .ok state) :
    support state = SFT.InformationScience.QuantitySupport.words alphabet positions.length := by
  unfold completeSupport at accepted
  split at accepted
  · cases accepted
  · cases cycle with
    | nil => cases accepted
    | cons first rest =>
      have exactState := makeStateSource _ _ _ accepted
      rw [exactState]
      exact labelledSupport _ _

theorem completeSupportExactly (alphabet positions cycle : List String) (state : State)
    (accepted : completeSupport alphabet positions cycle = .ok state) (word : Word) :
    word ∈ support state ↔ word.length = positions.length ∧
      ∀ label, label ∈ word → label ∈ alphabet := by
  rw [completeSupportWords _ _ _ _ accepted]
  exact SFT.InformationScience.QuantitySupport.wordCharacterization _ _ _

end SFT.QuantumComputation.ReversibleModel
