import SFT.Physics.BoundaryGrowth
import SFT.Physics.FieldGeometricDilution
import SFT.Mathematics.FoldScalar
namespace SFT.Physics.InverseSquare
open SFT.Foundation.ExactOperations BoundaryGrowth
open SFT.Physics.FoldFirstReturn SFT.Physics.GeneratorOperations
open SFT.Mathematics.FoldScalar

-- Original guards and their precedence: validate the source before distance.
def response : Input → Input → Except String PositiveFraction
 | .nonFraction,_ => .error "ValueError: source support must be an exact positive carrier"
 | .fraction source,distance => match admitPositive source with
   | none => .error "ValueError: source support must be an exact positive carrier"
   | some source => do
     let growth ← boundaryGrowth distance
     pure (quotientMagnitude source growth)

def exactResponse (source distance : PositiveFraction) :=
 quotientMagnitude source (BoundaryGrowth.multiply distance distance)

theorem responseAdmitted (source distance : PositiveFraction)
 (above : distance.denominator<distance.numerator) :
 response (.fraction (asFraction source)) (.fraction (asFraction distance))=.ok (exactResponse source distance) := by
 unfold response
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [growthAdmitted distance above]
 rfl

theorem responseBoundary (source distance : PositiveFraction)
 (notAbove : ¬distance.denominator<distance.numerator) :
 response (.fraction (asFraction source)) (.fraction (asFraction distance))=
 .error "ValueError: distance ratio must be exact and above the One" := by
 unfold response
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [growthBoundary distance notAbove]
 rfl

theorem sourceGuardFirst (distance : Input) : response .nonFraction distance=
 .error "ValueError: source support must be an exact positive carrier" := rfl

theorem exactDivision (source distance : PositiveFraction) :
 (source.numerator*(BoundaryGrowth.multiply distance distance).denominator)*(exactResponse source distance).denominator=
 (exactResponse source distance).numerator*(source.denominator*(BoundaryGrowth.multiply distance distance).numerator) :=
 quotientExact _ _

-- General conservation identity for the already generated positive boundary growth.
theorem recomposes (source growth : PositiveFraction) :
 BoundaryGrowth.multiply (quotientMagnitude source growth) growth=source := by
 apply FieldGeometricDilution.positiveNormalizationRepresents
 have h := quotientExact source growth
 change (quotientMagnitude source growth).numerator*growth.numerator*source.denominator=
  source.numerator*((quotientMagnitude source growth).denominator*growth.denominator)
 calc
  _ = (quotientMagnitude source growth).numerator*(source.denominator*growth.numerator) := by
   rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm growth.numerator source.denominator]
  _ = (source.numerator*growth.denominator)*(quotientMagnitude source growth).denominator := h.symm
  _ = _ := by rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm growth.denominator (quotientMagnitude source growth).denominator]

theorem conservedAtEveryScale (source distance : PositiveFraction) :
 BoundaryGrowth.multiply (exactResponse source distance) (BoundaryGrowth.multiply distance distance)=source :=
 recomposes _ _

theorem uniqueConservedResponse (source growth candidate : PositiveFraction)
 (conserved : source.numerator*growth.denominator*candidate.denominator=
  candidate.numerator*(source.denominator*growth.numerator)) :
 candidate=quotientMagnitude source growth := by
 exact (FieldGeometricDilution.positiveNormalizationRepresents
  (source.numerator*growth.denominator) (source.denominator*growth.numerator)
  (Nat.mul_pos source.positive (Nat.pos_of_ne_zero growth.denominatorNonzero))
  (Nat.mul_pos (Nat.pos_of_ne_zero source.denominatorNonzero) growth.positive) candidate conserved).symm.trans
  (FieldGeometricDilution.positiveNormalizationRepresents
   (source.numerator*growth.denominator) (source.denominator*growth.numerator)
   (Nat.mul_pos source.positive (Nat.pos_of_ne_zero growth.denominatorNonzero))
   (Nat.mul_pos (Nat.pos_of_ne_zero source.denominatorNonzero) growth.positive)
   (quotientMagnitude source growth) (quotientExact source growth))

def pairDistribution (source : PositiveFraction) (left right : List String)
 (positive : 0<(SpatialStability.pairCells left right).length) : FieldGeometricDilution.Distribution (String×String) :=
 ⟨source,SpatialStability.pairCells left right,positive⟩

theorem allPairCellsRetained (source : PositiveFraction) (left right : List String)
 (positive : 0<(SpatialStability.pairCells left right).length) :
 (FieldGeometricDilution.responses (pairDistribution source left right positive)).map Prod.fst=
 SpatialStability.pairCells left right := FieldGeometricDilution.allBoundaryCellsRetained _

theorem squareShare (source : PositiveFraction) (left right : List String) (scale : Nat)
 (positive : 0<(SpatialStability.pairCells left right).length)
 (first : left.length=scale) (second : right.length=scale) :
 source.numerator*(FieldGeometricDilution.share (pairDistribution source left right positive)).denominator=
 (FieldGeometricDilution.share (pairDistribution source left right positive)).numerator*(source.denominator*(scale*scale)) := by
 have h := FieldGeometricDilution.exactShare (pairDistribution source left right positive)
 change source.numerator*_=_*(source.denominator*(SpatialStability.pairCells left right).length) at h
 rw [BoundarySupport.scaledPairCount left right scale first second] at h
 exact h

end SFT.Physics.InverseSquare
