import SFT.Chemistry.ComplexSpinStateSource
import SFT.Chemistry.ComplexSpinStateDerivation
namespace SFT.Chemistry.ComplexSpinStateAnalysis
open SFT.Host ComplexSpinState ComplexSpinStateDerivation
open JointCorrelationTargets (field)
open ComplexSpinStatePrediction (get equal)
abbrev J := Canonical.Value
def countValue : ExactCount → J
 | .empty _ => .text "EmptyOne"
 | .positive p => .integer (.ofNat p.value)
def conjunction (row : J) (keys : List String) : Except String J := do
 match keys with
 | [] => return .boolean true
 | key::rest =>
  let first ← field row key
  rest.foldlM (fun value key => do
   if equal value (.boolean false) then return value
   field row key) first
def lowPairValue (x : ExactCount) : J :=
 if isEmpty x then .text "EmptyOne" else .integer 3
def retainAnd (x y : J) : J := if equal x (.boolean false) then x else y
def rowAt : List J → Nat → J
 | [],_ => .null
 | x::_,0 => x
 | _::xs,n+1 => rowAt xs n
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 3 then throw "INORG-007 requires all three source surfaces"
 let signatures ← sixCensus
 let hi ← high signatures
 let lo ← low signatures
 let vector ← sixVector
 let highRow := rowAt rows 0
 let lowRow := rowAt rows 1
 let crossoverRow := rowAt rows 2
 let highSurface ← field highRow "source_outcome"
 let lowSurface ← field lowRow "source_outcome"
 let cross ← field crossoverRow "source_outcome"
 let post ← field primary "exact_postseal_analysis"
 let combined ← conjunction highSurface ["combined_surface_also_defines_high_spin","low_spin_complete_lower_support_surface_present","high_spin_prior_higher_support_occupation_surface_present"]
 let lowDefinition ← conjunction lowSurface ["paired_lower_support_surface_present","complete_order_comparison_surface_present"]
 let mismatch ← field highSurface "registered_transport_identity_mismatch_preserved"
 let mismatch := retainAnd mismatch
  (.boolean (!(equal (get highSurface "requested_source_id") (get highSurface "observed_source_code"))))
 let direction ← conjunction cross ["shorter_distance_maps_to_low_spin","longer_distance_maps_to_high_spin"]
 let preserved ← field post "all_three_rows_preserved"
 return .object [
  ("signature_count",.integer (.ofNat signatures.length)),
  ("low_signature",.array [lowPairValue lo.lowerPairs,countValue lo.lowerSingles,countValue lo.upperPairs,countValue lo.upperSingles]),
  ("low_spin_width",.integer (.ofNat (spinWidth lo).value)),
  ("low_crossings",countValue (crossings lo)),
  ("high_signature",.array [countValue hi.lowerPairs,countValue hi.lowerSingles,countValue hi.upperPairs,countValue hi.upperSingles]),
  ("high_spin_width",.integer (.ofNat (spinWidth hi).value)),
  ("high_crossings",countValue (crossings hi)),
  ("order_vector",.array (vector.map fun x => .text x.relation.label)),
  ("cost_vector",.array (vector.map fun x => .array [countValue x.highCost,countValue x.lowCost])),
  ("combined_high_low_definition_surface_present",combined),
  ("low_order_definition_surface_present",lowDefinition),
  ("transport_mismatch_preserved",mismatch),
  ("external_distance_vector_pm",.array [← field cross "lower_distance_pm_exact",← field cross "higher_distance_pm_exact"]),
  ("external_temperature_vector_k",.array [← field cross "lower_temperature_k_exact",← field cross "higher_temperature_k_exact"]),
  ("external_term_vector",.array [← field cross "lower_term",← field cross "higher_term"]),
  ("external_state_vector",.array [← field cross "lower_state",← field cross "higher_state"]),
  ("external_dilution_direction_match",direction),
  ("complete_rows_preserved",retainAnd preserved (.boolean (rows.length==3))),
  ("dimensional_values_fitted_or_derived",← field post "dimensional_distance_temperature_or_term_fitted_or_derived")]
end SFT.Chemistry.ComplexSpinStateAnalysis
