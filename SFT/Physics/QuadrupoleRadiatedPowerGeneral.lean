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
end SFT.Physics.QuadrupoleRadiatedPowerGeneral

