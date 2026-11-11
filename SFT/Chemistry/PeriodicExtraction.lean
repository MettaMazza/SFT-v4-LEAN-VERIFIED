import SFT.Chemistry.PeriodicPDF
import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.PeriodicExtraction
open SFT.Host SFT.Host.Canonical SourceExtraction

def isArray : Value → Bool
 | .array _ => true
 | .text _ | .boolean _ | .integer _ | .null | .object _ => false

def isObject : Value → Bool
 | .object _ => true
 | .text _ | .boolean _ | .integer _ | .null | .array _ => false

structure Snapshot where
 path : String
 bytes : ByteArray
 document : Value
 streams : List ByteArray

def pdfLabel (streams : List ByteArray) (observation : Value) : Except String String := do
 let fragments := arrayValue (field observation "required_pdf_fragments")
 let features := arrayValue (field observation "ordered_features")
 if fragments.isEmpty || features.isEmpty || !(fragments.all nonblankValue) || !(features.all nonblankValue) then
  .error "periodic PDF extraction registration is invalid"
 else do
  let texts ← PeriodicPDF.texts streams
  let raw := SourceText.casefold texts.1
  let joined := SourceText.casefold texts.2
  let missing := fragments.filter (fun f =>
   let fragment := SourceText.casefold (textValue f)
   !(Text.contains raw fragment) && !(Text.contains joined fragment))
  if !missing.isEmpty then .error (Text.append "periodic PDF fragments are absent: " (Text.intercalate ", " (missing.map textValue)))
  else .ok (Text.intercalate "__" (features.map textValue))

def resolve (reference : Reference) (observation : Value) (snapshot : Snapshot) : Except String Resolved := do
 if !Text.equal (textField observation "source_id") reference.sourceId then .error "periodic observation source differs from registration"
 else if !Text.equal (Text.append "sha256:" (SHA256Window.digest snapshot.bytes)) reference.snapshotHash then
  .error "official periodic Chemistry snapshot differs from registration"
 else do
  let kind := textField observation "source_kind"
  let label ← if Text.equal kind "iupac-periodic-table-pdf" then pdfLabel snapshot.streams observation
   else if Text.equal kind "iupac-gold-book-json" then do
    if !isObject (field snapshot.document "term") then .error "IUPAC term record is invalid"
    else if !isArray (field (field snapshot.document "term") "definitions") then .error "IUPAC definition support is invalid"
    else do
     let resolved ← SourceExtraction.resolve reference observation snapshot.document snapshot.bytes
     .ok resolved.label
   else .error "unsupported mixed Chemistry source kind"
  .ok ⟨reference,label,identity (.array [.text reference.targetId,.text kind,observation,.text label,.text reference.snapshotHash])⟩

def resolveAll (registry : Value) (references : List Reference) (snapshots : List Snapshot) : Except String (List Resolved) := do
 if !Text.equal (textField registry "schema") "sft-v3-chemistry-mixed-source-derived-observations/1" then
  .error "mixed Chemistry observation registry schema is invalid"
 else if !isArray (field registry "observations") then .error "mixed Chemistry observation rows are invalid"
 else do
  let observations := arrayValue (field registry "observations")
  if !(observations.all isObject) || !uniqueValues (observations.map (fun row => field row "target_id")) then
   .error "mixed Chemistry registry contains duplicate or invalid target rows"
  else references.mapM fun reference => do
   match observations.find? (fun row => Text.equal (textField row "target_id") reference.targetId) with
   | none => .error "registered periodic target is absent from the source registry"
   | some observation =>
     match snapshots.find? (fun source => Text.equal source.path reference.snapshotPath) with
     | none => .error "registered Chemistry snapshot file is absent"
     | some snapshot => resolve reference observation snapshot
end SFT.Chemistry.PeriodicExtraction
