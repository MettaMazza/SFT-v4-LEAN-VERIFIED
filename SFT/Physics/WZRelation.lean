import SFT.Physics.ElectroweakMixing
import SFT.Physics.CommonScaleAxisProofs
namespace SFT.Physics.WZRelation
open SFT.Foundation ExactOperations ExactPartCarrier ElectroweakMixing

def squaredRatio : Except String Part := do
 let channels ← mixing
 .ok channels.cosSquared

theorem sourceAssembly : squaredRatio=.ok threeQuarters := by
 unfold squaredRatio;rw [nativeMixing];rfl

theorem exactReading : threeQuarters.numerator=3 ∧ threeQuarters.denominator=4 := ⟨rfl,rfl⟩
theorem lowerReassembles : (FoldDynamics.sumParts quarter threeQuarters).numerator=
 (FoldDynamics.sumParts quarter threeQuarters).denominator := partitionOne

theorem everyPositiveScaleRetainsRatio (q f : Nat) (hq : 0<q) (hf : 0<f) :
 CommonScaleAxis.commonRationalRescalingRatio
 (.fraction (VacuumLedgerProofs.natRatio 3 4 (by decide)))
 (.fraction (VacuumLedgerProofs.natRatio 1 1 (by decide)))
 (.fraction (VacuumLedgerProofs.natRatio q f hf))=
 LeptonRatios.divide (VacuumLedgerProofs.natRatio 3 4 (by decide)) (VacuumLedgerProofs.natRatio 1 1 (by decide)) :=
 CommonScaleAxis.commonUnitCancellation 3 4 1 1 q f (by decide) (by decide) (by decide) (by decide) hq hf
end SFT.Physics.WZRelation
