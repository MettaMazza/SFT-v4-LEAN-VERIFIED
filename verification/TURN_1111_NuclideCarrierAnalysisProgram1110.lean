import SFT.Chemistry.NuclideCarrierAnalysis
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
open SFT.Chemistry.NuclideCarrierAnalysis
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/nuclidecarrier1108_analysis_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let analysis ← IO.ofExcept (field input "analysis" >>= convert (raw.utf8ByteSize+1))
 let files ← authorities.mapM fun (path,_) => do
  let bytes ← IO.FS.readBinFile ("work/pinned1107/" ++ path)
  return SFT.Materials.MaterialSource.Snapshot.mk path bytes
 let entries ← IO.ofExcept (items input "surfaces")
 let surfaces ← entries.mapM fun entry => IO.ofExcept (do
  let path ← text entry "path"
  let kind ← text entry "kind"
  if kind == "pdf" then
   let pages ← (← items entry "pages").mapM fun j => do
    match j with
    | .null => return none
    | _ => return some (← j.getStr?)
   return SurfaceInput.mk path pages []
  else
   let events ← (← items entry "events").mapM fun j => do
    let a ← j.getArr?
    let tag ← a[0]!.getStr?
    let value ← a[1]!.getStr?
    if tag == "start" then return NuclideCarrierSurface.Event.startTag value
    else if tag == "end" then return NuclideCarrierSurface.Event.endTag value
    else return NuclideCarrierSurface.Event.data value
   return SurfaceInput.mk path [] events)
 let (summary,checks) ← IO.ofExcept (exactCarrierAnalysis analysis files surfaces)
 let omission := match exactCarrierAnalysis analysis files surfaces true with
  | .error e => e
  | .ok _ => "ERROR: omission accepted"
 let cases ← IO.ofExcept (items input "clean_cases")
 let clean ← cases.mapM fun j => do
  let value ← IO.ofExcept j.getStr?
  return SFT.Host.Canonical.Value.text (NuclideCarrierSurface.clean value)
 let output : CJ := .object [("analysis",summary),
  ("checks",.object (checks.map fun (k,v) => (k,.boolean v))),
  ("omission_error",.text omission),("clean",.array clean)]
 IO.println (SFT.Host.Canonical.render output)
