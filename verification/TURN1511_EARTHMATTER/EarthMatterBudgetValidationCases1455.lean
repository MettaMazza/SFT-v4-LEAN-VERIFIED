import SFT.EarthEnvironment.EarthMatterBudgetValidation
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
 let raw ← IO.FS.readFile "work/earthmatter1455_validation_input.json"
 let row ← IO.ofExcept (Lean.Json.parse raw)
 let entries ← IO.ofExcept (items row "files")
 let files ← entries.mapM fun entry => do
  let path ← IO.ofExcept (text entry "path")
  let localPath ← IO.ofExcept (text entry "local")
  let bytes ← IO.FS.readBinFile localPath
  return SFT.Materials.MaterialSource.Snapshot.mk path bytes
 let get (key : String) := IO.ofExcept (field row key >>= convert (raw.utf8ByteSize+1))
 let sealValue ← get "seal"
 let audit ← get "audit"
 let targets ← get "targets"
 let bindings ← get "bindings"
 let first ← get "first"
 let holdout ← get "holdout"
 let targetRow ← get "row"
 let extraction ← IO.ofExcept (text row "extraction")
 let preSeal ← IO.ofExcept (text row "preseal_hash")
 let derivation ← IO.ofExcept (text row "derivation")
 let registration ← IO.ofExcept (SFT.EarthEnvironment.EarthMatterBudgetExperiment.registration targetRow extraction preSeal)
 let result := SFT.EarthEnvironment.EarthMatterBudgetValidation.validate sealValue audit targets bindings first holdout files derivation "Darwin" "CPython" (⟨"", [], ""⟩) (⟨"", [], ""⟩)
 let wrapped := match result with
  | .ok v => SFT.Host.Canonical.Value.object [("ok",v)]
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
 IO.println (SFT.Host.Canonical.render (.object [("program",SFT.EarthEnvironment.EarthMatterBudgetExperiment.predictionDocument),("registration",registration),("validation",wrapped)]))
