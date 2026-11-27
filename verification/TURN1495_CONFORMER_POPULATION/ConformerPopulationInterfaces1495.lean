import SFT.Chemistry.ConformerPopulationAnalysis
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
 let source : CJ := match ConformerPopulationSource.sourceRows th ph ih identities targets hashes with
  | .error e => .object [("error",.text e)]
  | .ok _ => .object [("ok",.boolean true)]
 IO.println (SFT.Host.Canonical.render (.object [("prediction",prediction),("analysis",analysis),("source",source)]))
