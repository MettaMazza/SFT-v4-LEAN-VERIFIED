import SFT.Consciousness.Source
import Lean
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
 let raw ← IO.FS.readFile "work/consciousness1374_source_inputs.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 for row in input do
  let entries ← IO.ofExcept (items row "files")
  let files ← entries.mapM fun entry => do
   let path ← IO.ofExcept (text entry "path")
   let localPath ← IO.ofExcept (text entry "local")
   let bytes ← IO.FS.readBinFile localPath
   return SFT.Materials.MaterialSource.Snapshot.mk path bytes
  let result : Except String CJ := do
   let sealPayload ← field row "seal" >>= convert (raw.utf8ByteSize+1)
   let audit ← field row "audit" >>= convert (raw.utf8ByteSize+1)
   let targets ← field row "targets" >>= convert (raw.utf8ByteSize+1)
   let sealHash ← SFT.Consciousness.Source.validatePreSourceSeal sealPayload files
   let (target,extraction) ← SFT.Consciousness.Source.targetRow
     (← text row "root") (← text row "claim_id") (← text row "target_id") (← text row "expected_label") audit targets files
   pure (.object [("seal",.text sealHash),("row",target),("extraction",.text extraction)])
  let wrapped := match result with
   | .ok v => SFT.Host.Canonical.Value.object [("ok",v)]
   | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
  IO.println (SFT.Host.Canonical.render wrapped)
