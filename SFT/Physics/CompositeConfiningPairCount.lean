import SFT.Physics.CompositeConfiningReturn
import SFT.Physics.CompositeConfiningOrbits
namespace SFT.Physics.CompositeConfiningDerivation
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
open SFT.Mathematics.OrbitCycleSupport
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- The two original pair-count expressions agree for every odd held support. -/
theorem originalPairCountFormula (d : Nat) (odd : d%2=1) :
 (d+1)/2-1=(d-1)/2 := by
 have split := remainderQuotient d 2 (by decide)
 rw [odd] at split
 have shape : d=2*(d/2)+1 := split.symm.trans (Nat.add_comm 1 _)
 have plus : (2*(d/2)+1)+1=2*(d/2+1) := by
  rw [Nat.mul_succ,Nat.add_assoc]
 rw [shape,plus,divisionMultiple 2 _ (by decide),addSubtract _ 1,addSubtract _ 1,
  divisionMultiple 2 _ (by decide)]
/-- The original pair generator has exactly the declared cardinality. -/
theorem originalPairListCount (d : Nat) (odd : d%2=1) :
 ((List.range ((d+1)/2-1)).map (fun n => (n+1,d-(n+1)))).length=(d-1)/2 :=
 (mappedLength _ _).trans ((rangeLoopLength _ []).trans (originalPairCountFormula d odd))
/-- Advancing to the next even sector adds precisely one original antipodal pair. -/
theorem originalPairCountSuccessor (d : Nat) (odd : d%2=1) :
 ((d+2)-1)/2=(d-1)/2+1 := by
 have split := remainderQuotient d 2 (by decide)
 rw [odd] at split
 have shape : d=2*(d/2)+1 := split.symm.trans (Nat.add_comm 1 _)
 have plus : (2*(d/2)+1)+2=2*(d/2+1)+1 := by
  rw [Nat.mul_succ]
 rw [shape,plus,addSubtract _ 1,addSubtract _ 1,
  divisionMultiple 2 _ (by decide),divisionMultiple 2 _ (by decide)]
end SFT.Physics.CompositeConfiningDerivation
