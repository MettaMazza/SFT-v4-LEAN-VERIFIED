import SFT.Chemistry.ConfigurationOrderValidation
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
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/configuration1155_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let rawEvents ← IO.FS.readFile "work/configuration1155_events.json"
 let ev ← IO.ofExcept (Lean.Json.parse rawEvents)
 let events ← (← IO.ofExcept ev.getArr?).toList.mapM fun row => IO.ofExcept (do
  let row ← row.getArr?
  let kind ← row[0]!.getStr?
  let value ← row[1]!.getStr?
  if kind == "start" then pure (ElectronSpinHtml.Event.startTag value [])
  else if kind == "end" then pure (ElectronSpinHtml.Event.endTag value)
  else pure (ElectronSpinHtml.Event.data value))
 let hashes ← ConfigurationTargets.authorities.mapM fun (path,_) => do
  let bytes ← IO.FS.readBinFile ("work/pinned1155/"++path)
  return (path,"sha256:"++SFT.Host.SHA256.digest bytes)
 let rawTargets ← IO.FS.readFile "work/pinned1155/experiments/external_sources/chemistry/configuration_order_withheld_targets_v1.json"
 let document ← IO.ofExcept (Lean.Json.parse rawTargets >>= convert (rawTargets.utf8ByteSize+1))
 let result ← IO.ofExcept (ConfigurationOrderValidation.validate hashes document events derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result.value)
