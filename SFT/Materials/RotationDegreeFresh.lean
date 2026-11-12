import SFT.Materials.RotationDegreeProduct
namespace SFT.Materials.RotationDegreeFresh
open RotationTotient RotationCoprime RotationDegreeBase RotationDegreeLift RotationDegreeProduct
open RotationFactors RotationFactorDivisibility RotationFactorPrimality RotationPrimeSupport
open SFT.Foundation.FractionReduction SFT.Mathematics.OrbitBinaryDepth SFT.Mathematics.OrbitTilingCount
open SFT.Mathematics.OrbitCyclotomic

theorem newPrimeReduced (p : Nat) (prime : Prime p) (n : PositiveCount) (fresh : n.val%p ≠ 0) :
 Nat.gcd p n.val = 1 := by
 have parts := gcdDivides p n.val
 cases prime.2 _ parts.1 with
 | inl one => exact one
 | inr same =>
   rw [same] at parts
   exact False.elim (fresh (zeroRemainderOfDivides p n.val (Nat.lt_trans (by decide) prime.1) parts.2))

theorem removedCheck (c p : Nat) : (!(!(c%p == 0))) = true ↔ c%p = 0 := by
 cases eq : c%p with
 | zero => constructor; intro _; rfl; intro _; rfl
 | succ k => constructor; intro h; cases h; intro h; cases h

theorem keptCount (p : Nat) (prime : Prime p) (n : PositiveCount) :
 ((eligible n.val (p*n.val)).filter (fun c => !(c%p == 0))).length =
 (totientCount (productOrder p prime n)).val := by
 apply sameMembersLength _ _ (uniqueFilter _ _ (eligibleUnique _ _)) (residuesUnique _)
 intro c
 constructor
 · intro held
   have h := (filterMember _ _ _).mp held
   have g := (eligibleMember _ _ _).mp h.1
   exact (exactCoprimeResidues _ _).mpr
     ⟨g.1,g.2.1,(productCoprime p prime n c).mpr ⟨g.2.2,(nonzeroCheck _).mp h.2⟩⟩
 · intro held
   have h := (exactCoprimeResidues _ _).mp held
   have g := (productCoprime p prime n c).mp h.2.2
   exact (filterMember _ _ _).mpr
     ⟨(eligibleMember _ _ _).mpr ⟨h.1,h.2.1,g.1⟩,(nonzeroCheck _).mpr g.2⟩

theorem removedCount (p : Nat) (prime : Prime p) (n : PositiveCount) (fresh : n.val%p ≠ 0) :
 ((eligible n.val (p*n.val)).filter (fun c => !(!(c%p == 0)))).length = (totientCount n).val := by
 have hp : 0 < p := Nat.lt_trans (by decide) prime.1
 have reduced := newPrimeReduced p prime n fresh
 have same : ((eligible n.val (p*n.val)).filter (fun c => !(!(c%p == 0)))).length =
     ((residues n).map (fun c => p*c)).length := by
   apply sameMembersLength _ _ (uniqueFilter _ _ (eligibleUnique _ _))
     (uniqueMap _ _ (residuesUnique n) (fun _ _ _ _ eq => Nat.eq_of_mul_eq_mul_left hp eq))
   intro c
   constructor
   · intro held
     have h := (filterMember _ _ _).mp held
     have g := (eligibleMember _ _ _).mp h.1
     have divides := dividesFromRemainder c p hp ((removedCheck c p).mp h.2)
     have factor := quotientFactor c p hp divides
     have positive := quotientPositive c p g.1 hp divides
     have bound : c/p ≤ n.val := by
       have bound := g.2.1
       rw [factor] at bound
       exact Nat.le_of_mul_le_mul_left bound hp
     have coprime : Nat.gcd (c/p) n.val = 1 := by
       have eq := gcdMultiplyReduced p n.val (c/p) n.property reduced
       rw [←factor] at eq
       exact eq.symm.trans g.2.2
     have member := mapMember (fun x => p*x) (residues n) (c/p)
       ((exactCoprimeResidues n (c/p)).mpr ⟨positive,bound,coprime⟩)
     rw [←factor] at member
     exact member
   · intro held
     obtain ⟨x,hx,eq⟩ := mapPreimage (fun x => p*x) (residues n) c held
     have h := (exactCoprimeResidues n x).mp hx
     rw [←eq]
     apply (filterMember _ _ _).mpr
     refine ⟨(eligibleMember _ _ _).mpr ⟨Nat.mul_pos hp h.1,Nat.mul_le_mul_left p h.2.1,?_⟩,?_⟩
     · exact (gcdMultiplyReduced p n.val x n.property reduced).trans h.2.2
     · exact (removedCheck _ _).mpr (zeroRemainderOfDivides p (p*x) hp ⟨x,rfl⟩)
 rw [same,SFT.Foundation.CommonRefinement.mapLength]
 rfl

theorem freshPrimeDegree (p : Nat) (prime : Prime p) (n : PositiveCount) (fresh : n.val%p ≠ 0) :
 (totientCount (productOrder p prime n)).val = (p-1)*(totientCount n).val := by
 have split := splitLength (fun c => !(c%p == 0)) (eligible n.val (p*n.val))
 rw [keptCount p prime n,removedCount p prime n fresh,Nat.mul_comm p n.val,liftedDegree n p] at split
 have form := subtractAdd p 1 (Nat.lt_trans (by decide) prime.1)
 have expanded : p*(totientCount n).val = (p-1)*(totientCount n).val+(totientCount n).val := by
   conv => lhs; arg 1; rw [←form]
   exact Nat.succ_mul _ _
 rw [expanded] at split
 have cancellation := congrArg (fun t => t-(totientCount n).val) split
 rw [SFT.Foundation.ExactCast.addSubtract,SFT.Foundation.ExactCast.addSubtract] at cancellation
 exact cancellation
end SFT.Materials.RotationDegreeFresh
