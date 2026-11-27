import SFT.Chemistry.AntiaromaticDistinctionPrediction
import SFT.Chemistry.JointCorrelationComparison
namespace SFT.Chemistry.AntiaromaticDistinctionSource
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open AntiaromaticDistinctionPrediction (get equal)
abbrev J := Canonical.Value

def identityKeys : List String := ["target_id", "source_record_ordinal", "source_id", "authority", "registered_identity", "source_record_role", "custody_class"]
def predictionMap (output : Value) : Except String JointCorrelationComparison.Predictions := do
 let entries ← match output with
  | .table entries => pure entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "ORG-004 prediction incomplete"
 if entries.length != 5 then throw "ORG-004 prediction incomplete"
 let resolved ← entries.foldlM (fun resolved (key,value) => do
  match key with
  | .label h => match value with
   | .word cells =>
    if !Text.equal h.family "target-id" || cells.length != 11 then throw "ORG-004 prediction row incomplete"
    pure (JointCorrelationComparison.store resolved h.label value)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .table _ | .pair _ _ => throw "ORG-004 prediction row incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .table _ | .pair _ _ => throw "ORG-004 prediction row incomplete") []
 if resolved.length != 5 then throw "ORG-004 duplicate prediction target"
 return resolved

def checkHashes (files : List (String × String × String)) : Except String Unit := do
 files.forM fun (path,expected,actual) => do
  if !Text.equal actual expected then throw "ORG-004 external evidence changed"
  pure ()

def bindTarget (identity target : J) : Except String J := do
 let bound ← identityKeys.mapM fun key => do
  let wanted ← field identity key
  pure (equal wanted (get target key))
 if !(bound.all id) then throw "ORG-004 identity changed after target opening"
 let inscription := get target "source_outcome"
 let payload := Canonical.Value.array [← field identity "target_id",← field identity "source_record_role",inscription]
 if !equal (get target "target_payload_hash") (.text (Canonical.identity payload)) then
  throw "ORG-004 target payload changed"
 return target

def sourceRows (files : List (String × String × String)) (identityActual : String)
 (identityDocument targetDocument : J) : Except String (List J) := do
 checkHashes (files.take 2)
 let identities ← AntiaromaticDistinctionPrediction.identities identityActual identityDocument
 let targets := match get targetDocument "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if !equal (get targetDocument "complete_registered_target_count") (.integer 5) ||
  !equal (get targetDocument "release_requires_prediction_seal") (.boolean true) || targets.length != 5 ||
  !equal (get targetDocument "all_favourable_adverse_absent_scope_and_unresolved_rows_preserved") (.boolean true) then
  throw "ORG-004 complete target vector incomplete"
 (identities.zip targets).mapM fun (identity,target) => do
  let bound ← bindTarget identity target
  let path ← field target "opened_snapshot_path" >>= text
  let expected ← field target "opened_snapshot_sha256" >>= text
  let actual ← match files.find? (fun f => Text.equal f.1 path) with
   | some f => pure f.2.2
   | none => throw (Text.append "missing source hash: " path)
  if !Text.equal actual expected then throw "ORG-004 opened snapshot changed"
  return bound
end SFT.Chemistry.AntiaromaticDistinctionSource
