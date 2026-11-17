import SFT.Chemistry.XrayDiffractionValidation
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

def decodeDocument : Nat → Lean.Json → Except String XrayDiffractionJSON.Document
 | 0,_ => .error "document nesting exceeds input byte count"
 | n+1,j => do
  let a ← j.getArr?
  let tag ← a[0]!.getStr?
  if tag=="null" then return .scalar .null
  else if tag=="text" then return .scalar (.text (← a[1]!.getStr?))
  else if tag=="integer" then return .scalar (.integer (← a[1]!.getInt?))
  else if tag=="boolean" then return .scalar (.boolean (← a[1]!.getBool?))
  else if tag=="decimal" then return .decimal (← a[1]!.getStr?)
  else if tag=="array" then
   let xs ← a[1]!.getArr?
   return .array (← xs.toList.mapM (decodeDocument n))
  else if tag=="object" then
   let fs ← a[1]!.getArr?
   return .object (← fs.toList.mapM fun field => do
    let pair ← field.getArr?
    return (← pair[0]!.getStr?,← decodeDocument n pair[1]!))
  else throw "unknown external document node"

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
open SFT.Chemistry.NuclideCarrierAnalysis
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/xray1163_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let analysis ← IO.ofExcept (field input "analysis_document" >>= decodeDocument (raw.utf8ByteSize+1))
 let ocrDocument ← IO.ofExcept (field input "ocr_document" >>= decodeDocument (raw.utf8ByteSize+1))
 let ocr := XrayDiffractionJSON.view ocrDocument
 let files ← (XrayDiffractionAnalysis.authorities++XrayDiffractionAnalysis.artifacts).mapM fun (path,_) => do
  let bytes ← IO.FS.readBinFile ("work/pinned1163/" ++ path)
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
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let result ← IO.ofExcept (SFT.Chemistry.XrayDiffractionValidation.validate analysis ocr files surfaces derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result)
