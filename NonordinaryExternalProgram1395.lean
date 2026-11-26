import SFT.Consciousness.NonordinaryExternalValidation
import Lean
open SFT.Consciousness SFT.Physics
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
def readBytes (path : String) : IO ByteArray := IO.FS.readBinFile (("work/pinned1394/" ++ path) : String)
def readDocument (path : String) : IO CJ := do
 let raw ← IO.FS.readFile (("work/pinned1394/" ++ path) : String)
 IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/nonordinary1395_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let files ← (← IO.ofExcept (items input "files")).mapM fun row => do
  let path ← IO.ofExcept row.getStr?
  let bytes ← readBytes path
  let document ← if path.endsWith ".json" then readDocument path else pure (SFT.Host.Canonical.Value.null)
  return (⟨path,bytes,document⟩ : NonordinaryExternalSource.File)
 let result ← IO.ofExcept (NonordinaryExternalValidation.validate files derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result)
