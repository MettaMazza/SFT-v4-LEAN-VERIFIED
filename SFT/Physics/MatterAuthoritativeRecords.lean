import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.MatterAuthoritativeRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def componentHashes : List (String × String) := [("nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("pdg-2025-quark-masses.pdf","sha256:d544d099aa15739ec83d87711bd4c5b1e0a1032d6f70aaa4847ec78601f7aeae"),("pdg-2025-ckm-matrix.pdf","sha256:a0a78578971f38ff89c6fc5579bc608de41ec383a205dc25cba1d26f7145610a"),("pdg-2025-neutrino-mixing.pdf","sha256:d7067e2e3c9098cc924f10ffbca579c557fb8e848bf3acc17f9815598cdda7a6"),("fermilab-muon-g2-result-2025.pdf","sha256:22fa2f99c52932ed012dc222eb821c2cb1a3d387671d650b23fbbed87a6e80a0")]
def sourceHash : String := "sha256:6e56fcdd94371ebf396b9600a1431fd448075f69073572b9cb0660959329b9fe"
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 let sealed := (field custody "formal_seal_completed_before_source_open").toOption.getD .null
 if !sameValue sealed (.boolean true) then throw "matter/flavour post-seal custody changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "matter/flavour source vector is incomplete")
 if sources.length != 6 then throw "matter/flavour source vector is incomplete"
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
  | none => pure ()
  | some (_,hash) =>
   let bytes ← match files.find? (fun p => Text.equal p.1 path) with
    | none => .error (Text.append "FileNotFoundError: " path)
    | some p => .ok p.2
   if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) hash then
    throw "matter/flavour component identity changed"
   pure ()) ()
 pure ()

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "matter/flavour source record identity changed"
 let record ← payloadBoundary payload
 checkComponents files record
 pure record

def findSourceRows (sourceId : String) : List Value → Except String Value
 | [] => .error (Text.append "missing registered source " sourceId)
 | item::tail => do
   let id ← text (← field item "source_id")
   if Text.equal id sourceId then field item "rows" else findSourceRows sourceId tail

def sourceRowsFromRecord (record : Value) (sourceId : String) : Except String Value := do
 findSourceRows sourceId (← array (← field record "sources"))
def sourceRows (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) (sourceId : String) : Except String Value := do
 sourceRowsFromRecord (← authoritativeRecord bytes files payload) sourceId
end SFT.Physics.MatterAuthoritativeRecords
