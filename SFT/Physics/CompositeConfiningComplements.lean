import SFT.Physics.CompositeConfiningDerivation
namespace SFT.Physics.CompositeConfiningDerivation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- The original d-k complement is positive, remains in support and reassembles d. -/
theorem originalComplement (d k : Nat) (positive : 0<k) (bound : k<d) :
 0<d-k ∧ d-k<d ∧ k+(d-k)=d := by
 exact ⟨SFT.Foundation.ExactCast.subtractPositive d k bound, Nat.sub_lt (Nat.lt_trans positive bound) positive,
 (Nat.add_comm k (d-k)).trans (SFT.Foundation.FractionReduction.subtractAdd d k (Nat.le_of_lt bound))⟩
/-- Reassembly with the same held denominator forces the original complement. -/
theorem originalComplementUnique (d k other : Nat) (reassembly : k+other=d) : other=d-k := by
 exact (SFT.Foundation.ExactCast.addSubtract other k).symm.trans (congrArg (fun x => x-k) ((Nat.add_comm other k).trans reassembly))
/-- The source complement operation reverses itself on every standing label. -/
theorem originalComplementInvolutive (d k : Nat) (bound : k<d) : d-(d-k)=k := by
 have rebuild := SFT.Foundation.FractionReduction.subtractAdd d k (Nat.le_of_lt bound)
 exact (congrArg (fun x => x-(d-k)) rebuild).symm.trans ((congrArg (fun x => x-(d-k)) (Nat.add_comm (d-k) k)).trans (SFT.Foundation.ExactCast.addSubtract k (d-k)))
/-- Odd held support excludes a standing label paired with itself. -/
theorem originalComplementNotSelf (d k : Nat) (odd : d%2=1) (bound : k<d) : d-k≠k := by
 intro same
 have sum : k+k=d := (congrArg (fun x => k+x) same).symm.trans ((Nat.add_comm k (d-k)).trans (SFT.Foundation.FractionReduction.subtractAdd d k (Nat.le_of_lt bound)))
 have even : d%2=0 := by
  rw [← sum,← Nat.mul_two]
  have zero := SFT.Mathematics.OrbitOrderIdentity.moduloAddMultiple 0 2 k (by decide)
  rw [Nat.zero_add,Nat.mul_comm 2 k] at zero
  exact zero
 have impossible : (0 : Nat)=1 := even.symm.trans odd
 cases impossible
end SFT.Physics.CompositeConfiningDerivation
