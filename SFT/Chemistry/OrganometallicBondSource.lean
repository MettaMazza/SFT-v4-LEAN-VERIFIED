import SFT.Chemistry.OrganometallicBondPrediction
import SFT.Chemistry.JointCorrelationComparison
namespace SFT.Chemistry.OrganometallicBondSource
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open OrganometallicBondPrediction (get equal)
abbrev J := Canonical.Value

def identityKeys : List String := ["target_id", "source_record_ordinal", "source_id", "authority", "registered_identity", "source_record_role", "custody_class"]
def predictionMap (output : Value) : Except String JointCorrelationComparison.Predictions := do
 let entries ← match output with
  | .table entries => pure entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "INORG-010 prediction is not the complete twelve-row table"
 if entries.length != 12 then throw "INORG-010 prediction is not the complete twelve-row table"
 let resolved ← entries.foldlM (fun resolved (key,value) => do
  match key with
  | .label h => match value with
   | .word cells =>
    if !Text.equal h.family "target-id" || cells.length != 11 then throw "INORG-010 prediction row is incomplete"
    pure (JointCorrelationComparison.store resolved h.label value)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .table _ | .pair _ _ => throw "INORG-010 prediction row is incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .table _ | .pair _ _ => throw "INORG-010 prediction row is incomplete") []
 if resolved.length != 12 then throw "INORG-010 prediction duplicates a target"
 return resolved

def checkHashes (files : List (String × String × String)) : Except String Unit := do
 files.forM fun (path,expected,actual) => do
  if !Text.equal actual expected then throw "INORG-010 post-seal evidence changed"
  pure ()

def bindTarget (identity target : J) : Except String J := do
 let bound ← identityKeys.mapM fun key => do
  let wanted ← field identity key
  pure (equal wanted (get target key))
 if !(bound.all id) then throw "INORG-010 target differs from registered identity"
 let inscription := get target "source_outcome"
 let payload := Canonical.Value.array [← field identity "target_id",← field identity "source_record_role",inscription]
 if !equal (get target "target_payload_hash") (.text (Canonical.identity payload)) then
  throw "INORG-010 target payload hash changed"
 return target

def sourceRows (files : List (String × String × String)) (identityActual : String)
 (identityDocument targetDocument : J) : Except String (List J) := do
 checkHashes files
 let identities ← OrganometallicBondPrediction.identities identityActual identityDocument
 let targets := match get targetDocument "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if !equal (get targetDocument "complete_registered_target_count") (.integer 12) ||
  !equal (get targetDocument "release_requires_prediction_seal") (.boolean true) || targets.length != 12 then
  throw "INORG-010 target vector is incomplete"
 (identities.zip targets).mapM fun (identity,target) => bindTarget identity target
end SFT.Chemistry.OrganometallicBondSource
