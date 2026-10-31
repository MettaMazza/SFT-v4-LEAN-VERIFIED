import SFT.Physics.FoldFirstReturn
import SFT.Physics.GeneratorOperations
import SFT.Physics.MatterHadrons
namespace SFT.Physics.ColourCouplingDerivation
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

def binaryCount : Except String Nat := do
  let generator ← FoldFirstReturn.generatorPeriod
  GeneratorOperations.positivePredecessor (.integer (.ofNat generator))

theorem binaryCountTwo : binaryCount = .ok 2 := by
  unfold binaryCount
  rw [FoldFirstReturn.generatorPeriodThree]
  rfl

def value : PositiveFraction := ratio 2 3 (by decide) (by decide)

def colourCoupling : Except String PositiveFraction := do
  let numerator ← binaryCount
  let denominator ← FoldFirstReturn.generatorPeriod
  if hn : 0 < numerator then
    if hd : 0 < denominator then .ok (ratio numerator denominator hn hd)
    else .error "generator support must be positive"
  else .error "participating support must be positive"

theorem forcedFromFoldAndGenerator : colourCoupling = .ok value := by
  unfold colourCoupling
  rw [binaryCountTwo,FoldFirstReturn.generatorPeriodThree]
  rfl

theorem exactReducedFields : value.numerator = 2 ∧ value.denominator = 3 := ⟨rfl,rfl⟩

def participatingLabels : List MechanicalLocation.Held := [.first,.second]

theorem bothHeldLabelsRetained (held : MechanicalLocation.Held) : held ∈ participatingLabels := by
  cases held
  · exact .head _
  · exact .tail _ (.head _)

theorem labelsRemainDistinct : (MechanicalLocation.Held.first : MechanicalLocation.Held) ≠ .second := by
  intro h; cases h

def replicated (copies : Nat) (positive : 0 < copies) :=
  ratio (copies * 2) (copies * 3) (Nat.mul_pos positive (by decide)) (Nat.mul_pos positive (by decide))

theorem everyCompleteReplicationSameRatio (copies : Nat) (positive : 0 < copies) : replicated copies positive = value := by
  apply FieldGeometricDilution.positiveNormalizationRepresents (copies * 2) (copies * 3)
    (Nat.mul_pos positive (by decide)) (Nat.mul_pos positive (by decide)) value
  change (copies * 2) * 3 = 2 * (copies * 3)
  rw [Nat.mul_comm copies 2]
  exact SFT.Foundation.FractionReduction.mulAssoc 2 copies 3

theorem uniqueNormalizedCoupling (candidate : PositiveFraction)
    (completeRatio : 2 * candidate.denominator = candidate.numerator * 3) : candidate = value :=
  (FieldGeometricDilution.positiveNormalizationRepresents 2 3 (by decide) (by decide) candidate completeRatio).symm
end SFT.Physics.ColourCouplingDerivation
