import verification.TURN_342_ReversiblePhaseDraft
import SFT.InformationScience.EncodingMaps
namespace SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversiblePhase
open SFT.InformationScience.EncodingMaps SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

def domainMatches (state : State) (gate : Gate) : Bool :=
  (gate.wordMap.map Prod.fst).all (has (support state)) &&
    (support state).all (has (gate.wordMap.map Prod.fst))

def transformBranches (gate : Gate) (cycle : List String) (amount : Nat) :
    List (Word × String) → Option (List (Word × String))
  | [] => some []
  | (word,phase)::rest => match lookupFirst gate.wordMap word with
    | none => none
    | some target => match shiftPhase cycle amount phase with
      | none => none
      | some shifted => match transformBranches gate cycle amount rest with
        | none => none
        | some tail => some ((target,shifted)::tail)

def applyGate (state : State) (gate : Gate) (inversePhase : Bool := false) : Except String State :=
  if domainMatches state gate then
    let amount := gate.phaseSuccessors.length % state.phaseCycle.length
    let shift := if inversePhase then inverseShift amount state.phaseCycle.length else amount
    match transformBranches gate state.phaseCycle shift state.branches with
    | none => .error "unregistered word or phase"
    | some branches => makeState branches state.phaseCycle
  else .error "gate domain must equal complete state support"

theorem inverseWordImage (gate : Gate) (uniqueTargets : distinct (gate.wordMap.map Prod.snd) = true)
    (word target : Word) (forward : lookupFirst gate.wordMap word = some target) :
    lookupFirst (inverse gate).wordMap target = some word := by
  have row := lookupRow _ _ _ forward
  apply lookupUnique
  · exact (congrArg distinct (inverseSources gate.wordMap)).trans uniqueTargets
  · exact memMap (fun pair : Word × Word => (pair.2,pair.1)) (word,target) gate.wordMap row

theorem transformedBranchesInverse (gate : Gate)
    (uniqueTargets : distinct (gate.wordMap.map Prod.snd) = true)
    (cycle : List String) (uniqueCycle : distinct cycle = true) (positive : 0 < cycle.length)
    (amount : Nat) (amountBound : amount < cycle.length) (branches transformed : List (Word × String))
    (held : ∀ row, row ∈ branches → row.2 ∈ cycle)
    (forward : transformBranches gate cycle amount branches = some transformed) :
    transformBranches (inverse gate) cycle (inverseShift amount cycle.length) transformed = some branches := by
  induction branches generalizing transformed with
  | nil => cases forward; rfl
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    unfold transformBranches at forward
    cases w : lookupFirst gate.wordMap word with
    | none => rw [w] at forward; cases forward
    | some target =>
      rw [w] at forward
      cases p : shiftPhase cycle amount phase with
      | none => rw [p] at forward; cases forward
      | some shifted =>
        rw [p] at forward
        cases t : transformBranches gate cycle amount rest with
        | none => rw [t] at forward; cases forward
        | some tail =>
          rw [t] at forward
          cases forward
          have wordBack := inverseWordImage gate uniqueTargets word target w
          have phaseBack := phaseInverse cycle uniqueCycle positive phase shifted amount
            (held _ (.head _)) amountBound p
          have tailBack := ih tail (fun row member => held row (.tail _ member)) t
          unfold transformBranches
          rw [wordBack,phaseBack,tailBack]

theorem domainExactly (state : State) (gate : Gate) : domainMatches state gate = true ↔
    ∀ word, word ∈ gate.wordMap.map Prod.fst ↔ word ∈ support state := by
  constructor
  · intro accepted word
    have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp accepted
    exact ⟨fun member => (hasIff _ _).mp ((allTrueIffMembers _ _).mp both.1 word member),
      fun member => (hasIff _ _).mp ((allTrueIffMembers _ _).mp both.2 word member)⟩
  · intro equal
    apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
    exact ⟨(allTrueIffMembers _ _).mpr (fun word member => (hasIff _ _).mpr ((equal word).mp member)),
      (allTrueIffMembers _ _).mpr (fun word member => (hasIff _ _).mpr ((equal word).mpr member))⟩

theorem applicationSource (state result : State) (gate : Gate) (inversePhase : Bool)
    (accepted : applyGate state gate inversePhase = .ok result) :
    domainMatches state gate = true ∧ result.phaseCycle = state.phaseCycle ∧
    transformBranches gate state.phaseCycle
      (if inversePhase then inverseShift (gate.phaseSuccessors.length % state.phaseCycle.length) state.phaseCycle.length
       else gate.phaseSuccessors.length % state.phaseCycle.length) state.branches = some result.branches := by
  unfold applyGate at accepted
  split at accepted
  · rename_i domain
    dsimp only at accepted
    cases t : transformBranches gate state.phaseCycle
      (if inversePhase then inverseShift (gate.phaseSuccessors.length % state.phaseCycle.length) state.phaseCycle.length
       else gate.phaseSuccessors.length % state.phaseCycle.length) state.branches with
    | none => rw [t] at accepted; cases accepted
    | some branches =>
      rw [t] at accepted
      have source := makeStateSource _ _ _ accepted
      cases source
      exact ⟨domain,rfl,rfl⟩
  · cases accepted

theorem admittedGateTargets (gate : Gate)
    (admitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate) :
    distinct (gate.wordMap.map Prod.snd) = true :=
  ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp
    ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp ((gateAdmission gate).mp admitted)).1).2

theorem applicationInverseWithDomain (state result : State) (gate : Gate)
    (stateAdmitted : makeState state.branches state.phaseCycle = .ok state)
    (gateAdmitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (forward : applyGate state gate false = .ok result)
    (inverseDomain : domainMatches result (inverse gate) = true) :
    applyGate result (inverse gate) true = .ok state := by
  have properties := admittedPhaseCycle state stateAdmitted
  have positive : 0 < state.phaseCycle.length := Nat.lt_of_lt_of_le (by decide : 0 < 2) properties.2.2
  have source := applicationSource state result gate false forward
  have restored := transformedBranchesInverse gate (admittedGateTargets gate gateAdmitted)
    state.phaseCycle properties.2.1 positive (gate.phaseSuccessors.length % state.phaseCycle.length)
    (Nat.mod_lt _ positive) state.branches result.branches (admittedPhaseMember state stateAdmitted) source.2.2
  unfold applyGate
  rw [inverseDomain]
  dsimp only
  rw [source.2.1]
  change (match transformBranches (inverse gate) state.phaseCycle
    (inverseShift (gate.phaseSuccessors.length % state.phaseCycle.length) state.phaseCycle.length) result.branches with
    | none => Except.error "unregistered word or phase"
    | some branches => makeState branches state.phaseCycle) = .ok state
  rw [restored]
  exact stateAdmitted

theorem transformedSupport (gate : Gate) (cycle : List String) (amount : Nat)
    (branches transformed : List (Word × String))
    (forward : transformBranches gate cycle amount branches = some transformed) :
    ∀ target, target ∈ transformed.map Prod.fst ↔
      ∃ row, row ∈ branches ∧ lookupFirst gate.wordMap row.1 = some target := by
  induction branches generalizing transformed with
  | nil =>
    cases forward
    intro target
    constructor
    · intro member; cases member
    · intro ⟨row,member,_⟩; cases member
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    unfold transformBranches at forward
    cases w : lookupFirst gate.wordMap word with
    | none => rw [w] at forward; cases forward
    | some image =>
      rw [w] at forward
      cases p : shiftPhase cycle amount phase with
      | none => rw [p] at forward; cases forward
      | some shifted =>
        rw [p] at forward
        cases t : transformBranches gate cycle amount rest with
        | none => rw [t] at forward; cases forward
        | some tail =>
          rw [t] at forward
          cases forward
          intro target
          constructor
          · intro member
            cases member with
            | head => exact ⟨(word,phase),.head _,w⟩
            | tail _ member =>
              obtain ⟨row,held,lookup⟩ := (ih tail t target).mp member
              exact ⟨row,.tail _ held,lookup⟩
          · intro ⟨row,held,lookup⟩
            cases held with
            | head => rw [w] at lookup; cases lookup; exact .head _
            | tail _ held => exact .tail _ ((ih tail t target).mpr ⟨row,held,lookup⟩)

theorem admittedGateSources (gate : Gate)
    (admitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate) :
    distinct (gate.wordMap.map Prod.fst) = true :=
  ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp
    ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp
      ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp ((gateAdmission gate).mp admitted)).1).1).2

theorem inverseDomainFromApplication (state result : State) (gate : Gate) (inversePhase : Bool)
    (gateAdmitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (forward : applyGate state gate inversePhase = .ok result) :
    domainMatches result (inverse gate) = true := by
  have execution := applicationSource state result gate inversePhase forward
  have domain := (domainExactly state gate).mp execution.1
  have image := transformedSupport gate state.phaseCycle _ state.branches result.branches execution.2.2
  apply (domainExactly result (inverse gate)).mpr
  intro word
  change word ∈ (invertRows gate.wordMap).map Prod.fst ↔ word ∈ support result
  rw [inverseSources]
  constructor
  · intro member
    obtain ⟨pair,registered,targetEq⟩ := memMapPreimage Prod.snd word gate.wordMap member
    obtain ⟨source,target⟩ := pair
    dsimp only at targetEq
    cases targetEq
    have sourceHeld := domain source |>.mp (memMap Prod.fst (source,word) gate.wordMap registered)
    obtain ⟨branch,branchHeld,sourceEq⟩ := memMapPreimage Prod.fst source state.branches sourceHeld
    apply (image word).mpr
    refine ⟨branch,branchHeld,?_⟩
    rw [sourceEq]
    exact lookupUnique _ _ _ (admittedGateSources gate gateAdmitted) registered
  · intro member
    obtain ⟨branch,_,lookup⟩ := (image word).mp member
    exact memMap Prod.snd (branch.1,word) gate.wordMap (lookupRow _ _ _ lookup)

theorem applicationInverse (state result : State) (gate : Gate)
    (stateAdmitted : makeState state.branches state.phaseCycle = .ok state)
    (gateAdmitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (forward : applyGate state gate false = .ok result) :
    applyGate result (inverse gate) true = .ok state :=
  applicationInverseWithDomain state result gate stateAdmitted gateAdmitted forward
    (inverseDomainFromApplication state result gate false gateAdmitted forward)

theorem transformationExists (gate : Gate) (cycle : List String) (positive : 0 < cycle.length)
    (amount : Nat) (branches : List (Word × String))
    (wordsHeld : ∀ row, row ∈ branches → row.1 ∈ gate.wordMap.map Prod.fst)
    (phasesHeld : ∀ row, row ∈ branches → row.2 ∈ cycle) :
    ∃ transformed, transformBranches gate cycle amount branches = some transformed ∧
      ∀ row, row ∈ transformed → row.2 ∈ cycle := by
  induction branches with
  | nil => exact ⟨[],rfl,fun row member => by cases member⟩
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    obtain ⟨target,w⟩ := (lookupDefined gate.wordMap word).mpr (wordsHeld _ (.head _))
    obtain ⟨shifted,p,held⟩ := shiftedPhaseExists cycle positive phase (phasesHeld _ (.head _)) amount
    obtain ⟨tail,t,tailHeld⟩ := ih (fun row member => wordsHeld row (.tail _ member))
      (fun row member => phasesHeld row (.tail _ member))
    refine ⟨(target,shifted)::tail,?_,?_⟩
    · unfold transformBranches
      rw [w,p,t]
    · intro row member
      cases member with
      | head => exact held
      | tail _ member => exact tailHeld row member

theorem transformedDistinct (gate : Gate) (uniqueTargets : distinct (gate.wordMap.map Prod.snd) = true)
    (cycle : List String) (amount : Nat) (branches transformed : List (Word × String))
    (uniqueWords : distinct (branches.map Prod.fst) = true)
    (forward : transformBranches gate cycle amount branches = some transformed) :
    distinct (transformed.map Prod.fst) = true := by
  induction branches generalizing transformed with
  | nil => cases forward; rfl
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    have original := (distinctCons _ _).mp uniqueWords
    unfold transformBranches at forward
    cases w : lookupFirst gate.wordMap word with
    | none => rw [w] at forward; cases forward
    | some target =>
      rw [w] at forward
      cases p : shiftPhase cycle amount phase with
      | none => rw [p] at forward; cases forward
      | some shifted =>
        rw [p] at forward
        cases t : transformBranches gate cycle amount rest with
        | none => rw [t] at forward; cases forward
        | some tail =>
          rw [t] at forward
          cases forward
          apply (distinctCons _ _).mpr
          refine ⟨(absentIff _ _).mpr ?_,ih tail original.2 t⟩
          intro member
          obtain ⟨row,held,lookup⟩ := (transformedSupport gate cycle amount rest tail t target).mp member
          have firstBack := inverseWordImage gate uniqueTargets word target w
          have otherBack := inverseWordImage gate uniqueTargets row.1 target lookup
          rw [firstBack] at otherBack
          have same := Option.some.inj otherBack
          have originalMember := memMap Prod.fst row rest held
          rw [← same] at originalMember
          exact (absentIff _ _).mp original.1 originalMember

theorem transformedLength (gate : Gate) (cycle : List String) (amount : Nat)
    (branches transformed : List (Word × String))
    (forward : transformBranches gate cycle amount branches = some transformed) :
    transformed.length = branches.length := by
  induction branches generalizing transformed with
  | nil => cases forward; rfl
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    unfold transformBranches at forward
    cases w : lookupFirst gate.wordMap word with
    | none => rw [w] at forward; cases forward
    | some target =>
      rw [w] at forward
      cases p : shiftPhase cycle amount phase with
      | none => rw [p] at forward; cases forward
      | some shifted =>
        rw [p] at forward
        cases t : transformBranches gate cycle amount rest with
        | none => rw [t] at forward; cases forward
        | some tail => rw [t] at forward; cases forward; exact congrArg Nat.succ (ih tail t)

theorem applicationExists (state : State) (gate : Gate) (inversePhase : Bool)
    (stateAdmitted : makeState state.branches state.phaseCycle = .ok state)
    (gateAdmitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (domain : domainMatches state gate = true) :
    ∃ result, applyGate state gate inversePhase = .ok result ∧
      makeState result.branches result.phaseCycle = .ok result ∧ result.branches.length = state.branches.length := by
  have properties := admittedPhaseCycle state stateAdmitted
  have positive : 0 < state.phaseCycle.length := Nat.lt_of_lt_of_le (by decide : 0 < 2) properties.2.2
  let amount := gate.phaseSuccessors.length % state.phaseCycle.length
  let shift := if inversePhase then inverseShift amount state.phaseCycle.length else amount
  have wordsHeld : ∀ row, row ∈ state.branches → row.1 ∈ gate.wordMap.map Prod.fst := by
    intro row member
    exact ((domainExactly state gate).mp domain row.1).mpr (memMap Prod.fst row state.branches member)
  obtain ⟨transformed,executed,phasesHeld⟩ := transformationExists gate state.phaseCycle positive shift
    state.branches wordsHeld (admittedPhaseMember state stateAdmitted)
  have lengthEq := transformedLength gate state.phaseCycle shift state.branches transformed executed
  have nonempty : transformed.isEmpty = false := by
    cases ht : transformed with
    | nil =>
      rw [ht] at lengthEq
      cases hs : state.branches with
      | nil => have bad := properties.1; rw [hs] at bad; cases bad
      | cons row rest => rw [hs] at lengthEq; cases lengthEq
    | cons row rest => rfl
  have wordsUnique := transformedDistinct gate (admittedGateTargets gate gateAdmitted)
    state.phaseCycle shift state.branches transformed (admittedStateSupport state stateAdmitted) executed
  have phases := noOutsidePhases _ _ phasesHeld
  have cycleBound : decide (state.phaseCycle.length < 2) = false :=
    decide_eq_false (Nat.not_lt_of_ge properties.2.2)
  have made : makeState transformed state.phaseCycle = .ok ⟨transformed,state.phaseCycle⟩ := by
    unfold makeState
    rw [nonempty,properties.2.1,cycleBound,wordsUnique,phases]
    rfl
  refine ⟨⟨transformed,state.phaseCycle⟩,?_,made,lengthEq⟩
  unfold applyGate
  rw [domain]
  change (match transformBranches gate state.phaseCycle shift state.branches with
    | none => Except.error "unregistered word or phase"
    | some branches => makeState branches state.phaseCycle) = .ok ⟨transformed,state.phaseCycle⟩
  rw [executed]
  exact made

theorem admittedRoundTrip (state : State) (gate : Gate)
    (stateAdmitted : makeState state.branches state.phaseCycle = .ok state)
    (gateAdmitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (domain : domainMatches state gate = true) :
    ∃ result, applyGate state gate false = .ok result ∧
      applyGate result (inverse gate) true = .ok state ∧
      makeState result.branches result.phaseCycle = .ok result ∧
      result.branches.length = state.branches.length := by
  obtain ⟨result,forward,admitted,count⟩ := applicationExists state gate false stateAdmitted gateAdmitted domain
  exact ⟨result,forward,applicationInverse state result gate stateAdmitted gateAdmitted forward,admitted,count⟩

end SFT.QuantumComputation.ReversibleApplication
