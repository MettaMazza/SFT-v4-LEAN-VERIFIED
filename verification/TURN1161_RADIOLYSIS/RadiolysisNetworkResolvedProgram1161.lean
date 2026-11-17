import SFT.Chemistry.RadiolysisNetworkValidation
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
open SFT.Chemistry.NuclideCarrierAnalysis
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/radiolysis1160_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let analysis ← IO.ofExcept (field input "analysis" >>= convert (raw.utf8ByteSize+1))
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let recorded ← IO.ofExcept (NuclideCarrierAnalysis.field analysis "complete_result_vector_sha256" >>= NuclideCarrierAnalysis.text)
 let (summary,checks) ← IO.ofExcept (RadiolysisNetworkAnalysis.resolvedAnalysis analysis recorded (370,837013))
 let omission := match RadiolysisNetworkAnalysis.resolvedAnalysis analysis recorded (370,837013) true with
  | .error _ => true
  | .ok _ => false
 let result ← IO.ofExcept (RadiolysisNetworkValidation.validateResolved summary checks omission derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result)
