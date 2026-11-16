import SFT.Physics.ParticleModeFibres
namespace SFT.Physics.ParticleModeFibreDerivation
open ParticleModeFibres LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def offsetValue (m p q j : Nat) (hm : 0<m) (hq : 0<q) : Rat :=
 natRatio (p+j*q) (q*m) (Nat.mul_pos hq hm)

theorem originalOffsetFormula (m p q j : Nat) (hm : 0<m) (hq : 0<q) :
 fibreValue m (natRatio p q hq) j = .ok (offsetValue m p q j hm hq) := by
 have whole : wholeRatio j = natRatio (j*q) q hq := by
  rw [←natRatioWhole j]
  apply natRatioCongruence
  rw [Nat.mul_one]
 unfold fibreValue
 rw [whole,addNormalized,←natRatioWhole m,divideNormalized _ _ _ _ hq hm (by decide),Nat.mul_one]
 rfl

theorem originalOffsetReturn (m p q j : Nat) (hm : 0<m) (hq : 0<q) :
 multiply (wholeRatio m) (offsetValue m p q j hm hq) = add (natRatio p q hq) (wholeRatio j) := by
 have whole : wholeRatio j = natRatio (j*q) q hq := by
  rw [←natRatioWhole j];apply natRatioCongruence;rw [Nat.mul_one]
 rw [whole,addNormalized,←natRatioWhole m]
 unfold offsetValue
 rw [multiplyNormalized]
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.mul_comm m (p+j*q),SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm m q]

theorem originalOffsetInjective (m p q i j : Nat) (hm : 0<m) (hq : 0<q)
 (same : offsetValue m p q i hm hq = offsetValue m p q j hm hq) : i=j := by
 have hi := natRatioValue (p+i*q) (q*m) (Nat.mul_pos hq hm)
 have hj := natRatioValue (p+j*q) (q*m) (Nat.mul_pos hq hm)
 change (p+i*q)*(offsetValue m p q i hm hq).den =
  (offsetValue m p q i hm hq).num.natAbs*(q*m) at hi
 change (p+j*q)*(offsetValue m p q j hm hq).den =
  (offsetValue m p q j hm hq).num.natAbs*(q*m) at hj
 rw [same] at hi
 have equal := Nat.eq_of_mul_eq_mul_right
  (Nat.pos_of_ne_zero (offsetValue m p q j hm hq).den_nz) (hi.trans hj.symm)
 apply Nat.le_antisymm
 · apply Nat.le_of_not_gt
   intro h
   exact Nat.ne_of_lt (Nat.add_lt_add_left (Nat.mul_lt_mul_of_pos_right h hq) p) equal.symm
 · apply Nat.le_of_not_gt
   intro h
   exact Nat.ne_of_lt (Nat.add_lt_add_left (Nat.mul_lt_mul_of_pos_right h hq) p) equal

theorem originalOffsetInsideOne (m p q j : Nat) (hm : 0<m) (hp : 0<p) (hq : 0<q)
 (targetBound : p≤q) (offsetBound : j<m) :
 0<(offsetValue m p q j hm hq).num.natAbs ∧
 (offsetValue m p q j hm hq).num.natAbs≤(offsetValue m p q j hm hq).den := by
 have numeratorPositive : 0<p+j*q := Nat.lt_of_lt_of_le hp (Nat.le_add_right _ _)
 have bound : p+j*q≤q*m := by
  calc
   p+j*q≤q+j*q := Nat.add_le_add_right targetBound _
   _ = (j+1)*q := by rw [Nat.mul_comm (j+1) q,Nat.mul_add,Nat.mul_one,Nat.mul_comm q j,Nat.add_comm]
   _ ≤ m*q := Nat.mul_le_mul_right q (Nat.succ_le_of_lt offsetBound)
   _ = q*m := Nat.mul_comm _ _
 refine ⟨positiveNormalizedNumerator _ _ numeratorPositive (Nat.mul_pos hq hm),?_⟩
 have val := natRatioValue (p+j*q) (q*m) (Nat.mul_pos hq hm)
 change (p+j*q)*(offsetValue m p q j hm hq).den =
  (offsetValue m p q j hm hq).num.natAbs*(q*m) at val
 have scaled := Nat.mul_le_mul_right (offsetValue m p q j hm hq).den bound
 rw [val,Nat.mul_comm (q*m)] at scaled
 apply Nat.le_of_not_gt
 intro opposite
 exact Nat.not_lt_of_ge scaled (Nat.mul_lt_mul_of_pos_right opposite (Nat.mul_pos hq hm))

def completeOffsets (m p q : Nat) (hm : 0<m) (hq : 0<q) : List Rat :=
 (List.range m).map (fun j=>offsetValue m p q j hm hq)
theorem originalOffsetCount (m p q : Nat) (hm : 0<m) (hq : 0<q) :
 (completeOffsets m p q hm hq).length=m := by
 unfold completeOffsets
 rw [VacuumSpectrum.mappedLength]
 exact (VacuumSpectrum.rangeLoopLength m []).trans (Nat.add_zero _)
theorem originalOffsetRangeSuccessor (n : Nat) : List.range (n+1)=List.range n++[n] := rangeSuccessor n
#print axioms originalOffsetFormula
#print axioms originalOffsetReturn
#print axioms originalOffsetInjective
#print axioms originalOffsetInsideOne
#print axioms originalOffsetCount
#print axioms originalOffsetRangeSuccessor
end SFT.Physics.ParticleModeFibreDerivation
