import SFT.Chemistry.CoordinationNumberPrediction
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
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/coordinationnumberprediction1145_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
 let hash := SFT.Host.Text.append "sha256:" (SFT.Host.SHA256.digest raw.toUTF8)
 let result ← IO.ofExcept (CoordinationNumberPrediction.predictionDocument hash input)
 IO.println (SFT.Host.Canonical.render result)
