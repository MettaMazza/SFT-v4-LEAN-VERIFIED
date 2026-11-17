import SFT.Biology.LifeOrganizationSeal
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

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/lifeorganization1106_seal_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let entries ← IO.ofExcept (items input "files")
 let files ← entries.mapM fun entry => do
  let path ← IO.ofExcept (text entry "path")
  let localPath ← IO.ofExcept (text entry "local")
  let bytes ← IO.FS.readBinFile localPath
  return SFT.Materials.MaterialSource.Snapshot.mk path bytes
 let cases ← IO.ofExcept (items input "cases")
 let results ← IO.ofExcept (cases.mapM fun entry => do
  let payload ← field entry "payload" >>= convert (raw.utf8ByteSize+1)
  let result := match SFT.Biology.LifeOrganizationSeal.validate payload files with
   | .ok s => SFT.Host.Canonical.Value.object [("ok",.text s)]
   | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
  return result)
 IO.println (SFT.Host.Canonical.render (.array results))
