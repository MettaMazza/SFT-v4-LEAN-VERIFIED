import SFT.Physics.LeptonTake
import SFT.Physics.LeptonIntervals
import SFT.Physics.FoldFirstReturn
namespace SFT.Chemistry.BondDissociationEnergy
open SFT.Foundation.ExactOperations SFT.Physics SFT.Physics.BoundaryGrowth SFT.Physics.LeptonIntervals
-- Original bond_dissociation_energy_law_v1.py:ground_dissociation_from_transition.
-- The output type retains the original successful positive-fraction check.
def groundDissociationFromTransition : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String PositiveFraction
 | .nonFraction,_ => .error "molecular threshold must be an exact positive fraction"
 | .fraction threshold,atomic =>
  match admitPositive threshold with
  | none => .error "molecular threshold must be an exact positive fraction"
  | some whole => match atomic with
    | .nonFraction => .error "atomic excitation must be an exact positive fraction"
    | .fraction excitation => match admitPositive excitation with
      | none => .error "atomic excitation must be an exact positive fraction"
      | some part =>
        if smaller : part.numerator*whole.denominator < whole.numerator*part.denominator then
          .ok (LeptonTake.heldRemainder whole part smaller)
        else .error "the retained threshold cannot Take a non-smaller segment"

theorem retainedPathTake (threshold atomic : PositiveFraction)
 (ordered : atomic.numerator*threshold.denominator < threshold.numerator*atomic.denominator) :
 groundDissociationFromTransition (.fraction (asFraction threshold)) (.fraction (asFraction atomic)) =
 .ok (LeptonTake.heldRemainder threshold atomic ordered) := by
 dsimp only [groundDissociationFromTransition]
 rw [positiveRoundTrip]
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [dite_eq_left ordered]

theorem rejectedNonSmaller (threshold atomic : PositiveFraction)
 (unordered : ¬ atomic.numerator*threshold.denominator < threshold.numerator*atomic.denominator) :
 groundDissociationFromTransition (.fraction (asFraction threshold)) (.fraction (asFraction atomic)) =
 .error "the retained threshold cannot Take a non-smaller segment" := by
 dsimp only [groundDissociationFromTransition]
 rw [positiveRoundTrip]
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [dite_eq_right unordered]

theorem retainedPathValue (threshold atomic : PositiveFraction)
 (ordered : atomic.numerator*threshold.denominator < threshold.numerator*atomic.denominator) :
 (threshold.numerator*atomic.denominator-atomic.numerator*threshold.denominator) *
 (LeptonTake.heldRemainder threshold atomic ordered).denominator =
 (LeptonTake.heldRemainder threshold atomic ordered).numerator *
 (threshold.denominator*atomic.denominator) := LeptonTake.remainderValue threshold atomic ordered

theorem retainedPathReassembles (threshold atomic : PositiveFraction)
 (ordered : atomic.numerator*threshold.denominator < threshold.numerator*atomic.denominator) :
 (threshold.numerator*atomic.denominator-atomic.numerator*threshold.denominator) +
 atomic.numerator*threshold.denominator = threshold.numerator*atomic.denominator :=
 LeptonTake.heldPartReassembles threshold atomic ordered

def witnessValue (a b c d : Nat) (hb : 0 < b) (hd : 0 < d) : Except String (Nat × Nat) := do
 let value ← groundDissociationFromTransition (.fraction (normalize (Int.ofNat a) b hb))
  (.fraction (normalize (Int.ofNat c) d hd))
 pure (value.numerator,value.denominator)
def exactPathWitness : Bool := match witnessValue 9 8 3 4 (by decide) (by decide) with
 | .ok value => value == (3,8)
 | .error _ => false
def orientationWitness : Bool := match witnessValue 3 4 9 8 (by decide) (by decide) with
 | .error _ => true
 | .ok _ => false
def sameLawWitness : Bool := match witnessValue 17 16 3 4 (by decide) (by decide) with
 | .ok value => value == (5,16)
 | .error _ => false
theorem exactPathPassed : exactPathWitness = true := rfl
theorem orientationPassed : orientationWitness = true := rfl
theorem sameLawPassed : sameLawWitness = true := rfl
end SFT.Chemistry.BondDissociationEnergy
