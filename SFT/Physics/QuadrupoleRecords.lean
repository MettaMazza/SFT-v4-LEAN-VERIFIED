import SFT.Physics.QuadrupoleRadiatedPowerEvidence
import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.QuadrupoleRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault requiredFields fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "D9Q-QUADRUPOLE-RADIATED-POWER-COMPARISON"
def sourcePath : String := "experiments/external_sources/physics/snapshots/quadrupole-radiated-power-source-record.json"
def sourceHash : String := "sha256:cc4962b3f7d4051b91baef30a5f936323beab162da74cc5618a4d603a78cdde9"
def formalCommit : String := "6d2fc8cafd72fb3b50ca3d648a69190d469841e1"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/quadrupole-radiated-power-source-record.json","sha256:cc4962b3f7d4051b91baef30a5f936323beab162da74cc5618a4d603a78cdde9"),("audits/v1_theorem_manifest_observation_census.json","sha256:05c7c285e87720c0b22a69cc69b07cdd9749a1aa1728afd934e1ed9f7c30ce93"),("claims/SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003/certificate.json","sha256:efd694cafd4d48fdaf097d51325114b0ed16f9d201bf437501a88dfafbf7b2be"),("claims/SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003/certificate.json","sha256:f4b3a491aba638ed3ebf7730372980d323235ef3b9f33c2a7223d91779f02f0d"),("claims/SFT-PHYS-FIELD-INVERSE-SQUARE-001/certificate.json","sha256:a5314f6a9f477e596674d93b71437f0b35d9b44401a339e9ae6352f439c3e40f"),("claims/SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001/certificate.json","sha256:49cf663f9be8a83bcb90520d38fea24eff091f0d478e830b269500c129156fa5"),("claims/SFT-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010/certificate.json","sha256:50f20cd3f109456709c36cb46d9e97ec0e4632f18cdfcd19224d7d7d8b619425"),("claims/SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002/certificate.json","sha256:e09460421ef6317965e279632172b357150096ec535dc5d47f26f30430d7d8e5"),("claims/SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001/certificate.json","sha256:f26507521a00aa23286f77949a0f3cae2baea030feff5990885357499885c476"),("claims/SFT-PHYS-MEAS-TARGET-CUSTODY-001/certificate.json","sha256:2df6f9d76ec76047ac2d244218cc132197d04b0008f6f7f6e6654d0c4ebdacde"),("experiments/external_sources/physics/snapshots/arxiv-2112.06795-double-pulsar.pdf","sha256:9d1b5b4dc304b1d6b1b11059a26d96ca97d1c0d43857523058f973c12bddc6a4")]
def requiredKeys : List String := ["v1_source_entry", "v1_leading_radiating_moment", "v1_radiative_rate", "v1_power_relation", "v1_static_control", "v1_amplitude_scaling", "v1_outward_transport", "existing_v3_quadrupole_first", "existing_v3_field_energy_square", "existing_v3_inverse_square", "existing_v3_boundary_rank_two", "existing_v3_source_conservation", "existing_v3_binary_coupling", "formal_prediction_commit_precedes_target_access", "formal_normalized_binary_comparison", "primary_system", "primary_observation_span", "primary_orbital_period", "primary_eccentricity", "primary_tracked_orbits", "primary_dominant_orbital_decay_cause", "primary_shklovskii_correction", "primary_galactic_correction", "primary_combined_external_correction", "primary_intrinsic_orbital_decay", "primary_spin_down_mass_loss_correction", "primary_measured_GW_orbital_decay", "primary_measured_fractional_precision", "primary_leading_quadrupole_prediction", "primary_next_order_3_5PN_correction", "primary_total_prediction", "primary_measured_over_predicted_ratio", "primary_95_percent_agreement_boundary", "primary_extreme_EOS_ratio", "primary_cumulative_periastron_normalized_chi_squared", "primary_leading_order_classification", "primary_next_order_classification", "primary_distance_uncertainty_currently_subdominant", "primary_observed_timing_error_dominates_current_intrinsic_uncertainty", "primary_future_limit_requires_kinematic_corrections", "primary_regime", "primary_black-hole_merger_comparison_requires_regime_caveat", "primary_alternative_scalar_theories_can_add_lower-moment-radiation", "primary_result_measures_universal_Fold_power_fraction", "external_values_select_formal_survivor", "negative_external_decay_sign_used_as_formal_proof_scalar", "measured_parameter_fitted_into_v3", "free_radiation_correction_added_to_v3"]
def historicalAnchors : Value := .object [("v1_source_entry",.text "D9q"),("v1_radiative_rate",.text "third-time-difference-of-quadrupole"),("v1_static_control",.text "static-quadrupole-is-silent"),("existing_v3_binary_coupling",.text "half-One"),("formal_prediction_commit_precedes_target_access",.boolean true),("formal_normalized_binary_comparison",.text "One")]
def primaryAnchors : Value := .object [("primary_measured_GW_orbital_decay",.text "-1.247782(79)e-12"),("primary_leading_quadrupole_prediction",.text "-1.247810(+6/-7)e-12"),("primary_next_order_3_5PN_correction",.text "-1.75e-17"),("primary_total_prediction",.text "-1.247827(+6/-7)e-12"),("primary_measured_over_predicted_ratio",.text "0.999963(63)"),("primary_95_percent_agreement_boundary",.text "1.3e-4"),("primary_extreme_EOS_ratio",.text "0.999958(64)")]
def scopeAnchors : Value := .object [("primary_distance_uncertainty_currently_subdominant",.boolean true),("primary_observed_timing_error_dominates_current_intrinsic_uncertainty",.boolean true),("primary_future_limit_requires_kinematic_corrections",.boolean true),("primary_black-hole_merger_comparison_requires_regime_caveat",.boolean true),("primary_alternative_scalar_theories_can_add_lower-moment-radiation",.boolean true),("primary_result_measures_universal_Fold_power_fraction",.boolean false),("external_values_select_formal_survivor",.boolean false),("negative_external_decay_sign_used_as_formal_proof_scalar",.boolean false),("measured_parameter_fitted_into_v3",.boolean false),("free_radiation_correction_added_to_v3",.boolean false)]
def requiredCustody : Value := .object [("formal_claim_contains_historical_or_external_target_values",.boolean false),("formal_prediction_commit_precedes_external_target_access",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_historical_prerequisite_measurement_correction_and_scope_rows_retained",.boolean true),("targets_select_formal_survivor",.boolean false)]
def prerequisiteClaims : List (String × String) := [("claims/SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003/certificate.json","SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003"),("claims/SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003/certificate.json","SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003"),("claims/SFT-PHYS-FIELD-INVERSE-SQUARE-001/certificate.json","SFT-PHYS-FIELD-INVERSE-SQUARE-001"),("claims/SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001/certificate.json","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001"),("claims/SFT-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010/certificate.json","SFT-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010"),("claims/SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002/certificate.json","SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002"),("claims/SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001/certificate.json","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"),("claims/SFT-PHYS-MEAS-TARGET-CUSTODY-001/certificate.json","SFT-PHYS-MEAS-TARGET-CUSTODY-001")]
def payloadBoundary (record : Value) : Except String Value := do
 let target := getDefault record "registered_target" (.object [])
 if !sameValue (getDefault record "source_id") (.text sourceId) || !sameValue (getDefault record "formal_prediction_commit") (.text formalCommit) then throw "D9q source identity or pre-target formal commit changed"
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D9q complete target row ledger changed"
 if (← array (getDefault record "snapshots" (.array []))).length != 10 || keys.length != 48 || !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) then throw "D9q complete target row ledger changed"
 if !requiredFields target historicalAnchors then throw "D9q historical or formal comparison row changed"
 if !requiredFields target primaryAnchors then throw "D9q primary timing values changed"
 if !requiredFields target scopeAnchors then throw "D9q limiting or custody row changed"
 pure record
def historicalBoundary (v1 prerequisites : Value) : Except String Unit := do
 let rows ← array (← field v1 "rows")
 let row ← match rows.find? (fun item => sameValue (getDefault item "v1_claim_id") (.text "D9q")) with
  | none => .error "StopIteration"
  | some item => .ok item
 let observation ← text (← field row "prior_result_observation")
 if !(["quadrupole radiated-power magnitude","third time-rate of the quadrupole moment","P = coupling*(third-difference of the quadrupole)^2"].all (Text.contains observation)) then throw "D9q V1 row changed"
 let _ ← prerequisiteClaims.mapM (fun (relative,claim) => do
  let record ← field prerequisites relative
  if !sameValue (getDefault record "claim_id") (.text claim) then throw "D9q prerequisite changed"
  pure ())
 pure ()
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D9q custody changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload v1 prerequisites : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "D9q source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let _ ← historicalBoundary v1 prerequisites
 custodyBoundary record
end SFT.Physics.QuadrupoleRecords
