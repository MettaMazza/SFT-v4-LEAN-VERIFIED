import SFT.Chemistry.ExtendedExtraction
namespace SFT.Chemistry.MultiSourceExtraction
open SFT.Host SFT.Host.Canonical SourceExtraction ExtendedExtraction
-- JSON decoding and the original HTML decoding/extraction are supplied by the source IO adapter.
structure Document where
 snapshot : SourceExtraction.Snapshot
 htmlCorpus : String

def goldbookCorpus (document : Value) (code : String) : Except String String := do
 let term := get document "term" (.object [])
 if !isObject term || !Text.equal (render (field term "code")) (render (.text code)) || !Text.equal (textField term "status") "current" then
  throw "IUPAC Gold Book identity or current status differs from registration"
 match definitionAndNotes term with
 | .ok text => pure text
 | .error message =>
   if Text.equal message "IUPAC definition support is invalid" then throw "IUPAC Gold Book definitions are invalid"
   else if Text.equal message "IUPAC definition row is invalid" then throw "IUPAC Gold Book definition row is invalid"
   else throw "IUPAC Gold Book notes are invalid"

def exactKeys (value : Value) (keys : List String) : Bool := match value with
 | .object fields => fields.length == keys.length && keys.all (fun k => fields.any (fun f => Text.equal f.1 k))
 | .text _ | .integer _ | .boolean _ | .null | .array _ => false

def loadDocuments (sources : List Document) : List Value → List (String × String) → List Value → Except String (List (String × String) × List Value)
 | [], corpora, receipts => .ok (corpora,receipts)
 | doc::rest, corpora, receipts => do
   if !exactKeys doc ["kind","term_code","snapshot_path","snapshot_hash"] then
    throw "multi-source Chemistry support document is invalid"
   let path := strValue (field doc "snapshot_path")
   let source ← match sources.find? (fun s => Text.equal s.snapshot.path path) with
    | some s => pure s
    | none => throw "registered Chemistry snapshot file is absent"
   let digest := Text.append "sha256:" (SHA256Window.digest source.snapshot.bytes)
   if !Text.equal digest (textField doc "snapshot_hash") then throw "multi-source Chemistry support document differs from registration"
   let kind := strValue (field doc "kind")
   let code := strValue (field doc "term_code")
   if corpora.any (fun p => Text.equal p.1 code) then throw "multi-source Chemistry document identity repeats"
   let corpus ← if Text.equal kind "goldbook-json" then goldbookCorpus source.snapshot.document code
    else if Text.equal kind "official-html" then pure source.htmlCorpus
    else throw "unregistered authoritative Chemistry document kind"
   loadDocuments sources rest (corpora++[(code,corpus)]) (receipts++[.object [("term_code",.text code),("snapshot_hash",.text digest)]])

def nonemptyArray (value : Value) (message : String) : Except String (List Value) := match value with
 | .array (x::xs) => .ok (x::xs)
 | .array [] | .text _ | .integer _ | .boolean _ | .null | .object _ => .error message

def featureValid (corpora : List (String × String)) (feature : Value) : Bool :=
 exactKeys feature ["document","required_fragment","normalized_feature"] &&
 ["document","required_fragment","normalized_feature"].all (fun k => match field feature k with
  | .text s => SourceText.nonblank s
  | .integer _ | .boolean _ | .null | .array _ | .object _ => false) &&
 match corpora.find? (fun p => Text.equal p.1 (textField feature "document")) with
 | none => false
 | some row => Text.contains (SourceText.casefold row.2) (SourceText.casefold (textField feature "required_fragment"))

def resolve (reference : Reference) (observation : Value) (sources : List Document) : Except String Resolved := do
 if !isObject observation || !Text.equal (textField observation "source_id") reference.sourceId then
  throw "registered multi-source Chemistry target is absent or changed"
 let documents ← nonemptyArray (field observation "support_documents") "multi-source Chemistry support documents are absent"
 let (corpora,receipts) ← loadDocuments sources documents [] []
 match documents.find? (fun d => Text.equal (textField d "snapshot_path") reference.snapshotPath) with
 | none => throw "primary Chemistry target snapshot differs from claim binding"
 | some d => if !Text.equal (textField d "snapshot_hash") reference.snapshotHash then throw "primary Chemistry target snapshot differs from claim binding"
 let features ← nonemptyArray (field observation "ordered_feature_extractions") "multi-source Chemistry feature extraction is absent"
 features.forM fun f => if featureValid corpora f then pure () else throw "multi-source Chemistry feature is invalid or not reproduced by official text"
 let label := Text.intercalate "__" (features.map (fun f => textField f "normalized_feature"))
 pure ⟨reference,label,identity (.array [.text reference.targetId,observation,.text label,.array receipts])⟩

def resolveAll (registry : Value) (references : List Reference) (sources : List Document) : Except String (List Resolved) := do
 if !Text.equal (textField registry "schema") "sft-v3-chemistry-multi-source-authority-observations/1" then
  throw "multi-source Chemistry observation registry schema is invalid"
 let rows ← match field registry "observations" with
 | .array xs => pure xs
 | .text _ | .integer _ | .boolean _ | .null | .object _ => throw "multi-source Chemistry observation rows are invalid"
 rows.forM checkTargetKey
 if !(rows.all isObject) || !uniqueValues (rows.map targetKey) then throw "multi-source Chemistry registry contains duplicate or invalid rows"
 references.mapM fun reference => do
  let observation := match rows.find? (fun r => Text.equal (textField r "target_id") reference.targetId) with
   | none => .null
   | some row => row
  resolve reference observation sources
end SFT.Chemistry.MultiSourceExtraction
