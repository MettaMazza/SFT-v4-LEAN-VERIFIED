import SFT.Chemistry.PairExchangeComparison
import SFT.Chemistry.StateSymmetryControls
namespace SFT.Chemistry.PairExchangeControls
open SFT.Host SFT.Physics.CapabilityValues PairExchange
open StateSymmetryControls (rejected)
def expectedCounts : List (String × Nat) := [
 ("state_rows",46),("singlet_states",25),("triplet_states",21),("explicit_same_cell_singlets",2),
 ("same_configuration_exchange_pairs",14),("triplet_below_singlet",13),("singlet_below_triplet",1),
 ("source_ground_absence_glyphs",1)]
def countAt (counts : List (String × Nat)) (key : String) : Except String Nat :=
 match counts.find? (fun row => Text.equal row.1 key) with
 | none => .error (Text.intercalate "" ["'",key,"'"])
 | some row => .ok row.2

def adverse (states : List PairExchangeComparison.StateComparison) (pairs : List PairExchangeComparison.PairComparison)
 (counts : List (String × Nat)) (actualHash changedHash registeredHash : String) : Except String (List (String × Bool)) := do
 let invalidMultiplicity := rejected (fromMultiplicity "H2" "invalid" ⟨2,by decide⟩)
 let triplet ← fromMultiplicity "H2" "triplet-control" ⟨3,by decide⟩
 let sameCellTriplet := !(← occupancyCompatible triplet ⟨2,by decide⟩)
 let third := rejected (do
  let singlet ← fromMultiplicity "H2" "singlet-control" ⟨1,by decide⟩
  occupancyCompatible singlet ⟨3,by decide⟩)
 let badTotal := rejected (validate ⟨← heldLabel "molecular-carrier" "H2",← heldLabel "molecular-electronic-state" "tampered",
  ⟨1,by decide⟩,alternating,preserving,preserving,sameCellAdmitted⟩)
 let sameFibre := StateSymmetry.labelEqual (← exchangeProduct preserving preserving) preserving &&
  StateSymmetry.labelEqual (← exchangeProduct alternating alternating) preserving
 let numericZero := rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])
 let changedRatios ← pairs.mapM fun row => do
  let original ← PairExchangeComparison.positiveRatio row.numerator.value row.denominator.value
  let changed ← PairExchangeComparison.positiveRatio (row.numerator.value+1) row.denominator.value
  return !(original.1.value==changed.1.value && original.2.value==changed.2.value)
 let allCounts := counts.length==expectedCounts.length && expectedCounts.all (fun (k,n) => counts.any (fun (key,m) => Text.equal k key && n==m))
 return [("invalid_two-electron_multiplicity_rejected",invalidMultiplicity),
  ("same_cell_triplet_rejected",sameCellTriplet),("third_same_support_occurrence_rejected",third),
  ("nonalternating_total_rejected",badTotal),("same_fibre_product_retained_as_preserving_not_fermionic_total",sameFibre),
  ("source_absence_glyph_as_numerical_value_rejected",numericZero),
  ("omitted_state_rejected",states.length-1 != 46),("omitted_exchange_pair_rejected",pairs.length-1 != 14),
  ("selected_favourable_energy_order_rejected",(← countAt counts "singlet_below_triplet")==1),
  ("changed_measured_separation_rejected",changedRatios.all id),
  ("tampered_snapshot_rejected",Text.equal actualHash registeredHash && !Text.equal changedHash registeredHash),
  ("complete_external_vector_retained",allCounts)]
#print axioms expectedCounts
#print axioms countAt
#print axioms adverse
end SFT.Chemistry.PairExchangeControls
