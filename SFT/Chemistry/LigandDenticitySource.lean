import SFT.Chemistry.LigandDenticityPrediction
import SFT.Chemistry.JointCorrelationComparison
namespace SFT.Chemistry.LigandDenticitySource
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open LigandDenticityPrediction (get equal)
abbrev J := Canonical.Value

def identityKeys : List String := ["target_id","source_record_ordinal","authority","source_document_identity","source_term_role","source_record_role"]
def predictionMap (output : Value) : Except String JointCorrelationComparison.Predictions := do
 let entries ← match output with
  | .table entries => pure entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "INORG-003 prediction is not the complete 24-record table"
 if entries.length != 24 then throw "INORG-003 prediction is not the complete 24-record table"
 let resolved ← entries.foldlM (fun resolved (key,value) => do
  match key with
  | .label h => match value with
   | .word cells =>
    if !Text.equal h.family "target-id" || cells.length != 9 then throw "INORG-003 prediction lost a consequence"
    pure (JointCorrelationComparison.store resolved h.label value)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .table _ | .pair _ _ => throw "INORG-003 prediction lost a consequence"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .table _ | .pair _ _ => throw "INORG-003 prediction lost a consequence") []
 if resolved.length != 24 then throw "INORG-003 duplicated a target"
 return resolved

def checkHashes (files : List (String × String × String)) : Except String Unit := do
 files.forM fun (path,expected,actual) => do
  if !Text.equal actual expected then throw (Text.append "INORG-003 source changed: " path)
  pure ()

def bindTarget (identity target : J) : Except String J := do
 let bound ← identityKeys.mapM fun key => do
  let wanted ← field identity key
  pure (equal wanted (get target key))
 if !(bound.all id) then throw "INORG-003 identity/target binding changed"
 let inscription ← match get target "source_inscription" with
  | .text s => if s.isEmpty then throw "INORG-003 target payload changed" else pure s
  | .null | .boolean _ | .integer _ | .array _ | .object _ => throw "INORG-003 target payload changed"
 let payload := Canonical.Value.array [← field identity "target_id",← field identity "source_record_role",.text inscription]
 if !equal (get target "target_payload_hash") (.text (Canonical.identity payload)) then
  throw "INORG-003 target payload changed"
 return target

def sourceRows (files : List (String × String × String)) (identityActual : String)
 (identityDocument targetDocument : J) : Except String (List J) := do
 checkHashes files
 let identities ← LigandDenticityPrediction.identities identityActual identityDocument
 let targets := match get targetDocument "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if !equal (get targetDocument "complete_registered_target_count") (.integer 24) ||
  !equal (get targetDocument "release_requires_prediction_seal") (.boolean true) || targets.length != 24 then
  throw "INORG-003 target registry changed"
 (identities.zip targets).mapM fun (identity,target) => bindTarget identity target
end SFT.Chemistry.LigandDenticitySource
