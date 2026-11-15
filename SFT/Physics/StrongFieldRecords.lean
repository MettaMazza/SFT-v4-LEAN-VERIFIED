import SFT.Physics.StrongFieldNonlinearFixedPointEvidence
import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.StrongFieldRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault requiredFields fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "D10E-STRONG-FIELD-NONLINEAR-FIXED-POINT-COMPARISON"
def sourcePath : String := "experiments/external_sources/physics/snapshots/strong-field-nonlinear-fixed-point-source-record.json"
def sourceHash : String := "sha256:6f398afa78b808889b2f0e259e81500f72b5ac128aec4f4a9eefcccc12444818"
def formalCommit : String := "8638badbc9d7fce370e1ad21b0fd04fcad42da21"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/strong-field-nonlinear-fixed-point-source-record.json","sha256:6f398afa78b808889b2f0e259e81500f72b5ac128aec4f4a9eefcccc12444818"),("audits/v1_theorem_manifest_observation_census.json","sha256:05c7c285e87720c0b22a69cc69b07cdd9749a1aa1728afd934e1ed9f7c30ce93"),("claims/SFT-PHYS-STRONG-RUNNING-DIRECTION-002/certificate.json","sha256:a561407fd117a6109e6fb84c83d466c9120213947301d2d224812bb4068801a0"),("claims/SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009/certificate.json","sha256:29f075d3b8331d053f5abb96b76bc24fdc67dae44932fb7e69b22d660b3c9441"),("claims/SFT-PHYS-FIELD-SOURCE-RESPONSE-001/certificate.json","sha256:0e20924541239a1623e3d1cef19f39f9d51538072a9b8044adca86144ce156ed"),("claims/SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003/certificate.json","sha256:a3864e036aca4e2fd083fd4e99334eb450d0e41b490f04439f402a91740a67ea"),("claims/SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013/certificate.json","sha256:189d82acd076b6f4f729af53a9d9733f9a4f96abcd2bdf85eb09933b99608d36"),("claims/SFT-MATH-EXACT-ARITHMETIC-001/certificate.json","sha256:b82b7eaf90c6796ad85bcdf06dd999f3aabf071d9392d59b586869f4d7a87b50"),("claims/SFT-MATH-DYNAMICAL-SYSTEMS-001/certificate.json","sha256:055f93fc7650642070961c4e7b1feecbbd340893faa5049058f4b2cf8472b979"),("claims/SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001/certificate.json","sha256:f26507521a00aa23286f77949a0f3cae2baea030feff5990885357499885c476"),("claims/SFT-PHYS-MEAS-TARGET-CUSTODY-001/certificate.json","sha256:2df6f9d76ec76047ac2d244218cc132197d04b0008f6f7f6e6654d0c4ebdacde"),("experiments/external_sources/physics/snapshots/pdg-2026-qcd.pdf","sha256:c04c628d76b18610c5fa2a919c6081918a25b55fb971b6af5829f4ca2baa386f"),("experiments/external_sources/physics/snapshots/arxiv-1902.04006-string-breaking.pdf","sha256:6c6de4ebdfc86d7976fb343a35f490ff108ab0d56dd1450a1ee27539e2641bb5")]
def requiredKeys : List String := ["v1_source_entry", "v1_chargeless_relation", "v1_gravity_relation", "v1_strong_relation", "v1_joint_discriminator", "existing_v3_strong_running", "existing_v3_gravity_fixed_point", "existing_v3_field_source_response", "existing_v3_sector_inventory", "existing_v3_massless_confined_carrier", "formal_prediction_commit_precedes_target_access", "formal_chargeless_correction_record", "formal_chargeless_fixed_point", "formal_gravity_fixed_point", "formal_gravity_corrections", "formal_strong_initial_source", "formal_strong_successor", "formal_strong_correction", "formal_strong_positive_finite_fixed_point_record", "formal_strong_arbitrary_positive_bound_witness", "formal_completed_infinity_used", "pdg_qcd_nonabelian_gauge_theory", "pdg_qcd_gluon_carries_colour_charge", "pdg_qcd_three_and_four_gluon_self_interactions", "pdg_qcd_free_quarks_observed", "lattice_source_identity", "lattice_theory", "lattice_gluons_only_static_energy_relation", "lattice_linear_growth_rate", "lattice_full_QCD_pair_creation", "lattice_full_QCD_ground_state_saturates", "lattice_ground_state_asymptote", "lattice_string_and_broken_string_mixing_required", "lattice_string_branch_in_breaking_region", "lattice_light_string_breaking_distance", "lattice_strange_string_breaking_distance", "lattice_spacing", "lattice_pion_mass", "lattice_kaon_mass", "lattice_single_ensemble", "lattice_quark_masses_are_not_physical", "lattice_distances_are_not_universal_physical_thresholds", "formal_branch_correspondence", "external_values_select_formal_survivor", "external_distances_used_as_formal_proof_scalars", "measured_parameter_fitted_into_v3", "free_strong_field_correction_added_to_v3"]
def primaryAnchors : Value := .object [("v1_source_entry",.text "D10e"),("formal_strong_successor",.text "F-plus-2"),("formal_strong_correction",.text "2-at-every-successor"),("formal_strong_positive_finite_fixed_point_record",.text "empty"),("formal_completed_infinity_used",.boolean false),("pdg_qcd_nonabelian_gauge_theory",.boolean true),("pdg_qcd_gluon_carries_colour_charge",.boolean true),("pdg_qcd_three_and_four_gluon_self_interactions",.boolean true),("lattice_gluons_only_static_energy_relation",.text "grows-linearly-at-asymptotically-large-separations"),("lattice_full_QCD_pair_creation",.boolean true),("lattice_full_QCD_ground_state_saturates",.boolean true),("lattice_string_and_broken_string_mixing_required",.boolean true)]
def requiredCustody : Value := .object [("formal_claim_contains_historical_or_external_target_values",.boolean false),("formal_prediction_commit_precedes_external_target_access",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_historical_prerequisite_theory_measurement_and_scope_rows_retained",.boolean true),("string_branch_not_inflated_to_full_QCD_ground_state",.boolean true),("lattice_thresholds_not_misreported_as_universal_physical_constants",.boolean true),("targets_select_formal_survivor",.boolean false)]
def prerequisiteClaims : List (String × String) := [("claims/SFT-PHYS-STRONG-RUNNING-DIRECTION-002/certificate.json","SFT-PHYS-STRONG-RUNNING-DIRECTION-002"),("claims/SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009/certificate.json","SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009"),("claims/SFT-PHYS-FIELD-SOURCE-RESPONSE-001/certificate.json","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"),("claims/SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003/certificate.json","SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003"),("claims/SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013/certificate.json","SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013"),("claims/SFT-MATH-EXACT-ARITHMETIC-001/certificate.json","SFT-MATH-EXACT-ARITHMETIC-001"),("claims/SFT-MATH-DYNAMICAL-SYSTEMS-001/certificate.json","SFT-MATH-DYNAMICAL-SYSTEMS-001"),("claims/SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001/certificate.json","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"),("claims/SFT-PHYS-MEAS-TARGET-CUSTODY-001/certificate.json","SFT-PHYS-MEAS-TARGET-CUSTODY-001")]
def payloadBoundary (record : Value) : Except String Value := do
 let target := getDefault record "registered_target" (.object [])
 if !sameValue (getDefault record "source_id") (.text sourceId) || !sameValue (getDefault record "formal_prediction_commit") (.text formalCommit) then throw "D10e source identity or pre-target formal commit changed"
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D10e complete target row ledger changed"
 if (← array (getDefault record "snapshots" (.array []))).length != 12 || keys.length != 47 || !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) then throw "D10e complete target row ledger changed"
 pure record
def historicalBoundary (v1 prerequisites : Value) : Except String Unit := do
 let _ ← prerequisiteClaims.mapM (fun (relative,claim) => do
  let record ← field prerequisites relative
  if !sameValue (getDefault record "claim_id") (.text claim) then throw "D10e prerequisite identity changed"
  pure ())
 let rows ← array (← field v1 "rows")
 let row ← match rows.find? (fun item => sameValue (getDefault item "v1_claim_id") (.text "D10e")) with
  | none => .error "StopIteration"
  | some item => .ok item
 let observation ← text (← field row "prior_result_observation")
 if !(["strong field equation: nonlinear, self-sourced through colour","convergent fixed point with shrinking corrections","corrections do not shrink","chargeless field is linear"].all (Text.contains observation)) then throw "D10e V1 row changed"
 pure ()
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "registered_target" (.object [])) primaryAnchors then throw "D10e formal or external structural row changed"
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D10e custody or scope row changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload v1 prerequisites : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "D10e source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let _ ← historicalBoundary v1 prerequisites
 custodyBoundary record
end SFT.Physics.StrongFieldRecords
