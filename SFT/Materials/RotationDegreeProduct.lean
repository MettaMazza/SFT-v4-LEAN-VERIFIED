import SFT.Materials.RotationDegreeLift
namespace SFT.Materials.RotationDegreeProduct
open RotationTotient RotationCoprime RotationDegreeBase RotationDegreeLift
open RotationFactors RotationFactorDivisibility RotationFactorPrimality RotationPrimeSupport
open SFT.Foundation.FractionReduction SFT.Mathematics.OrbitBinaryDepth SFT.Mathematics.OrbitTilingCount

def productOrder (p : Nat) (prime : Prime p) (n : PositiveCount) : PositiveCount :=
 ⟨p*n.val,Nat.mul_pos (Nat.lt_trans (by decide) prime.1) n.property⟩

theorem coprimeExcludesDivisor (c n p : Nat) (above : 1 < p)
 (reduced : Nat.gcd c n = 1) (pn : p ∣ n) : c%p ≠ 0 := by
 intro zero
 have common := commonDivisorDividesGcd p c n
   (dividesFromRemainder c p (Nat.lt_trans (by decide) above) zero) pn
 rw [reduced] at common
 exact Nat.not_le_of_gt above (divisorBound p 1 (by decide) common)

theorem productCoprime (p : Nat) (prime : Prime p) (n : PositiveCount) (c : Nat) :
 Nat.gcd c (p*n.val) = 1 ↔ Nat.gcd c n.val = 1 ∧ c%p ≠ 0 := by
 constructor
 · intro h
   exact ⟨reducedWithDivisor c (p*n.val) n.val h ⟨p,Nat.mul_comm _ _⟩,
     coprimeExcludesDivisor c (p*n.val) p prime.1 h ⟨n.val,rfl⟩⟩
 · intro h
   by_cases one : Nat.gcd c (p*n.val) = 1
   · exact one
   · have positive := gcdPositive c (p*n.val) (productOrder p prime n).property
     have above := Nat.lt_of_le_of_ne positive (fun eq => one eq.symm)
     obtain ⟨q,qp,qdiv⟩ := primeDivisorExists _ above
     have parts := gcdDivides c (p*n.val)
     have qc := composeDivides _ _ _ qdiv parts.1
     have qproduct := composeDivides _ _ _ qdiv parts.2
     cases primeProduct q p n.val qp qproduct with
     | inl dividesP =>
       cases prime.2 q dividesP with
       | inl eq => rw [eq] at qp; exact False.elim (Nat.lt_irrefl _ qp.1)
       | inr eq =>
         rw [eq] at qc
         exact False.elim (h.2 (zeroRemainderOfDivides p c (Nat.lt_trans (by decide) prime.1) qc))
     | inr dividesN =>
       exact False.elim (coprimeExcludesDivisor c n.val q qp.1 h.1 dividesN
         (zeroRemainderOfDivides q c (Nat.lt_trans (by decide) qp.1) qc))

theorem repeatedPrimeDegree (p : Nat) (prime : Prime p) (n : PositiveCount) (pn : p ∣ n.val) :
 (totientCount (productOrder p prime n)).val = p*(totientCount n).val := by
 have count : (residues (productOrder p prime n)).length = (eligible n.val (p*n.val)).length := by
   apply sameMembersLength _ _ (residuesUnique _) (eligibleUnique _ _)
   intro c
   constructor
   · intro held
     have h := (exactCoprimeResidues _ _).mp held
     exact (eligibleMember _ _ _).mpr ⟨h.1,h.2.1,((productCoprime p prime n c).mp h.2.2).1⟩
   · intro held
     have h := (eligibleMember _ _ _).mp held
     exact (exactCoprimeResidues _ _).mpr
       ⟨h.1,h.2.1,(productCoprime p prime n c).mpr ⟨h.2.2,coprimeExcludesDivisor _ _ _ prime.1 h.2.2 pn⟩⟩
 change (residues (productOrder p prime n)).length = _
 rw [count,Nat.mul_comm p n.val]
 exact liftedDegree n p
end SFT.Materials.RotationDegreeProduct
