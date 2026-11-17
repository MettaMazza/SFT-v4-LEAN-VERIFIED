import SFT.Chemistry.StateSymmetryValidation
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
def protectedSnapshot (j : Lean.Json) : Except String HostilePackage.Snapshot := do
 let pairs ← (← items j "file_hashes").mapM fun row => do
  let a ← row.getArr?
  return (← a[0]!.getStr?,← a[1]!.getStr?)
 return ⟨← text j "root_identity",pairs,← text j "snapshot_hash"⟩
def sourceEvent (j : Lean.Json) : Except String StateSymmetrySource.Event := do
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
def sourceSnapshot (j : Lean.Json) : Except String StateSymmetryPrediction.Snapshot := do
 return ⟨← text j "path",← text j "actual_hash",← (← items j "events").mapM sourceEvent⟩
def sourceIdentity (j : Lean.Json) : Except String StateSymmetryPrediction.Identity := do
 return ⟨← text j "target_id",← text j "species_row_id",← text j "snapshot_path",← text j "snapshot_hash",
  ← (← field j "state_row_ordinal").getInt?,← (← field j "term_assignment_ordinal").getInt?⟩
def sourceTarget (fuel : Nat) (j : Lean.Json) : Except String StateSymmetryPrediction.WithheldTarget := do
 let value ← convert fuel j
 let fields ← match value with
  | .object xs => pure xs
  | _ => throw "target dictionary expected"
 return ⟨← text j "target_id",fields⟩
structure Input where
 identityHash : String
 identitySchema : String
 targetHash : String
 targetSchema : String
 identities : List StateSymmetryPrediction.Identity
 targets : List StateSymmetryPrediction.WithheldTarget
 snapshots : List StateSymmetryPrediction.Snapshot

def sourceInput (fuel : Nat) (j : Lean.Json) : Except String Input := do
 let idDocument ← field j "identity_document"
 let targetDocument ← field j "target_document"
 return ⟨← text j "identity_hash",← text idDocument "schema",← text j "target_hash",← text targetDocument "schema",
  ← (← items idDocument "rows").mapM sourceIdentity,← (← items targetDocument "rows").mapM (sourceTarget fuel),
  ← (← items j "snapshots").mapM sourceSnapshot⟩

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main (args : List String) : IO Unit := do
 let path := args.headD "work/statesymmetry1102_input.json"
 let bytes ← IO.FS.readFile path
 let parsed ← IO.ofExcept (Lean.Json.parse bytes)
 let result ← IO.ofExcept (do
  let i ← sourceInput (bytes.utf8ByteSize+1) parsed
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  StateSymmetryValidation.validate i.identityHash i.identitySchema i.targetHash i.targetSchema i.identities i.targets i.snapshots
   (← text parsed "tampered_first_hash") (← text parsed "derivation_seal") (← text parsed "host")
   (← text parsed "implementation") before after)
 IO.println (SFT.Host.Canonical.render result.value)
