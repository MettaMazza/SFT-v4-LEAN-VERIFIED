import SFT.Chemistry.ElectrophilicAnalysis
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
 let raw ← IO.FS.readFile "work/electrophilic1498_analysis_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let rows ← IO.ofExcept (field input "rows" >>= convert (raw.utf8ByteSize+1) >>= ConformerAnalysis.array)
 let primary ← IO.ofExcept (field input "primary" >>= convert (raw.utf8ByteSize+1))
 let texts ← IO.ofExcept ((← IO.ofExcept (items input "page_texts")).mapM Lean.Json.getStr?)
 let (analysis,checks) ← IO.ofExcept (ElectrophilicAnalysis.analysis rows primary texts)
 IO.println (SFT.Host.Canonical.render (.object [("analysis",analysis),("checks",.object (checks.map fun (k,v) => (k,.boolean v)))]))
