import SFT.Materials.RotationClosure
namespace SFT.Materials.QuasicrystalInflation
open RotationTotient RotationFactors RotationCoprime RotationPrimeSupport
open SFT.Foundation.FractionReduction

-- Pinned successor_structural_counts.py: actual population recurrence and
-- rational_inflation_fixed_point_certificate, retained under its source name.
structure PopulationPair where
 first : PositiveCount
 second : PositiveCount

def initial : PopulationPair := ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩
def next (p : PopulationPair) : PopulationPair :=
 ⟨⟨p.first.val+p.second.val,Nat.add_pos_left p.first.property _⟩,p.first⟩
def population : Nat → PopulationPair
 | 0 => initial
 | n+1 => next (population n)
def history : Nat → List PopulationPair
 | 0 => [initial]
 | n+1 => history n ++ [population (n+1)]
def substitutionPopulations (depth : PositiveCount) : List PopulationPair := history (depth.val-1)

theorem successorEquation (n : Nat) :
 (population (n+1)).first.val = (population n).first.val+(population n).second.val ∧
 (population (n+1)).second.val = (population n).first.val := ⟨rfl,rfl⟩

theorem historyCount (n : Nat) : (history n).length = n+1 := by
 induction n with
 | zero => rfl
 | succ n ih =>
   unfold history
   rw [SFT.Foundation.CommonRefinement.appendLength,ih]
   rfl

theorem originalDepthCount (depth : PositiveCount) :
 (substitutionPopulations depth).length = depth.val := by
 rw [substitutionPopulations,historyCount]
 exact subtractAdd depth.val 1 depth.property

theorem originalSixSuccessors :
 (substitutionPopulations ⟨6,by decide⟩).map (fun row => (row.first.val,row.second.val)) =
 [(1,1),(2,1),(3,2),(5,3),(8,5),(13,8)] := rfl

theorem rationalFixedScaleExcluded (p q : PositiveCount) (reduced : Nat.gcd p.val q.val = 1) :
 p.val*p.val ≠ p.val*q.val+q.val*q.val := by
 intro equation
 have qSquare : q.val ∣ p.val*p.val := by
   refine ⟨p.val+q.val,?_⟩
   rw [Nat.mul_add,Nat.mul_comm q.val p.val]
   exact equation
 have qOne : q.val=1 := by
   by_cases one : q.val=1
   · exact one
   · have above : 1<q.val := Nat.lt_of_le_of_ne q.property (fun eq => one eq.symm)
     obtain ⟨r,prime,rq⟩ := primeDivisorExists q.val above
     have rsquare := RotationFactorDivisibility.composeDivides r q.val (p.val*p.val) rq qSquare
     have rp : r∣p.val := (primeProduct r p.val p.val prime rsquare).elim (fun h => h) (fun h => h)
     have common := commonDivisorDividesGcd r p.val q.val rp rq
     rw [reduced] at common
     exact False.elim (Nat.not_le_of_gt prime.1 (divisorBound r 1 (by decide) common))
 have pSquare : p.val ∣ p.val*p.val := ⟨p.val,rfl⟩
 have pProduct : p.val ∣ p.val*q.val := ⟨q.val,rfl⟩
 have remainder := dividesSubtract pSquare pProduct
 rw [equation,Nat.add_comm (p.val*q.val) (q.val*q.val),SFT.Foundation.ExactCast.addSubtract] at remainder
 rw [qOne] at remainder
 have bound : p.val≤1 := divisorBound p.val 1 (by decide) remainder
 have pOne : p.val=1 := Nat.le_antisymm bound p.property
 rw [pOne,qOne] at equation
 exact Nat.noConfusion (Nat.succ.inj equation)
end SFT.Materials.QuasicrystalInflation
