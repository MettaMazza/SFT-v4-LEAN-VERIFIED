import SFT.Chemistry.ThermalConductivityValidation
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
def readBytes (path : String) : IO ByteArray := IO.FS.readBinFile (("work/pinned1345/" ++ path) : String)
def readDocument (path : String) : IO CJ := do
 let raw ← IO.FS.readFile (("work/pinned1345/" ++ path) : String)
 IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
def htmlEvent (j : Lean.Json) : Except String ElectronSpinHtml.Event := do
 let a ← j.getArr?
 let kind ← a[0]!.getStr?
 if kind == "data" then return .data (← a[1]!.getStr?)
 else if kind == "end" then return .endTag (← a[1]!.getStr?)
 else if kind == "start" then
  let attrs ← (← a[2]!.getArr?).toList.mapM fun pair => do
   let pair ← pair.getArr?
   let value ← if pair[1]! == Lean.Json.null then pure none else pure (some (← pair[1]!.getStr?))
   return (← pair[0]!.getStr?,value)
  return .startTag (← a[1]!.getStr?) attrs
 else throw "unknown HTML event"
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/thermal1345_chunked1453_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let ip := ThermalConductivityExperiment.identityPath
 let tp := ThermalConductivityExperiment.targetPath
 let result ← IO.ofExcept (ThermalConductivityValidation.validate
  (← readBytes ip) (← readBytes tp) (← readBytes ThermalConductivityExperiment.primaryPath) (← ThermalConductivityExperiment.sourceFiles.mapM fun (p,_)=>readBytes p) (← readDocument ip) (← readDocument tp) (← readDocument ThermalConductivityExperiment.primaryPath)
  derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result.value)
