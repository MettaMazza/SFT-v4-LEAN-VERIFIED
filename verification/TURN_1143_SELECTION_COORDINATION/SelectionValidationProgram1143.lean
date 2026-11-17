import SFT.Chemistry.SelectionRuleValidation
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
def protectedSnapshot (j : Lean.Json) : Except String HostilePackage.Snapshot := do
 let pairs ← (← items j "file_hashes").mapM fun row => do
  let a ← row.getArr?
  return (← a[0]!.getStr?,← a[1]!.getStr?)
 return ⟨← text j "root_identity",pairs,← text j "snapshot_hash"⟩

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
 let metadataRaw ← IO.FS.readFile "work/selection1143_empirical_input.json"
 let metadata ← IO.ofExcept (Lean.Json.parse metadataRaw)
 let before ← IO.ofExcept (field metadata "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field metadata "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text metadata "derivation_seal")
 let host ← IO.ofExcept (text metadata "host")
 let implementation ← IO.ofExcept (text metadata "implementation")
 let result ← IO.ofExcept (SelectionRuleValidation.validate hashes ids targets transitionRows stateRows raw derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result.value)
