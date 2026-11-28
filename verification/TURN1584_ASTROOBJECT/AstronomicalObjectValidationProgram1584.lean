import SFT.AstronomyCosmology.AstronomicalObjectValidation
import Lean
open SFT.AstronomyCosmology SFT.Physics
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
 let raw ← IO.FS.readFile "work/astroobject1584_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivation ← IO.ofExcept (text input "derivation")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let supplied ← (← IO.ofExcept (items input "files")).mapM fun x => do
  let relative ← IO.ofExcept x.getStr?
  let data ← IO.FS.readBinFile (("work/pinned1584/" ++ relative) : String)
  let decoded ← if relative.endsWith ".json" then do
   let raw ← IO.FS.readFile (("work/pinned1584/" ++ relative) : String)
   IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
   else pure SFT.Host.Canonical.Value.null
  pure ((⟨relative,data⟩ : Source.Snapshot),(relative,decoded))
 let files := supplied.map Prod.fst
 let records := supplied.map Prod.snd
 let specs ← IO.ofExcept (Source.buildSpecs [AstronomicalObjectExperiment.blueprint] records files)
 let spec ← match specs with
  | [spec] => pure spec
  | _ => throw (IO.userError "Original one-entry specification projection changed")
 let result ← IO.ofExcept (AstronomicalObjectValidation.validate spec records files derivation host implementation before after)
 IO.println (SFT.Host.Canonical.render (.object [("registration",AstronomicalObjectExperiment.registration spec),("validation",result)]))
