import SFT.Physics.QuantumSupportParseval
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.QuantumSupportNormalization
open QuantumSupportPreparation QuantumSupportParseval LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.PrimitiveMaps CommonScaleAxis
set_option maxHeartbeats 100000000
private theorem crossNotLess (n d m e : Nat) (hd : 0<d) (he : 0<e) (cross : m*d≤n*e) :
 (natRatio m e he).num.natAbs*(natRatio n d hd).den ≤
 (natRatio n d hd).num.natAbs*(natRatio m e he).den := by
 let a := natRatio n d hd
 let b := natRatio m e he
 have av := natRatioValue n d hd
 have bv := natRatioValue m e he
 have left : (a.num.natAbs*b.den)*(d*e)=(n*e)*(a.den*b.den) := by
  calc
   (a.num.natAbs*b.den)*(d*e)=(a.num.natAbs*d)*(b.den*e) := mulInterchange _ _ _ _
   _ = (n*a.den)*(b.den*e) := congrArg (fun x=>x*(b.den*e)) av.symm
   _ = (n*e)*(a.den*b.den) := by
    conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
    conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
 have right : (b.num.natAbs*a.den)*(d*e)=(m*d)*(a.den*b.den) := by
  calc
   (b.num.natAbs*a.den)*(d*e)=(b.num.natAbs*e)*(a.den*d) := by
    conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
    conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
   _ = (m*b.den)*(a.den*d) := congrArg (fun x=>x*(a.den*d)) bv.symm
   _ = (m*d)*(a.den*b.den) := by
    conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
    conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
 have scaled : (b.num.natAbs*a.den)*(d*e)≤(a.num.natAbs*b.den)*(d*e) := by
  rw [left,right]
  exact Nat.mul_le_mul_right _ cross
 apply Nat.le_of_not_gt
 intro opposite
 exact Nat.not_lt_of_ge scaled (Nat.mul_lt_mul_of_pos_right opposite (Nat.mul_pos hd he))
private theorem integerNotLess (a b : Nat) (bound : b≤a) : ¬Int.ofNat a<Int.ofNat b := by
 intro h
 change Int.NonNeg (Int.subNatNat b (a+1)) at h
 unfold Int.subNatNat at h
 cases hd : (a+1)-b with
 | zero => exact Nat.not_succ_le_self a (Nat.le_trans (Nat.le_of_sub_eq_zero hd) bound)
 | succ k => rw [hd] at h;cases h
private theorem positiveRatioNotLess (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : m*d≤n*e) : (natRatio n d hd).blt (natRatio m e he)=false := by
 have ap := positiveNormalizedNumerator n d hn hd
 have bp := positiveNormalizedNumerator m e hm he
 have bound := crossNotLess n d m e hd he cross
 unfold Rat.blt
 rw [natRatioNonnegative n d hd,natRatioNonnegative m e he]
 generalize ha : (natRatio n d hd).num.natAbs=na at ap bound ⊢
 generalize hb : (natRatio m e he).num.natAbs=nb at bp bound ⊢
 cases na with
 | zero => cases ap
 | succ na =>
  cases nb with
  | zero => cases bp
  | succ nb =>
   have notNeg : ¬Int.ofNat (na+1)<0 := by
    intro h;change Int.NonNeg (Int.subNatNat 0 (na+2)) at h
    unfold Int.subNatNat at h;rw [Nat.sub_zero] at h;cases h
   have notZero : Int.ofNat (na+1)≠0 := fun h=>Nat.noConfusion (congrArg Int.toNat h)
   have notNonpos : ¬Int.ofNat (nb+1)≤0 := by
    intro h;change Int.NonNeg (Int.subNatNat 0 (nb+1)) at h
    unfold Int.subNatNat at h;rw [Nat.sub_zero] at h;cases h
   rw [decide_eq_false notNeg,ite_eq_right notZero,decide_eq_false notNonpos,Bool.and_false,Bool.false_and]
   change decide (Int.ofNat ((na+1)*(natRatio m e he).den)<Int.ofNat ((nb+1)*(natRatio n d hd).den))=false
   exact decide_eq_false (integerNotLess _ _ bound)

theorem originalUnitFreeBound (d : Nat) (selected : List Word)
 (hs : ∀ x,x∈selected → x∈words d) (unique : selected.Nodup) (nonempty : 0<selected.length) :
 (!(natRatio (selected.length*frequencySupport selected (words d)) (2^d) (Nat.pow_pos (by decide))).blt (wholeRatio 1))=true := by
 have bound := originalSupportProductBound d selected hs unique nonempty
 have pos := Nat.lt_of_lt_of_le (Nat.pow_pos (by decide : 0<2)) bound
 rw [←natRatioWhole 1,positiveRatioNotLess _ _ 1 1 pos _ (by decide) (by decide)]
 rfl
 rw [Nat.one_mul,Nat.mul_one];exact bound

theorem originalSquaredProduct (st sf n : Nat) (hn : 0<n) :
 multiply (multiply (natRatio st n hn) (natRatio st n hn)) (multiply (natRatio sf n hn) (natRatio sf n hn))=
 natRatio ((st*sf)*(st*sf)) ((n*n)*(n*n)) (Nat.mul_pos (Nat.mul_pos hn hn) (Nat.mul_pos hn hn)) := by
 rw [multiplyNormalized,multiplyNormalized,multiplyNormalized]
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]

theorem originalSquaredGridBound (d : Nat) (selected : List Word)
 (hs : ∀ x,x∈selected → x∈words d) (unique : selected.Nodup) (nonempty : 0<selected.length) :
 (!(multiply (multiply (natRatio selected.length (2^d) (Nat.pow_pos (by decide))) (natRatio selected.length (2^d) (Nat.pow_pos (by decide))))
  (multiply (natRatio (frequencySupport selected (words d)) (2^d) (Nat.pow_pos (by decide))) (natRatio (frequencySupport selected (words d)) (2^d) (Nat.pow_pos (by decide))))).blt
  (natRatio 1 ((2^d)*(2^d)) (Nat.mul_pos (Nat.pow_pos (by decide)) (Nat.pow_pos (by decide)))))=true := by
 have bound := originalSupportProductBound d selected hs unique nonempty
 have pos := Nat.lt_of_lt_of_le (Nat.pow_pos (by decide : 0<2)) bound
 have squared := Nat.le_trans (Nat.mul_le_mul_left (2^d) bound) (Nat.mul_le_mul_right (selected.length*frequencySupport selected (words d)) bound)
 rw [originalSquaredProduct,positiveRatioNotLess _ _ 1 _ (Nat.mul_pos pos pos) _ (by decide)]
 rfl
 rw [Nat.one_mul,Nat.mul_comm ((2^d)*(2^d))]
 exact Nat.mul_le_mul_right _ squared

theorem originalSpacingCancellation (st sf n p q : Nat) (hn : 0<n) (hp : 0<p) (hq : 0<q) :
 (do
  let frequency ← LeptonRatios.divide (←LeptonRatios.divide (wholeRatio sf) (wholeRatio n)) (natRatio p q hq)
  pure (multiply (multiply (wholeRatio st) (natRatio p q hq)) frequency))=
 Except.ok (ε:=String) (natRatio (st*sf) n hn) := by
 rw [←natRatioWhole sf,←natRatioWhole n,divideNormalized sf 1 n 1 (by decide) hn (by decide)]
 change (do let frequency ← LeptonRatios.divide (natRatio (sf*1) (1*n) _) (natRatio p q hq)
            pure (multiply (multiply (wholeRatio st) (natRatio p q hq)) frequency))=_
 rw [divideNormalized _ _ _ _ _ hp hq]
 change Except.ok (ε:=String) (multiply (multiply (wholeRatio st) (natRatio p q hq)) (natRatio ((sf*1)*q) ((1*n)*p) _))=_
 rw [←natRatioWhole st,multiplyNormalized,multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.mul_one,Nat.one_mul]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.mul_one,Nat.one_mul]
theorem originalEveryPositiveSpacing (st sf n : Nat) (hn : 0<n) (spacing : Rat)
 (positive : zero.blt spacing=true) :
 (do
  let frequency ← LeptonRatios.divide (←LeptonRatios.divide (wholeRatio sf) (wholeRatio n)) spacing
  pure (multiply (multiply (wholeRatio st) spacing) frequency))=
 Except.ok (ε:=String) (natRatio (st*sf) n hn) := by
 cases hnum : spacing.num with
 | negSucc k =>
   have rejected : zero.blt spacing=false := by unfold Rat.blt zero;rw [hnum];rfl
   exact False.elim (Bool.noConfusion (rejected.symm.trans positive))
 | ofNat k =>
   cases k with
   | zero =>
     have rejected : zero.blt spacing=false := by unfold Rat.blt zero;rw [hnum];rfl
     exact False.elim (Bool.noConfusion (rejected.symm.trans positive))
   | succ k =>
     have repr : spacing=natRatio (k+1) spacing.den (Nat.pos_of_ne_zero spacing.den_nz) := by
       apply representedIdentity
       · rw [hnum];rfl
       · rw [hnum];rfl
     rw [repr]
     exact originalSpacingCancellation st sf n (k+1) spacing.den hn (Nat.zero_lt_succ _) _
end SFT.Physics.QuantumSupportNormalization
