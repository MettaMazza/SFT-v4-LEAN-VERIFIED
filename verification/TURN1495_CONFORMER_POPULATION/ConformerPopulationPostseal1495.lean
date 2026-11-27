import SFT.Chemistry.ConformerPopulationValidation
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
 let raw ← IO.FS.readFile "work/conformerpopulation1495_interfaces_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let identities ← IO.ofExcept (field input "identities" >>= convert (raw.utf8ByteSize+1))
 let targets ← IO.ofExcept (field input "targets" >>= convert (raw.utf8ByteSize+1))
 let primary ← IO.ofExcept (field input "primary" >>= convert (raw.utf8ByteSize+1))
 let ih ← IO.ofExcept (text input "identity_hash")
 let th ← IO.ofExcept (text input "target_hash")
 let ph ← IO.ofExcept (text input "primary_hash")
 let hashes ← IO.ofExcept (do
  (← items input "snapshot_hashes").mapM fun row => do
   let a ← row.getArr?
   return (← a[0]!.getStr?,← a[1]!.getStr?))
 let prediction ← IO.ofExcept (ConformerPopulationPrediction.predictionDocument ih identities)
 let rows ← IO.ofExcept (ConformerPopulationPrediction.get targets "rows" |> ConformerAnalysis.array)
 let analysis ← IO.ofExcept (ConformerPopulationAnalysis.analysis rows primary)
 let programFields := match prediction with | .object fs => fs | _ => []
 let program ← IO.ofExcept (CapabilityDocuments.loadProgramFields programFields)
 let inputs ← IO.ofExcept (ConformerPopulationValidation.inputValues "native-conformerpopulation1495")
 let execution ← IO.ofExcept (CapabilityExecution.execute program inputs)
 let predictions ← IO.ofExcept (ConformerPopulationSource.predictionMap execution.output)
 let released ← IO.ofExcept (rows.mapM fun row => do
  let id ← JointCorrelationTargets.field row "target_id" >>= JointCorrelationTargets.text
  let payload ← JointCorrelationTargets.field row "target_payload_hash" >>= JointCorrelationTargets.text
  let label ← CapabilityValues.heldLabel "external-complete-source-record-hash" payload
  return (id,CapabilityValues.canonical (.label label)))
 let comparisons ← IO.ofExcept (rows.mapM (ConformerPopulationComparison.compare predictions released))
 let controls ← IO.ofExcept (ConformerPopulationComparison.controls rows analysis prediction released)
 let passed := comparisons.all ConformerPopulationValidation.rowPassed && ConformerPopulationComparison.analysisPassed analysis && controls.all Prod.snd
 IO.println (SFT.Host.Canonical.render (.object [
  ("comparisons",.array comparisons),("analysis",analysis),
  ("controls",.object (controls.map fun (k,v) => (k,.boolean v))),
  ("passed",.boolean passed),("registration",ConformerPopulationExperiment.registration prediction)]))
