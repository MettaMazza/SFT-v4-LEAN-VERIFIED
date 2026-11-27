import SFT.Chemistry.NucleophilicAnalysis
namespace SFT.Chemistry.NucleophilicSource
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
abbrev J := Canonical.Value

def identities (actualHash : String) (document : J) : Except String (List J) := do
 if !Text.equal actualHash "sha256:5dcb77e93b457fc4c02e93c3b8aac171d0813ecee72c8046e2cef36a2c585bff" then
  throw "ORG-007 identity registry changed"
 let rows := match get document "rows" with
  | .array xs => xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if rows.length != 9 || !equal (get document "external_values_or_outcomes_used_by_candidate_generator_or_eliminator") (.boolean false) then
  throw "ORG-007 value-free identity boundary changed"
 return rows

def sourceRows (targetActual identityActual : String) (identityDocument targetDocument : J)
 (snapshotHashes : List (String × String)) : Except String (List J) := do
 if !Text.equal targetActual "sha256:f5ab1d106f19f9d5a6208d0eec94cd5da2eb6d367cd4d3f9b1812fec145d7853" then
  throw "ORG-007 complete external vector changed"
 let ids ← identities identityActual identityDocument
 let rows := match get targetDocument "rows" with
  | .array xs => xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if rows.length != 9 || !equal (get targetDocument "complete_registered_target_count") (.integer 9) ||
  !equal (get targetDocument "all_favourable_adverse_absent_and_unresolved_rows_preserved") (.boolean true) then
  throw "ORG-007 complete target vector is incomplete"
 (ids.zip rows).mapM fun (identity,row) => do
  let aligned ← ["target_id","source_id","authority","registered_identity","source_record_role","custody_class"].mapM fun key => do
   return equal (← field identity key) (get row key)
  if !(aligned.all id) then throw "ORG-007 target identity changed after sealing"
  let path ← field row "opened_snapshot_path" >>= text
  let actual ← match snapshotHashes.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "missing source hash: " path)
   | some p => .ok p.2
  if !equal (.text actual) (← field row "opened_snapshot_sha256") then throw "ORG-007 source snapshot changed"
  let expected := Canonical.identity (.array [← field row "target_id",← field row "source_record_role",← field row "source_outcome"])
  if !equal (get row "target_payload_hash") (.text expected) then throw "ORG-007 source outcome payload changed"
  return row
end SFT.Chemistry.NucleophilicSource
