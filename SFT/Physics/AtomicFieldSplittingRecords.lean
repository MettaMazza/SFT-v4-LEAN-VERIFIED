import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.AtomicFieldSplittingRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 20000
def sourceHash : String := "sha256:5093c824cec5438a98f82fd5e75460e737a001a11471d12dbd7cd67b930661df"
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "complete_reported_resolution_and_uncertainty_status_retained").toOption.getD .null) (.boolean true) then throw "atomic field-splitting custody disclosure changed"
 if !sameValue ((field custody "linear_and_quadratic_stark_classes_separately_retained").toOption.getD .null) (.boolean true) then throw "atomic field-splitting custody disclosure changed"
 let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "atomic field-splitting source set changed"
  | .boolean _ => .error "atomic field-splitting source set changed"
  | .integer _ => .error "atomic field-splitting source set changed"
  | .null => .error "atomic field-splitting source set changed"
  | .array _ => .error "atomic field-splitting source set changed"
 let required := ["nist_zeeman","nbs_hydrogen_linear_stark","nist_cesium_quadratic_stark"]
 if !(pairs.all (fun p => required.any (fun s => Text.equal s p.1))) || !(required.all (fun s => pairs.any (fun p => Text.equal s p.1))) then
  throw "atomic field-splitting source set changed"
 pure payload
def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "atomic field-splitting source record identity changed"
 let record ← payloadBoundary payload
 pure record
def componentFiles : List (String × String) := []
def registeredRecord : Value := .object [("schema",.text "sft-v3-atomic-field-splitting-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("classification",.text "observational_derivation"),("development_targets_already_known",.boolean true),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("complete_reported_resolution_and_uncertainty_status_retained",.boolean true),("linear_and_quadratic_stark_classes_separately_retained",.boolean true)]),("sources",.object [("nist_zeeman",.object [("source_id",.text "NIST-ATOMIC-SPECTROSCOPY-ZEEMAN"),("body",.text "National Institute of Standards and Technology"),("source_uri",.text "https://physics.nist.gov/Pubs/AtSpec/node12.html"),("reported_record",.object [("sublevel_count_relation",.text "2J+1"),("weak_field_energy_relation",.text "delta-E=g*M*mu_B*B"),("field_order",.text "linear"),("wavenumber_shift_coefficient_cm_inverse_per_tesla",.text "0.46686"),("coefficient_status",.text "NIST displayed value; no uncertainty reported on page")])]),("nbs_hydrogen_linear_stark",.object [("source_id",.text "NBS-SP617-HYDROGEN-LINEAR-STARK"),("body",.text "National Bureau of Standards"),("source_uri",.text "https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nbsspecialpublication617.pdf"),("reported_record",.object [("system",.text "extreme hydrogen Rydberg state in a uniform electric field"),("response_order",.text "linear"),("measurement_protocol",.text "precision measurement of the linear energy shift")])]),("nist_cesium_quadratic_stark",.object [("source_id",.text "NIST-CESIUM-RYDBERG-VOLTAGE-REFERENCE-2023"),("body",.text "National Institute of Standards and Technology"),("source_uri",.text "https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=933361"),("reported_record",.object [("system",.text "nondegenerate cesium 15s Rydberg state"),("response_relation",.text "frequency-shift=(polarizability/2)*electric-field-squared"),("response_order",.text "quadratic"),("polarizability_displayed_hz_per_field_squared",.text "0.5"),("electrode_spacing_m",.text "0.005"),("quadratic_voltage_range_V",.text "750"),("first_level_crossing_field_V_per_cm",.text "1500"),("uncertainty_status",.text "no uncertainty reported for these displayed design values")])])]),("comparison_policy",.object [("provenance",.text "Observation informed the explicit frozen successor law. The executable module contains none of these formulas or values and cannot open this record. Complete enumeration, unique selection and sealing precede target release."),("zeeman",.text "The sealed 2J+1 multiplicity and first-order magnetic response must equal the complete NIST weak-field relations; the dimensional coefficient remains an external unit carrier."),("stark",.text "The sealed degeneracy discriminator must classify the NBS hydrogen row as linear and the NIST nondegenerate cesium row as quadratic, with the complete displayed coefficient and operating range retained."),("scaling_controls",.text "Doubling exact field magnitude must double the sealed Zeeman and degenerate Stark responses and multiply the nondegenerate Stark response by four.")])]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.AtomicFieldSplittingRecords
