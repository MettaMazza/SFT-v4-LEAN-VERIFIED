import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.HydrogenRydbergRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 20000
def sourceHash : String := "sha256:2bbdc82b1ff35fce2b486fe1c26fc8341faeca13fbba201ceffa64ee731ac448"
def componentHashes : List (String × String) := [("rydberg","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("hydrogen_ionization","sha256:cc54c774518d62cbb7e95f17b3b7fcd9d1faf0aa90043a607b91dff0a43e2087"),("hydrogen_lines","sha256:86ccaeb875fcdb4445e727618509621ceee656e5dc02295140ecdb6e1d2dd443")]
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "complete_reported_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "displayed_resolution_separately_labelled_where_no_uncertainty_is_reported").toOption.getD .null) (.boolean true) then throw "hydrogen Rydberg custody disclosure changed"
 if !sameValue ((field custody "earlier_hydrogen_and_proton_receipts_preserved").toOption.getD .null) (.boolean true) then throw "hydrogen Rydberg custody disclosure changed"
 let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "hydrogen Rydberg source set changed"
  | .boolean _ => .error "hydrogen Rydberg source set changed"
  | .integer _ => .error "hydrogen Rydberg source set changed"
  | .null => .error "hydrogen Rydberg source set changed"
  | .array _ => .error "hydrogen Rydberg source set changed"
 if !(pairs.all (fun p => Text.equal p.1 "rydberg" || Text.equal p.1 "hydrogen_ionization" || Text.equal p.1 "hydrogen_lines")) ||
    !(pairs.any (fun p => Text.equal p.1 "rydberg")) || !(pairs.any (fun p => Text.equal p.1 "hydrogen_ionization")) || !(pairs.any (fun p => Text.equal p.1 "hydrogen_lines")) then
  throw "hydrogen Rydberg source set changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "hydrogen Rydberg source record identity changed"
 let record ← payloadBoundary payload
 let sources ← field record "sources"
 let _ ← componentHashes.foldlM (fun (_ : Unit) (pair : String × String) => do
  let source ← field sources pair.1
  let path ← text ((field source "snapshot_path").toOption.getD (.text "missing"))
  if !sameValue ((field source "snapshot_hash").toOption.getD .null) (.text pair.2) then
   throw (Text.append "hydrogen Rydberg component identity changed: " pair.1)
  let component ← match files.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) pair.2 then
   throw (Text.append "hydrogen Rydberg component identity changed: " pair.1)
  pure ()) ()
 let policy := (field payload "comparison_policy").toOption.getD (.object [])
 if !sameValue ((field policy "provenance").toOption.getD .null) (.text "Observation informed the explicit frozen successor relation. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release.") then
  throw "hydrogen Rydberg comparison provenance changed"
 pure record
def componentFiles : List (String × String) := [("nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("nist-hydrogen-atomic-data.html","sha256:cc54c774518d62cbb7e95f17b3b7fcd9d1faf0aa90043a607b91dff0a43e2087"),("nist-hydrogen-critical-compilation.pdf","sha256:86ccaeb875fcdb4445e727618509621ceee656e5dc02295140ecdb6e1d2dd443")]
def registeredRecord : Value := .object [("schema",.text "sft-v3-hydrogen-rydberg-successor-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("development_targets_already_known",.boolean true),("classification",.text "observational_derivation"),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("complete_reported_uncertainties_retained",.boolean true),("displayed_resolution_separately_labelled_where_no_uncertainty_is_reported",.boolean true),("earlier_hydrogen_and_proton_receipts_preserved",.boolean true)]),("sources",.object [("rydberg",.object [("source_id",.text "NIST-CODATA-2022-ALL-CONSTANTS"),("body",.text "National Institute of Standards and Technology, CODATA 2022"),("source_uri",.text "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"),("snapshot_hash",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("locator",.text "Rydberg constant row"),("row",.object [("value_m_inverse",.text "10973731.568157"),("standard_uncertainty_m_inverse",.text "0.000012"),("value_cm_inverse",.text "109737.31568157"),("standard_uncertainty_cm_inverse",.text "0.00000012")])]),("hydrogen_ionization",.object [("source_id",.text "NIST-ASD-HYDROGEN-ATOMIC-DATA"),("body",.text "National Institute of Standards and Technology, Atomic Spectra Database"),("source_uri",.text "https://physics.nist.gov/PhysRefData/Handbook/Tables/hydrogentable1.htm"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-hydrogen-atomic-data.html"),("snapshot_hash",.text "sha256:cc54c774518d62cbb7e95f17b3b7fcd9d1faf0aa90043a607b91dff0a43e2087"),("locator",.text "H I ground-state ionization-energy row"),("row",.object [("value_cm_inverse",.text "109678.7717"),("last_inscribed_digit_half_width_cm_inverse",.text "0.00005"),("interval_kind",.text "displayed-resolution enclosure, not a reported NIST uncertainty")])]),("hydrogen_lines",.object [("source_id",.text "NIST-KRAMIDA-HYDROGEN-CRITICAL-COMPILATION-2010-2019"),("body",.text "National Institute of Standards and Technology, Atomic Physics Division"),("source_uri",.text "https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=842564"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-hydrogen-critical-compilation.pdf"),("snapshot_hash",.text "sha256:86ccaeb875fcdb4445e727618509621ceee656e5dc02295140ecdb6e1d2dd443"),("locator",.text "Table 11 Lyman n=2 observed wavenumber and Table 10 Balmer 2-3 observed wavenumber"),("rows",.object [("lyman_alpha",.object [("value_cm_inverse",.text "82259.16"),("standard_uncertainty_cm_inverse",.text "0.14")]),("balmer_alpha",.object [("value_cm_inverse",.text "15233.21"),("standard_uncertainty_cm_inverse",.text "0.07")])])])]),("frozen_relation",.object [("reduced_mass",.text "rho/(rho+1) for the already admitted exact terminal proton/electron enclosure rho"),("terminal_return",.text "rho/(rho+1) + alpha^2/5 + alpha^3/2 Take 6alpha^4 + 49alpha^5"),("ionization_to_electron_rest",.text "alpha^2/2 times the terminal return"),("lyman_alpha",.text "three-quarters of the terminal ionization carrier"),("balmer_alpha",.text "five-thirty-sixths of the terminal ionization carrier")]),("comparison_policy",.object [("provenance",.text "Observation informed the explicit frozen successor relation. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release."),("decision",.text "The complete exact terminal ratio interval must lie inside the outward hydrogen-ionization/Rydberg interval; its translation through the complete CODATA Rydberg interval must lie inside the hydrogen ionization displayed-resolution enclosure, and the immutable three-quarter and five-thirty-sixth gaps must overlap both complete reported NIST line intervals."),("no_reuse_as_premise",.text "Every external inscription remains a post-seal comparison record and does not become a formal proof scalar.")])]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.HydrogenRydbergRecords
