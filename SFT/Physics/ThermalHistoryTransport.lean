import SFT.Physics.ThermalHistory
import SFT.Physics.GravitySourceProofs
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.ThermalHistoryTransport
open ThermalHistory LeptonIntervals VacuumLedgerProofs VacuumScaleProofs GravitySourceProofs
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar
set_option maxHeartbeats 100000000
-- The original source's exact positive temperature and scale carriers.
theorem admittedPositive (p : PositiveFraction) (name : String) :
 requirePositive (BoundaryGrowth.asFraction p) name = .ok (BoundaryGrowth.asFraction p) := by
 unfold requirePositive
 have h : zero.blt (BoundaryGrowth.asFraction p) = true := by
  rw [positiveCarrierRepresentation]
  exact positiveNormalized p.numerator p.denominator p.positive (Nat.pos_of_ne_zero p.denominatorNonzero)
 rw [h]
 rfl

theorem originalInverseTransport (temperature growth : PositiveFraction) :
 transportedTemperature (BoundaryGrowth.asFraction temperature) (BoundaryGrowth.asFraction growth) =
 .ok (BoundaryGrowth.asFraction (quotientMagnitude temperature growth)) := by
 unfold transportedTemperature
 rw [admittedPositive,admittedPositive]
 dsimp only [Except.bind,Bind.bind]
 exact sourceQuotient temperature growth

theorem originalHeldProduct (temperature growth : PositiveFraction) :
 (do let later ← transportedTemperature (BoundaryGrowth.asFraction temperature) (BoundaryGrowth.asFraction growth)
     pure (multiply later (BoundaryGrowth.asFraction growth))) =
 .ok (BoundaryGrowth.asFraction temperature) := by
 rw [originalInverseTransport]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,InverseSquare.recomposes]
 rfl
theorem originalInvariant (temperature growth : PositiveFraction) :
 temperatureScaleInvariant (BoundaryGrowth.asFraction temperature) (BoundaryGrowth.asFraction growth) = .ok true := by
 unfold temperatureScaleInvariant
 rw [originalInverseTransport]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,InverseSquare.recomposes]
 apply congrArg Except.ok
 exact decide_eq_true rfl
end SFT.Physics.ThermalHistoryTransport
