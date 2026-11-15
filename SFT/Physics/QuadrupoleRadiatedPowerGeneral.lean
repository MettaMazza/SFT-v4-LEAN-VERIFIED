import SFT.Physics.QuadrupoleRadiatedPowerCertificate
import SFT.Mathematics.FiniteDifferenceBounds
namespace SFT.Physics.QuadrupoleRadiatedPowerGeneral
open SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
private theorem cubeProduct (k : Nat) : k^3=k*k*k := by
 rw [Nat.pow_succ,Nat.pow_succ,Nat.pow_succ,Nat.pow_zero,Nat.one_mul]
private theorem triple (k : Nat) : 3*k=k+k+k := by
 rw [show 3=2+1 from rfl,SFT.Mathematics.FiniteDifferenceBounds.addMul,Nat.one_mul,show 2=1+1 from rfl,SFT.Mathematics.FiniteDifferenceBounds.addMul,Nat.one_mul]
theorem originalCubicOpposition (k : Nat) :
 (k+3)^3+3*(k+1)^3=3*(k+2)^3+k^3+6 := by
 let a := k*k*k
 let b := (k+1)*(k+1)*(k+1)
 let c := (k+2)*(k+2)*(k+2)
 let d := (k+3)*(k+3)*(k+3)
 let t := (k+k+k+k+k+k)+6
 have first : c+a=b+b+t := SFT.Mathematics.FiniteDifferenceBounds.cubicForward k
 have next : d+b=c+c+(t+6) := by
  have source := SFT.Mathematics.FiniteDifferenceBounds.cubicForward (k+1)
  change d+b=c+c+((k+1)+(k+1)+(k+1)+(k+1)+(k+1)+(k+1))+(1+1+1+1+1+1) at source
  rw [source]
  dsimp only [t]
  conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.reduceAdd]
  all_goals conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.reduceAdd]
 have ledger : (d+(b+b+b))+t=((c+c+c)+a+6)+t := by
  calc
   (d+(b+b+b))+t = (d+b)+(b+b+t) := by
    conv => lhs; simp only [Nat.add_assoc]
    all_goals conv => rhs; simp only [Nat.add_assoc]
   _ = (d+b)+(c+a) := congrArg (fun x => (d+b)+x) first.symm
   _ = (c+c+(t+6))+(c+a) := congrArg (fun x => x+(c+a)) next
   _ = ((c+c+c)+a+6)+t := by
    conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
    all_goals conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
 have taken := congrArg (fun x => x-t) ledger
 rw [Nat.add_comm (d+(b+b+b)) t,Nat.add_comm ((c+c+c)+a+6) t,RunningConvergence.addSubtractLeft,RunningConvergence.addSubtractLeft] at taken
 rw [cubeProduct,cubeProduct,cubeProduct,cubeProduct,triple,triple]
 exact taken

private theorem squareProduct (k : Nat) : k^2=k*k := by
 rw [Nat.pow_succ,Nat.pow_succ,Nat.pow_zero,Nat.one_mul]
private theorem cubicIncrement (k : Nat) : (k+1)^3=k^3+3*k^2+3*k+1 := by
 rw [cubeProduct,cubeProduct,squareProduct,triple,triple]
 conv => lhs; simp only [Nat.mul_add,SFT.Mathematics.FiniteDifferenceBounds.addMul,Nat.mul_one,Nat.one_mul,mulAssoc,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
 all_goals conv => rhs; simp only [Nat.mul_add,SFT.Mathematics.FiniteDifferenceBounds.addMul,Nat.mul_one,Nat.one_mul,mulAssoc,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]


private theorem polynomialAdd (a b c d e f x y : Nat) :
 (a*x+b*y+c)+(d*x+e*y+f)=(a+d)*x+(b+e)*y+(c+f) := by
 conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
 all_goals conv => rhs; simp only [SFT.Mathematics.FiniteDifferenceBounds.addMul,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
private theorem polynomialScale (q a b c x y : Nat) :
 q*(a*x+b*y+c)=(q*a)*x+(q*b)*y+q*c := by
 rw [Nat.mul_add,Nat.mul_add,←mulAssoc q a x,←mulAssoc q b y]
private theorem incrementShift (k t : Nat) :
 3*(k+t)^2+3*(k+t)+1=3*(k*k)+(6*t+3)*k+(3*(t*t)+3*t+1) := by
 rw [squareProduct,CommonScaleAxis.squareDifference t k,Nat.mul_add,Nat.mul_add]
 have middle : 3*(t*(2*k))=(6*t)*k := by
  rw [←mulAssoc t 2 k,Nat.mul_comm t 2,←mulAssoc 3 (2*t) k,←mulAssoc 3 2 t]
 rw [Nat.mul_add,Nat.mul_add,middle]
 have combine := polynomialAdd 3 (6*t) (3*(t*t)) 0 3 (3*t) (k*k) k
 rw [Nat.zero_mul,Nat.zero_add] at combine
 rw [←Nat.add_assoc (3*(k*k)) ((6*t)*k) (3*(t*t)),combine,Nat.add_assoc]

theorem originalCubicLeftSuccessor (k : Nat) :
 (k+4)^3+3*(k+2)^3=((k+3)^3+3*(k+1)^3)+(12*k^2+48*k+58) := by
 have c3 : (k+4)^3=(k+3)^3+(3*(k*k)+21*k+37) := by
  calc
   (k+4)^3=(k+3)^3+(3*(k+3)^2+3*(k+3)+1) := by
    rw [show k+4=(k+3)+1 from rfl,cubicIncrement]
    conv => lhs; simp only [Nat.add_assoc]
    all_goals conv => rhs; simp only [Nat.add_assoc]
   _ = _ := congrArg (fun x => (k+3)^3+x) (incrementShift k 3)
 have c1 : (k+2)^3=(k+1)^3+(3*(k*k)+9*k+7) := by
  calc
   (k+2)^3=(k+1)^3+(3*(k+1)^2+3*(k+1)+1) := by
    rw [show k+2=(k+1)+1 from rfl,cubicIncrement]
    conv => lhs; simp only [Nat.add_assoc]
    all_goals conv => rhs; simp only [Nat.add_assoc]
   _ = _ := congrArg (fun x => (k+1)^3+x) (incrementShift k 1)
 rw [c3,c1,Nat.mul_add]
 calc
  ((k+3)^3+(3*(k*k)+21*k+37))+(3*(k+1)^3+3*(3*(k*k)+9*k+7))=
   ((k+3)^3+3*(k+1)^3)+((3*(k*k)+21*k+37)+3*(3*(k*k)+9*k+7)) := by
   conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
   all_goals conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
  _ = _ := by
   rw [polynomialScale,polynomialAdd,squareProduct]

theorem originalCubicRightSuccessor (k : Nat) :
 3*(k+3)^3+(k+1)^3+6=(3*(k+2)^3+k^3+6)+(12*k^2+48*k+58) := by
 have following := originalCubicOpposition (k+1)
 change (k+4)^3+3*(k+2)^3=3*(k+3)^3+(k+1)^3+6 at following
 rw [←following,originalCubicLeftSuccessor,originalCubicOpposition]

theorem originalCubicIncrements (k : Nat) :
 ((k+4)^3+3*(k+2)^3)-((k+3)^3+3*(k+1)^3)=12*k^2+48*k+58 ∧
 (3*(k+3)^3+(k+1)^3+6)-(3*(k+2)^3+k^3+6)=12*k^2+48*k+58 := by
 constructor
 · rw [originalCubicLeftSuccessor,RunningConvergence.addSubtractLeft]
 · rw [originalCubicRightSuccessor,RunningConvergence.addSubtractLeft]
open QuadrupoleRadiatedPower LeptonIntervals
-- The exact original eight-field operation, at every admitted index.
theorem originalEveryIdentityRecord (k : Nat) :
 cubicOppositionIdentity (.integer (.ofNat (k+1))) = .ok
  ⟨k+1,3*(k+3)^3+(k+1)^3+6,3*(k+3)^3+(k+1)^3+6,true,
   12*(k+1)^2+48*(k+1)+58,12*(k+1)^2+48*(k+1)+58,
   12*(k+1)^2+48*(k+1)+58,true⟩ := by
 unfold cubicOppositionIdentity
 dsimp only [Except.bind,Bind.bind,pure,Except.pure]
 have left := originalCubicOpposition (k+1)
 have inc := originalCubicIncrements (k+1)
 change (k+4)^3+3*(k+2)^3=3*(k+3)^3+(k+1)^3+6 at left
 have same (x : Nat) : (x==x)=true := by
  induction x with
  | zero => rfl
  | succ x ih => exact ih
 conv => lhs; rw [inc.1,inc.2,left]; simp only [same,Bool.true_and]

-- The source's density-times-radius-times-radius law uses the already proved
-- inverse-square reconstruction, for every positive exact source and radius.
theorem originalEveryShellReconstruction
 (power radius : SFT.Foundation.ExactOperations.PositiveFraction) :
 (do let density ← LeptonRatios.divide (BoundaryGrowth.asFraction power)
       (multiply (BoundaryGrowth.asFraction radius) (BoundaryGrowth.asFraction radius))
     pure (multiply (multiply density (BoundaryGrowth.asFraction radius)) (BoundaryGrowth.asFraction radius))) =
 .ok (BoundaryGrowth.asFraction power) :=
 StaticExteriorClockGeneral.originalFluxIdentity power radius

private theorem retainedReplicateMap (f : α → β) (x : α) (n : Nat) :
 (List.replicate n x).map f=List.replicate n (f x) := by
 induction n with
 | zero => rfl
 | succ n ih => rw [List.replicate_succ,List.map_cons,ih,List.replicate_succ]
private theorem retainedReplicateLength (x : α) (n : Nat) :
 (List.replicate n x).length=n := by
 induction n with
 | zero => rfl
 | succ n ih => rw [List.replicate_succ,List.length_cons,ih]
private theorem retainedReplicateAll (f : α → Bool) (x : α) (h : f x=true) (n : Nat) :
 (List.replicate n x).all f=true := by
 induction n with
 | zero => rfl
 | succ n ih => rw [List.replicate_succ,List.all_cons,h,ih]; rfl

theorem originalEveryStaticDifference (n : Nat) :
 positiveDifferenceRecord (List.replicate (n+2) (FoldFirstReturn.Input.fraction (normalize 1 1 (by decide))))=.ok [] := by
 unfold positiveDifferenceRecord
 rw [retainedReplicateLength,retainedReplicateAll _ _ (by rfl),retainedReplicateMap]
 have bound : ¬n+2<2 := Nat.not_lt.mpr (Nat.le_add_left 2 n)
 rw [show decide (n+2<2)=false from decide_eq_false bound]
 have head : (List.replicate (n+2) (normalize 1 1 (by decide))).headD zero=normalize 1 1 (by decide) := by
  rw [List.replicate_succ]
  rfl
 dsimp only
 rw [head,retainedReplicateAll _ _ (by rfl)]
 rfl

theorem originalEveryStaticThirdRecord (n : Nat) :
 generatedDifferenceRecord (List.replicate (n+4) (FoldFirstReturn.Input.fraction (normalize 1 1 (by decide)))) (.integer 3)=.ok [] := by
 have nonempty : (List.replicate (n+4) (FoldFirstReturn.Input.fraction (normalize 1 1 (by decide)))).isEmpty=false := by
  rw [List.replicate_succ]
  rfl
 unfold generatedDifferenceRecord
 dsimp only [Except.bind,Bind.bind]
 rw [nonempty]
 rw [originalEveryStaticDifference (n+2)]
 rfl

theorem originalEveryStaticPower (n : Nat) :
 (do let values ← staticQuadrupoleTrace (.integer (.ofNat (n+4)))
     quadrupolePowerRecord (values.map FoldFirstReturn.Input.fraction))=.ok none := by
 unfold staticQuadrupoleTrace
 dsimp only [Except.bind,Bind.bind,pure,Except.pure]
 rw [retainedReplicateMap]
 unfold quadrupolePowerRecord
 dsimp only
 rw [originalEveryStaticThirdRecord]
 rfl

open VacuumLedgerProofs VacuumScaleProofs
private theorem productLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [←mulAssoc,Nat.mul_comm a b,mulAssoc]
-- Exact amplitude-square covariance of the source's half-One power expression.
theorem originalPowerScaleSquare (n d m e : Nat) (hd : 0<d) (he : 0<e) :
 multiply (multiply (natRatio 1 2 (by decide))
  (multiply (natRatio m e he) (natRatio n d hd)))
  (multiply (natRatio m e he) (natRatio n d hd)) =
 multiply (multiply (natRatio m e he) (natRatio m e he))
  (multiply (multiply (natRatio 1 2 (by decide)) (natRatio n d hd)) (natRatio n d hd)) := by
 repeat rw [multiplyNormalized]
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm,Nat.one_mul,Nat.mul_one]
 all_goals conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm,Nat.one_mul,Nat.mul_one]

theorem originalPowerOnAdmittedThird (values : List FoldFirstReturn.Input) (first : Rat) (rest : List Rat)
 (third : generatedDifferenceRecord values (.integer 3)=.ok (first::rest))
 (constant : rest.all (fun q => q==first)=true) (positive : zero.blt first=true) :
 quadrupolePowerRecord values = .ok (some (multiply (multiply (normalize 1 2 (by decide)) first) first)) := by
 unfold quadrupolePowerRecord
 dsimp only
 rw [third]
 dsimp only [Except.bind,Bind.bind]
 rw [constant,positive]
 rfl

theorem originalGeneratedTickValue (n d k : Nat) (hd : 0<d) :
 multiply (natRatio n d hd) (wholeRatio ((k+1)^3))=
 natRatio (n*((k+1)^3)) d hd := by
 rw [←natRatioWhole,multiplyNormalized]
 congr 1
 exact Nat.mul_one d

theorem originalEveryAmplitudeOpposition (n d k : Nat) (hd : 0<d) :
 add (natRatio (n*((k+3)^3)) d hd) (natRatio (3*(n*((k+1)^3))) d hd) =
 add (add (natRatio (3*(n*((k+2)^3))) d hd) (natRatio (n*(k^3)) d hd))
  (natRatio (6*n) d hd) := by
 rw [addNormalized,addNormalized,addNormalized]
 have identity := congrArg (fun x => n*x) (originalCubicOpposition k)
 rw [Nat.mul_add,Nat.mul_add,Nat.mul_add,productLeftComm n 3 ((k+1)^3),
  productLeftComm n 3 ((k+2)^3),Nat.mul_comm n 6] at identity
 exact congrArg (fun x => natRatio x d hd) identity

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
 unfold LeptonIntervals.subtract
 rw [natRatioNonnegative n d hd,natRatioNonnegative m d hd]
 change normalize (Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)) (a.den*b.den) _ = _
 rw [intDiff]
 apply natRatioCongruence
 rw [multiplyDifference _ _ _ ordered,avc,bvc,multiplyDifference _ _ _ bound]

private theorem scaledPositiveTake (n base step d : Nat) (hd : 0<d) :
 subtract (natRatio (n*(base+step)) d hd) (natRatio (n*base) d hd)=natRatio (n*step) d hd := by
 rw [Nat.mul_add,subtractNormalized _ _ _ hd (Nat.le_add_right _ _),RunningConvergence.addSubtractLeft]

private theorem firstRateSuccessor (k : Nat) :
 3*(k+1)^2+3*(k+1)+1=(3*k^2+3*k+1)+(6*k+6) := by
 rw [incrementShift k 1,squareProduct]
 have combined := polynomialAdd 3 3 1 0 6 6 (k*k) k
 rw [Nat.zero_mul,Nat.zero_add] at combined
 exact combined.symm

theorem originalEveryFirstDifference (n d k : Nat) (hd : 0<d) :
 subtract (natRatio (n*((k+1)^3)) d hd) (natRatio (n*(k^3)) d hd)=
 natRatio (n*(3*k^2+3*k+1)) d hd := by
 have step : (k+1)^3=k^3+(3*k^2+3*k+1) := by
  rw [cubicIncrement]
  conv => lhs; simp only [Nat.add_assoc]
  all_goals conv => rhs; simp only [Nat.add_assoc]
 rw [step,scaledPositiveTake]

theorem originalEverySecondDifference (n d k : Nat) (hd : 0<d) :
 subtract (natRatio (n*(3*(k+1)^2+3*(k+1)+1)) d hd)
  (natRatio (n*(3*k^2+3*k+1)) d hd)=natRatio (n*(6*k+6)) d hd := by
 rw [firstRateSuccessor,scaledPositiveTake]

theorem originalEveryThirdDifference (n d k : Nat) (hd : 0<d) :
 subtract (natRatio (n*(6*(k+1)+6)) d hd) (natRatio (n*(6*k+6)) d hd)=
 natRatio (6*n) d hd := by
 rw [Nat.mul_add 6 k 1,Nat.mul_one,scaledPositiveTake,Nat.mul_comm n 6]

theorem originalEveryRatePositive (n d k : Nat) (hn : 0<n) (hd : 0<d) :
 zero.blt (natRatio (n*(3*k^2+3*k+1)) d hd)=true ∧
 zero.blt (natRatio (n*(6*k+6)) d hd)=true ∧
 zero.blt (natRatio (6*n) d hd)=true := by
 constructor
 · exact positiveNormalized _ _ (Nat.mul_pos hn (Nat.zero_lt_succ _)) hd
 · constructor
   · exact positiveNormalized _ _ (Nat.mul_pos hn (Nat.zero_lt_succ _)) hd
   · exact positiveNormalized _ _ (Nat.mul_pos (by decide) hn) hd

end SFT.Physics.QuadrupoleRadiatedPowerGeneral

