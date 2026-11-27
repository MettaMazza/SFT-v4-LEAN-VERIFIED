import SFT.Chemistry.NucleophilicAnalysis
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
 let raw ← IO.FS.readFile "work/nucleophilic1497_analysis_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let rows ← IO.ofExcept (field input "rows" >>= convert (raw.utf8ByteSize+1) >>= ConformerAnalysis.array)
 let primary ← IO.ofExcept (field input "primary" >>= convert (raw.utf8ByteSize+1))
 let (analysis,checks) ← IO.ofExcept (NucleophilicAnalysis.analysis rows primary)
 let formulas ← IO.ofExcept ((← IO.ofExcept (items input "formulas")).mapM fun j => do
  let s ← j.getStr?
  return match NucleophilicFormula.formula s with
   | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
   | .ok rows => .object [("value",NucleophilicFormula.value rows)])
 let sums ← IO.ofExcept ((← IO.ofExcept (items input "sums")).mapM fun group => do
  let rows ← group.getArr?
  let values ← rows.toList.mapM fun row => do
   let fs ← row.getObj?
   fs.toList.mapM fun (k,v) => do return (k,← v.getInt?)
  return NucleophilicFormula.value (NucleophilicFormula.sum values))
 IO.println (SFT.Host.Canonical.render (.object [("analysis",analysis),("checks",.object (checks.map fun (k,v) => (k,.boolean v))),("formulas",.array formulas),("sums",.array sums)]))
