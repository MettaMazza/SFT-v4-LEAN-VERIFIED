import SFT.Chemistry.ResonanceEquivalentComparison
namespace SFT.Chemistry.ResonanceEquivalentControls
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
 let omitted := match ResonanceEquivalentAnalysis.exactAnalysis (rows.take (rows.length-1)) (.object []) with
  | .error _ => true
  | .ok _ => false
 let zero := match wordCells [.inr (.integer 0)] with | .error _ => true | .ok _ => false
 let carrier ← field analysis "carrier_mismatch_rejected"
 let adjacency ← field analysis "adjacency_mismatch_rejected"
 let partialComplement ← field analysis "partial_complement_rejected"
 let identical ← field analysis "identical_encoding_rejected"
 let wave ← field analysis "external_wavefunction_and_coefficient_language_preserved"
 let external ← if truthy wave then field analysis "external_signed_charge_inscription_preserved" else pure wave
 let search ← checkField analysis "preserved_v1_charge_search_scope_false_result_count" (.integer 1)
 let corrected ← if search then checkField analysis "v2_corrected_complete_record_search_count" (.integer 4) else pure false
 let recapture ← checkField analysis "source_recapture_count" (.integer 0)
 let tokens := ["complete_term_record","definition","wavefunction","coefficient","o^{-}","target_payload_hash"]
 let forbidden := tokens.any (Text.contains (Text.lowerAscii (Canonical.render document)))
 return [
 ("omitted_source_row_rejected",.boolean omitted),("numerical_zero_rejected",.boolean zero),
 ("all_four_target_hashes_bound_postseal",.boolean (releasedCount==4)),
 ("different_carrier_rejected",carrier),("changed_adjacency_rejected",adjacency),
 ("partial_noncomplement_rejected",partialComplement),("identical_encoding_rejected",identical),
 ("external_wavefunction_coefficient_and_charge_downstream_and_preserved",external),
 ("v1_search_scope_error_preserved_and_corrected_separately",.boolean corrected),
 ("sources_not_recaptured",.boolean recapture),
 ("prediction_contains_no_definition_note_example_wavefunction_coefficient_charge_or_payload",.boolean (!forbidden))]
def originalPassChecks : List (String × Option J) := [
("base_atom_count",some (.integer 3)),
("base_adjacency_count",some (.integer 2)),
("base_representation_count",some (.integer 2)),
("successor_atom_count",some (.integer 4)),
("successor_adjacency_count",some (.integer 3)),
("prior_atom_prefix_preserved",none),
("prior_adjacency_prefix_preserved",none),
("complete_complement_preserved",none),
("complete_target_count",some (.integer 4)),
("complete_source_count",some (.integer 4)),
("development_observed_target_count",some (.integer 3)),
("predecessor_opened_target_count",some (.integer 1)),
("one_molecular_entity_representation_surface_present",none),
("at_least_two_formal_structures_surface_present",none),
("single_structure_insufficient_surface_present",none),
("formal_not_species_surface_present",none),
("not_equilibrium_surface_present",none),
("nonlocal_support_surface_present",none),
("all_rows_preserved",none)]
def passChecks (analysis : J) : List (String × Option J) → Except String Bool
 | [] => .ok true
 | (key,expected)::rest => do
  let actual ← field analysis key
  let holds := match expected with | none => truthy actual | some expected => equalExpected actual expected
  if holds then passChecks analysis rest else pure false
def passed (comparisons : List ResonanceEquivalentComparison.Comparison) (analysis : J)
 (controlRows : List (String × J)) : Except String Bool := do
 if !(comparisons.all ResonanceEquivalentComparison.Comparison.passed) then pure false else do
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
end SFT.Chemistry.ResonanceEquivalentControls
