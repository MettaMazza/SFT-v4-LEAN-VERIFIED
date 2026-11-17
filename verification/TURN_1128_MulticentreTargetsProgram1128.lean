import SFT.Chemistry.MulticentreTargets
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
def event (x : Lean.Json) : Except String MulticentreSurface.Event := do
 let a ← x.getArr?
 let k ← a[0]!.getStr?
 let v ← a[1]!.getStr?
 if k=="start" then return .startTag v []
 if k=="end" then return .endTag v
 return .data v
def resolvedValue (r : MulticentreTargets.Resolved) : CJ := .object (r.row.fields++[
 ("magnitude",CapabilityValues.canonical r.magnitude),("target_value",CapabilityValues.canonical r.targetValue)])
def sourceHash (path : String) : IO String := do
 let bytes ← IO.FS.readBinFile ("work/pinned1126/"++path)
 return SFT.Host.Text.append "sha256:" (SFT.Host.SHA256.digest bytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
open MulticentreTargets

def main : IO Unit := do
 let raw ← IO.FS.readFile "work/multicentre1127_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let identityDoc ← IO.ofExcept (field input "identity_document")
 let identitySchema ← IO.ofExcept (text identityDoc "schema")
 let ids ← IO.ofExcept (do (← items identityDoc "rows").mapM (fun row => text row "target_id"))
 let targetDoc ← IO.ofExcept (field input "target_document")
 let targetSchema ← IO.ofExcept (text targetDoc "schema")
 let targets ← IO.ofExcept (do
  (← items targetDoc "rows").mapM fun row => do
   let id ← text row "target_id"
   let fields ← (← row.getObj?).toList.mapM fun (k,v) => do return (k,← convert (raw.utf8ByteSize+1) v)
   return PairExchangeTargets.Target.mk id fields)
 let iupac ← IO.ofExcept (field input "iupac_document" >>= convert (raw.utf8ByteSize+1))
 let surfaces ← IO.ofExcept (items input "surfaces")
 let dibEvents ← IO.ofExcept (do (← surfaces[0]!.getArr?).toList.mapM event)
 let benEvents ← IO.ofExcept (do (← surfaces[1]!.getArr?).toList.mapM event)
 let identityActual ← sourceHash "experiments/external_sources/chemistry/multicentre_target_identities_v1.json"
 let targetActual ← sourceHash "experiments/external_sources/chemistry/multicentre_withheld_targets_v1.json"
 let iupacActual ← sourceHash iupacPath
 let dibActual ← sourceHash diboranePath
 let benActual ← sourceHash benzenePath
 let rows ← IO.ofExcept (reconstructedTargets identityActual identitySchema ids targetActual targetSchema targets iupacActual dibActual benActual iupac dibEvents benEvents)
 IO.println (SFT.Host.Canonical.render (.array (rows.map resolvedValue)))
