import SFT.Chemistry.StateSymmetryComparison
import SFT.Chemistry.ConjugatedSupportControls
namespace SFT.Chemistry.StateSymmetryControls
open SFT.Host SFT.Physics.CapabilityValues StateSymmetry

def rejected {α : Type} : Except String α → Bool
 | .error _ => true
 | .ok _ => false

def expectedCounts : List (String × Nat) := [
 ("term_assignments",362),("inversion_labels",170),("reflection_labels",167),
 ("positive_axis_components",32),("absent_axis_components",330),("source_zero_component_glyphs",11),
 ("species",22),("registered_state_rows",360)]

def countsMatch (actual : List (String × Nat)) : Bool :=
 actual.length==expectedCounts.length && expectedCounts.all (fun (key,n) =>
  actual.any (fun (other,m) => Text.equal key other && n==m))

def adverse (comparisons : List StateSymmetryComparison.Comparison)
 (actualFirstHash changedFirstHash registeredFirstHash : String) : Except String (List (String × Bool)) := do
 let carrierSigma ← heldLabel "molecular-carrier" "tampered-sigma"
 let carrierPi ← heldLabel "molecular-carrier" "tampered-pi"
 let absent := OptionalLabel.emptyOne "empty-One"
 let sigmaWrong := rejected (validate ⟨carrierSigma,⟨1,by decide⟩,.emptyOne "empty-One",⟨2,by decide⟩,
  absent,absent,absent,absent⟩)
 let piWrong := rejected (validate ⟨carrierPi,⟨1,by decide⟩,.count ⟨1,by decide⟩,⟨1,by decide⟩,
  absent,absent,absent,absent⟩)
 let sample ← fromSource "control" ⟨2,by decide⟩ "Π" "absence" "absence" "absence" "absence"
 let incompleteLabel ← heldLabel "state-component" "incomplete-component"
 let incomplete := rejected (validateClass ⟨sample,[incompleteLabel]⟩)
 let numericZero := rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])
 return [("unknown_support_symbol_rejected",rejected (axisFromSymbol "unknown")),
  ("axis_invariant_wrong_orientation_rejected",sigmaWrong),
  ("positive_axis_without_complementary_pair_rejected",piWrong),
  ("free_degeneracy_count_rejected",(degeneracy sample).value != 5),
  ("incomplete_equivalence_class_rejected",incomplete),
  ("source_absence_glyph_as_numerical_value_rejected",numericZero),
  ("omitted_assignment_rejected",comparisons.length-1 != 362),
  ("tampered_snapshot_rejected",Text.equal actualFirstHash registeredFirstHash && !Text.equal changedFirstHash registeredFirstHash),
  ("complete_external_vector_retained",countsMatch (StateSymmetryComparison.counts comparisons))]
#print axioms rejected
#print axioms expectedCounts
#print axioms countsMatch
#print axioms adverse
end SFT.Chemistry.StateSymmetryControls
