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

#print axioms admittedGroundCount
#print axioms groundBeforePositive
#print axioms noStateBeforeGround
end SFT.Chemistry.StateEnergyOrder
