import SFT.Chemistry.SourceText
import SFT.Host.SHA256Window
import SFT.Host.Canonical
namespace SFT.Chemistry.SourceExtraction
open SFT.Host SFT.Host.Canonical

structure Reference where
 targetId : String
 sourceId : String
 sourceLocator : String
 snapshotPath : String
 snapshotHash : String

def field (value : Value) (key : String) : Value :=
 match value with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with
   | some p => p.2
   | none => .null
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .null

def textValue : Value → String
 | .text s => s
 | .boolean _ | .integer _ | .null | .array _ | .object _ => ""
def arrayValue : Value → List Value
 | .array xs => xs
 | .text _ | .boolean _ | .integer _ | .null | .object _ => []
def textField (v : Value) (k : String) := textValue (field v k)
def unique (xs : List String) : Bool :=
 match xs with
 | [] => true
 | x::rest => !(rest.any (Text.equal x)) && unique rest

def uniqueValues : List Value → Bool
 | [] => true
 | x::rest => !(rest.any (fun y => Text.equal (render x) (render y))) && uniqueValues rest

def nonblankValue : Value → Bool
 | .text s => SourceText.nonblank s
 | .boolean _ | .integer _ | .null | .array _ | .object _ => false

def validFeature (v : Value) : Bool :=
 match v with
 | .object fields => fields.length == 2 &&
   (fields.any (fun p => Text.equal p.1 "required_fragment")) &&
   (fields.any (fun p => Text.equal p.1 "normalized_feature")) &&
   nonblankValue (field v "required_fragment") && nonblankValue (field v "normalized_feature")
 | .text _ | .boolean _ | .integer _ | .null | .array _ => false

structure Resolved where
 reference : Reference
 label : String
 extractionHash : String

def resolve (reference : Reference) (observation sourceDocument : Value)
 (snapshotBytes : ByteArray) : Except String Resolved := do
 if !Text.equal (textField observation "source_id") reference.sourceId then
  .error "Chemistry observation source identity differs from registration"
 else if !Text.equal (Text.append "sha256:" (SHA256Window.digest snapshotBytes)) reference.snapshotHash then
  .error "official Chemistry snapshot differs from registration"
 else do
  let term := field sourceDocument "term"
  if !Text.equal (render (field term "code")) (render (field observation "term_code")) ||
     !Text.equal (textField term "status") "current" then
   .error "IUPAC term identity or status differs from observation registration"
  else do
   let definition := Text.intercalate " " ((arrayValue (field term "definitions")).map (fun row => textField row "text"))
   let features := arrayValue (field observation "ordered_feature_extractions")
   if features.isEmpty || !(features.all validFeature) then
    .error "source-derived Chemistry feature extraction is invalid"
   else if features.any (fun feature => !(Text.contains (SourceText.casefold definition)
     (SourceText.casefold (textField feature "required_fragment")))) then
    .error "source-derived Chemistry target is not reproduced by the official definition"
   else
    let label := Text.intercalate "__" (features.map (fun feature => textField feature "normalized_feature"))
    .ok ⟨reference,label,identity (.array [.text reference.targetId,field term "code",.array features,.text label,.text reference.snapshotHash])⟩

-- JSON decoding is the IO boundary. These inputs retain the original bytes
-- used for hashing alongside their parsed documents.
structure Snapshot where
 path : String
 bytes : ByteArray
 document : Value

def resolveAll (registry : Value) (references : List Reference)
 (snapshots : List Snapshot) : Except String (List Resolved) := do
 if !Text.equal (textField registry "schema") "sft-v3-chemistry-source-derived-observations/1" then
  .error "Chemistry observation registry schema is invalid"
 else do
  let observations := arrayValue (field registry "observations")
  if !uniqueValues (observations.map (fun row => field row "target_id")) then
   .error "Chemistry observation registry contains duplicate target identities"
  else references.mapM fun reference => do
   match observations.find? (fun row => Text.equal (textField row "target_id") reference.targetId) with
   | none => .error "registered Chemistry target is absent from the source-derived registry"
   | some observation =>
     match snapshots.find? (fun source => Text.equal source.path reference.snapshotPath) with
     | none => .error "registered Chemistry snapshot file is absent"
     | some source => resolve reference observation source.document source.bytes

def resolvedValue (row : Resolved) : Value := .object [
 ("target_id",.text row.reference.targetId),("source_id",.text row.reference.sourceId),
 ("source_locator",.text row.reference.sourceLocator),("observed_label",.text row.label),
 ("snapshot_hash",.text row.reference.snapshotHash),("extraction_hash",.text row.extractionHash)]
end SFT.Chemistry.SourceExtraction
