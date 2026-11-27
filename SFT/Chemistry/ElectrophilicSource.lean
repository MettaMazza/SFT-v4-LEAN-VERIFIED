import SFT.Chemistry.ElectrophilicAnalysis
namespace SFT.Chemistry.ElectrophilicSource
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
abbrev J := Canonical.Value

def identities (actualHash : String) (document : J) : Except String (List J) := do
 if !Text.equal actualHash "sha256:d718044a43d35b2c2a01a419359cb1316053e6ec684d3dd10d4685565082b453" then
  throw "ORG-008 identity changed"
 let rows := match get document "rows" with
  | .array xs => xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if rows.length != 4 || !equal (get document "external_values_or_outcomes_used_by_candidate_generator_or_eliminator") (.boolean false) then
  throw "ORG-008 identity boundary changed"
 return rows

def sourceRows (targetActual identityActual : String) (identityDocument targetDocument : J)
 (snapshotHashes : List (String × String)) : Except String (List J) := do
 if !Text.equal targetActual "sha256:41d6d0aed51dec5720ea0553351c9ec72e06e22c037bc0025ca012398787d08d" then
  throw "ORG-008 target vector changed"
 let ids ← identities identityActual identityDocument
 let rows := match get targetDocument "rows" with
  | .array xs => xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if rows.length != 4 ||
  !equal (get targetDocument "all_favourable_adverse_absent_and_unresolved_rows_preserved") (.boolean true) then
  throw "ORG-008 target vector incomplete"
 (ids.zip rows).mapM fun (identity,row) => do
  let aligned ← ["target_id","source_id","authority","registered_identity","source_record_role","custody_class"].mapM fun key => do
   return equal (← field identity key) (get row key)
  if !(aligned.all id) then throw "ORG-008 target identity changed"
  let path ← field row "opened_snapshot_path" >>= text
  let actual ← match snapshotHashes.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "missing source hash: " path)
   | some p => .ok p.2
  if !equal (.text actual) (← field row "opened_snapshot_sha256") then throw "ORG-008 snapshot changed"
  let expected := Canonical.identity (.array [← field row "target_id",← field row "source_record_role",← field row "source_outcome"])
  if !equal (get row "target_payload_hash") (.text expected) then throw "ORG-008 target payload changed"
  return row
end SFT.Chemistry.ElectrophilicSource
