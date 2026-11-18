import SFT.Chemistry.MolecularBondAngleValidation
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

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def readBytes (path : String) : IO ByteArray := IO.FS.readBinFile (("work/pinned1313/" ++ path) : String)
def readDocument (path : String) : IO CJ := do
 let raw ← IO.FS.readFile (("work/pinned1313/" ++ path) : String)
 IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
def htmlEvent (j : Lean.Json) : Except String ElectronSpinHtml.Event := do
 let a ← j.getArr?
 let kind ← a[0]!.getStr?
 if kind == "data" then return .data (← a[1]!.getStr?)
 else if kind == "end" then return .endTag (← a[1]!.getStr?)
 else if kind == "start" then
  let attrs ← (← a[2]!.getArr?).toList.mapM fun pair => do
   let pair ← pair.getArr?
   let value ← if pair[1]! == Lean.Json.null then pure none else pure (some (← pair[1]!.getStr?))
   return (← pair[0]!.getStr?,value)
  return .startTag (← a[1]!.getStr?) attrs
 else throw "unknown HTML event"
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/bondangle1313_table_input.json"
 let j ← IO.ofExcept (Lean.Json.parse raw)
 let cases ← IO.ofExcept j.getArr?
 let results ← cases.toList.mapM fun row => do
  let events ← IO.ofExcept (row.getArr? >>= fun a => a.toList.mapM htmlEvent)
  pure (SFT.Host.Canonical.Value.array ((MolecularBondAngleSource.tableRows events).map fun row => .array (row.map SFT.Host.Canonical.Value.text)))
 IO.println (SFT.Host.Canonical.render (.array results))
