import SFT.Chemistry.StateEnergyOrder
namespace SFT.Chemistry.StateEnergyOrder
open SFT.Host SFT.Physics.CapabilityValues

theorem admittedGroundCount (order result : ExactFiniteStateOrder)
 (accepted : validOrder order = .ok result) :
 (order.states.filter (fun row => isGround row.orderPosition)).length = 1 := by
 unfold validOrder at accepted
 cases h0 : (order.states.isEmpty || order.states.any (fun row => !ElectronCountSpin.sameLabel row.molecularCarrier order.molecularCarrier)) with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  cases h1 : !ElectronCountSpin.distinctLabels (order.states.map OrderedMolecularState.stateIdentity) with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   cases h2 : ((order.states.filter (fun row => isGround row.orderPosition)).length == 1) with
   | true => exact Nat.eq_of_beq_eq_true h2
   | false =>
    change (if !((order.states.filter (fun row => isGround row.orderPosition)).length == 1) then _ else _) = _ at accepted
    rw [h2] at accepted
    cases accepted

-- Comparisons use the structural least branch before reading positive counts.
theorem groundBeforePositive (left right : OrderedMolecularState)
 (sameCarrier : ElectronCountSpin.sameLabel left.molecularCarrier right.molecularCarrier = true)
 (least : isGround left.orderPosition = true)
 (excited : isGround right.orderPosition = false) :
 precedes left right = .ok true := by
 unfold precedes
 rw [sameCarrier]
 change (if isGround left.orderPosition then _ else _) = _
 rw [least]
 change Except.ok (!isGround right.orderPosition) = _
 rw [excited]
 rfl

theorem noStateBeforeGround (left right : OrderedMolecularState)
 (sameCarrier : ElectronCountSpin.sameLabel left.molecularCarrier right.molecularCarrier = true)
 (ground : isGround right.orderPosition = true) :
 precedes left right = .ok false := by
 unfold precedes
 rw [sameCarrier]
 change (if isGround left.orderPosition then _ else _) = _
 cases h : isGround left.orderPosition with
 | true => change Except.ok (!isGround right.orderPosition) = _; rw [ground]; rfl
 | false => change (if isGround right.orderPosition then _ else _) = _; rw [ground]; rfl

theorem positiveComparisonEquation (left right : OrderedMolecularState) (a b : PositiveCount)
 (sameCarrier : ElectronCountSpin.sameLabel left.molecularCarrier right.molecularCarrier = true)
 (leftPositive : left.orderPosition = .count a) (rightPositive : right.orderPosition = .count b) :
 precedes left right = .ok (decide (a.value < b.value)) := by
 unfold precedes
 rw [sameCarrier]
 change (if isGround left.orderPosition then _ else _) = _
 rw [leftPositive]
 change (if isGround right.orderPosition then _ else _) = _
 rw [rightPositive]
 rfl

theorem distinctPositivePositionsComparable (a b : PositiveCount) (distinct : a.value ≠ b.value) :
 a.value < b.value ∨ b.value < a.value := by
 cases Nat.lt_trichotomy a.value b.value with
 | inl less => exact Or.inl less
 | inr rest => cases rest with
  | inl same => exact (distinct same).elim
  | inr greater => exact Or.inr greater

theorem retainedPositiveGap (low high : PositiveCount) (ordered : low.value < high.value) :
 0 < high.value-low.value := by
 have prove : ∀ lo hi : Nat, lo < hi → 0 < hi-lo := by
  intro lo
  induction lo with
  | zero => intro hi h; exact h
  | succ lo ih =>
   intro hi h
   cases hi with
   | zero => exact (Nat.not_lt_zero _ h).elim
   | succ hi => rw [Nat.succ_sub_succ_eq_sub]; exact ih hi (Nat.lt_of_succ_lt_succ h)
 exact prove low.value high.value ordered

theorem gapReconstructsHigher (low high : PositiveCount) (ordered : low.value < high.value) :
 low.value+(high.value-low.value) = high.value := by
 have prove : ∀ lo hi : Nat, lo < hi → lo+(hi-lo) = hi := by
  intro lo
  induction lo with
  | zero => intro hi h; exact Nat.zero_add hi
  | succ lo ih =>
   intro hi h
   cases hi with
   | zero => exact (Nat.not_lt_zero _ h).elim
   | succ hi =>
    rw [Nat.succ_sub_succ_eq_sub]
    change Nat.succ lo + (hi-lo) = Nat.succ hi
    rw [Nat.succ_add]
    exact congrArg Nat.succ (ih hi (Nat.lt_of_succ_lt_succ h))
 exact prove low.value high.value ordered

theorem admittedSuccessorPositions (order result : ExactFiniteStateOrder)
 (accepted : validOrder order = .ok result) :
 sortPositions (positivePositions order.states) = (List.range (order.states.length-1)).map (fun n=>n+1) := by
 have equalLists : ∀ (a b : List Nat), (a==b)=true → a=b := by
  intro a
  induction a with
  | nil => intro b h; cases b with
    | nil => rfl
    | cons x xs => cases h
  | cons x xs ih =>
   intro b h
   cases b with
   | nil => cases h
   | cons y ys =>
    change ((x==y) && (xs==ys))=true at h
    cases head : (x==y) with
    | false => rw [head] at h; cases h
    | true =>
     rw [head] at h
     have same := Nat.eq_of_beq_eq_true head
     cases same
     exact congrArg (List.cons x) (ih ys h)
 unfold validOrder at accepted
 cases h0 : (order.states.isEmpty || order.states.any (fun row=>!ElectronCountSpin.sameLabel row.molecularCarrier order.molecularCarrier)) with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  cases h1 : !ElectronCountSpin.distinctLabels (order.states.map OrderedMolecularState.stateIdentity) with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   cases h2 : ((order.states.filter (fun row=>isGround row.orderPosition)).length != 1) with
   | true => rw [h2] at accepted; cases accepted
   | false =>
    rw [h2] at accepted
    cases h3 : (sortPositions (positivePositions order.states) == (List.range (order.states.length-1)).map (fun n=>n+1)) with
    | true => exact equalLists _ _ h3
    | false =>
     change (if !(sortPositions (positivePositions order.states) == (List.range (order.states.length-1)).map (fun n=>n+1)) then _ else _) = _ at accepted
     rw [h3] at accepted
     cases accepted

#print axioms admittedSuccessorPositions
#print axioms positiveComparisonEquation
#print axioms distinctPositivePositionsComparable
#print axioms retainedPositiveGap
#print axioms gapReconstructsHigher
#print axioms admittedGroundCount
#print axioms groundBeforePositive
#print axioms noStateBeforeGround
end SFT.Chemistry.StateEnergyOrder
