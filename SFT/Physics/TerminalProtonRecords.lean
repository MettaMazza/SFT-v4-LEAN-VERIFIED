import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.TerminalProtonRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def sourceHash : String := "sha256:a2fd002521902242e3db10eac896389d2190f88169b827c3575640e9a31f2790"
def componentHash : String := "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"
def componentHashes : List (String × String) := [("nist-codata-2022-allascii.txt",componentHash)]
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "development_target_already_known").toOption.getD .null) (.boolean true) then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "formal_relation_contains_measurement").toOption.getD .null) (.boolean false) then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "measurement_selects_formal_survivor").toOption.getD .null) (.boolean false) then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "earlier_unfavorable_receipt_preserved").toOption.getD .null) (.boolean true) then throw "terminal proton custody disclosure changed"
 if !sameValue ((field custody "complete_uncertainty_retained").toOption.getD .null) (.boolean true) then throw "terminal proton custody disclosure changed"
 pure payload
def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "terminal proton source record identity changed"
 let record ← payloadBoundary payload
 let source := (field record "source").toOption.getD (.object [])
 let path ← text ((field source "snapshot_path").toOption.getD (.text "missing"))
 if !sameValue ((field source "snapshot_hash").toOption.getD .null) (.text componentHash) then
  throw "terminal proton component identity changed"
 let component ← match files.find? (fun p => Text.equal p.1 path) with
  | none => .error (Text.append "FileNotFoundError: " path)
  | some p => .ok p.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) componentHash then
  throw "terminal proton component identity changed"
 pure record
def registeredRecord : Value := .object [("schema",.text "sft-v3-terminal-proton-postseal-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("development_target_already_known",.boolean true),("classification",.text "observational_derivation"),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relation_contains_measurement",.boolean false),("measurement_selects_formal_survivor",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("earlier_unfavorable_receipt_preserved",.boolean true),("complete_uncertainty_retained",.boolean true)]),("source",.object [("source_id",.text "NIST-CODATA-2022-ALL-CONSTANTS"),("body",.text "National Institute of Standards and Technology / CODATA Task Group on Fundamental Constants"),("source_uri",.text "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"),("snapshot_hash",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("row",.object [("quantity",.text "proton-electron mass ratio"),("value",.text "1836.152673426"),("standard_uncertainty",.text "0.000000032")])]),("validation_boundary",.text "This is the registered observational-derivation empirical prediction protocol: authoritative observation informed construction of an explicit candidate law; the executable relation contains only admitted exact Fold carriers; the target is inaccessible while the engine enumerates and seals its prediction; this source record is released only afterward for exact comparison; and the earlier non-overlap plus the full CODATA standard uncertainty remain retained.")]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.TerminalProtonRecords
