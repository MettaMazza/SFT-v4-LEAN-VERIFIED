import SFT.Chemistry.JointCorrelationValidation
import Lean
open SFT.Chemistry SFT.Physics
abbrev CJ := SFT.Host.Canonical.Value
def convert : Nat → Lean.Json → Except String CJ
 | 0,_ => .error "JSON nesting exceeds input byte count"
 | n+1,j => match j with
  | .null => .ok .null
  | .bool b => .ok (.boolean b)
  | .num _ => do return .integer (← j.getInt?)
  | .str s => .ok (.text s)
  | .arr xs => do return .array (← xs.toList.mapM (convert n))
  | .obj fs => do return .object (← fs.toList.mapM fun (k,v) => do return (k,← convert n v))
def field (j : Lean.Json) (name : String) := j.getObjVal? name
def text (j : Lean.Json) (name : String) := j.getObjValAs? String name
def items (j : Lean.Json) (name : String) : Except String (List Lean.Json) := do
 return (← (← field j name).getArr?).toList
def sourceEvent (j : Lean.Json) : Except String JointCorrelationNotes.Event := do
 let a ← j.getArr?
 let kind ← a[0]!.getStr?
 let name ← a[1]!.getStr?
 if kind=="data" then return .data name
 else if kind=="end" then return .endTag name
 else if kind=="start" then
  let attrs ← (← a[2]!.getArr?).toList.mapM fun pair => do
   let cells ← pair.getArr?
   let key ← cells[0]!.getStr?
   let value ← match cells[1]! with
    | .null => pure none
    | other => do pure (some (← other.getStr?))
   return (key,value)
  return .startTag name attrs
 else throw "unrecognized HTML event"

open SFT.Host SFT.Chemistry.JointCorrelationTargets
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceTarget (fuel : Nat) (j : Lean.Json) : Except String Target := do
 let v ← convert fuel j
 let fields ← match v with | .object xs => pure xs | _ => throw "dictionary expected"
 return ⟨← text j "target_id",fields⟩

def protectedSnapshot (j : Lean.Json) : Except String HostilePackage.Snapshot := do
 let pairs ← (← items j "file_hashes").mapM fun row => do
  let a ← row.getArr?
  return (← a[0]!.getStr?,← a[1]!.getStr?)
 return ⟨← text j "root_identity",pairs,← text j "snapshot_hash"⟩

def main (args : List String) : IO Unit := do
 let bytes ← IO.FS.readFile (args.headD "work/jointempirical1119_input.json")
 let parsed ← IO.ofExcept (Lean.Json.parse bytes)
 let output ← IO.ofExcept (do
  let idDoc ← field parsed "identity_document"
  let targetDoc ← field parsed "target_document"
  let apsDoc ← field parsed "aps_document"
  let ids ← (← items idDoc "rows").mapM (fun row => text row "target_id")
  let targets ← (← items targetDoc "rows").mapM (sourceTarget (bytes.utf8ByteSize+1))
  let aps ← (← items apsDoc "records").mapM (convert (bytes.utf8ByteSize+1))
  let events ← (← items parsed "events").mapM sourceEvent
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  JointCorrelationValidation.validate (← text parsed "identity_hash") (← text idDoc "schema") ids
   (← text parsed "target_hash") (← text targetDoc "schema") targets
   (← text parsed "actual_aps_hash") (← text parsed "actual_nist_hash") (← text apsDoc "schema") aps events
   (← text parsed "tampered_aps_hash") (← text parsed "derivation_seal") (← text parsed "host") (← text parsed "implementation") before after)
 IO.println (Canonical.render output.value)
