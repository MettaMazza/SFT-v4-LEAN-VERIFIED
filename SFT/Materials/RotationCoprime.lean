import SFT.Materials.RotationPrimeSupport
import SFT.Materials.RotationTotient
namespace SFT.Materials.RotationCoprime
open RotationFactors RotationFactorDivisibility RotationFactorPrimality RotationPrimeSupport RotationTotient
open SFT.Foundation.FractionReduction

theorem factorExists (s : FactorState) : 1 < s.remainder → ∃ p, p ∈ factorRun s := by
 apply factorOrder.wf.induction s
 intro current ih above
 have equation := factorEquation current
 unfold factorBody at equation
 split at equation
 · rename_i bound
   split at equation
   · refine ⟨current.divisor,?_⟩
     rw [equation]
     exact List.Mem.head _
   · obtain ⟨p,hp⟩ := ih ⟨current.remainder,current.divisor+1,current.positive,Nat.lt_trans current.lower (Nat.lt_succ_self _)⟩
       (measureDecreases _ _ _ (Nat.le_refl _) (divisorWithin _ _ current.lower bound)) above
     refine ⟨p,?_⟩
     rw [equation]
     exact hp
 · refine ⟨current.remainder,?_⟩
   rw [equation]
   exact List.Mem.head _

theorem primeDivisorExists (n : Nat) (above : 1 < n) : ∃ p, Prime p ∧ p ∣ n := by
 obtain ⟨p,hp⟩ := factorExists ⟨n,2,Nat.lt_trans (by decide) above,by decide⟩ above
 exact ⟨p,(exactPrimeSupport n (Nat.lt_trans (by decide) above) p).mp hp⟩

theorem avoidsFactorsIffCoprime (order : PositiveCount) (candidate : Nat) :
 (∀ p, p ∈ factorLoop order.val 2 order.property (by decide) → candidate % p ≠ 0) ↔
 Nat.gcd candidate order.val = 1 := by
 constructor
 · intro avoid
   have positive := gcdPositive candidate order.val order.property
   by_cases one : Nat.gcd candidate order.val = 1
   · exact one
   · have above : 1 < Nat.gcd candidate order.val :=
       Nat.lt_of_le_of_ne positive (fun eq => one eq.symm)
     obtain ⟨p,prime,divides⟩ := primeDivisorExists _ above
     have parts := gcdDivides candidate order.val
     have pn := composeDivides _ _ _ divides parts.2
     have pc := composeDivides _ _ _ divides parts.1
     exact False.elim (avoid p ((exactPrimeSupport _ order.property p).mpr ⟨prime,pn⟩)
       (zeroRemainderOfDivides _ _ (Nat.lt_trans (by decide) prime.1) pc))
 · intro reduced p held zero
   have support := (exactPrimeSupport _ order.property p).mp held
   have pc := dividesFromRemainder candidate p (Nat.lt_trans (by decide) support.1.1) zero
   have common := commonDivisorDividesGcd p candidate order.val pc support.2
   rw [reduced] at common
   exact Nat.not_le_of_gt support.1.1 (divisorBound p 1 (by decide) common)

theorem exactCoprimeResidues (order : PositiveCount) (candidate : Nat) :
 candidate ∈ residues order ↔ 0 < candidate ∧ candidate ≤ order.val ∧ Nat.gcd candidate order.val = 1 := by
 constructor
 · intro held
   have h := (residueMembership order candidate).mp held
   exact ⟨h.1,h.2.1,(avoidsFactorsIffCoprime order candidate).mp h.2.2⟩
 · intro h
   exact (residueMembership order candidate).mpr
     ⟨h.1,h.2.1,(avoidsFactorsIffCoprime order candidate).mpr h.2.2⟩
end SFT.Materials.RotationCoprime
