import SFT.Chemistry.ResonanceEquivalentValidation
import Lean
open SFT.Chemistry SFT.Physics
def convert : Nat → Lean.Json → Except String SFT.Host.Canonical.Value
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
def main (args : List String) : IO Unit := do
 let path ← match args with | [] => throw (IO.userError "Pass input file") | head::_ => pure head
 let bytes ← IO.FS.readFile path
 let parsed ← IO.ofExcept (Lean.Json.parse bytes)
 let output ← IO.ofExcept (do
  let idDoc ← field parsed "identity_document" >>= convert (bytes.utf8ByteSize+1)
  let targetDoc ← field parsed "target_document" >>= convert (bytes.utf8ByteSize+1)
  let primaryDoc ← field parsed "primary_document" >>= convert (bytes.utf8ByteSize+1)
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  ResonanceEquivalentValidation.validate (← text parsed "identity_hash") (← text parsed "target_hash")
   (← text parsed "primary_hash") idDoc targetDoc primaryDoc (← text parsed "derivation_seal")
   (← text parsed "host") (← text parsed "implementation") before after)
 IO.println (SFT.Host.Canonical.render output.value)
