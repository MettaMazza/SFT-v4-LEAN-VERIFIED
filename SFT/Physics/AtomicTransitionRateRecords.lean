import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.AtomicTransitionRateRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 20000
def sourceHash : String := "sha256:77bb5da60432c1dd9d5979e952254ace888073af666605ecce7c8f5fda4eb5a4"
def componentHash : String := "sha256:35f4c76e7ed640958c6ef184cb731fc91c540608bda87bab7ab63130abb7f7a2"
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "complete_reported_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "atomic transition-rate custody disclosure changed"
 if !sameValue ((field custody "adverse_universal_forbidden_ordering_retained").toOption.getD .null) (.boolean true) then throw "atomic transition-rate custody disclosure changed"
 let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "atomic transition-rate source set changed"
  | .boolean _ => .error "atomic transition-rate source set changed"
  | .integer _ => .error "atomic transition-rate source set changed"
  | .null => .error "atomic transition-rate source set changed"
  | .array _ => .error "atomic transition-rate source set changed"
 let required := ["nist_atomic_spectroscopy","nist_argon_metastable","nist_aluminium_clock"]
 if !(pairs.all (fun p => required.any (fun s => Text.equal s p.1))) || !(required.all (fun s => pairs.any (fun p => Text.equal s p.1))) then
  throw "atomic transition-rate source set changed"
 pure payload
def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "atomic transition-rate source record identity changed"
 let record ← payloadBoundary payload
 let atspec ← field (← field record "sources") "nist_atomic_spectroscopy"
 let path ← text (← field atspec "snapshot_path")
 if !sameValue (← field atspec "snapshot_hash") (.text componentHash) then
  throw "NIST atomic-spectroscopy snapshot changed"
 let component ← match files.find? (fun p => Text.equal p.1 path) with
  | none => .error (Text.append "FileNotFoundError: " path)
  | some p => .ok p.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) componentHash then
  throw "NIST atomic-spectroscopy snapshot changed"
 let policy := (field payload "comparison_policy").toOption.getD (.object [])
 if !sameValue ((field policy "adverse_boundary").toOption.getD .null) (.text "NIST M1 and E1 relations both have cubic gap exponent, so channel naming alone cannot lawfully force every forbidden transition below every E1 transition. Distinct line strength and weight carriers remain explicit.") then
  throw "atomic transition-rate adverse boundary changed"
 pure record
def componentFiles : List (String × String) := [("nist-atomic-selection-rules.html","sha256:35f4c76e7ed640958c6ef184cb731fc91c540608bda87bab7ab63130abb7f7a2")]
def registeredRecord : Value := .object [("schema",.text "sft-v3-atomic-transition-rate-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("classification",.text "observational_derivation"),("development_targets_already_known",.boolean true),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("complete_reported_uncertainties_retained",.boolean true),("adverse_universal_forbidden_ordering_retained",.boolean true)]),("sources",.object [("nist_atomic_spectroscopy",.object [("source_id",.text "NIST-ATOMIC-SPECTROSCOPY-SELECTION-RATE-LIFETIME"),("body",.text "National Institute of Standards and Technology"),("source_uri",.text "https://physics.nist.gov/Pubs/AtSpec/node17.html"),("equation_uri",.text "https://physics.nist.gov/Pubs/AtSpec/latex.html"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-atomic-selection-rules.html"),("snapshot_hash",.text "sha256:35f4c76e7ed640958c6ef184cb731fc91c540608bda87bab7ab63130abb7f7a2"),("reported_record",.object [("E1_orbital_rule",.text "delta-l equals plus-or-minus one"),("E1_gap_exponent",.integer (3)),("E2_gap_exponent",.integer (5)),("M1_gap_exponent",.integer (3)),("lifetime_relation",.text "tau_k=(sum_i A_ki)^-1"),("hydrogenic_gap_scaling_exponent",.integer (2)),("hydrogenic_strength_scaling",.text "inverse-square"),("hydrogenic_rate_scaling_exponent",.integer (4)),("allowed_helium_example",.object [("wavelength_angstrom",.text "6678.15"),("lower_weight",.integer (3)),("upper_weight",.integer (5)),("transition_probability_per_second",.text "63800000"),("oscillator_strength",.text "0.711"),("line_strength_atomic_units",.text "46.9")])])]),("nist_argon_metastable",.object [("source_id",.text "NIST-AR9-METASTABLE-M1-LIFETIME-2018"),("body",.text "National Institute of Standards and Technology"),("source_uri",.text "https://www.nist.gov/publications/lifetime-metastable-2p12-state-f-ar9-isolated-compact-penning-trap"),("reported_record",.object [("channel",.text "magnetic-dipole M1 weakly allowed transition"),("lifetime_seconds",.text "0.00939"),("standard_uncertainty_seconds",.text "0.00009")])]),("nist_aluminium_clock",.object [("source_id",.text "NIST-AL27-METASTABLE-CLOCK-LIFETIME-2007"),("body",.text "National Institute of Standards and Technology"),("source_uri",.text "https://www.nist.gov/publications/observation-1s0-3p0-clock-transition-27al"),("reported_record",.object [("channel",.text "metastable clock transition"),("lifetime_seconds",.text "20.6"),("standard_uncertainty_seconds",.text "1.4")])])]),("comparison_policy",.object [("provenance",.text "Observation informed the explicit frozen successor law. The executable module contains none of these equations or values and cannot open this record. Complete enumeration, unique selection and sealing precede target release."),("formal_exponents",.text "The sealed E1 exponent three, electric-rank successor exponent five and lifetime reciprocal must match the complete NIST equations exactly."),("independent_scaling",.text "The sealed gap-cube and held-strength law must compose the NIST hydrogenic gap-squared and strength-inverse-squared rows into rate exponent four."),("measured_lifetimes",.text "The reciprocal of the NIST allowed helium example is retained beside both complete metastable lifetime intervals; both metastable lower endpoints must exceed the allowed implied lifetime."),("adverse_boundary",.text "NIST M1 and E1 relations both have cubic gap exponent, so channel naming alone cannot lawfully force every forbidden transition below every E1 transition. Distinct line strength and weight carriers remain explicit.")])]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.AtomicTransitionRateRecords
