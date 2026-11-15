import SFT.Physics.CompositeConfining
import SFT.Mathematics.OrbitOrderExistence
namespace SFT.Physics.CompositeConfiningDerivation
open SFT.Mathematics.OrbitOrderIdentity SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- The source half-successor inverse, for every odd held denominator and label. -/
theorem halfSuccessorDouble (d : Nat) (odd : d%2=1) : ((d+1)/2)*2=d+1 := by
 have split := remainderQuotient d 2 (by decide)
 rw [odd] at split
 have shape : d+1 = 2*(d/2+1) := by
  calc
   d+1 = (1+2*(d/2))+1 := congrArg (fun x => x+1) split.symm
   _ = 2*(d/2)+(1+1) := by rw [Nat.add_comm 1 (2*(d/2)),Nat.add_assoc]
   _ = 2*(d/2+1) := (Nat.mul_succ 2 (d/2)).symm
 rw [shape,divisionMultiple 2 _ (by decide),Nat.mul_comm]
theorem originalInverseReconstructs (d label : Nat) (positive : 0<d) (odd : d%2=1) (bound : label<d) :
 (((d+1)/2)*((label+label)%d))%d=label := by
 let inverse := (d+1)/2
 have twice : 2*inverse=d+1 := (Nat.mul_comm 2 inverse).trans (halfSuccessorDouble d odd)
 have multiplied : (label+label)*inverse=label+d*label := by
  calc
   (label+label)*inverse = (label*2)*inverse := congrArg (fun x => x*inverse) (Nat.mul_two label).symm
   _ = label*(2*inverse) := mulAssoc label 2 inverse
   _ = label*(d+1) := congrArg (fun x => label*x) twice
   _ = label+d*label := by rw [Nat.mul_succ,Nat.mul_comm label d,Nat.add_comm]
 calc
  (inverse*((label+label)%d))%d = (((label+label)%d)*inverse)%d := congrArg (fun x => x%d) (Nat.mul_comm _ _)
  _ = ((label+label)*inverse)%d := moduloMulReduce (label+label) inverse d positive
  _ = (label+d*label)%d := congrArg (fun x => x%d) multiplied
  _ = label%d := moduloAddMultiple label d label positive
  _ = label := SFT.Foundation.ExactValueIdentity.moduloBelow label d positive bound
/-- No source standing mode can become empty or leave its original denominator. -/
theorem originalFoldConfined (d label : Nat) (positive : 0<d) (odd : d%2=1)
 (nonempty : 0<label) (bound : label<d) : 0<(label+label)%d ∧ (label+label)%d<d := by
 refine ⟨Nat.pos_of_ne_zero ?_,Nat.mod_lt _ positive⟩
 intro empty
 have reconstructed := originalInverseReconstructs d label positive odd bound
 rw [empty,Nat.mul_zero,SFT.Foundation.ExactValueIdentity.moduloBelow 0 d positive positive] at reconstructed
 exact (Nat.ne_of_gt nonempty) reconstructed.symm
/-- Equality of Fold images identifies the original source labels. -/
theorem originalFoldInjective (d a b : Nat) (positive : 0<d) (odd : d%2=1)
 (abound : a<d) (bbound : b<d) (same : (a+a)%d=(b+b)%d) : a=b := by
 have left := originalInverseReconstructs d a positive odd abound
 have right := originalInverseReconstructs d b positive odd bbound
 exact left.symm.trans ((congrArg (fun x => (((d+1)/2)*x)%d) same).trans right)
/-- The source inverse is also a preimage under the forward Fold operation. -/
theorem originalForwardReconstructs (d label : Nat) (positive : 0<d) (odd : d%2=1)
 (bound : label<d) :
 let predecessor := (((d+1)/2)*label)%d
 (predecessor+predecessor)%d=label := by
 let inverse := (d+1)/2
 change (((inverse*label)%d)+((inverse*label)%d))%d=label
 calc
  (((inverse*label)%d)+((inverse*label)%d))%d = (((inverse*label)%d)*2)%d := congrArg (fun x => x%d) (Nat.mul_two _).symm
  _ = ((inverse*label)*2)%d := moduloMulReduce (inverse*label) 2 d positive
  _ = ((label*2)*inverse)%d := congrArg (fun x => x%d) ((Nat.mul_comm inverse label).trans (Eq.refl _) |> fun h => (congrArg (fun x => x*2) h).trans ((mulAssoc label inverse 2).trans ((congrArg (fun x => label*x) (Nat.mul_comm inverse 2)).trans (mulAssoc label 2 inverse).symm)))
  _ = (((label*2)%d)*inverse)%d := (moduloMulReduce (label*2) inverse d positive).symm
  _ = (inverse*((label+label)%d))%d := by rw [Nat.mul_two,Nat.mul_comm ((label+label)%d) inverse]
  _ = label := originalInverseReconstructs d label positive odd bound


/-- Every nonempty source label has the declared nonempty inverse label in the same support. -/
theorem originalInverseConfined (d label : Nat) (positive : 0<d) (odd : d%2=1)
 (nonempty : 0<label) (bound : label<d) :
 0<(((d+1)/2)*label)%d ∧ (((d+1)/2)*label)%d<d := by
 refine ⟨Nat.pos_of_ne_zero ?_,Nat.mod_lt _ positive⟩
 intro empty
 have reconstructed := originalForwardReconstructs d label positive odd bound
 change (((((d+1)/2)*label)%d)+((((d+1)/2)*label)%d))%d=label at reconstructed
 rw [empty,SFT.Foundation.ExactValueIdentity.moduloBelow 0 d positive positive] at reconstructed
 exact (Nat.ne_of_gt nonempty) reconstructed.symm

end SFT.Physics.CompositeConfiningDerivation
