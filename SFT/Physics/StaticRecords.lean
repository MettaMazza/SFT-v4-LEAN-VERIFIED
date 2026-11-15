import SFT.Physics.StaticExteriorClockEvidence
import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.StaticRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault requiredFields fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "D9O-STATIC-EXTERIOR-CLOCK-COMPARISON"
def sourcePath : String := "experiments/external_sources/physics/snapshots/static-exterior-clock-source-record.json"
def sourceHash : String := "sha256:b13dfc5d2661e725525314984c727177fb3eb57c4694daa8802f04b7cb8f642b"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/static-exterior-clock-source-record.json","sha256:b13dfc5d2661e725525314984c727177fb3eb57c4694daa8802f04b7cb8f642b"),("audits/v1_theorem_manifest_observation_census.json","sha256:05c7c285e87720c0b22a69cc69b07cdd9749a1aa1728afd934e1ed9f7c30ce93"),("claims/SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003/certificate.json","sha256:6b59623fd551d55ecaee95d917d6a3fffeb0cf4d4426304361eed2b8c62d8f07"),("claims/SFT-PHYS-GRAVITY-STATIC-CLOCK-003/certificate.json","sha256:2e522bf82c29435dbcdff2f49f8981996172d0b83c1769b455553e56eb4b3c42"),("claims/SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003/certificate.json","sha256:cf49b4db93c63fb1b47a519d8f15402aa198ff763a0768ae9e85ddce9e1978b6"),("claims/SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003/certificate.json","sha256:0603a79736aa9b1393f89955897be632cd7d29b3e12d5a84ba0e5787e06e18cc"),("claims/SFT-PHYS-VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003/certificate.json","sha256:7226a910ad10a4b643a83c53c1da568ef931c75814d4c258da3199ebbfbb7745"),("experiments/external_sources/physics/snapshots/arxiv-1503.02172-schwarzschild-kerr-introduction.pdf","sha256:13288f2e0ada228df6e567506c6ac1541e2559a423a740d1e2844cc9a4fe7085"),("experiments/external_sources/physics/snapshots/nist-jila-millimetre-gravitational-redshift-2022.pdf","sha256:7d4376361233f17082814d99cc46cd3263c9febfdbf273bb9bfbe9699723e2b3"),("experiments/external_sources/physics/snapshots/gravity-spacetime-source-record.json","sha256:b64325355bd993ab32cff6c088023dbe7911ab13278b9439466cd0ae56bedd5e")]
def requiredKeys : List String := ["v1_source_entry", "v1_static_spherical_vacuum", "v1_exterior_coefficient", "v1_exterior_domain", "v1_vacuum_flux", "v1_redshift_relation", "v1_weak_field_relation", "v1_horizon_radius", "existing_v3_flux_law", "existing_v3_clock_law", "existing_v3_horizon_law", "existing_v3_redshift_law", "existing_v3_measured_clock_status", "external_unique_spherical_vacuum", "external_static_exterior", "external_vacuum_equation", "external_time_coefficient", "external_radial_coefficient", "external_mass_parameter", "external_horizon_radius", "external_asymptotic_flatness", "external_spherical_vacuum_radiation", "nist_predicted_fractional_gradient_per_mm", "nist_full_cloud_corrected_gradient_per_mm", "nist_split_cloud_corrected_gradient_per_mm", "nist_fractional_frequency_uncertainty", "nist_measurement_count", "nist_higher_clock_direction", "nist_systematic_corrections_retained", "nist_result_consistent_with_predicted_redshift", "nist_measures_universal_Fold_clock_fraction", "completed_infinity_used_in_v3", "irrational_clock_rate_used_in_v3", "measured_parameter_fitted_into_v3"]
def historicalAnchors : Value := .object [("v1_source_entry",.text "D9o"),("v1_exterior_coefficient",.text "One-take-horizon-radius-over-radius"),("v1_horizon_radius",.text "two-G-M-over-c-squared")]
def theoryAnchors : Value := .object [("external_time_coefficient",.text "One-take-two-G-M-over-radius"),("external_horizon_radius",.text "two-m-equals-two-G-M-over-c-squared"),("external_spherical_vacuum_radiation",.text "absent")]
def nistAnchors : Value := .object [("nist_predicted_fractional_gradient_per_mm",.text "-1.09e-19"),("nist_full_cloud_corrected_gradient_per_mm",.text "-9.8(2.3)e-20"),("nist_split_cloud_corrected_gradient_per_mm",.text "-1.28(27)e-19"),("nist_fractional_frequency_uncertainty",.text "7.6e-21")]
def scopeAnchors : Value := .object [("nist_measures_universal_Fold_clock_fraction",.boolean false),("completed_infinity_used_in_v3",.boolean false),("irrational_clock_rate_used_in_v3",.boolean false),("measured_parameter_fitted_into_v3",.boolean false)]
def requiredCustody : Value := .object [("formal_claim_contains_historical_or_external_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_historical_prerequisite_theory_measurement_and_scope_rows_retained",.boolean true),("targets_select_formal_survivor",.boolean false)]
def prerequisiteClaims : List (String × String) := [("claims/SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003/certificate.json","SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003"),("claims/SFT-PHYS-GRAVITY-STATIC-CLOCK-003/certificate.json","SFT-PHYS-GRAVITY-STATIC-CLOCK-003"),("claims/SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003/certificate.json","SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003"),("claims/SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003/certificate.json","SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003"),("claims/SFT-PHYS-VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003/certificate.json","SFT-PHYS-VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003")]
def payloadBoundary (record : Value) : Except String Value := do
 let target := getDefault record "registered_target" (.object [])
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D9o target record changed"
 if !sameValue (getDefault record "source_id") (.text sourceId) || (← array (getDefault record "snapshots" (.array []))).length != 9 || keys.length != 34 || !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) then throw "D9o target record changed"
 if !requiredFields target historicalAnchors then throw "D9o historical relation changed"
 if !requiredFields target theoryAnchors then throw "D9o theory relation changed"
 if !requiredFields target nistAnchors then throw "D9o NIST values changed"
 if !requiredFields target scopeAnchors then throw "D9o scope row changed"
 pure record
def historicalBoundary (v1 prerequisites : Value) : Except String Unit := do
 let rows ← array (← field v1 "rows")
 let row ← match rows.find? (fun item => sameValue (getDefault item "v1_claim_id") (.text "D9o")) with
  | none => .error "StopIteration"
  | some item => .ok item
 let observation ← text (← field row "prior_result_observation")
 if !(["A(r)=take(ONE,ratio(rs,r))","r^2*dA/dr constant (=rs)","rs=2GM/c^2"].all (Text.contains observation)) then throw "D9o V1 row changed"
 let _ ← prerequisiteClaims.mapM (fun (relative,claim) => do
  let record ← field prerequisites relative
  if !sameValue (getDefault record "claim_id") (.text claim) then throw "D9o prerequisite changed"
  pure ())
 pure ()
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D9o custody changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload v1 prerequisites : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "D9o source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let _ ← historicalBoundary v1 prerequisites
 custodyBoundary record
end SFT.Physics.StaticRecords
