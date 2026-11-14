import SFT.Physics.LatticeCurvatureProofs
import SFT.Physics.CoupledEnsembleSynchronization
namespace SFT.Physics.CoupledEnsembleSynchronizationBalance
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
set_option maxHeartbeats 100000000
private theorem normalizedEqualityCross (n d m e : Nat) (hd : 0<d) (he : 0<e)
 (same : natRatio n d hd=natRatio m e he) : n*e=m*d := by
 have a := natRatioValue n d hd
 have b := natRatioValue m e he
 rw [same] at a
 have scaled : (n*e)*(natRatio m e he).den=(m*d)*(natRatio m e he).den := by
  rw [mulRightComm n e _,a,mulAssoc,mulRightComm m d _,b,mulAssoc,Nat.mul_comm d e]
 exact Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero (natRatio m e he).den_nz) scaled
-- Original balance_relation: the two equal coupled moves exhaust the separation.
-- Positive separation cancels; no historical ensemble or measured coordinate enters.
theorem equalMovesExhaustSeparationIffHalf (c d n e : Nat)
 (hd : 0<d) (hn : 0<n) (he : 0<e) :
 add (multiply (natRatio c d hd) (natRatio n e he))
     (multiply (natRatio c d hd) (natRatio n e he))=natRatio n e he ↔
 natRatio c d hd=CoupledEnsembleSynchronization.halfOneValue := by
 rw [multiplyNormalized,addNormalized,CoupledEnsembleSynchronization.halfOneValueExact]
 change natRatio (c*n+c*n) (d*e) _=natRatio n e he ↔ natRatio c d hd=natRatio 1 2 (by decide)
 constructor
 · intro balance
   have cross := normalizedEqualityCross (c*n+c*n) (d*e) n e (Nat.mul_pos hd he) he balance
   have counts : c+c=d := by
    have cancelled : c*n+c*n=n*d := Nat.eq_of_mul_eq_mul_right he (by rw [mulAssoc];exact cross)
    rw [←addMul,Nat.mul_comm n d] at cancelled
    exact Nat.eq_of_mul_eq_mul_right hn cancelled
   apply natRatioCongruence
   rw [Nat.mul_succ,Nat.mul_one,Nat.one_mul,counts]
 · intro half
   have cross := normalizedEqualityCross c d 1 2 hd (by decide) half
   have counts : c+c=d := by rw [Nat.mul_succ,Nat.mul_one,Nat.one_mul] at cross;exact cross
   apply natRatioCongruence
   rw [←addMul,counts,Nat.mul_comm d n,mulAssoc]
private theorem multiplyDifference (n m k : Nat) (bound : m≤n) : (n-m)*k=n*k-m*k := by
 conv => rhs;rw [← subtractAdd n m bound,addMul,Nat.add_comm ((n-m)*k) (m*k),RunningConvergence.addSubtractLeft]

private theorem subtractNormalized (n m d : Nat) (hd : 0<d) (bound : m≤n) :
 subtract (natRatio n d hd) (natRatio m d hd)=natRatio (n-m) d hd := by
 let a := natRatio n d hd
 let b := natRatio m d hd
 have av := natRatioValue n d hd
 have bv := natRatioValue m d hd
 have avc : (a.num.natAbs*b.den)*d=n*(a.den*b.den) := by
  rw [mulRightComm,← av,mulAssoc]
 have bvc : (b.num.natAbs*a.den)*d=m*(a.den*b.den) := by
  rw [mulRightComm,← bv,mulAssoc,Nat.mul_comm b.den a.den]
 have ordered : b.num.natAbs*a.den≤a.num.natAbs*b.den := by
  apply Nat.le_of_mul_le_mul_right _ hd
  rw [avc,bvc]
  exact Nat.mul_le_mul_right _ bound
 have intDiff : Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)=
  Int.ofNat (a.num.natAbs*b.den-b.num.natAbs*a.den) := by
  generalize h : b.num.natAbs*a.den = k at ordered ⊢
  cases k with
  | zero => rw [Nat.sub_zero];rfl
  | succ k =>
   change Int.subNatNat _ _ = _
   unfold Int.subNatNat
   rw [CommonScaleAxis.subtractionZeroOfBound _ _ ordered]
 change subtract a b = _
 unfold subtract
 rw [natRatioNonnegative n d hd,natRatioNonnegative m d hd]
 change normalize (Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)) (a.den*b.den) _ = _
 rw [intDiff]
 apply natRatioCongruence
 rw [multiplyDifference _ _ _ ordered,avc,bvc,multiplyDifference _ _ _ bound]

theorem returnedCoordinatesEqualIffBalance (a b m d : Nat) (hd : 0<d)
 (ordered : a≤b) (moveBelow : m≤b) :
 add (natRatio a d hd) (natRatio m d hd)=subtract (natRatio b d hd) (natRatio m d hd) ↔
 add (natRatio m d hd) (natRatio m d hd)=subtract (natRatio b d hd) (natRatio a d hd) := by
 rw [addNormalized,addNormalized,subtractNormalized b m d hd moveBelow,subtractNormalized b a d hd ordered]
 constructor
 · intro same
   have cross := normalizedEqualityCross (a+m) d (b-m) d hd hd same
   have eq := Nat.eq_of_mul_eq_mul_right hd cross
   have sum : a+(m+m)=b := by
    have h := congrArg (fun x => x+m) eq
    rw [subtractAdd b m moveBelow,Nat.add_assoc] at h
    exact h
   apply natRatioCongruence
   have diff : m+m=b-a := by
    rw [←sum,RunningConvergence.addSubtractLeft]
   rw [diff]
 · intro balance
   have cross := normalizedEqualityCross (m+m) d (b-a) d hd hd balance
   have eq := Nat.eq_of_mul_eq_mul_right hd cross
   have sum : b=(a+m)+m := by
    have h := subtractAdd b a ordered
    rw [←eq,Nat.add_comm (m+m) a,←Nat.add_assoc] at h
    exact h.symm
   apply natRatioCongruence
   rw [sum,Nat.add_comm (a+m) m,RunningConvergence.addSubtractLeft]
end SFT.Physics.CoupledEnsembleSynchronizationBalance

