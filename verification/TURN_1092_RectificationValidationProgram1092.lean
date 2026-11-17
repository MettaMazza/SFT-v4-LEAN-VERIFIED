import SFT.Materials.RectificationSourceValidation
import Lean
open SFT.Materials SFT.Physics
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
 let input ← IO.FS.readFile (args.headD "")
 let parsed ← IO.ofExcept (Lean.Json.parse input)
 let path ← IO.ofExcept (text parsed "seal_path")
 let sealText ← IO.FS.readFile path
 let sealJson ← IO.ofExcept (Lean.Json.parse sealText)
 let payload ← IO.ofExcept (convert (sealText.utf8ByteSize+1) sealJson)
 let entries ← IO.ofExcept (items parsed "files")
 let files ← entries.mapM (fun entry => do
  let path ← IO.ofExcept (text entry "path")
  let localPath ← IO.ofExcept (text entry "local")
  let bytes ← IO.FS.readBinFile localPath
  pure ({path:=path,bytes:=bytes} : MaterialSource.Snapshot))
 let output ← IO.ofExcept (do
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  RectificationSourceValidation.validate payload files (← text parsed "derivation_seal")
   (← text parsed "host") (← text parsed "implementation") before after)
 IO.println (SFT.Host.Canonical.render output)
