import SFT.Materials.QuasicrystalInflationSource
import Lean
open SFT.Materials QuasicrystalInflationSource
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
def result : Except String SFT.Host.Canonical.Value → SFT.Host.Canonical.Value
 | .ok value => .object [("ok",value)]
 | .error e => .object [("error",.text e)]
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
 let sealResult := result (do let hash ← validatePreSourceSeal payload files; pure (.text hash))
 let observed := result (do let rows ← receipts files; pure (.array rows))
 let tampered := files.map (fun file => {file with bytes := file.bytes.push 32})
 let badSeal := result (do let hash ← validatePreSourceSeal payload tampered; pure (.text hash))
 let badSource := result (do let rows ← receipts tampered; pure (.array rows))
 IO.println (SFT.Host.Canonical.render (.object [("seal",sealResult),("receipts",observed),("changed_source",badSeal),("changed_snapshot",badSource)]))
