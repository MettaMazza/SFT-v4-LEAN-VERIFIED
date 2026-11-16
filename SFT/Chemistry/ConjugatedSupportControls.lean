import SFT.Chemistry.ConjugatedSupportComparison
namespace SFT.Chemistry.ConjugatedSupportControls
open SFT.Host ConjugatedSupportAnalysis
-- FoldWord.__post_init__/validate_fold_value: host scalars are not typed Fold values.
def wordCells : List (Sum SFT.Physics.CapabilityValues.Value J) → Except String (List SFT.Physics.CapabilityValues.Value)
 | [] => .ok []
 | .inr _ :: _ => .error "value is outside the capability-closed exact Fold domain"
 | .inl value :: rest => do let tail ← wordCells rest; pure (value::tail)
def truthy : J → Bool
 | .boolean b => b
 | .integer (.ofNat n) => !(n==0)
 | .integer (.negSucc _) => true
 | .text s => !s.isEmpty
 | .null => false
 | .array xs => !xs.isEmpty
 | .object xs => !xs.isEmpty
def equalExpected (actual expected : J) : Bool :=
 match expected with
 | .integer (.ofNat n) => match actual with
   | .integer (.ofNat m) => m==n
   | .boolean b => if b then n==1 else n==0
   | .integer (.negSucc _) | .null | .text _ | .array _ | .object _ => false
 | .integer (.negSucc _) | .boolean _ | .null | .text _ | .array _ | .object _ =>
   Text.equal (Canonical.render actual) (Canonical.render expected)
def checkField (analysis : J) (key : String) (expected : J) : Except String Bool := do
 let actual ← field analysis key
 pure (equalExpected actual expected)
def controls (rows : List SourceRow) (releasedCount : Nat) (analysis document : J) : Except String (List (String × J)) := do
 let omitted := match exactAnalysis (rows.take (rows.length-1)) (.object []) with
  | .error _ => true
  | .ok _ => false
 let zero := match wordCells [.inr (.integer 0)] with | .error _ => true | .ok _ => false
 let repeated ← field analysis "repeated_fibre_rejected"
 let incomplete ← field analysis "incomplete_incidence_rejected"
 let duplicate ← field analysis "duplicate_occurrence_rejected"
 let separated ← field analysis "separated_control_rcc_external_strings"
 let conjugated ← field analysis "conjugated_rcc_external_strings"
 let signed ← field analysis "external_signed_control_inscription_preserved"
 let overrun ← checkField analysis "preserved_v1_parser_overrun_count" (.integer 1)
 let corrected ← if overrun then checkField analysis "v2_corrected_table_count" (.integer 2) else pure false
 let recapture ← checkField analysis "source_recapture_count" (.integer 0)
 let tokens := ["complete_definition","1.476","1.337","FIRSTX","NPOINTS","target_payload_hash","alternating single and multiple bonds"]
 let forbidden := tokens.any (Text.contains (Canonical.render document))
 return [
 ("omitted_source_row_rejected",.boolean omitted),("numerical_zero_rejected",.boolean zero),
 ("all_ten_target_hashes_bound_postseal",.boolean (releasedCount==10)),
 ("repeated_adjacent_fibre_rejected",repeated),("incomplete_incidence_rejected",incomplete),
 ("duplicate_occurrence_rejected",duplicate),
 ("separated_control_not_classified_from_bond_counts_alone",.boolean (!equalExpected separated conjugated)),
 ("external_signed_control_inscription_downstream_and_preserved",signed),
 ("v1_parser_overrun_preserved_and_corrected_separately",.boolean corrected),
 ("sources_not_recaptured",.boolean recapture),
 ("prediction_contains_no_definition_coordinate_spectrum_or_target_payload",.boolean (!forbidden))]
def originalPassChecks : List (String × Option J) := [
("base_atom_count",some (.integer 3)),
("base_support_count",some (.integer 2)),
("successor_atom_count",some (.integer 4)),
("successor_support_count",some (.integer 3)),
("prior_incidence_prefix_preserved",none),
("complete_target_count",some (.integer 10)),
("complete_source_count",some (.integer 7)),
("development_observed_target_count",some (.integer 8)),
("identity_only_unopened_target_count",some (.integer 2)),
("alternating_single_multiple_surface_count",some (.integer 2)),
("connected_intervening_bond_surface_present",none),
("delocalized_nonlocal_support_surface_present",none),
("conjugated_smiles_inscription",some (.text "C=CC=C")),
("conjugated_rcc_external_strings",some (.array [.text "1.476",.text "1.337"])),
("separated_control_rcc_external_strings",some (.array [.text "1.511",.text "1.339"])),
("complete_vibrational_table_rows",some (.integer 26)),
("uv_visible_declared_point_count",some (.integer 502)),
("uv_visible_preserved_point_count",some (.integer 502)),
("uv_visible_first_x_external_string",some (.text "200.6193")),
("uv_visible_last_x_external_string",some (.text "333.0485")),
("uv_visible_max_y_external_string",some (.text "4.47885")),
("uv_visible_jcamp_link_present",none),
("all_rows_preserved",none)]
def passChecks (analysis : J) : List (String × Option J) → Except String Bool
 | [] => .ok true
 | (key,expected)::rest => do
  let actual ← field analysis key
  let holds := match expected with | none => truthy actual | some expected => equalExpected actual expected
  if holds then passChecks analysis rest else pure false
def passed (comparisons : List ConjugatedSupportComparison.Comparison) (analysis : J)
 (controlRows : List (String × J)) : Except String Bool := do
 if !(comparisons.all ConjugatedSupportComparison.Comparison.passed) then pure false else do
  let analysisPassed ← passChecks analysis originalPassChecks
  if analysisPassed then pure (controlRows.all (fun row => truthy row.2)) else pure false
#print axioms wordCells
#print axioms truthy
#print axioms equalExpected
#print axioms checkField
#print axioms controls
#print axioms originalPassChecks
#print axioms passChecks
#print axioms passed
end SFT.Chemistry.ConjugatedSupportControls
