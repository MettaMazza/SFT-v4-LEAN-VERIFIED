import SFT.Materials.FerrimagneticGap
namespace SFT.Materials.BoundaryEdgeCount
open SFT.Host SFT.Materials.RotationTotient

def certificate (first second : PositiveCount) : Except String Canonical.Value :=
 if first.val = second.val then .error "edge count requires distinct adjacent winding classes"
 else
  let larger := if second.val < first.val then first else second
  let smaller := if second.val < first.val then second else first
  let orientation := if first.val < second.val then "first-to-second" else "second-to-first"
  .ok (.object [("count",.object [("value",.integer (.ofNat (larger.val-smaller.val)))]),
   ("orientation",.object [("family",.text "bulk-order"),("label",.text orientation)])])

theorem firstGapPositive (first second : PositiveCount) (h : second.val < first.val) :
 0 < first.val-second.val := SFT.Materials.FerrimagneticGap.firstGapPositive first second h

theorem secondGapPositive (first second : PositiveCount) (unequal : first.val ≠ second.val)
 (notFirst : ¬second.val < first.val) : 0 < second.val-first.val :=
 SFT.Materials.FerrimagneticGap.secondGapPositive first second unequal notFirst

theorem equalRejected (first second : PositiveCount) (same : first.val = second.val) :
 certificate first second = .error "edge count requires distinct adjacent winding classes" := by
 unfold certificate
 rw [ite_eq_left same]

def originalWitness : Bool :=
 match certificate ⟨5,by decide⟩ ⟨2,by decide⟩ with
 | .error _ => false
 | .ok output => match output with
   | .object fields => fields.any (fun row => Text.equal row.1 "count" &&
     match row.2 with
     | .object inner => inner.any (fun field => Text.equal field.1 "value" &&
       match field.2 with
       | .integer z => match z with | .ofNat n => Nat.beq n 3 | .negSucc _ => false
       | .text _ | .boolean _ | .null | .array _ | .object _ => false)
     | .text _ | .integer _ | .boolean _ | .null | .array _ => false)
   | .text _ | .integer _ | .boolean _ | .null | .array _ => false

theorem originalWitnessPassed : originalWitness = true := rfl
#print axioms certificate
#print axioms firstGapPositive
#print axioms secondGapPositive
#print axioms equalRejected
#print axioms originalWitness
#print axioms originalWitnessPassed
end SFT.Materials.BoundaryEdgeCount
