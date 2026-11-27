import SFT.Chemistry.ConformerPopulationPrediction
import SFT.Chemistry.JointCorrelationComparison
namespace SFT.Chemistry.ConformerPopulationSource
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open ConformerPopulationPrediction (get equal)
abbrev J := Canonical.Value

def identityKeys : List String := ["target_id","source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"]
def predictionMap (output : Value) : Except String JointCorrelationComparison.Predictions := do
 let entries ← match output with
  | .table entries => pure entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "ORG-006 prediction incomplete"
 if entries.length != 14 then throw "ORG-006 prediction incomplete"
 let resolved ← entries.foldlM (fun resolved (key,value) => do
  match key with
  | .label h => match value with
   | .word cells =>
    if !Text.equal h.family "target-id" || cells.length != 11 then throw "ORG-006 prediction row incomplete"
    pure (JointCorrelationComparison.store resolved h.label value)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .table _ | .pair _ _ => throw "ORG-006 prediction row incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .table _ | .pair _ _ => throw "ORG-006 prediction row incomplete") []
 if resolved.length != 14 then throw "ORG-006 duplicate target"
 return resolved

def bindTarget (identity target : J) : Except String J := do
 let bound ← identityKeys.mapM fun key => do
  let wanted ← field identity key
  pure (equal wanted (get target key))
 if !(bound.all id) then throw "ORG-006 identity changed after target preservation"
 let payload := Canonical.Value.array [← field identity "target_id",← field identity "source_record_role",get target "source_outcome"]
 if !equal (get target "target_payload_hash") (.text (Canonical.identity payload)) then
  throw "ORG-006 target payload changed"
 return target

def sourceRows (targetActual primaryActual identityActual : String) (identityDocument targetDocument : J)
 (snapshotHashes : List (String × String)) : Except String (List J) := do
 if !Text.equal targetActual "sha256:992fd64ac240c750753fce9fabeb0487e88e6a5efadd843313f2dc96c93b3d0e" ||
    !Text.equal primaryActual "sha256:9d44c07e1f26a5dbbac7abff49187ac26feb6cd08413c6b5469e301cd0b99eb7" then
  throw "ORG-006 external evidence changed"
 let identities ← ConformerPopulationPrediction.identities identityActual identityDocument
 let targets := match get targetDocument "rows" with | .array rows => rows | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if !equal (get targetDocument "complete_registered_target_count") (.integer 14) ||
    !equal (get targetDocument "all_favourable_adverse_absent_unavailable_unresolved_signed_and_rounded_rows_preserved") (.boolean true) || targets.length != 14 then
  throw "ORG-006 complete target vector incomplete"
 (identities.zip targets).mapM fun (identity,target) => do
  let row ← bindTarget identity target
  let path ← field row "opened_snapshot_path" >>= text
  let expected ← field row "opened_snapshot_sha256" >>= text
  let actual ← match snapshotHashes.find? (fun pair => Text.equal pair.1 path) with
   | none => throw (Text.append "missing source snapshot: " path)
   | some pair => pure pair.2
  if !Text.equal actual expected then throw "ORG-006 source snapshot changed"
  return row
end SFT.Chemistry.ConformerPopulationSource
