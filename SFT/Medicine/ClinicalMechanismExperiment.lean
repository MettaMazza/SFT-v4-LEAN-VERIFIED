import SFT.Medicine.ClinicalMechanismEvidence
import SFT.Medicine.PatientIdentitySeal
import SFT.Medicine.ClinicalMechanismSource
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Medicine.ClinicalMechanismExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-MED-CLINICAL-MECHANISM-001"
def experimentId : String := "SFT-EXP-MED-CLINICAL-MECHANISM-001-E1"
def targetId : String := "sft-med-clinical-mechanism-001-authority-correspondence"
def expectedLabel : String := "medicine:ordered-biological-clinical-mediators__exposure-to-mediator-to-outcome__noncollapsed-causal-chain__patient-condition-and-temporal-order"
def falsification : String := "Reject if any registered authoritative medical source contradicts a required relation, if another generated form preserves every dimension, or if any patient, arm, outcome, adverse, null, missing, consent or provenance distinction is erased."
def exactResult : String := "ordered-biological-clinical-mediators__exposure-to-mediator-to-outcome__noncollapsed-causal-chain__patient-condition-and-temporal-order__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule"
def sourceIds : List String := ["MED-CDC-EPIDEMIOLOGY-001","MED-STROBE-001"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-MED-CLINICAL-MECHANISM-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "medicine-observation",.text "medicine:ordered-biological-clinical-mediators__exposure-to-mediator-to-outcome__noncollapsed-causal-chain__patient-condition-and-temporal-order"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def registration (preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-MED-CLINICAL-MECHANISM-001-E1"),("claim_id",.text "SFT-MED-CLINICAL-MECHANISM-001"),("frozen_relation",.text "ordered-biological-clinical-mediators__exposure-to-mediator-to-outcome__noncollapsed-causal-chain__patient-condition-and-temporal-order__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule"),("target_id",.text "sft-med-clinical-mechanism-001-authority-correspondence"),("source_references",.array [.array [.text "MED-CDC-EPIDEMIOLOGY-001",.text "https://archive.cdc.gov/www_cdc_gov/csels/dsepd/ss1978/lesson1/summary.html",.text "experiments/external_sources/medicine/snapshots/MED-CDC-EPIDEMIOLOGY-001.html",.text "sha256:430c2d885670c185491ab9b84d1c703eeaff0eece3ddb69fc855c001fb93478b"],.array [.text "MED-STROBE-001",.text "https://www.strobe-statement.org/",.text "experiments/external_sources/medicine/snapshots/MED-STROBE-001.html",.text "sha256:420432c148d01e7aaaab8f7bcb4bcbc4412d028aa50cd7814fc1b058faf1cf7c"]]),("required_fragments",.array [.array [.text "MED-CDC-EPIDEMIOLOGY-001",.text "frequency, patterns, and causes"],.array [.text "MED-CDC-EPIDEMIOLOGY-001",.text "population and comparison"],.array [.text "MED-STROBE-001",.text "what was planned"]]),("pre_source_seal_path",.text "experiments/sealed_predictions/medicine_foundation_complete_pre_source.json"),("pre_source_seal_hash",.text preSourceSeal),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-MED-CLINICAL-MECHANISM-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "medicine-observation",.text "medicine:ordered-biological-clinical-mediators__exposure-to-mediator-to-outcome__noncollapsed-causal-chain__patient-condition-and-temporal-order"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("expected_observation_label",.text "medicine:ordered-biological-clinical-mediators__exposure-to-mediator-to-outcome__noncollapsed-causal-chain__patient-condition-and-temporal-order"),("falsification_condition",.text "Reject if any registered authoritative medical source contradicts a required relation, if another generated form preserves every dimension, or if any patient, arm, outcome, adverse, null, missing, consent or provenance distinction is erased."),("all_source_rows_required",.boolean true),("source_content_absent_until_after_complete_branch_seal",.boolean true),("target_inaccessible_before_prediction_seal",.boolean true),("failed_source_transports_and_content_responses_preserved",.boolean true)]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-erased-aggregate-or-answer-only",false),("ordered-biological-clinical-mediators",true)]),("relation",[("relation-imported-fitted-or-erased",false),("exposure-to-mediator-to-outcome",true)]),("organization",[("organization-collapsed",false),("noncollapsed-causal-chain",true)]),("observation",[("observation-boundary-unrecorded",false),("patient-condition-and-temporal-order",true)]),("record",[("favorable-result-without-complete-record",false),("complete-protocol-state-transition-adverse-null-record",true)]),("provenance",[("authority-consensus-prior-or-target-selected-law",false),("root-bound-forward-forcing",true)]),("generality",[("single-patient-favorable-study",false),("positive-finite-successor-and-unfavorable-closure",true)]),("extension",[("free-fit-exception-opaque-model-or-extra-rule",false),("no-extra-rule",true)])]
def witnesses : List Bool := [ClinicalMechanism.carrierWitness,ClinicalMechanism.relationWitness,ClinicalMechanism.boundaryWitness]
def admittedName (d : String × List (String × Bool)) : Except String String :=
 match d.2.filter Prod.snd with
 | [(name,_)] => .ok name
 | [] | _::_::_ => .error (Text.intercalate "" ["dimension ",d.1," requires one preserving form"])
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-MED-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-MED-").isPrefixOf (Text.chars experimentId) then
  throw "invalid Medicine identity"
 if dimensions.length != 8 || !(SFT.Biology.LifeOrganizationSource.distinctIds (dimensions.map Prod.fst)) then
  throw "Medicine blueprint requires eight distinct dimensions"
 if !(dimensions.all (fun d => d.2.length==2)) then throw "each Medicine dimension must exhaust two registered forms"
 let names ← dimensions.mapM admittedName
 if !Text.equal exactResult (Text.intercalate "__" names) then throw "Medicine exact result is not the unique preservation survivor"
 if ClinicalMechanismEvidence.dependencies.isEmpty || !(SFT.Biology.LifeOrganizationSource.distinctIds ClinicalMechanismEvidence.dependencies) then
  throw "Medicine dependencies are empty or repeated"
 if !(witnesses.all id) then throw "Medicine operational witness failed"
 let expected := (ClinicalMechanismSource.requirements.map ClinicalMechanismSource.Requirement.sourceId).foldl
  (fun acc value => if acc.any (Text.equal value) then acc else acc++[value]) []
 if sourceIds.isEmpty || !(Text.equal (Canonical.render (.array (sourceIds.map Value.text))) (Canonical.render (.array (expected.map Value.text)))) then
  throw "Medicine source identities differ from the registered binding"
 if !Text.equal targetId "sft-med-patient-identity-001-authority-correspondence" then throw "Medicine target identity is invalid"
 return ()
#print axioms claimId
#print axioms experimentId
#print axioms targetId
#print axioms expectedLabel
#print axioms falsification
#print axioms exactResult
#print axioms sourceIds
#print axioms predictionDocument
#print axioms programFields
#print axioms registration
#print axioms labelValue
#print axioms envelope
#print axioms dimensions
#print axioms witnesses
#print axioms admittedName
#print axioms validateSpec
end SFT.Medicine.ClinicalMechanismExperiment
