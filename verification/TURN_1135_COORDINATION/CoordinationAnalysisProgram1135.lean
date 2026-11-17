import SFT.Chemistry.CoordinationAnalysis
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
def runCase (fuel : Nat) (j : Lean.Json) : Except String CJ := do
 let rows ← (← items j "rows").mapM (convert fuel)
 let primary ← field j "primary" >>= convert fuel
 CoordinationAnalysis.analysis rows primary
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/coordinationanalysis1135_input.json"
 let input ← IO.ofExcept (do (← Lean.Json.parse raw).getArr?)
 let result := input.toList.map fun j => match runCase (raw.utf8ByteSize+1) j with
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
  | .ok v => SFT.Host.Canonical.Value.object [("ok",v)]
 IO.println (SFT.Host.Canonical.render (.array result))
