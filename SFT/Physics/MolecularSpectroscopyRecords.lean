import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.MolecularSpectroscopyRecords
set_option maxRecDepth 20000
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def sourceHash : String := "sha256:211fb30414204bcc61f9fb4a69a451db24cb5d5aaaacb2bb3b85fc83429388a9"
def componentHashes : List (String × String) := [("hydrogen","sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24"),("deuterium","sha256:790276cd493dbede03fc9e83db95bc0808a36838eb31473aaf923493b4749936")]
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "reported_digits_retained_without_reinterpretation").toOption.getD .null) (.boolean true) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "last_inscribed_digit_enclosures_are_comparison_resolutions_not_reported_uncertainties").toOption.getD .null) (.boolean true) then throw "molecular spectroscopy custody disclosure changed"
 if !sameValue ((field custody "earlier_leading_and_adverse_receipts_preserved").toOption.getD .null) (.boolean true) then throw "molecular spectroscopy custody disclosure changed"
 let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "molecular spectroscopy source set changed"
  | .boolean _ => .error "molecular spectroscopy source set changed"
  | .integer _ => .error "molecular spectroscopy source set changed"
  | .null => .error "molecular spectroscopy source set changed"
  | .array _ => .error "molecular spectroscopy source set changed"
 if !(pairs.all (fun p => Text.equal p.1 "hydrogen" || Text.equal p.1 "deuterium")) ||
    !(pairs.any (fun p => Text.equal p.1 "hydrogen")) || !(pairs.any (fun p => Text.equal p.1 "deuterium")) then
  throw "molecular spectroscopy source set changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "molecular spectroscopy source record identity changed"
 let record ← payloadBoundary payload
 let sources ← field record "sources"
 let _ ← componentHashes.foldlM (fun (_ : Unit) (pair : String × String) => do
  let source ← field sources pair.1
  let path ← text ((field source "snapshot_path").toOption.getD (.text "missing"))
  if !sameValue ((field source "snapshot_hash").toOption.getD .null) (.text pair.2) then
   throw (Text.append "molecular spectroscopy component identity changed: " pair.1)
  let component ← match files.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) pair.2 then
   throw (Text.append "molecular spectroscopy component identity changed: " pair.1)
  pure ()) ()
 let policy := (field payload "comparison_policy").toOption.getD (.object [])
 if !sameValue ((field policy "provenance").toOption.getD .null) (.text "Observation informed the explicit frozen successor relations. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release.") then
  throw "molecular spectroscopy provenance disclosure changed"
 let predecessor := (field payload "predecessor_disposition").toOption.getD (.object [])
 if !sameValue ((field predecessor "immutable_leading_claim").toOption.getD .null) (.text "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004") then
  throw "molecular spectroscopy predecessor identity changed"
 pure record
def componentFiles : List (String × String) := [("nist-webbook-h2-diatomic-constants.html","sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24"),("nist-webbook-d2-diatomic-constants.html","sha256:790276cd493dbede03fc9e83db95bc0808a36838eb31473aaf923493b4749936")]
def registeredRecord : Value := .object [("schema",.text "sft-v3-molecular-spectroscopy-successor-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("development_targets_already_known",.boolean true),("classification",.text "observational_derivation"),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("reported_digits_retained_without_reinterpretation",.boolean true),("last_inscribed_digit_enclosures_are_comparison_resolutions_not_reported_uncertainties",.boolean true),("earlier_leading_and_adverse_receipts_preserved",.boolean true)]),("sources",.object [("hydrogen",.object [("source_id",.text "NIST-WEBBOOK-SRD69-H2-DIATOMIC-CONSTANTS"),("body",.text "National Institute of Standards and Technology, Chemistry WebBook SRD 69"),("source_uri",.text "https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1828"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-webbook-h2-diatomic-constants.html"),("snapshot_hash",.text "sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24"),("locator",.text "Constants of diatomic molecules, H2 X 1Sigma_g+ 1s-sigma-squared ground-state row"),("rows",.object [("vibrational_constant_cm_inverse",.object [("inscription",.text "4401.213"),("last_inscribed_digit_half_width",.text "0.0005")]),("anharmonic_constant_cm_inverse",.object [("inscription",.text "121.336"),("last_inscribed_digit_half_width",.text "0.0005")]),("rotational_constant_cm_inverse",.object [("inscription",.text "60.8530"),("last_inscribed_digit_half_width",.text "0.00005")]),("equilibrium_internuclear_distance_angstrom",.object [("inscription",.text "0.74144"),("last_inscribed_digit_half_width",.text "0.000005")])])]),("deuterium",.object [("source_id",.text "NIST-WEBBOOK-SRD69-D2-DIATOMIC-CONSTANTS"),("body",.text "National Institute of Standards and Technology, Chemistry WebBook SRD 69"),("source_uri",.text "https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782390&Mask=1000"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-webbook-d2-diatomic-constants.html"),("snapshot_hash",.text "sha256:790276cd493dbede03fc9e83db95bc0808a36838eb31473aaf923493b4749936"),("locator",.text "Constants of diatomic molecules, D2 X 1Sigma_g+ 1s-sigma-squared ground-state row"),("rows",.object [("vibrational_constant_cm_inverse",.object [("inscription",.text "3115.50"),("last_inscribed_digit_half_width",.text "0.005")]),("anharmonic_constant_cm_inverse",.object [("inscription",.text "61.82"),("last_inscribed_digit_half_width",.text "0.005")]),("rotational_constant_cm_inverse",.object [("inscription",.text "30.4436"),("last_inscribed_digit_half_width",.text "0.00005")]),("equilibrium_internuclear_distance_angstrom",.object [("inscription",.text "0.74152"),("last_inscribed_digit_half_width",.text "0.000005")])])])]),("frozen_relations",.object [("rotational_ladder",.text "E_J/B=J(J+1) with the empty ground form and positive J; adjacent positive gap is 2J"),("vibrational_ladder",.text "G_n=omega*q_n/2 Take omega_x*q_n^2/4 for q_n=2n-1 and positive ordinal n"),("hydrogen_rotational_to_vibrational",.text "2 alpha Take 14 alpha^2 Take 58 alpha^3 Take 82 alpha^4"),("hydrogen_anharmonic_to_vibrational",.text "4 alpha Take 30 alpha^2 Take 59 alpha^3 Take 63 alpha^4"),("deuterium_to_hydrogen_rotational",.text "1/2 + 5 alpha^2 + 38 alpha^3"),("squared_deuterium_to_hydrogen_vibrational",.text "1/2 + 20 alpha^2 + 49 alpha^3")]),("comparison_policy",.object [("provenance",.text "Observation informed the explicit frozen successor relations. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release."),("interval_policy",.text "Each exact decimal inscription is enclosed by one half of its last displayed place solely to test faithful transcription at the source's displayed resolution; these enclosures are not represented as NIST uncertainty statements."),("decision_policy",.text "Every sealed exact ratio must lie inside the complete outward interval propagated from the registered source inscriptions, and the exact ladder identities and positive anharmonic narrowing must hold independently of source release.")]),("predecessor_disposition",.object [("immutable_leading_claim",.text "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004"),("retained_result",.text "electronic above vibrational above rotational ordering"),("retained_adverse_result",.text "the universal equal-quarter rotation/vibration reading and universal factor-two numerical translation are rejected by the registered H2 vector"),("successor_rule",.text "distinct exact carriers replace the rejected universal numerical reading without rewriting either predecessor receipt")])]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.MolecularSpectroscopyRecords
