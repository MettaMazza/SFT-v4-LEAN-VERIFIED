import SFT.Physics.SymmetricSourceConservationEvidence
import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.SymmetricRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault requiredFields fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "D9N-SYMMETRIC-SOURCE-CONSERVATION-COMPARISON"
def sourcePath : String := "experiments/external_sources/physics/snapshots/symmetric-source-conservation-source-record.json"
def sourceHash : String := "sha256:3d4dfab0d020b9165c83e8d6fd76b2aabf5572f4e988bd95c20417cbf475c013"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/symmetric-source-conservation-source-record.json","sha256:3d4dfab0d020b9165c83e8d6fd76b2aabf5572f4e988bd95c20417cbf475c013"),("audits/v1_theorem_manifest_observation_census.json","sha256:05c7c285e87720c0b22a69cc69b07cdd9749a1aa1728afd934e1ed9f7c30ce93"),("claims/SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003/certificate.json","sha256:d238bf2169eadae2f3066817381ad8ae5c173cd365c6df04812d3cd287d57021"),("experiments/external_sources/physics/snapshots/arxiv-gr-qc-9712019-carroll-gr.pdf","sha256:d4cbfeed3a18370cb7e1a256da6fa7de722982ad7f6a146b4fc0fe14a6bebf6c"),("experiments/external_sources/physics/snapshots/arxiv-gr-qc-0107031-exact-regge-bianchi.pdf","sha256:98499dc16e8963c56be885911f4a0476036f97607f01dfb221ec1c9bc85f6d6c"),("experiments/external_sources/physics/snapshots/ligo-p1800059-gw170817-tests-gr.pdf","sha256:d86fc8bc15abdac47b75960218aefd247f7adeddc00237e9c329b492962584b7")]
def requiredKeys : List String := ["v1_source_entry", "v1_symmetric_four_coordinate_slots", "v1_planar_slots", "v1_energy_source_slots", "v1_momentum_source_slots", "v1_stress_source_slots", "v1_local_conservation_directions", "v1_balanced_source_conserved", "v1_leaking_source_rejected", "existing_v3_symmetric_slots", "existing_v3_physical_polarizations", "carroll_source_tensor", "carroll_geometric_tensor", "carroll_contracted_identity", "carroll_field_equation", "carroll_source_consequence", "regge_exact_discrete_identity", "regge_contracted_identity_count_in_four_dimensions", "regge_equation_count_in_four_dimensions", "regge_gauge_condition_count_in_four_dimensions", "regge_physical_degree_count_in_four_dimensions", "regge_arbitrary_curvature_validity", "regge_general_identity_linear_in_curvature", "regge_operator_identical_to_v3_commuting_difference_operator", "ligo_generic_metric_mode_count", "ligo_general_relativity_tensor_mode_count", "ligo_tensor_vs_vector_log10_bayes", "ligo_tensor_vs_scalar_log10_bayes", "ligo_sky_location", "ligo_hypothesis_scope", "ligo_mixed_mode_tested", "measured_parameter_fitted_into_v3"]
def historicalAnchors : Value := .object [("v1_symmetric_four_coordinate_slots",.text "10"),("v1_energy_source_slots",.text "1"),("v1_momentum_source_slots",.text "3"),("v1_stress_source_slots",.text "6"),("v1_local_conservation_directions",.text "4")]
def discreteAnchors : Value := .object [("regge_contracted_identity_count_in_four_dimensions",.text "4"),("regge_equation_count_in_four_dimensions",.text "10"),("regge_gauge_condition_count_in_four_dimensions",.text "4"),("regge_physical_degree_count_in_four_dimensions",.text "2"),("regge_general_identity_linear_in_curvature",.boolean false),("regge_operator_identical_to_v3_commuting_difference_operator",.boolean false)]
def waveAnchors : Value := .object [("ligo_generic_metric_mode_count",.text "6"),("ligo_general_relativity_tensor_mode_count",.text "2"),("ligo_tensor_vs_vector_log10_bayes",.text "20.81+/-0.08"),("ligo_tensor_vs_scalar_log10_bayes",.text "23.09+/-0.08"),("ligo_mixed_mode_tested",.boolean false),("measured_parameter_fitted_into_v3",.boolean false)]
def requiredCustody : Value := .object [("formal_claim_contains_historical_or_external_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_historical_theory_measurement_and_scope_rows_retained",.boolean true),("targets_select_formal_survivor",.boolean false)]
def truthy : Value → Bool
 | .null => false
 | .boolean b => b
 | .integer (.ofNat n) => !(n==0)
 | .integer (.negSucc _) => true
 | .text s => !s.isEmpty
 | .array xs => !xs.isEmpty
 | .object xs => !xs.isEmpty
def payloadBoundary (record : Value) : Except String Value := do
 let target := getDefault record "registered_target" (.object [])
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D9n target record changed"
 if !sameValue (getDefault record "source_id") (.text sourceId) || (← array (getDefault record "snapshots" (.array []))).length != 5 || keys.length != 32 || !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) then throw "D9n target record changed"
 if !requiredFields target historicalAnchors || !truthy (← field target "v1_balanced_source_conserved") || !truthy (← field target "v1_leaking_source_rejected") then throw "D9n historical values changed"
 if !requiredFields target discreteAnchors then throw "D9n discrete scope changed"
 if !requiredFields target waveAnchors then throw "D9n GW record changed"
 pure record
def historicalBoundary (v1 prerequisite : Value) : Except String Unit := do
 let rows ← array (← field v1 "rows")
 let row ← match rows.find? (fun item => sameValue (getDefault item "v1_claim_id") (.text "D9n")) with
  | none => .error "StopIteration"
  | some item => .ok item
 let observation ← text (← field row "prior_result_observation")
 if !(["ten in 3+1 dimensions","six in 2+1","contracted Bianchi identity","leaking source not"].all (Text.contains observation)) then throw "D9n V1 row changed"
 if !sameValue (getDefault prerequisite "claim_id") (.text "SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003") || !Text.contains (← text (getDefault prerequisite "exact_result" (.text ""))) "D=4" then throw "D9n prerequisite changed"
 pure ()
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D9n custody changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload v1 prerequisite : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "D9n source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let _ ← historicalBoundary v1 prerequisite
 custodyBoundary record
end SFT.Physics.SymmetricRecords
