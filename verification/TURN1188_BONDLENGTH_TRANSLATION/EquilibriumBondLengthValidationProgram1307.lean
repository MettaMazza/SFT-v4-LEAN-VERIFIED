import SFT.Chemistry.EquilibriumBondLengthValidation
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
def readBytes (path : String) : IO ByteArray := IO.FS.readBinFile (("work/pinned1307/" ++ path) : String)
def readDocument (path : String) : IO CJ := do
 let raw ← IO.FS.readFile (("work/pinned1307/" ++ path) : String)
 IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/bondlength1307_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let paths ← IO.ofExcept (items input "snapshot_paths" >>= List.mapM Lean.Json.getStr?)
 let files ← paths.mapM fun path => do return (path,← readBytes path)
 let scaleBytes ← readBytes EquilibriumBondLengthExperiment.scalePath
 let identityBytes ← readBytes EquilibriumBondLengthExperiment.identityPath
 let targetBytes ← readBytes EquilibriumBondLengthExperiment.targetPath
 let sourcePath := "experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json"
 let sourceBytes ← readBytes sourcePath
 let scale ← readDocument EquilibriumBondLengthExperiment.scalePath
 let identities ← readDocument EquilibriumBondLengthExperiment.identityPath
 let targets ← readDocument EquilibriumBondLengthExperiment.targetPath
 let source ← readDocument sourcePath
 let _ ← IO.ofExcept (EquilibriumBondLengthSource.validateRegistryBinding identityBytes scaleBytes targetBytes identities)
 let result ← IO.ofExcept (EquilibriumBondLengthValidation.validate scaleBytes identityBytes targetBytes sourceBytes
  scale identities targets source files derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result.value)
