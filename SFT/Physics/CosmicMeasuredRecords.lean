import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
set_option maxRecDepth 20000
namespace SFT.Physics.CosmicMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/cosmic-transport-measured-value-successor-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/cosmic-transport-measured-value-successor-source-record.json","sha256:d4595bfbf4a8bf413fd17493eeed848da664a1d794dacd8ad90627307bcbb8a1"),("experiments/external_sources/physics/snapshots/cosmic_transport_terminal-source-record.json","sha256:6a88728657b19dba0bcf2430d28218a595c0798c6ac34bf2778ef53a1b540705"),("experiments/external_sources/physics/snapshots/gomez-valent-2023-cosmic-chronometers.html","sha256:cbd38055c3c9b27b2cbe1fb7456c60dfd7df3eeb366182932b7899d25207b128"),("experiments/external_sources/physics/snapshots/planck-2018-bao-budget-record.json","sha256:a8525585688e7ba818f8650fc0f8b73a449823d5e199a8be36e37b8e73a0e612"),("experiments/external_sources/physics/snapshots/arxiv-1805.03595-source-record.json","sha256:4ac5d80b39e3dc963d5cc7a0c1b8996b0b895a974f08fa736803186bd100f74c"),("experiments/external_sources/physics/snapshots/arxiv-1810.02278-cosmic-acceleration.pdf","sha256:55100ed889f8aad5ada957f33759d954466b944d21b461b4c63c62f0b0fb45d0"),("experiments/external_sources/physics/snapshots/arxiv-2307.14802-dark-energy-state.pdf","sha256:67c8d75e79fd85d727012e72e8838651de6720a2e8898e225e251601814c20a5"),("experiments/external_sources/physics/snapshots/arxiv-2503.14738-desi-dr2.pdf","sha256:1e82f26e4cc3901b16168cd147f252bfa804f9c3caad3f4f7e3532640d237841"),("claims/SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032/certificate.json","sha256:c83b4fc53d29e878502657b310325adcee62be483407433d61465dd744b57354")]
def sourceIds : List String := ["GOMEZ-VALENT-2023-CCH-32", "PLANCK-2018-BAO-BASELINE-BUDGET", "HARIDASU-2018-LATE-EXPANSION", "GOMEZ-VALENT-2019-ACCELERATION", "ESCAMILLA-2024-DARK-ENERGY-STATE", "DESI-DR2-2025-COSMOLOGY"]
def boundaryValuesTrue (boundary : Value) : Bool :=
 match boundary with
 | .object fs => fs.all (fun (key,value) => Text.equal key "measurement_selected_formal_survivor" || ThermometryMeasurement.literalBoolean value true)
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false

def measurementNotSelected (boundary : Value) : Bool :=
 ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false

def authoritativeRecord (files : List (String × ByteArray)) (bundle : Value) : Except String Value := do
 let payload ← field bundle "record"
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "cosmic successor source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-cosmic-transport-measured-value-successor-source-record/1") then
  throw "cosmic successor schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:504257d441fad45a8f173fad45015c7d723caa7636c517e71d27fddc43a2c42d") then
  throw "cosmic formal receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 if !sameValue (.array (sources.map (fun row => getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then
  throw "complete cosmic source vector required"
 let boundary := getDefault payload "methodological_boundary" (.object [])
 if !boundaryValuesTrue boundary then throw "cosmic methodological boundary changed"
 if !measurementNotSelected boundary then throw "cosmic measurement-selection boundary changed"
 let source ← field payload "registered_target_source"
 let path ← text (← field source "path")
 let _ ← fileBytes files path
 .ok (.object [("record",payload),("original",← field bundle "original")])
def originalBoundary : Value := .object [("all_thirty_two_chronometer_rows_enter_one_complete_normalized_residual_ledger",.boolean true),("unit_mean_squared_residual_is_forced_by_reported_standard_uncertainty_units",.boolean true),("rational_root_enclosures_refine_until_the_pass_or_reject_decision_is_exact",.boolean true),("no_fixed_sigma_multiplier_or_selected_tolerance",.boolean true),("Planck_budget_and_Haridasu_acceleration_values_are_like_typed_tests",.boolean true),("Gomez_Valent_2019_reconstruction_is_retained_as_an_alternate_method_record",.boolean true),("DESI_w0_wa_preference_is_retained_as_a_model_comparison_record_not_a_direct_scalar_measurement",.boolean true),("no_uncertainty_is_widened_or_rescaled",.boolean true),("measurement_selected_formal_survivor",.boolean false),("target_inaccessible_to_formal_derivation",.boolean true)]
theorem originalBoundaryValues : boundaryValuesTrue originalBoundary = true := rfl
theorem originalMeasurementBoundary : measurementNotSelected originalBoundary = true := rfl
#print axioms boundaryValuesTrue
#print axioms measurementNotSelected
#print axioms authoritativeRecord
#print axioms originalBoundaryValues
#print axioms originalMeasurementBoundary
end SFT.Physics.CosmicMeasuredRecords
