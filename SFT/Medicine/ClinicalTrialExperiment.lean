import SFT.Medicine.ClinicalTrialEvidence
import SFT.Medicine.PatientIdentitySeal
import SFT.Medicine.ClinicalTrialSource
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Medicine.ClinicalTrialExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-MED-CLINICAL-TRIAL-001"
def experimentId : String := "SFT-EXP-MED-CLINICAL-TRIAL-001-E1"
def targetId : String := "sft-med-clinical-trial-001-authority-correspondence"
def expectedLabel : String := "medicine:eligible-participant-traces__prospective-allocation-and-outcome__protocol-arms-flow-and-analysis__registered-setting-time-and-endpoints"
def falsification : String := "Reject if any registered authoritative medical source contradicts a required relation, if another generated form preserves every dimension, or if any patient, arm, outcome, adverse, null, missing, consent or provenance distinction is erased."
def exactResult : String := "eligible-participant-traces__prospective-allocation-and-outcome__protocol-arms-flow-and-analysis__registered-setting-time-and-endpoints__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule"
def sourceIds : List String := ["MED-ICH-E6R3-001","MED-STROBE-001","MED-COCHRANE-MISSING-EVIDENCE-001"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-MED-CLINICAL-TRIAL-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "medicine-observation",.text "medicine:eligible-participant-traces__prospective-allocation-and-outcome__protocol-arms-flow-and-analysis__registered-setting-time-and-endpoints"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def registration (preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-MED-CLINICAL-TRIAL-001-E1"),("claim_id",.text "SFT-MED-CLINICAL-TRIAL-001"),("frozen_relation",.text "eligible-participant-traces__prospective-allocation-and-outcome__protocol-arms-flow-and-analysis__registered-setting-time-and-endpoints__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule"),("target_id",.text "sft-med-clinical-trial-001-authority-correspondence"),("source_references",.array [.array [.text "MED-ICH-E6R3-001",.text "https://database.ich.org/sites/default/files/ICH_E6%28R3%29_Step4_FinalGuideline_2025_0106.pdf",.text "experiments/external_sources/medicine/snapshots/MED-ICH-E6R3-001.pdf",.text "sha256:e6ce19e36ce7d2e294f89ee89492b9e035178c3cca48984392bbd92eec9b002c"],.array [.text "MED-STROBE-001",.text "https://www.strobe-statement.org/",.text "experiments/external_sources/medicine/snapshots/MED-STROBE-001.html",.text "sha256:420432c148d01e7aaaab8f7bcb4bcbc4412d028aa50cd7814fc1b058faf1cf7c"],.array [.text "MED-COCHRANE-MISSING-EVIDENCE-001",.text "https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-13",.text "experiments/external_sources/medicine/snapshots/MED-COCHRANE-MISSING-EVIDENCE-001.html",.text "sha256:9ebd35b49c689f1b12fa3919051ea9a5ed315b168d9eaec7b1eb8860317d07bb"]]),("required_fragments",.array [.array [.text "MED-ICH-E6R3-001",.text "quality by design"],.array [.text "MED-STROBE-001",.text "what was done"],.array [.text "MED-STROBE-001",.text "what was found"],.array [.text "MED-COCHRANE-MISSING-EVIDENCE-001",.text "missing evidence"]]),("pre_source_seal_path",.text "experiments/sealed_predictions/medicine_foundation_complete_pre_source.json"),("pre_source_seal_hash",.text preSourceSeal),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-MED-CLINICAL-TRIAL-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "medicine-observation",.text "medicine:eligible-participant-traces__prospective-allocation-and-outcome__protocol-arms-flow-and-analysis__registered-setting-time-and-endpoints"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("expected_observation_label",.text "medicine:eligible-participant-traces__prospective-allocation-and-outcome__protocol-arms-flow-and-analysis__registered-setting-time-and-endpoints"),("falsification_condition",.text "Reject if any registered authoritative medical source contradicts a required relation, if another generated form preserves every dimension, or if any patient, arm, outcome, adverse, null, missing, consent or provenance distinction is erased."),("all_source_rows_required",.boolean true),("source_content_absent_until_after_complete_branch_seal",.boolean true),("target_inaccessible_before_prediction_seal",.boolean true),("failed_source_transports_and_content_responses_preserved",.boolean true)]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-erased-aggregate-or-answer-only",false),("eligible-participant-traces",true)]),("relation",[("relation-imported-fitted-or-erased",false),("prospective-allocation-and-outcome",true)]),("organization",[("organization-collapsed",false),("protocol-arms-flow-and-analysis",true)]),("observation",[("observation-boundary-unrecorded",false),("registered-setting-time-and-endpoints",true)]),("record",[("favorable-result-without-complete-record",false),("complete-protocol-state-transition-adverse-null-record",true)]),("provenance",[("authority-consensus-prior-or-target-selected-law",false),("root-bound-forward-forcing",true)]),("generality",[("single-patient-favorable-study",false),("positive-finite-successor-and-unfavorable-closure",true)]),("extension",[("free-fit-exception-opaque-model-or-extra-rule",false),("no-extra-rule",true)])]
def witnesses : List Bool := [ClinicalTrial.carrierWitness,ClinicalTrial.relationWitness,ClinicalTrial.boundaryWitness]
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
 if ClinicalTrialEvidence.dependencies.isEmpty || !(SFT.Biology.LifeOrganizationSource.distinctIds ClinicalTrialEvidence.dependencies) then
  throw "Medicine dependencies are empty or repeated"
 if !(witnesses.all id) then throw "Medicine operational witness failed"
 let expected := (ClinicalTrialSource.requirements.map (fun requirement => requirement.sourceId)).foldl
  (fun acc value => if acc.any (Text.equal value) then acc else acc++[value]) []
 if sourceIds.isEmpty || !(Text.equal (Canonical.render (.array (sourceIds.map Value.text))) (Canonical.render (.array (expected.map Value.text)))) then
  throw "Medicine source identities differ from the registered binding"
 if !Text.equal targetId "sft-med-clinical-trial-001-authority-correspondence" then throw "Medicine target identity is invalid"
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
end SFT.Medicine.ClinicalTrialExperiment
