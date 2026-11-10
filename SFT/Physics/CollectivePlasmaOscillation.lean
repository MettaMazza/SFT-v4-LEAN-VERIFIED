import SFT.Physics.CollectivePlasma
import SFT.Physics.MechanicalConstraintOscillation
namespace SFT.Physics.CollectivePlasmaOscillation
open MechanicalConstraintOscillation FieldElectricDistinction
open SFT.Mathematics.FoldScalar

-- Source-bound charge displacement, field response and restoring path are
-- retained together; the source's observation closure supplies screening.
structure RestoringResponse (Part Support State ClockState Clock : Type) where
 coupling : CollectivePlasma.Coupling Part Support State ClockState Clock
 motion : Oscillation Support
 sameDisplacement : coupling.field.electric.work.displacement = motion.first.carrier

variable {Part Support State ClockState Clock : Type}

theorem returnedDisplacement (r : RestoringResponse Part Support State ClockState Clock) :
 r.motion.last.carrier = r.coupling.field.electric.work.displacement :=
 (forcedCarrierReturn r.motion).trans r.sameDisplacement.symm

theorem intermediateSeparationDistinguished (r : RestoringResponse Part Support State ClockState Clock) :
 r.motion.middle.carrier ≠ r.coupling.field.electric.work.displacement := by
 rw [r.sameDisplacement]
 exact intermediateCarrierDistinct r.motion

theorem bothRestoringStepsRetained (r : RestoringResponse Part Support State ClockState Clock) :
 MechanicalEvents.sourceRecords (path r.motion) =
 [(r.motion.outward.sourceIdentity,r.motion.outward.actionRecord),
  (r.motion.returning.sourceIdentity,r.motion.returning.actionRecord)] := fullTransferTrace _

theorem reversedChargeReversesField (value : Scalar) (charge : Charge) :
 FieldElectricPotential.normalizeCharge value (FieldElectricDistinction.reverse charge) =
 SFT.Mathematics.FoldScalar.reverse (FieldElectricPotential.normalizeCharge value charge) :=
 FieldElectricPotential.reversedChargeReversesResponse value charge

theorem recurrenceRetainsCharge (r : RestoringResponse Part Support State ClockState Clock)
 (step : MechanicalEvents.Row State) :
 (FieldInduction.electricResponse r.coupling.field.induction step).charge = r.coupling.transfer.carrier :=
 CollectivePlasma.coupledMotionRetainsCarrier _ step

structure ScreenedResponse where
 cells : CollectiveCoarseGrain.NetworkObservation
 left : String
 right : String
 leftPresent : left ∈ cells.graph.nodes
 rightPresent : right ∈ cells.graph.nodes

def screened (s : ScreenedResponse) : Prop := CollectiveCoarseGrain.sameMacroClass s.cells s.left s.right

theorem screeningExactlyClosedObservation (s : ScreenedResponse) : screened s ↔
 SFT.Mathematics.GeometryTopology.image s.cells.observation s.left =
 SFT.Mathematics.GeometryTopology.image s.cells.observation s.right := by
 constructor
 · intro h
   obtain ⟨label,_,_,left,right⟩ := (CollectiveCoarseGrain.sameClassExactly _ _ _).mp h
   exact left.trans right.symm
 · intro h
   obtain ⟨label,members,row,member,_⟩ := CollectiveCoarseGrain.everyCellHasUniqueClass s.cells s.left s.leftPresent
   have full := CollectiveCoarseGrain.everyClassIsCompleteFibre s.cells label members row
   rw [full] at member
   have left := ((CollectiveCoarseGrain.exactRegion s.cells label s.left).mp member).2
   apply (CollectiveCoarseGrain.sameClassExactly _ _ _).mpr
   exact ⟨label,s.leftPresent,s.rightPresent,left,h.symm.trans left⟩

theorem screenedSourceRetained (s : ScreenedResponse) (_ : screened s) :
 s.left ∈ s.cells.graph.nodes ∧ s.right ∈ s.cells.graph.nodes := ⟨s.leftPresent,s.rightPresent⟩

theorem distinctObservationNotScreened (s : ScreenedResponse)
 (different : SFT.Mathematics.GeometryTopology.image s.cells.observation s.left ≠
 SFT.Mathematics.GeometryTopology.image s.cells.observation s.right) : ¬ screened s :=
 fun h => different ((screeningExactlyClosedObservation s).mp h)

abbrev arbitraryRestoringPath := @MechanicalConstraintOscillation.finiteClosedRestoration
abbrev arbitraryPeriod := @MechanicalConstraintOscillation.arbitraryPeriodExact
abbrev completeChargeConservation := @CollectivePlasma.collectiveChargeConserved
end SFT.Physics.CollectivePlasmaOscillation
