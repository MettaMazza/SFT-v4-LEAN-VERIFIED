import SFT.Physics.StaticExteriorClockCertificate
namespace SFT.Physics.StaticExteriorClockGeneral
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar
open LeptonIntervals GravitySourceProofs
set_option maxHeartbeats 100000000
theorem originalFieldFormula (horizon radius : PositiveFraction) :
 LeptonRatios.divide (BoundaryGrowth.asFraction horizon)
  (multiply (BoundaryGrowth.asFraction radius) (BoundaryGrowth.asFraction radius))=
 .ok (BoundaryGrowth.asFraction (InverseSquare.exactResponse horizon radius)) := by
 rw [sourceProduct,sourceQuotient]
 rfl
theorem originalFluxIdentity (horizon radius : PositiveFraction) :
 (do let field ← LeptonRatios.divide (BoundaryGrowth.asFraction horizon)
       (multiply (BoundaryGrowth.asFraction radius) (BoundaryGrowth.asFraction radius))
     pure (multiply (multiply field (BoundaryGrowth.asFraction radius)) (BoundaryGrowth.asFraction radius)))=
 .ok (BoundaryGrowth.asFraction horizon) := by
 rw [originalFieldFormula]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,sourceProduct,CoulombGauss.sequentialFluxReturnsSource]
 rfl
theorem originalWellRadiusIdentity (horizon radius : PositiveFraction) :
 (do let well ← LeptonRatios.divide (BoundaryGrowth.asFraction horizon) (BoundaryGrowth.asFraction radius)
     pure (multiply well (BoundaryGrowth.asFraction radius)))=.ok (BoundaryGrowth.asFraction horizon) := by
 rw [sourceQuotient]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,InverseSquare.recomposes]
 rfl
end SFT.Physics.StaticExteriorClockGeneral
