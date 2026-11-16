import SFT.Physics.VelocityCompositionAlgebra
namespace SFT.Physics.VelocityComposition
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Exactly the forward/held multiplication in compose_held_pairs and SPEC.induction_step.
def appendHeld : Held → Held → Held
 | .empty,_ => .empty
 | .part _,.empty => .empty
 | .part a,.part b => .part (multiply a b)
def appendPair (a b : Pair) : Pair := ⟨multiply a.forward b.forward,appendHeld a.held b.held⟩
theorem originalPairProduct (u v : Rat) : composeHeldPairs u v = (do
 let a ← heldPair u
 let b ← heldPair v
 pure (appendPair a b)) := by
 unfold composeHeldPairs
 cases heldPair u with
 | error _ => rfl
 | ok a => cases heldPair v with
  | error _ => rfl
  | ok b => cases a with
   | mk af ah => cases b with
    | mk bf bh => cases ah <;> cases bh <;> rfl
theorem normalizedComponentAssociative (n d m e k f : Nat) (hd : 0<d) (he : 0<e) (hf : 0<f) :
 multiply (multiply (natRatio n d hd) (natRatio m e he)) (natRatio k f hf) =
 multiply (natRatio n d hd) (multiply (natRatio m e he) (natRatio k f hf)) := by
 rw [multiplyNormalized,multiplyNormalized,multiplyNormalized,multiplyNormalized]
 apply natRatioCongruence
 rw [mulAssoc n m k,mulAssoc d e f]
theorem retainedComponentAssociative (a b c : Rat)
 (ha : a.num = .ofNat a.num.natAbs) (hb : b.num = .ofNat b.num.natAbs)
 (hc : c.num = .ofNat c.num.natAbs) :
 multiply (multiply a b) c = multiply a (multiply b c) := by
 have ar := representedIdentity a a.num.natAbs a.den (Nat.pos_of_ne_zero a.den_nz) ha rfl
 have br := representedIdentity b b.num.natAbs b.den (Nat.pos_of_ne_zero b.den_nz) hb rfl
 have cr := representedIdentity c c.num.natAbs c.den (Nat.pos_of_ne_zero c.den_nz) hc rfl
 rw [ar,br,cr]
 exact normalizedComponentAssociative _ _ _ _ _ _ _ _ _
def heldNonnegative : Held → Prop
 | .empty => True
 | .part a => a.num = .ofNat a.num.natAbs
theorem originalHeldAssociative (a b c : Held) (ha : heldNonnegative a) (hb : heldNonnegative b) (hc : heldNonnegative c) :
 appendHeld (appendHeld a b) c = appendHeld a (appendHeld b c) := by
 cases a with
 | empty => rfl
 | part a => cases b with
  | empty => rfl
  | part b => cases c with
   | empty => rfl
   | part c => exact congrArg Held.part (retainedComponentAssociative a b c ha hb hc)
theorem originalPairAssociative (a b c : Pair)
 (ha : a.forward.num = .ofNat a.forward.num.natAbs) (hb : b.forward.num = .ofNat b.forward.num.natAbs)
 (hc : c.forward.num = .ofNat c.forward.num.natAbs)
 (hha : heldNonnegative a.held) (hhb : heldNonnegative b.held) (hhc : heldNonnegative c.held) :
 appendPair (appendPair a b) c = appendPair a (appendPair b c) := by
 change Pair.mk (multiply (multiply a.forward b.forward) c.forward) (appendHeld (appendHeld a.held b.held) c.held) =
  Pair.mk (multiply a.forward (multiply b.forward c.forward)) (appendHeld a.held (appendHeld b.held c.held))
 rw [retainedComponentAssociative _ _ _ ha hb hc,originalHeldAssociative _ _ _ hha hhb hhc]
-- Source reconstruction: forward minus held is twice the numerator;
-- forward plus held is twice the denominator of the existing exact composition.
theorem originalForwardHeldDifference (n a m b : Nat) :
 (2*n+a)*(2*m+b)=a*b+2*(n*(m+b)+m*(n+a)) := by
 conv => lhs; simp only [Nat.two_mul,Nat.mul_two,Nat.mul_add,Nat.add_mul,mulAssoc,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [Nat.two_mul,Nat.mul_two,Nat.mul_add,Nat.add_mul,mulAssoc,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem originalForwardHeldSum (n a m b : Nat) :
 (2*n+a)*(2*m+b)+a*b=2*((n+a)*(m+b)+n*m) := by
 conv => lhs; simp only [Nat.two_mul,Nat.mul_two,Nat.mul_add,Nat.add_mul,mulAssoc,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [Nat.two_mul,Nat.mul_two,Nat.mul_add,Nat.add_mul,mulAssoc,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem originalHeldReconstructionRatio (n a m b : Nat)
 (hd : 0<(n+a)*(m+b)+n*m) :
 natRatio (2*(n*(m+b)+m*(n+a))) (2*((n+a)*(m+b)+n*m)) (Nat.mul_pos (by decide) hd)=
 natRatio (n*(m+b)+m*(n+a)) ((n+a)*(m+b)+n*m) hd := by
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
end SFT.Physics.VelocityComposition
