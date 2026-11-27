import SFT.Chemistry.DefectPrediction
import SFT.Chemistry.JointCorrelationComparison
namespace SFT.Chemistry.DefectSource
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open DefectPrediction (get equal)
abbrev J := Canonical.Value

def identityKeys : List String := ["target_id", "source_record_ordinal", "source_id", "authority", "registered_identity", "source_record_role", "custody_class"]
def predictionMap (output : Value) : Except String JointCorrelationComparison.Predictions := do
 let entries ← match output with
  | .table entries => pure entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "INORG-016 prediction incomplete"
 if entries.length != 15 then throw "INORG-016 prediction incomplete"
 let resolved ← entries.foldlM (fun resolved (key,value) => do
  match key with
  | .label h => match value with
   | .word cells =>
    if !Text.equal h.family "target-id" || cells.length != 11 then throw "INORG-016 prediction row incomplete"
    pure (JointCorrelationComparison.store resolved h.label value)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .table _ | .pair _ _ => throw "INORG-016 prediction row incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .table _ | .pair _ _ => throw "INORG-016 prediction row incomplete") []
 if resolved.length != 15 then throw "INORG-016 duplicate prediction target"
 return resolved

def checkHashes (files : List (String × String × String)) : Except String Unit := do
 files.forM fun (path,expected,actual) => do
  if !Text.equal actual expected then throw (Text.append "INORG-016 evidence changed: " path)
  pure ()

def bindTarget (identity target : J) : Except String J := do
 let bound ← identityKeys.mapM fun key => do
  let wanted ← field identity key
  pure (equal wanted (get target key))
 if !(bound.all id) then throw "INORG-016 identity changed after target opening"
 let inscription := get target "source_outcome"
 let payload := Canonical.Value.array [← field identity "target_id",← field identity "source_record_role",inscription]
 if !equal (get target "target_payload_hash") (.text (Canonical.identity payload)) then
  throw "INORG-016 target payload changed"
 return target

def sourceRows (files : List (String × String × String)) (identityActual : String)
 (identityDocument targetDocument : J) : Except String (List J) := do
 checkHashes files
 let identities ← DefectPrediction.identities identityActual identityDocument
 let targets := match get targetDocument "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if !equal (get targetDocument "complete_registered_target_count") (.integer 15) ||
  !equal (get targetDocument "release_requires_prediction_seal") (.boolean true) || targets.length != 15 ||
  !equal (get targetDocument "corrected_registered_roles") (.array [.text "surface-and-near-surface-bulk-role",.text "vacancy-interstitial-edge-corner-kink-examples"]) then
  throw "INORG-016 V2 target vector incomplete"
 (identities.zip targets).mapM fun (identity,target) => bindTarget identity target
end SFT.Chemistry.DefectSource
