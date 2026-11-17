import SFT.Chemistry.CoordinationPrediction
import SFT.Chemistry.JointCorrelationComparison
namespace SFT.Chemistry.CoordinationSource
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationPrediction (get equal)
abbrev J := Canonical.Value

def identityKeys : List String := ["target_id","source_record_ordinal","authority","source_document_identity","source_record_role"]
def predictionMap (output : Value) : Except String JointCorrelationComparison.Predictions := do
 let entries ← match output with
  | .table entries => pure entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "INORG-001 prediction is not the complete 20-record table"
 if entries.length != 20 then throw "INORG-001 prediction is not the complete 20-record table"
 let resolved ← entries.foldlM (fun resolved (key,value) => do
  match key with
  | .label h => match value with
   | .word cells =>
    if !Text.equal h.family "target-id" || cells.length != 8 then throw "INORG-001 prediction lost a complete consequence"
    pure (JointCorrelationComparison.store resolved h.label value)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .table _ | .pair _ _ => throw "INORG-001 prediction lost a complete consequence"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .table _ | .pair _ _ => throw "INORG-001 prediction lost a complete consequence") []
 if resolved.length != 20 then throw "INORG-001 duplicated a target identity"
 return resolved

def checkHashes (files : List (String × String × String)) : Except String Unit := do
 files.forM fun (path,expected,actual) => do
  if !Text.equal actual expected then throw (Text.append "INORG-001 source changed: " path)
  pure ()

def bindTarget (identity target : J) : Except String J := do
 let bound ← identityKeys.mapM fun key => do
  let wanted ← field identity key
  pure (equal wanted (get target key))
 if !(bound.all id) then throw "INORG-001 identity/target binding changed"
 let inscription ← match get target "source_inscription" with
  | .text s => if s.isEmpty then throw "INORG-001 target inscription absent" else pure s
  | .null | .boolean _ | .integer _ | .array _ | .object _ => throw "INORG-001 target inscription absent"
 let payload := Canonical.Value.array [← field identity "target_id",← field identity "source_record_role",.text inscription]
 if !equal (get target "target_payload_hash") (.text (Canonical.identity payload)) then
  throw "INORG-001 target payload hash changed"
 return target

def sourceRows (files : List (String × String × String)) (identityActual : String)
 (identityDocument targetDocument : J) : Except String (List J) := do
 checkHashes files
 let identities ← CoordinationPrediction.identities identityActual identityDocument
 let targets := match get targetDocument "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if !equal (get targetDocument "complete_registered_target_count") (.integer 20) ||
  !equal (get targetDocument "release_requires_prediction_seal") (.boolean true) || targets.length != 20 then
  throw "INORG-001 target registry changed"
 (identities.zip targets).mapM fun (identity,target) => bindTarget identity target
end SFT.Chemistry.CoordinationSource
