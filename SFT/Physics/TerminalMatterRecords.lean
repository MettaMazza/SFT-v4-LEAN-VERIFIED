import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.TerminalMatterRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def componentHashes : List (String × String) := [("pdg-2025-ckm-matrix.pdf","sha256:a0a78578971f38ff89c6fc5579bc608de41ec383a205dc25cba1d26f7145610a"),("pdg-2025-bbang-cosmology.pdf","sha256:2ea12893db3cdd33a67b6dbff98e74ca15b14ba2b2c3c2be5abcfdeffd98b543")]
def sourceHash : String := "sha256:652b186e29c835c9cf8fdfd3393fe19c6a81917666989331c5ca060dc789ae9e"
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "development_target_already_known").toOption.getD .null) (.boolean true) then throw "terminal matter/flavour custody disclosure changed"
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "terminal matter/flavour custody disclosure changed"
 if !sameValue ((field custody "formal_relation_contains_measurement").toOption.getD .null) (.boolean false) then throw "terminal matter/flavour custody disclosure changed"
 if !sameValue ((field custody "measurement_selects_formal_survivor").toOption.getD .null) (.boolean false) then throw "terminal matter/flavour custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "terminal matter/flavour custody disclosure changed"
 if !sameValue ((field custody "blind_forward_discovery_claimed").toOption.getD .null) (.boolean false) then throw "terminal matter/flavour custody disclosure changed"
 if !sameValue ((field custody "all_rows_and_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "terminal matter/flavour custody disclosure changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "terminal matter/flavour source vector is incomplete")
 if sources.length != 2 then throw "terminal matter/flavour source vector is incomplete"
 pure payload

def lastPathPartChars (current : List Char) : List Char → List Char
 | [] => current.reverse
 | ch::tail => if ch == '/' then lastPathPartChars [] tail else lastPathPartChars (ch::current) tail

def lastPathPart (path : String) : String := String.ofList (lastPathPartChars [] (Text.chars path))

def checkComponents (files : List (String × ByteArray)) (payload : Value) : Except String Unit := do
 let sources ← array (← field payload "sources")
 let _ ← sources.foldlM (fun (_ : Unit) source => do
  let path ← text ((field source "snapshot_path").toOption.getD (.text ""))
  let snapshot := lastPathPart path
  match componentHashes.find? (fun p => Text.equal p.1 snapshot) with
  | none => throw "terminal matter/flavour component identity changed"
  | some (_,hash) =>
   let bytes ← match files.find? (fun p => Text.equal p.1 path) with
    | none => .error (Text.append "FileNotFoundError: " path)
    | some p => .ok p.2
   if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) hash then
    throw "terminal matter/flavour component identity changed"
   pure ()) ()
 pure ()

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "terminal matter/flavour source record identity changed"
 let record ← payloadBoundary payload
 checkComponents files record
 pure record

def findSourceRows (sourceId : String) : List Value → Except String Value
 | [] => .error (Text.append "missing registered terminal source " sourceId)
 | item::tail => do
   let id ← text (← field item "source_id")
   if Text.equal id sourceId then field item "rows" else findSourceRows sourceId tail

def sourceRowsFromRecord (record : Value) (sourceId : String) : Except String Value := do
 findSourceRows sourceId (← array (← field record "sources"))
def sourceRows (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) (sourceId : String) : Except String Value := do
 sourceRowsFromRecord (← authoritativeRecord bytes files payload) sourceId
def registeredRecord : Value := .object [("schema",.text "sft-v3-matter-flavour-terminal-postseal-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("development_target_already_known",.boolean true),("classification",.text "observational_derivation"),("formal_relation_contains_measurement",.boolean false),("measurement_selects_formal_survivor",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("blind_forward_discovery_claimed",.boolean false),("all_rows_and_uncertainties_retained",.boolean true)]),("sources",.array [.object [("source_id",.text "PDG-2025-CKM-MATRIX"),("body",.text "Particle Data Group, Lawrence Berkeley National Laboratory"),("source_uri",.text "https://pdg.lbl.gov/2025/reviews/rpp2025-rev-ckm-matrix.pdf"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/pdg-2025-ckm-matrix.pdf"),("snapshot_hash",.text "sha256:a0a78578971f38ff89c6fc5579bc608de41ec383a205dc25cba1d26f7145610a"),("rows",.object [("sin_theta12",.object [("value",.text "0.22501"),("lower_uncertainty",.text "0.00068"),("upper_uncertainty",.text "0.00068")]),("sin_theta23",.object [("value",.text "0.04183"),("lower_uncertainty",.text "0.00069"),("upper_uncertainty",.text "0.00079")]),("sin_theta13",.object [("value",.text "0.003732"),("lower_uncertainty",.text "0.000085"),("upper_uncertainty",.text "0.000090")]),("jarlskog",.object [("value",.text "0.0000312"),("lower_uncertainty",.text "0.0000012"),("upper_uncertainty",.text "0.0000013")])])],.object [("source_id",.text "PDG-2025-BIG-BANG-COSMOLOGY"),("body",.text "Particle Data Group, Lawrence Berkeley National Laboratory"),("source_uri",.text "https://pdg.lbl.gov/2025/reviews/rpp2025-rev-bbang-cosmology.pdf"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/pdg-2025-bbang-cosmology.pdf"),("snapshot_hash",.text "sha256:2ea12893db3cdd33a67b6dbff98e74ca15b14ba2b2c3c2be5abcfdeffd98b543"),("rows",.object [("bbn_baryon_to_photon_ratio",.object [("strict_lower",.text "0.00000000058"),("strict_upper",.text "0.00000000063"),("source_equation",.text "22.55")]),("planck_derived_baryon_to_photon_ratio",.object [("value",.text "0.000000000612"),("standard_uncertainty",.text "0.000000000004"),("source_context",.text "PDG translation of the registered Planck baryon density")])])]]),("validation_boundary",.text "The target was visible during successor development, so the result is registered as an observational derivation rather than a blind forward discovery. The executable Fold relations contain no target value, the engine seals each prediction before releasing this record within the admission run, and every source row and uncertainty is retained as a post-seal test.")]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.TerminalMatterRecords
