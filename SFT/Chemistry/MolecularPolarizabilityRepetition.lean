import SFT.Chemistry.MolecularPolarizability
namespace SFT.Chemistry.MolecularPolarizabilityRepetition
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues
open SFT.Chemistry.MolecularPolarizability SFT.Chemistry.DihedralTorsion
open SFT.Foundation.ExactOperations VacuumLedgerProofs VacuumScaleProofs LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
-- Exact relation between V3's returned PositiveRatio counts and Fraction arithmetic.
private theorem normalizedFields (n d : Nat) (hn : 0<n) (hd : 0<d) :
 ratioPair (normalizedRatio n d hn hd)=((natRatio n d hd).num.natAbs,(natRatio n d hd).den) := by
 cases n with
 | zero => cases hn
 | succ n => rfl
private theorem normalizedFraction (n d : Nat) (hn : 0<n) (hd : 0<d) :
 natRatio (normalizedRatio n d hn hd).numerator.value (normalizedRatio n d hn hd).denominator.value
  (normalizedRatio n d hn hd).denominator.positive = natRatio n d hd := by
 exact (positiveCarrierRepresentation (normalizePositive n d hn hd)).symm.trans (by
  cases n with
  | zero => cases hn
  | succ n => rfl)
private theorem responseMeaning (c : Component) :
 LeptonRatios.divide
  (natRatio c.induced.numerator.value c.induced.denominator.value c.induced.denominator.positive)
  (natRatio c.electric.numerator.value c.electric.denominator.value c.electric.denominator.positive)=
 .ok (natRatio (exactResponse c).numerator.value (exactResponse c).denominator.value (exactResponse c).denominator.positive) := by
 rw [divideNormalized _ _ _ _ _ c.electric.numerator.positive _]
 exact congrArg Except.ok (normalizedFraction _ _ _ _).symm
private theorem responseFields (c : Component) :
 ratioPair (exactResponse c)=
 ((natRatio (exactResponse c).numerator.value (exactResponse c).denominator.value (exactResponse c).denominator.positive).num.natAbs,
  (natRatio (exactResponse c).numerator.value (exactResponse c).denominator.value (exactResponse c).denominator.positive).den) := by
 rw [show natRatio (exactResponse c).numerator.value (exactResponse c).denominator.value (exactResponse c).denominator.positive =
  natRatio (c.induced.numerator.value*c.electric.denominator.value)
   (c.induced.denominator.value*c.electric.numerator.value)
   (Nat.mul_pos c.induced.denominator.positive c.electric.numerator.positive) from normalizedFraction _ _ _ _]
 exact normalizedFields _ _ _ _
-- The actual returned component preserves its exact response for every positive count.
theorem everyEqualFieldRepetition (c : Component) (k : PositiveCount) :
 (repeatedEqualFieldResponse (.component c) (.count k)).map (fun row => ratioPair (exactResponse row)) =
 .ok (ratioPair (exactResponse c)) := by
 let next : Component := ⟨c.axis,
   normalizedRatio (c.induced.numerator.value*k.value) c.induced.denominator.value
    (Nat.mul_pos c.induced.numerator.positive k.positive) c.induced.denominator.positive,
   normalizedRatio (c.electric.numerator.value*k.value) c.electric.denominator.value
    (Nat.mul_pos c.electric.numerator.positive k.positive) c.electric.denominator.positive⟩
 change Except.ok (ratioPair (exactResponse next)) = Except.ok (ratioPair (exactResponse c))
 have same : LeptonRatios.divide
  (natRatio next.induced.numerator.value next.induced.denominator.value next.induced.denominator.positive)
  (natRatio next.electric.numerator.value next.electric.denominator.value next.electric.denominator.positive)=
  LeptonRatios.divide
  (natRatio c.induced.numerator.value c.induced.denominator.value c.induced.denominator.positive)
  (natRatio c.electric.numerator.value c.electric.denominator.value c.electric.denominator.positive) := by
  dsimp only [next]
  rw [normalizedFraction,normalizedFraction]
  have original := CommonScaleAxis.commonUnitCancellation
   c.induced.numerator.value c.induced.denominator.value
   c.electric.numerator.value c.electric.denominator.value k.value 1
   c.induced.numerator.positive c.induced.denominator.positive
   c.electric.numerator.positive c.electric.denominator.positive k.positive (by decide)
  dsimp only [CommonScaleAxis.commonRationalRescalingRatio] at original
  rw [positiveNormalized _ _ c.induced.numerator.positive,positiveNormalized _ _ c.electric.numerator.positive,
   positiveNormalized _ _ k.positive] at original
  rw [multiplyNormalized,multiplyNormalized] at original
  change LeptonRatios.divide (natRatio (c.induced.numerator.value*k.value) (c.induced.denominator.value*1) _)
   (natRatio (c.electric.numerator.value*k.value) (c.electric.denominator.value*1) _) = _ at original
  simpa only [Nat.mul_one] using original
 rw [responseMeaning,responseMeaning] at same
 have fields := congrArg (fun q : Rat => (q.num.natAbs,q.den)) (Except.ok.inj same)
 apply congrArg Except.ok
 exact (responseFields next).trans (fields.trans (responseFields c).symm)
end SFT.Chemistry.MolecularPolarizabilityRepetition
