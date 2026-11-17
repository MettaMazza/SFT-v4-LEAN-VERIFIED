import SFT.Materials.RotationTotient
import SFT.Foundation.ExactCast
import SFT.Host.Canonical
namespace SFT.Materials.FerrimagneticGap
open SFT.Host SFT.Materials.RotationTotient

def certificate (first second : PositiveCount) : Canonical.Value :=
 if first.val = second.val then
  .object [("net_support",.object [("family",.text "moment"),("label",.text "structural-absence")]),
   ("order",.text "equal-opposed")]
 else
  let larger := if second.val < first.val then first else second
  let smaller := if second.val < first.val then second else first
  let orientation := if second.val < first.val then "first-sublattice" else "second-sublattice"
  .object [("net_support",.object [("value",.integer (.ofNat (larger.val-smaller.val)))]),
   ("orientation",.object [("family",.text "dominant-sublattice"),("label",.text orientation)]),
   ("order",.text "opposed-unequal")]

theorem firstGapPositive (first second : PositiveCount) (h : second.val < first.val) :
 0 < first.val-second.val := SFT.Foundation.ExactCast.subtractPositive _ _ h

theorem secondGapPositive (first second : PositiveCount) (unequal : first.val ≠ second.val)
 (notFirst : ¬second.val < first.val) : 0 < second.val-first.val := by
 cases Nat.lt_or_gt_of_ne unequal with
 | inl h => exact SFT.Foundation.ExactCast.subtractPositive _ _ h
 | inr h => exact False.elim (notFirst h)

theorem equalCertificate (first second : PositiveCount) (same : first.val = second.val) :
 certificate first second = .object [("net_support",.object [("family",.text "moment"),("label",.text "structural-absence")]),("order",.text "equal-opposed")] := by
 unfold certificate
 rw [if_pos same]

def originalWitness : Bool :=
 match certificate ⟨5,by decide⟩ ⟨3,by decide⟩ with
 | .object fields => fields.any (fun row => Text.equal row.1 "net_support" &&
   match row.2 with
   | .object inner => inner.any (fun field => Text.equal field.1 "value" &&
     match field.2 with
     | .integer z => match z with | .ofNat n => Nat.beq n 2 | .negSucc _ => false
     | .text _ | .boolean _ | .null | .array _ | .object _ => false)
   | .text _ | .integer _ | .boolean _ | .null | .array _ => false)
 | .text _ | .integer _ | .boolean _ | .null | .array _ => false

theorem originalWitnessPassed : originalWitness = true := rfl
#print axioms certificate
#print axioms firstGapPositive
#print axioms secondGapPositive
#print axioms equalCertificate
#print axioms originalWitness
#print axioms originalWitnessPassed
end SFT.Materials.FerrimagneticGap
