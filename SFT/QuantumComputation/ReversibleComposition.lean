import SFT.QuantumComputation.ReversibleApplication
namespace SFT.QuantumComputation.ReversibleComposition
open SFT.QuantumComputation.ReversibleModel

def jointWord (left right : Word) : Word := left ++ ["joint"] ++ right

def jointBranch (cycle : List String) (left right : Word × String) : Option (Word × String) :=
  match phaseIndex right.2 cycle with
  | none => none
  | some index => match shiftPhase cycle index left.2 with
    | none => none
    | some phase => some (jointWord left.1 right.1,phase)

def pairWith (cycle : List String) (left : Word × String) : List (Word × String) → Option (List (Word × String))
  | [] => some []
  | right::rest => match jointBranch cycle left right with
    | none => none
    | some row => match pairWith cycle left rest with
      | none => none
      | some tail => some (row::tail)

def jointBranches (cycle : List String) (left right : List (Word × String)) : Option (List (Word × String)) :=
  match left with
  | [] => some []
  | first::rest => match pairWith cycle first right with
    | none => none
    | some row => match jointBranches cycle rest right with
      | none => none
      | some tail => some (row ++ tail)

def compose (left right : State) : Except String State :=
  if left.phaseCycle = right.phaseCycle then
    match jointBranches left.phaseCycle left.branches right.branches with
    | none => .error "branch phase is outside the registered cycle"
    | some branches => makeState branches left.phaseCycle
  else .error "joint states require one exact phase cycle"

theorem pairCount (cycle : List String) (left : Word × String) (right result : List (Word × String))
    (accepted : pairWith cycle left right = some result) : result.length = right.length := by
  induction right generalizing result with
  | nil => cases accepted; rfl
  | cons first rest ih =>
    unfold pairWith at accepted
    cases p : jointBranch cycle left first with
    | none => rw [p] at accepted; cases accepted
    | some row =>
      rw [p] at accepted
      cases t : pairWith cycle left rest with
      | none => rw [t] at accepted; cases accepted
      | some tail => rw [t] at accepted; cases accepted; exact congrArg Nat.succ (ih tail t)

open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.QuantumComputation.ReversiblePhase

theorem jointBranchMeaning (cycle : List String) (left right result : Word × String)
    (accepted : jointBranch cycle left right = some result) :
    result.1 = jointWord left.1 right.1 ∧
      ∃ l r, phaseIndex left.2 cycle = some l ∧ phaseIndex right.2 cycle = some r ∧
        labelAt cycle ((l+r)%cycle.length) = some result.2 := by
  unfold jointBranch at accepted
  cases r : phaseIndex right.2 cycle with
  | none => rw [r] at accepted; cases accepted
  | some ri =>
    rw [r] at accepted
    dsimp only at accepted
    cases p : shiftPhase cycle ri left.2 with
    | none => rw [p] at accepted; cases accepted
    | some phase =>
      rw [p] at accepted
      cases accepted
      unfold shiftPhase at p
      cases l : phaseIndex left.2 cycle with
      | none => rw [l] at p; cases p
      | some li => rw [l] at p; exact ⟨rfl,li,ri,rfl,rfl,p⟩

theorem pairWords (cycle : List String) (left : Word × String) (right result : List (Word × String))
    (accepted : pairWith cycle left right = some result) :
    result.map Prod.fst = right.map (fun row => jointWord left.1 row.1) := by
  induction right generalizing result with
  | nil => cases accepted; rfl
  | cons first rest ih =>
    unfold pairWith at accepted
    cases p : jointBranch cycle left first with
    | none => rw [p] at accepted; cases accepted
    | some row =>
      rw [p] at accepted
      cases t : pairWith cycle left rest with
      | none => rw [t] at accepted; cases accepted
      | some tail =>
        rw [t] at accepted
        cases accepted
        change row.1 :: tail.map Prod.fst = jointWord left.1 first.1 :: rest.map _
        rw [(jointBranchMeaning cycle left first row p).1,ih tail t]

theorem projectionAppend (left right : List (Word × String)) :
    (left++right).map Prod.fst = left.map Prod.fst ++ right.map Prod.fst := by
  induction left with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.1) ih

theorem jointWords (cycle : List String) (left right result : List (Word × String))
    (accepted : jointBranches cycle left right = some result) :
    result.map Prod.fst = left.flatMap (fun l => right.map (fun r => jointWord l.1 r.1)) := by
  induction left generalizing result with
  | nil => cases accepted; rfl
  | cons first rest ih =>
    unfold jointBranches at accepted
    cases p : pairWith cycle first right with
    | none => rw [p] at accepted; cases accepted
    | some row =>
      rw [p] at accepted
      cases t : jointBranches cycle rest right with
      | none => rw [t] at accepted; cases accepted
      | some tail =>
        rw [t] at accepted
        cases accepted
        rw [projectionAppend,pairWords _ _ _ _ p,ih tail t]
        rfl

theorem jointCount (cycle : List String) (left right result : List (Word × String))
    (accepted : jointBranches cycle left right = some result) : result.length = left.length * right.length := by
  induction left generalizing result with
  | nil => cases accepted; exact (Nat.zero_mul _).symm
  | cons first rest ih =>
    unfold jointBranches at accepted
    cases p : pairWith cycle first right with
    | none => rw [p] at accepted; cases accepted
    | some row =>
      rw [p] at accepted
      cases t : jointBranches cycle rest right with
      | none => rw [t] at accepted; cases accepted
      | some tail =>
        rw [t] at accepted
        cases accepted
        rw [appendLength,pairCount _ _ _ _ p,ih tail t]
        exact (Nat.add_comm _ _).trans (Nat.succ_mul _ _).symm

theorem jointMembership (cycle : List String) (left right result : List (Word × String))
    (accepted : jointBranches cycle left right = some result) (word : Word) :
    word ∈ result.map Prod.fst ↔ ∃ l, l ∈ left ∧ ∃ r, r ∈ right ∧ word = jointWord l.1 r.1 := by
  rw [jointWords _ _ _ _ accepted]
  constructor
  · intro member
    obtain ⟨l,hl,member⟩ := memFlatMapOrigin _ _ _ member
    obtain ⟨r,hr,equal⟩ := memMapPreimage _ _ _ member
    exact ⟨l,hl,r,hr,equal.symm⟩
  · intro ⟨l,hl,r,hr,equal⟩
    cases equal
    exact memFlatMap _ _ l _ hl (memMap _ r _ hr)

theorem compositionSource (left right result : State) (accepted : compose left right = .ok result) :
    left.phaseCycle = right.phaseCycle ∧ result.phaseCycle = left.phaseCycle ∧
      jointBranches left.phaseCycle left.branches right.branches = some result.branches ∧
      makeState result.branches result.phaseCycle = .ok result := by
  unfold compose at accepted
  split at accepted
  · rename_i same
    cases generated : jointBranches left.phaseCycle left.branches right.branches with
    | none => rw [generated] at accepted; cases accepted
    | some branches =>
      rw [generated] at accepted
      have source := makeStateSource _ _ _ accepted
      cases source
      exact ⟨same,rfl,rfl,accepted⟩
  · cases accepted

theorem compositionCount (left right result : State) (accepted : compose left right = .ok result) :
    result.branches.length = left.branches.length * right.branches.length :=
  jointCount _ _ _ _ (compositionSource left right result accepted).2.2.1

theorem compositionSupport (left right result : State) (accepted : compose left right = .ok result)
    (word : Word) : word ∈ support result ↔
      ∃ l, l ∈ left.branches ∧ ∃ r, r ∈ right.branches ∧ word = jointWord l.1 r.1 :=
  jointMembership _ _ _ _ (compositionSource left right result accepted).2.2.1 word

theorem jointBranchExists (cycle : List String) (positive : 0 < cycle.length)
    (left right : Word × String) (leftHeld : left.2 ∈ cycle) (rightHeld : right.2 ∈ cycle) :
    ∃ result, jointBranch cycle left right = some result ∧ result.2 ∈ cycle := by
  obtain ⟨index,found⟩ := phaseIndexExists cycle right.2 rightHeld
  obtain ⟨phase,shifted,held⟩ := shiftedPhaseExists cycle positive left.2 leftHeld index
  refine ⟨(jointWord left.1 right.1,phase),?_,held⟩
  unfold jointBranch
  rw [found]
  dsimp only
  rw [shifted]

theorem pairExists (cycle : List String) (positive : 0 < cycle.length)
    (left : Word × String) (leftHeld : left.2 ∈ cycle) (right : List (Word × String))
    (rightHeld : ∀ row, row ∈ right → row.2 ∈ cycle) :
    ∃ result, pairWith cycle left right = some result ∧ ∀ row, row ∈ result → row.2 ∈ cycle := by
  induction right with
  | nil => exact ⟨[],rfl,fun row member => by cases member⟩
  | cons first rest ih =>
    obtain ⟨row,p,held⟩ := jointBranchExists cycle positive left first leftHeld (rightHeld _ (.head _))
    obtain ⟨tail,t,tailHeld⟩ := ih (fun row member => rightHeld row (.tail _ member))
    refine ⟨row::tail,?_,?_⟩
    · unfold pairWith; rw [p,t]
    · intro item member
      cases member with
      | head => exact held
      | tail _ member => exact tailHeld item member

theorem jointExists (cycle : List String) (positive : 0 < cycle.length)
    (left right : List (Word × String))
    (leftHeld : ∀ row, row ∈ left → row.2 ∈ cycle)
    (rightHeld : ∀ row, row ∈ right → row.2 ∈ cycle) :
    ∃ result, jointBranches cycle left right = some result ∧ ∀ row, row ∈ result → row.2 ∈ cycle := by
  induction left with
  | nil => exact ⟨[],rfl,fun row member => by cases member⟩
  | cons first rest ih =>
    obtain ⟨row,p,rowHeld⟩ := pairExists cycle positive first (leftHeld _ (.head _)) right rightHeld
    obtain ⟨tail,t,tailHeld⟩ := ih (fun row member => leftHeld row (.tail _ member))
    refine ⟨row++tail,?_,?_⟩
    · unfold jointBranches; rw [p,t]
    · intro item member
      cases memAppendCases item row tail member with
      | inl member => exact rowHeld item member
      | inr member => exact tailHeld item member

theorem admittedCompositionDecision (left right : State)
    (leftAdmitted : makeState left.branches left.phaseCycle = .ok left)
    (rightAdmitted : makeState right.branches right.phaseCycle = .ok right)
    (same : left.phaseCycle = right.phaseCycle) :
    ∃ branches, jointBranches left.phaseCycle left.branches right.branches = some branches ∧
      compose left right = if SFT.Mathematics.DiscreteObjects.distinct (branches.map Prod.fst)
        then .ok ⟨branches,left.phaseCycle⟩ else .error "a branch word occurs twice" := by
  have properties := admittedPhaseCycle left leftAdmitted
  have other := admittedPhaseCycle right rightAdmitted
  have positive : 0 < left.phaseCycle.length := Nat.lt_of_lt_of_le (by decide : 0 < 2) properties.2.2
  have rightHeld : ∀ row, row ∈ right.branches → row.2 ∈ left.phaseCycle := by
    intro row member
    rw [same]
    exact admittedPhaseMember right rightAdmitted row member
  obtain ⟨branches,generated,held⟩ := jointExists left.phaseCycle positive left.branches right.branches
    (admittedPhaseMember left leftAdmitted) rightHeld
  have positiveLength : ∀ (xs : List (Word × String)), xs.isEmpty = false → 0 < xs.length := by
    intro xs nonempty
    cases xs with
    | nil => cases nonempty
    | cons row rest => exact Nat.zero_lt_succ _
  have countPositive : 0 < branches.length := by
    rw [jointCount _ _ _ _ generated]
    exact Nat.mul_pos (positiveLength left.branches properties.1) (positiveLength right.branches other.1)
  have nonempty : branches.isEmpty = false := by
    cases h : branches with
    | nil => rw [h] at countPositive; exact False.elim (Nat.not_lt_zero _ countPositive)
    | cons row rest => rfl
  have phases := noOutsidePhases left.phaseCycle branches held
  have cycleBound : decide (left.phaseCycle.length < 2) = false :=
    decide_eq_false (Nat.not_lt_of_ge properties.2.2)
  refine ⟨branches,generated,?_⟩
  unfold compose
  rw [ite_eq_left same,generated]
  change makeState branches left.phaseCycle = _
  unfold makeState
  rw [nonempty,properties.2.1,cycleBound,phases]
  cases SFT.Mathematics.DiscreteObjects.distinct (branches.map Prod.fst) <;> rfl

end SFT.QuantumComputation.ReversibleComposition
