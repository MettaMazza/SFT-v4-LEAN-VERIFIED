import SFT.Chemistry.PairExchangeValidation
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

open SFT.Host SFT.Chemistry.PairExchangeSource SFT.Chemistry.PairExchangeTargets
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (j : Lean.Json) : Except String Identity := do
 return ⟨← text j "target_id",← text j "snapshot_path",← text j "snapshot_hash"⟩
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
 let bytes ← IO.FS.readFile (args.headD "work/pairexchange1103_empirical_input.json")
 let parsed ← IO.ofExcept (Lean.Json.parse bytes)
 let output ← IO.ofExcept (do
  let idDoc ← field parsed "identity_document"
  let targetDoc ← field parsed "target_document"
  let ids ← (← items idDoc "rows").mapM sourceIdentity
  let states ← (← items targetDoc "state_rows").mapM (sourceTarget (bytes.utf8ByteSize+1))
  let pairs ← (← items targetDoc "exchange_pairs").mapM (sourceTarget (bytes.utf8ByteSize+1))
  let events ← (← items parsed "events").mapM sourceEvent
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  PairExchangeValidation.validate (← text parsed "identity_hash") (← text idDoc "schema")
   (← text parsed "target_hash") (← text targetDoc "schema") ids states pairs
   (← text parsed "actual_snapshot_hash") events (← text parsed "tampered_first_hash")
   (← text parsed "derivation_seal") (← text parsed "host") (← text parsed "implementation") before after)
 IO.println (Canonical.render output.value)
