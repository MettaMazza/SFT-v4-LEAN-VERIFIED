import SFT.Biology.InsideOutsideValidation
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
def sourceReceiptHash : Except String String := do
 let receipts ← SFT.Biology.InsideOutsideSource.requirements.mapM fun requirement => do
  let source ← match SFT.Biology.CompartmentSource.sources.find? (fun s => SFT.Host.Text.equal s.sourceId requirement.sourceId) with
   | none => throw "missing registered source"
   | some source => pure source
  let folded := SFT.Chemistry.SourceText.casefold requirement.fragment
  return SFT.Host.Canonical.Value.array [.text requirement.sourceId,.text source.digest,.text requirement.fragment,
   .text (SFT.Host.Canonical.identity (.array [.text requirement.sourceId,.text folded]))]
 return SFT.Host.Canonical.identity (.array receipts)
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/insideoutside1166_resolved_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let result ← IO.ofExcept (do
  let before ← field input "before" >>= protectedSnapshot
  let after ← field input "after" >>= protectedSnapshot
  let sourceSeal ← text input "verified_source_seal"
  SFT.Biology.InsideOutsideExperiment.validateSpec
  let registrationHash := SFT.Host.Canonical.identity (SFT.Biology.InsideOutsideExperiment.registration sourceSeal)
  let program ← CapabilityDocuments.loadProgramFields SFT.Biology.InsideOutsideExperiment.programFields
  let derivationSeal ← text input "derivation_seal"
  let inputs ← SFT.Biology.InsideOutsideValidation.inputValues derivationSeal
  let extractionHash ← sourceReceiptHash
  SFT.Biology.InsideOutsideValidation.validateResolved registrationHash program inputs
   SFT.Biology.InsideOutsideSource.expectedLabel extractionHash derivationSeal
   (← text input "host") (← text input "implementation") before after)
 IO.println (SFT.Host.Canonical.render result)
