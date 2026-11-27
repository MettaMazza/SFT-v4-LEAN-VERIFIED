import SFT.Chemistry.AromaticRecurrenceAnalysis
import SFT.Physics.HostilePackage
import SFT.Host.SHA256Streaming
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
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/aromatic1491_analysis_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 let outputs ← input.toList.mapM fun c => do
  let rows ← IO.ofExcept (c.getObjVal? "rows" >>= convert (raw.utf8ByteSize+1) >>= AromaticRecurrenceAnalysis.array)
  let primary ← IO.ofExcept (c.getObjVal? "primary" >>= convert (raw.utf8ByteSize+1))
  return match AromaticRecurrenceAnalysis.analysis rows primary with
   | .ok v => SFT.Host.Canonical.Value.object [("ok",v)]
   | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
 IO.println (SFT.Host.Canonical.render (.array outputs))
