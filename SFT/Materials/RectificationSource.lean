import SFT.Materials.RotationTotient
import SFT.Foundation.ExactCast
import SFT.Host.Canonical
namespace SFT.Materials.RectificationSource
open SFT.Host SFT.Materials.RotationTotient

inductive ForwardState where
 | retained : PositiveCount → ForwardState
 | opened : ForwardState

def forwardState (barrier applied : PositiveCount) : ForwardState :=
 if h : applied.val < barrier.val then
  .retained ⟨barrier.val-applied.val,SFT.Foundation.ExactCast.subtractPositive _ _ h⟩
 else .opened

def reverseState (barrier applied : PositiveCount) : PositiveCount :=
 ⟨barrier.val+applied.val,Nat.add_pos_left barrier.property _⟩

def forwardValue : ForwardState → Canonical.Value
 | .retained count => .object [("value",.integer (.ofNat count.val))]
 | .opened => .object [("family",.text "junction-access"),("label",.text "open")]

def certificate (barrier applied : PositiveCount) : Canonical.Value := .object [
 ("forward_orientation",forwardValue (forwardState barrier applied)),
 ("reverse_orientation",.object [("value",.integer (.ofNat (reverseState barrier applied).val))]),
 ("orientations_distinct",.boolean true)]

theorem reverseEquation (barrier applied : PositiveCount) :
 (reverseState barrier applied).val = barrier.val+applied.val := rfl

theorem retainedForwardEquation (barrier applied : PositiveCount) (below : applied.val < barrier.val) :
 forwardState barrier applied = .retained ⟨barrier.val-applied.val,SFT.Foundation.ExactCast.subtractPositive _ _ below⟩ := by
 unfold forwardState
 rw [dif_pos below]

theorem openedForwardEquation (barrier applied : PositiveCount) (reached : ¬applied.val < barrier.val) :
 forwardState barrier applied = .opened := by
 unfold forwardState
 rw [dif_neg reached]

def originalWitness : Bool :=
 match certificate ⟨3,by decide⟩ ⟨1,by decide⟩ with
 | .object fields => fields.any (fun row => Text.equal row.1 "orientations_distinct" &&
   match row.2 with | .boolean value => value | .text _ | .integer _ | .null | .array _ | .object _ => false)
 | .text _ | .integer _ | .boolean _ | .null | .array _ => false

theorem originalWitnessPassed : originalWitness = true := rfl
#print axioms forwardState
#print axioms reverseState
#print axioms forwardValue
#print axioms certificate
#print axioms reverseEquation
#print axioms retainedForwardEquation
#print axioms openedForwardEquation
#print axioms originalWitness
#print axioms originalWitnessPassed
end SFT.Materials.RectificationSource
