import SFT.Chemistry.CoordinationSource
import SFT.Physics.HostilePackage
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
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/coordinationsource1135_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let checks ← IO.ofExcept (do
  (← items input "checks").mapM fun x => do
   let a ← x.getArr?
   return (← a[0]!.getStr?,← a[1]!.getStr?,← a[2]!.getStr?))
 let identityHash ← IO.ofExcept (text input "identity_hash")
 let identities ← IO.ofExcept (field input "identities" >>= convert (raw.utf8ByteSize+1))
 let targets ← IO.ofExcept (field input "targets" >>= convert (raw.utf8ByteSize+1))
 let result ← IO.ofExcept (CoordinationSource.sourceRows checks identityHash identities targets)
 IO.println (SFT.Host.Canonical.render (.array result))
