import SFT.Physics.StrongCarrierMasslessConfinedEvidence
import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.StrongCarrierRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault requiredFields fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "D10F-STRONG-CARRIER-MASSLESS-CONFINED-COMPARISON"
def sourcePath : String := "experiments/external_sources/physics/snapshots/strong-carrier-massless-confined-source-record.json"
def sourceHash : String := "sha256:0e78e607dae7721adae01f99f79ea24ea6d38569abfd19c94413aaadca9550cc"
def formalCommit : String := "5cc20feeaa53a7ecfba3208a2f60f70af36c3d4a"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/strong-carrier-massless-confined-source-record.json","sha256:0e78e607dae7721adae01f99f79ea24ea6d38569abfd19c94413aaadca9550cc"),("audits/v1_theorem_manifest_observation_census.json","sha256:05c7c285e87720c0b22a69cc69b07cdd9749a1aa1728afd934e1ed9f7c30ce93"),("claims/SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003/certificate.json","sha256:a3864e036aca4e2fd083fd4e99334eb450d0e41b490f04439f402a91740a67ea"),("claims/SFT-PHYS-STRONG-RUNNING-DIRECTION-002/certificate.json","sha256:a561407fd117a6109e6fb84c83d466c9120213947301d2d224812bb4068801a0"),("claims/SFT-PHYS-SPACETIME-EXACT-INTERVAL-003/certificate.json","sha256:af3c471a117b27824fc66dcf53eb5fac205f4485389805c5613a260d3e3cad41"),("claims/SFT-PHYS-WAVE-EXACT-OPERATIONS-003/certificate.json","sha256:1919bf9175f3aebbf62fd630b7853b65b5da0f4949048d215ce2cdbb1f69440e"),("claims/SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005/certificate.json","sha256:6bf9067bb86ea1a522075a097e13ca867bef76e4a9e98e8c2d1f19b2330d039e"),("claims/SFT-PHYS-MATTER-COMPOSITE-HADRONS-001/certificate.json","sha256:e38e1be56e5ae4cdcf51d491f269ceb2c245b7ef7aee4e6fbb181328eb2bdb6b"),("claims/SFT-PHYS-FIELD-CONSERVED-SOURCE-001/certificate.json","sha256:9e78df61ebe776423956367e08d714261f56f0b55a58b579a768270bd0000937"),("claims/SFT-MATH-EXACT-ARITHMETIC-001/certificate.json","sha256:b82b7eaf90c6796ad85bcdf06dd999f3aabf071d9392d59b586869f4d7a87b50"),("claims/SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001/certificate.json","sha256:f26507521a00aa23286f77949a0f3cae2baea030feff5990885357499885c476"),("claims/SFT-PHYS-MEAS-TARGET-CUSTODY-001/certificate.json","sha256:2df6f9d76ec76047ac2d244218cc132197d04b0008f6f7f6e6654d0c4ebdacde"),("experiments/external_sources/physics/snapshots/pdg-2026-gluon-listing.pdf","sha256:fcc152780d2efb6cb66d2f9351abd034d30cab0e914fd87a0daee46a0344353d"),("experiments/external_sources/physics/snapshots/pdg-2026-qcd.pdf","sha256:c04c628d76b18610c5fa2a919c6081918a25b55fb971b6af5829f4ca2baa386f"),("experiments/external_sources/physics/snapshots/pdg-2026-quark-model.pdf","sha256:6aa98fa53857122f27b638c59081af1a2857d787c4205370d8fa38fcb6b70ff0")]
def requiredKeys : List String := ["v1_source_entry", "v1_mass_relation", "v1_causal_relation", "v1_confinement_relation", "v1_joint_relation", "existing_v3_sector_inventory", "existing_v3_self_source", "existing_v3_empty_mass_boundary", "existing_v3_One_speed_operation", "existing_v3_finite_range_control", "existing_v3_colour_neutral_composites", "existing_v3_conserved_source", "formal_prediction_commit_precedes_target_access", "formal_colour_labels", "formal_nonsinglet_carrier_count", "formal_mass_record", "formal_causal_speed", "formal_tube_width", "formal_separation_work_successor", "formal_isolated_colour_record", "pdg_gluon_listing_identity", "pdg_gluon_colour_representation", "pdg_gluon_mass_value", "pdg_gluon_mass_value_classification", "pdg_gluon_mass_caveat", "pdg_qcd_colour_count", "pdg_qcd_gluon_count", "pdg_qcd_gluon_representation", "pdg_qcd_nonlinear_field_term_present", "pdg_qcd_three_gluon_vertex_present", "pdg_qcd_four_gluon_vertex_present", "pdg_qcd_free_quarks_or_gluons_observed", "pdg_qcd_hadrons_are_colour_singlets", "pdg_measured_CA", "pdg_expected_CA", "pdg_measured_CF", "pdg_expected_CF", "pdg_CA_CF_correlation", "pdg_colour_factor_assessment", "pdg_gluon_jet_evidence", "pdg_quark_model_confinement_status", "pdg_physical_state_boundary", "pdg_permanent_colour_confinement_status", "direct_free_gluon_time_of_flight_measurement_available", "external_values_select_formal_survivor", "external_mass_value_used_as_formal_proof_scalar", "measured_parameter_fitted_into_v3", "free_carrier_correction_added_to_v3"]
def historicalAnchors : Value := .object [("v1_source_entry",.text "D10f"),("v1_joint_relation",.text "masslessness-and-confinement-coexist"),("formal_prediction_commit_precedes_target_access",.boolean true),("formal_colour_labels",.text "3"),("formal_nonsinglet_carrier_count",.text "8"),("formal_mass_record",.text "empty"),("formal_causal_speed",.text "One-support-cell-per-tick"),("formal_tube_width",.text "half-One"),("formal_separation_work_successor",.text "two-thirds"),("formal_isolated_colour_record",.text "empty")]
def primaryAnchors : Value := .object [("pdg_gluon_colour_representation",.text "SU(3)-color-octet"),("pdg_gluon_mass_value",.text "m=0"),("pdg_gluon_mass_value_classification",.text "theoretical-value"),("pdg_gluon_mass_caveat",.text "mass-as-large-as-a-few-MeV-may-not-be-precluded"),("pdg_qcd_colour_count",.text "Nc=3"),("pdg_qcd_gluon_count",.text "Nc-squared-minus-1=8"),("pdg_qcd_gluon_representation",.text "adjoint-SU(3)"),("pdg_qcd_nonlinear_field_term_present",.boolean true),("pdg_qcd_three_gluon_vertex_present",.boolean true),("pdg_qcd_four_gluon_vertex_present",.boolean true),("pdg_qcd_free_quarks_or_gluons_observed",.boolean false),("pdg_qcd_hadrons_are_colour_singlets",.boolean true)]
def requiredCustody : Value := .object [("formal_claim_contains_historical_or_external_target_values",.boolean false),("formal_prediction_commit_precedes_external_target_access",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_historical_prerequisite_theory_measurement_and_scope_rows_retained",.boolean true),("pdg_theoretical_mass_value_not_misreported_as_direct_measurement",.boolean true),("targets_select_formal_survivor",.boolean false)]
def prerequisiteClaims : List (String × String) := [("claims/SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003/certificate.json","SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003"),("claims/SFT-PHYS-STRONG-RUNNING-DIRECTION-002/certificate.json","SFT-PHYS-STRONG-RUNNING-DIRECTION-002"),("claims/SFT-PHYS-SPACETIME-EXACT-INTERVAL-003/certificate.json","SFT-PHYS-SPACETIME-EXACT-INTERVAL-003"),("claims/SFT-PHYS-WAVE-EXACT-OPERATIONS-003/certificate.json","SFT-PHYS-WAVE-EXACT-OPERATIONS-003"),("claims/SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005/certificate.json","SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005"),("claims/SFT-PHYS-MATTER-COMPOSITE-HADRONS-001/certificate.json","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001"),("claims/SFT-PHYS-FIELD-CONSERVED-SOURCE-001/certificate.json","SFT-PHYS-FIELD-CONSERVED-SOURCE-001"),("claims/SFT-MATH-EXACT-ARITHMETIC-001/certificate.json","SFT-MATH-EXACT-ARITHMETIC-001"),("claims/SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001/certificate.json","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"),("claims/SFT-PHYS-MEAS-TARGET-CUSTODY-001/certificate.json","SFT-PHYS-MEAS-TARGET-CUSTODY-001")]
def payloadBoundary (record : Value) : Except String Value := do
 let target := getDefault record "registered_target" (.object [])
 if !sameValue (getDefault record "source_id") (.text sourceId) || !sameValue (getDefault record "formal_prediction_commit") (.text formalCommit) then throw "D10f source identity or pre-target formal commit changed"
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D10f complete target row ledger changed"
 if (← array (getDefault record "snapshots" (.array []))).length != 14 || keys.length != 48 || !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) then throw "D10f complete target row ledger changed"
 if !requiredFields target historicalAnchors then throw "D10f historical or formal target row changed"
 if !requiredFields target primaryAnchors then throw "D10f PDG structure or mass row changed"
 pure record
def historicalBoundary (v1 prerequisites : Value) : Except String Unit := do
 let _ ← prerequisiteClaims.mapM (fun (relative,claim) => do
  let record ← field prerequisites relative
  if !sameValue (getDefault record "claim_id") (.text claim) then throw "D10f prerequisite changed"
  pure ())
 let rows ← array (← field v1 "rows")
 let row ← match rows.find? (fun item => sameValue (getDefault item "v1_claim_id") (.text "D10f")) with
  | none => .error "StopIteration"
  | some item => .ok item
 let observation ← text (← field row "prior_result_observation")
 if !(["strong carrier is massless (luminal) yet confining","strong carrier acquires no mass-part","self-coupling forms a confining flux tube","masslessness and confinement coexist"].all (Text.contains observation)) then throw "D10f V1 row changed"

 pure ()
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D10f custody changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload v1 prerequisites : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "D10f source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let _ ← historicalBoundary v1 prerequisites
 custodyBoundary record
end SFT.Physics.StrongCarrierRecords
