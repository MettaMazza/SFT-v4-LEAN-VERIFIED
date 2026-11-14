import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.AtomicPrecisionRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def sourceHash : String := "sha256:1660817704753cfd689a7f9a4513cab4b3f40a53f5c58329d3610cc905dffd84"
def componentHashes : List (String × String) := [("rydberg","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("lamb_and_fine","sha256:4d7e7f34b98ab2fc4df68b38247f818f6fc8bdf7f25f91abcdfbc329e22d2f32"),("hyperfine","sha256:33d048a7f7a8d83e5c2b0b96e442b495cf23b888ad1386d7205b17930af9f152")]
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "complete_reported_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "earlier_leading_receipts_preserved").toOption.getD .null) (.boolean true) then throw "atomic precision custody disclosure changed"
 if !sameValue ((field custody "unfavorable_results_preserved").toOption.getD .null) (.boolean true) then throw "atomic precision custody disclosure changed"
 let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "atomic precision source set changed"
  | .boolean _ => .error "atomic precision source set changed"
  | .integer _ => .error "atomic precision source set changed"
  | .null => .error "atomic precision source set changed"
  | .array _ => .error "atomic precision source set changed"
 if !(pairs.all (fun p => Text.equal p.1 "rydberg" || Text.equal p.1 "lamb_and_fine" || Text.equal p.1 "hyperfine")) ||
    !(pairs.any (fun p => Text.equal p.1 "rydberg")) || !(pairs.any (fun p => Text.equal p.1 "lamb_and_fine")) || !(pairs.any (fun p => Text.equal p.1 "hyperfine")) then
  throw "atomic precision source set changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "atomic precision source record identity changed"
 let record ← payloadBoundary payload
 let sources ← field record "sources"
 let _ ← componentHashes.foldlM (fun (_ : Unit) (pair : String × String) => do
  let source ← field sources pair.1
  let path ← text ((field source "snapshot_path").toOption.getD (.text "missing"))
  if !sameValue ((field source "snapshot_hash").toOption.getD .null) (.text pair.2) then
   throw (Text.append "atomic precision component identity changed: " pair.1)
  let component ← match files.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) pair.2 then
   throw (Text.append "atomic precision component identity changed: " pair.1)
  pure ()) ()
 let fine ← field (← field (← field sources "lamb_and_fine") "rows") "direct_experimental_fine_interval"
 if !sameValue ((field fine "consensus_ritz_value_used").toOption.getD .null) (.boolean false) then
  throw "atomic fine comparison admitted a consensus Ritz selector"
 let policy := (field payload "comparison_policy").toOption.getD (.object [])
 if !sameValue ((field policy "provenance").toOption.getD .null) (.text "Observation informed the explicit frozen successor relations. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release.") then
  throw "atomic precision comparison provenance changed"
 pure record
def componentFiles : List (String × String) := [("nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("nist-codata-2022-adjustment.pdf","sha256:4d7e7f34b98ab2fc4df68b38247f818f6fc8bdf7f25f91abcdfbc329e22d2f32"),("nist-atomic-states-hyperfine.html","sha256:33d048a7f7a8d83e5c2b0b96e442b495cf23b888ad1386d7205b17930af9f152")]
def registeredRecord : Value := .object [("schema",.text "sft-v3-atomic-precision-successor-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("development_targets_already_known",.boolean true),("classification",.text "observational_derivation"),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("complete_reported_uncertainties_retained",.boolean true),("earlier_leading_receipts_preserved",.boolean true),("unfavorable_results_preserved",.boolean true)]),("sources",.object [("rydberg",.object [("source_id",.text "NIST-CODATA-2022-RYDBERG-FREQUENCY"),("body",.text "National Institute of Standards and Technology, CODATA Task Group on Fundamental Constants"),("source_uri",.text "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"),("snapshot_hash",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("locator",.text "Rydberg constant times c in Hz row"),("row",.object [("value_hz",.text "3289841960250000"),("standard_uncertainty_hz",.text "3600")])]),("lamb_and_fine",.object [("source_id",.text "NIST-CODATA-2022-HYDROGEN-TRANSITION-INPUTS"),("body",.text "National Institute of Standards and Technology, 2022 CODATA least-squares adjustment"),("source_uri",.text "https://doi.org/10.1063/5.0279860"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-adjustment.pdf"),("snapshot_hash",.text "sha256:4d7e7f34b98ab2fc4df68b38247f818f6fc8bdf7f25f91abcdfbc329e22d2f32"),("locator",.text "Table XIV input data A28 and A29, PDF page 16"),("rows",.object [("lamb_2p1_2_minus_2s1_2",.object [("value_hz",.text "1057829800"),("standard_uncertainty_hz",.text "3200"),("reported_form",.text "1 057 829.8(3.2) kHz"),("experiment",.text "Bezginov et al. (2019), York")]),("two_s1_2_minus_two_p3_2",.object [("value_hz",.text "9911200000"),("standard_uncertainty_hz",.text "12000"),("reported_form",.text "9 911 200(12) kHz"),("experiment",.text "Hagley and Pipkin (1994), Harvard")]),("direct_experimental_fine_interval",.object [("value_hz",.text "10969029800"),("conservative_uncertainty_hz",.text "15200"),("construction",.text "positive sum of the two independently reported experimental input intervals; component uncertainties are added rather than reduced"),("consensus_ritz_value_used",.boolean false)])])]),("hyperfine",.object [("source_id",.text "NIST-ATOMIC-SPECTROSCOPY-HYDROGEN-HYPERFINE"),("body",.text "National Institute of Standards and Technology, Atomic Spectroscopy Compendium"),("source_uri",.text "https://physics.nist.gov/Pubs/AtSpec/node03.html"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-atomic-states-hyperfine.html"),("snapshot_hash",.text "sha256:33d048a7f7a8d83e5c2b0b96e442b495cf23b888ad1386d7205b17930af9f152"),("locator",.text "Hydrogen and Hydrogen-like Ions, H I 1s ground-level hyperfine row"),("row",.object [("value_hz",.text "1420405751.7667"),("standard_uncertainty_hz",.text "0.001"),("reported_form",.text "1420.405 751 766 7(10) MHz"),("line",.text "21 cm")])])]),("comparison_policy",.object [("dimensionful_carrier",.text "The sealed Fold laws predict exact dimensionless frequency ratios. The NIST Rydberg-frequency row is released only after the formal seal to translate those ratios into hertz."),("lamb",.text "Compare the complete translated prediction interval with the complete Bezginov experimental interval."),("fine",.text "Compare with the conservative positive sum of NIST input rows A28 and A29. The older optimized Ritz value is retained as a separate derived record and is not allowed to select or replace the experimental target."),("hyperfine",.text "Compare the translated exact algebraic prediction enclosure with the complete NIST 21-cm interval; retain the Rydberg-carrier uncertainty and require interval overlap rather than suppressing that uncertainty."),("provenance",.text "Observation informed the explicit frozen successor relations. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release.")]),("preserved_predecessors",.object [("atomic_correction_hierarchy_receipt",.text "sha256:a6239e61a184cf72e869fabe9c7d2dcc433366e30ef4bfdff68ebd0ff2a0fd9d"),("hydrogen_spectrum_receipt",.text "sha256:ea9b3b9f34311e1f1f41962a5405ffad6250fcd74d75cf107a3b92d35dd2d464"),("proton_electron_terminal_receipt",.text "sha256:c52208ec2212ffa3fd16e34b90abfdd3adc083411d7a19914d3591b4f8ea9d23"),("terminal_turn_receipt",.text "sha256:b85f5162d1cf55490a4bc8666fa02b354029ff4a297d9013c61dddd93491629d")])]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.AtomicPrecisionRecords
