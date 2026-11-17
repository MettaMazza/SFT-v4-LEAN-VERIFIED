import SFT.Chemistry.SelectionTargets
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
def readJ (path : String) : IO CJ := do
 let raw ← IO.FS.readFile ("work/pinned1142/"++path)
 let json ← IO.ofExcept (Lean.Json.parse raw)
 IO.ofExcept (convert (raw.utf8ByteSize+1) json)
def main : IO Unit := do
 let hashes ← SelectionTargets.authorities.mapM fun (path,_) => do
  let bytes ← IO.FS.readBinFile ("work/pinned1142/"++path)
  return (path,"sha256:"++SFT.Host.SHA256.digest bytes)
 let ids ← readJ "experiments/external_sources/chemistry/selection_rule_target_identities_v1.json"
 let targets ← readJ "experiments/external_sources/chemistry/selection_rule_withheld_targets_v1.json"
 let transitions ← readJ "experiments/external_sources/chemistry/state_transition_withheld_targets_v1.json"
 let states ← readJ "experiments/external_sources/chemistry/state_symmetry_withheld_targets_v1.json"
 let transitionRows ← IO.ofExcept (ConjugatedSupportAnalysis.field transitions "rows" >>= ConjugatedSupportAnalysis.array)
 let stateRows ← IO.ofExcept (ConjugatedSupportAnalysis.field states "rows" >>= ConjugatedSupportAnalysis.array)
 let raw ← IO.FS.readFile ("work/pinned1142/"++SelectionTargets.sourcePath)
 let rows ← IO.ofExcept (SelectionTargets.targets hashes ids targets transitionRows stateRows raw)
 let comparisons ← IO.ofExcept (rows.mapM SelectionObservation.comparison)
 let counts ← IO.ofExcept (SelectionObservation.counts comparisons)
 IO.println (SFT.Host.Canonical.render (.object [("rows",.array rows),("comparisons",.array comparisons),("counts",.object (counts.map fun (k,n) => (k,.integer (.ofNat n))))]))
