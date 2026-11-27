import SFT.Chemistry.AromaticRecurrenceAnalysis
import SFT.Chemistry.AromaticRecurrenceExperiment
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
def resultValue (r : Except String CJ) : CJ := match r with
 | .ok value => .object [("ok",value)]
 | .error error => .object [("error",.text error)]
def runCase (j : CJ) : Except String CJ := do
 let kind ← JointCorrelationTargets.field j "kind" >>= JointCorrelationTargets.text
 if SFT.Host.Text.equal kind "prediction" then
  AromaticRecurrencePrediction.predictionDocument AromaticRecurrencePrediction.identityHash (← JointCorrelationTargets.field j "identity")
 else if SFT.Host.Text.equal kind "source" then do
  let rows ← AromaticRecurrenceSource.sourceRows (AromaticRecurrenceExperiment.sourceFiles.map (fun (p,h) => (p,h,h))) AromaticRecurrencePrediction.identityHash
   (← JointCorrelationTargets.field j "identity") (← JointCorrelationTargets.field j "targets")
  return .array rows
 else do
  let rows ← match ← JointCorrelationTargets.field j "rows" with
   | .array values => pure values
   | _ => throw "rows must be a sequence"
  AromaticRecurrenceAnalysis.analysis rows (← JointCorrelationTargets.field j "primary")
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/aromatic1491_interfaces_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
 let cases ← IO.ofExcept (match input with | .array rows => Except.ok rows | _ => .error "cases must be a sequence")
 IO.println (SFT.Host.Canonical.render (.array (cases.map fun row => resultValue (runCase row))))
