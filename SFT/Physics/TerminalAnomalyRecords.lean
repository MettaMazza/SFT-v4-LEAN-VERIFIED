import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.TerminalAnomalyRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def componentFiles : List (String × String) := [("nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("fermilab-muon-g2-result-2025.pdf","sha256:22fa2f99c52932ed012dc222eb821c2cb1a3d387671d650b23fbbed87a6e80a0")]
def sourceHash : String := "sha256:4b506052fc5037576cd6ba4de8ee5afce74460f7a5cb8da4bc58cbb823f6732f"
def componentHashes : List (String × String) := [("electron","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("muon","sha256:22fa2f99c52932ed012dc222eb821c2cb1a3d387671d650b23fbbed87a6e80a0")]
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "development_target_already_known").toOption.getD .null) (.boolean true) then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "formal_relation_contains_measurement").toOption.getD .null) (.boolean false) then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "measurement_selects_formal_survivor").toOption.getD .null) (.boolean false) then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "earlier_unfavorable_receipt_preserved").toOption.getD .null) (.boolean true) then throw "terminal anomaly custody disclosure changed"
 if !sameValue ((field custody "complete_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "terminal anomaly custody disclosure changed"
 let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "terminal anomaly source set changed"
  | .boolean _ => .error "terminal anomaly source set changed"
  | .integer _ => .error "terminal anomaly source set changed"
  | .null => .error "terminal anomaly source set changed"
  | .array _ => .error "terminal anomaly source set changed"
 if !(pairs.all (fun p => Text.equal p.1 "electron" || Text.equal p.1 "muon")) ||
    !(pairs.any (fun p => Text.equal p.1 "electron")) || !(pairs.any (fun p => Text.equal p.1 "muon")) then
  throw "terminal anomaly source set changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "terminal anomaly source record identity changed"
 let record ← payloadBoundary payload
 let sources ← field record "sources"
 let _ ← componentHashes.foldlM (fun (_ : Unit) (pair : String × String) => do
  let source ← field sources pair.1
  let path ← text ((field source "snapshot_path").toOption.getD (.text "missing"))
  if !sameValue ((field source "snapshot_hash").toOption.getD .null) (.text pair.2) then
   throw (Text.append (Text.append "terminal " pair.1) " anomaly source identity changed")
  let component ← match files.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) pair.2 then
   throw (Text.append (Text.append "terminal " pair.1) " anomaly source identity changed")
  pure ()) ()
 pure record
def registeredRecord : Value := .object [("schema",.text "sft-v3-terminal-anomaly-postseal-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("development_target_already_known",.boolean true),("classification",.text "observational_derivation"),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relation_contains_measurement",.boolean false),("measurement_selects_formal_survivor",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("earlier_unfavorable_receipt_preserved",.boolean true),("complete_uncertainties_retained",.boolean true)]),("sources",.object [("electron",.object [("source_id",.text "NIST-CODATA-2022-ELECTRON-MAGNETIC-ANOMALY"),("body",.text "National Institute of Standards and Technology / CODATA Task Group on Fundamental Constants"),("source_uri",.text "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"),("snapshot_hash",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("row",.object [("quantity",.text "electron magnetic moment anomaly"),("value",.text "0.00115965218046"),("standard_uncertainty",.text "0.00000000000018")])]),("muon",.object [("source_id",.text "FERMILAB-MUON-G2-WORLD-AVERAGE-2025"),("body",.text "Fermilab Muon g-2 Collaboration"),("source_uri",.text "https://muon-g-2.fnal.gov/result2025.pdf"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/fermilab-muon-g2-result-2025.pdf"),("snapshot_hash",.text "sha256:22fa2f99c52932ed012dc222eb821c2cb1a3d387671d650b23fbbed87a6e80a0"),("row",.object [("quantity",.text "muon magnetic moment anomaly world average"),("value",.text "0.001165920715"),("standard_uncertainty",.text "0.000000000145")])])]),("validation_boundary",.text "This is the registered observational-derivation empirical prediction protocol: authoritative observations informed construction of explicit candidate laws; the executable relations contain only admitted exact Fold carriers; both targets are inaccessible while the engine completely enumerates, uniquely selects and seals each prediction; this source record is released only afterward for exact comparison; the complete reported uncertainties and earlier unfavorable receipt remain retained.")]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.TerminalAnomalyRecords
