import SFT.Physics.MagneticSquare
import SFT.Physics.CommonScaleAxisAlgebra
import SFT.Foundation.FoldCastLaws
namespace SFT.Physics.MagneticCovariance
open SFT.Foundation ExactOperations ExactPartCarrier FractionReduction ExactCast FoldCastLaws
open VacuumLedgerProofs VacuumScaleProofs LeptonIntervals

private theorem addCancel (a b c : Nat) (h : a+b=a+c) : b=c := by
 induction a with
 | zero => rw [Nat.zero_add,Nat.zero_add] at h;exact h
 | succ a ih => rw [Nat.succ_add,Nat.succ_add] at h;exact ih (Nat.succ.inj h)

private theorem cancelRightBound (a b k : Nat) (h : a+k≤b+k) : a≤b := by
 induction k with
 | zero => exact h
 | succ k ih =>
  rw [Nat.add_succ,Nat.add_succ] at h
  exact ih (Nat.le_of_succ_le_succ h)

theorem lowerComplementCounts (a b : Nat) (ap : 0<a) (less : a<b) :
 castNumerator (a+a) (a+b)=a+a ∧
 castNumerator (b+b) (a+b)=(b+b)-(a+b) ∧
 castNumerator (a+a) (a+b)+castNumerator (b+b) (a+b)=a+b := by
 have dp := Nat.add_pos_left ap b
 have first := castRetains (a+a) (a+b) dp (Nat.add_le_add_left (Nat.le_of_lt less) a)
 have excess : a+b<b+b := Nat.add_lt_add_right less b
 have small : (b+b)-(a+b)≤a+b := by
  have short : (b+b)-(a+b)≤b := by
   have total : b+b≤b+(a+b) := Nat.add_le_add_left (Nat.le_add_left b a) b
   have reconstructed := subtractAdd (b+b) (a+b) (Nat.le_of_lt excess)
   have comparison : ((b+b)-(a+b))+(a+b)≤b+(a+b) := by rw [reconstructed];exact total
   exact cancelRightBound _ _ _ comparison
  exact Nat.le_trans short (Nat.le_add_left b a)
 have second := (castRemoves (b+b) (a+b) dp excess).trans
   (castRetains _ _ dp small)
 refine ⟨first,second,?_⟩
 rw [first,second]
 apply addCancel (a+b)
 have h := subtractAdd (b+b) (a+b) (Nat.le_of_lt excess)
 calc
  (a+b)+((a+a)+((b+b)-(a+b))) = (a+a)+(((b+b)-(a+b))+(a+b)) := by
   conv => lhs;simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
   conv => rhs;simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
  _=(a+a)+(b+b) := congrArg (fun x => (a+a)+x) h
  _=(a+b)+(a+b) := by
   conv => lhs;simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
   conv => rhs;simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]

theorem complementaryCounts (n d : Nat) (positive : 0<n) (proper : n<d) (notHalf : n+n≠d) :
 castNumerator (n+n) d+castNumerator ((d-n)+(d-n)) d=d := by
 have rem := subtractAdd d n (Nat.le_of_lt proper)
 have rp := subtractPositive d n proper
 have partition : n+(d-n)=d := (Nat.add_comm _ _).trans rem
 if less : n<d-n then
  have h := (lowerComplementCounts n (d-n) positive less).2.2
  rw [partition] at h
  exact h
 else
  have ne : n≠d-n := by
   intro same
   exact notHalf ((congrArg (fun x => n+x) same).trans partition)
  have greater : d-n<n := Nat.lt_of_le_of_ne (Nat.le_of_not_gt less) (fun h => ne h.symm)
  have h := (lowerComplementCounts (d-n) n rp greater).2.2
  rw [rem] at h
  exact (Nat.add_comm _ _).trans h

theorem normalizedPartRatio (n d : Nat) (hn : 0<n) (nd : n≤d) :
 asFraction (normalizePart n d hn nd)=natRatio n d (Nat.lt_of_lt_of_le hn nd) := by
 cases n with
 | zero => cases hn
 | succ n => rfl

theorem normalizedProper (n d : Nat) (hn : 0<n) (nd : n<d) :
 (normalizePart n d hn (Nat.le_of_lt nd)).numerator <
 (normalizePart n d hn (Nat.le_of_lt nd)).denominator := by
 let p := normalizePart n d hn (Nat.le_of_lt nd)
 have val := normalizedValuePreserved n d hn (Nat.lt_trans hn nd)
 have less := Nat.mul_lt_mul_of_pos_right nd (denominatorPositive p)
 change n*p.denominator=p.numerator*d at val
 rw [val] at less
 apply Nat.lt_of_not_ge
 intro opposite
 exact Nat.not_lt_of_ge (Nat.mul_le_mul_right d opposite)
  (by rw [Nat.mul_comm d p.denominator] at less;exact less)

theorem subtractOnePart (p : Part) (proper : p.numerator<p.denominator) :
 subtract (asFraction one) (asFraction p)=
 natRatio (p.denominator-p.numerator) p.denominator (denominatorPositive p) := by
 have diff : Int.ofNat p.denominator-Int.ofNat p.numerator=Int.ofNat (p.denominator-p.numerator) := by
  cases hn : p.numerator with
  | zero => rfl
  | succ n =>
   change Int.subNatNat p.denominator (n+1)=_
   unfold Int.subNatNat
   have bound : n+1≤p.denominator := by rw [← hn];exact Nat.le_of_lt proper
   rw [CommonScaleAxis.subtractionZeroOfBound _ _ bound]
 have right : Int.ofNat p.numerator*1=Int.ofNat p.numerator := congrArg Int.ofNat (Nat.mul_one _)
 have raw : (1:Int)*Int.ofNat p.denominator-Int.ofNat p.numerator*1=Int.ofNat (p.denominator-p.numerator) := by
  rw [Int.one_mul,right];exact diff
 have first := congrArg (fun n : Int => normalize n (1*p.denominator)
   (Nat.mul_pos (by decide) (denominatorPositive p))) raw
 change subtract (asFraction one) (asFraction p)=_ at first
 exact first.trans (by unfold natRatio; congr 1;exact Nat.one_mul _)

theorem subtractOneNormalized (n d : Nat) (hn : 0<n) (proper : n<d) :
 subtract (asFraction one) (natRatio n d (Nat.lt_trans hn proper))=
 natRatio (d-n) d (Nat.lt_trans hn proper) := by
 let p := normalizePart n d hn (Nat.le_of_lt proper)
 rw [← normalizedPartRatio n d hn (Nat.le_of_lt proper),subtractOnePart _ (normalizedProper n d hn proper)]
 apply natRatioCongruence
 have val := normalizedValuePreserved n d hn (Nat.lt_trans hn proper)
 change n*p.denominator=p.numerator*d at val
 change (p.denominator-p.numerator)*d=(d-n)*p.denominator
 rw [Nat.mul_comm (p.denominator-p.numerator) d,← mulSubtract,
  Nat.mul_comm d p.numerator,← val,Nat.mul_comm (d-n) p.denominator,← mulSubtract]
 rw [Nat.mul_comm d p.denominator,Nat.mul_comm n p.denominator]

theorem foldRatio (n d : Nat) (hn : 0<n) (nd : n≤d) :
 asFraction (foldPart (normalizePart n d hn nd))=
 natRatio (castNumerator (n+n) d) d (Nat.lt_of_lt_of_le hn nd) := by
 rw [FoldCastLaws.foldNormalized,normalizedPartRatio]

theorem foldComplement (n d : Nat) (hn : 0<n) (proper : n<d) (notHalf : n+n≠d) :
 asFraction (foldPart (normalizePart (d-n) d (subtractPositive d n proper) (Nat.sub_le d n)))=
 subtract (asFraction one) (asFraction (foldPart (normalizePart n d hn (Nat.le_of_lt proper)))) := by
 let a := castNumerator (n+n) d
 let b := castNumerator ((d-n)+(d-n)) d
 have dp := Nat.lt_trans hn proper
 have ap : 0<a := ExactCast.castPositive _ _ (Nat.add_pos_left hn _) dp
 have bp : 0<b := ExactCast.castPositive _ _ (Nat.add_pos_left (subtractPositive d n proper) _) dp
 have sum : a+b=d := complementaryCounts n d hn proper notHalf
 have ab : a<d := by rw [← sum];exact Nat.lt_add_of_pos_right bp
 have take : d-a=b := by rw [← sum,RunningConvergence.addSubtractLeft]
 rw [foldRatio,foldRatio,subtractOneNormalized _ _ ap ab]
 exact congrArg (fun x => natRatio x d dp) take.symm

theorem fromPairRatio (n d : Nat) (hn : 0<n) (nd : n≤d) :
 fromPair (natRatio n d (Nat.lt_of_lt_of_le hn nd)).num
  (.ofNat (natRatio n d (Nat.lt_of_lt_of_le hn nd)).den)=.ok (normalizePart n d hn nd) := by
 rw [← normalizedPartRatio n d hn nd]
 exact (fromPairAdmitted _ _ (normalizePart n d hn nd).positive
  (denominatorPositive _) (normalizePart n d hn nd).throughOne).trans
  (congrArg Except.ok (normalizationStable _))

private theorem integerSelfNotLess (a : Nat) : ¬Int.ofNat a<Int.ofNat a := by
 intro h
 change Int.NonNeg (Int.subNatNat a (a+1)) at h
 unfold Int.subNatNat at h
 rw [RunningConvergence.addSubtractLeft a 1] at h
 cases h

theorem positiveNotLessSelf (p : PositiveFraction) : (BoundaryGrowth.asFraction p).blt (BoundaryGrowth.asFraction p)=false := by
 cases p with
 | mk n d dz reduced positive =>
  cases n with
  | zero => cases positive
  | succ n =>
   unfold Rat.blt BoundaryGrowth.asFraction
   dsimp only
   have notNeg : ¬Int.ofNat (n+1)<0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (n+2)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   have notZero : Int.ofNat (n+1)≠0 := fun h => Nat.noConfusion (congrArg Int.toNat h)
   have notNonpos : ¬Int.ofNat (n+1)≤0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (n+1)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   rw [decide_eq_false notNeg,ite_eq_right notZero,decide_eq_false notNonpos,Bool.and_false,Bool.false_and]
   exact decide_eq_false (integerSelfNotLess ((n+1)*d))

theorem partNotLessSelf (p : Part) : (asFraction p).blt (asFraction p)=false :=
 positiveNotLessSelf ⟨p.numerator,p.denominator,p.denominatorNonzero,p.reduced,p.positive⟩

end SFT.Physics.MagneticCovariance
