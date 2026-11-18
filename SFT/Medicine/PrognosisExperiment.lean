import SFT.Medicine.PrognosisEvidence
import SFT.Medicine.PatientIdentitySeal
import SFT.Medicine.PrognosisSource
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Medicine.PrognosisExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-MED-PROGNOSIS-001"
def experimentId : String := "SFT-EXP-MED-PROGNOSIS-001-E1"
def targetId : String := "sft-med-prognosis-001-authority-correspondence"
def expectedLabel : String := "medicine:patient-baseline-state__baseline-to-future-outcome-support__conditioned-course-alternatives__care-context-horizon-and-censoring"
def falsification : String := "Reject if any registered authoritative medical source contradicts a required relation, if another generated form preserves every dimension, or if any patient, arm, outcome, adverse, null, missing, consent or provenance distinction is erased."
def exactResult : String := "patient-baseline-state__baseline-to-future-outcome-support__conditioned-course-alternatives__care-context-horizon-and-censoring__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule"
def sourceIds : List String := ["MED-FDA-BIOMARKER-001","MED-ICH-E9R1-001"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-MED-PROGNOSIS-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "medicine-observation",.text "medicine:patient-baseline-state__baseline-to-future-outcome-support__conditioned-course-alternatives__care-context-horizon-and-censoring"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def registration (preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-MED-PROGNOSIS-001-E1"),("claim_id",.text "SFT-MED-PROGNOSIS-001"),("frozen_relation",.text "patient-baseline-state__baseline-to-future-outcome-support__conditioned-course-alternatives__care-context-horizon-and-censoring__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule"),("target_id",.text "sft-med-prognosis-001-authority-correspondence"),("source_references",.array [.array [.text "MED-FDA-BIOMARKER-001",.text "https://www.fda.gov/drugs/biomarker-qualification-program/about-biomarkers-and-qualification",.text "experiments/external_sources/medicine/snapshots/MED-FDA-BIOMARKER-001.html",.text "sha256:93c5ee4b5e3480ed27aa805a7739f4acf7108701fc6f429ae5d4e5a1ad9d3d31"],.array [.text "MED-ICH-E9R1-001",.text "https://database.ich.org/sites/default/files/E9-R1_Step4_Guideline_2019_1203.pdf",.text "experiments/external_sources/medicine/snapshots/MED-ICH-E9R1-001.pdf",.text "sha256:f7471f411f1c87ee76783d5b2b9faaeca31d01d530213f71b50d136b39e3b0d9"]]),("required_fragments",.array [.array [.text "MED-FDA-BIOMARKER-001",.text "susceptibility/risk"],.array [.text "MED-FDA-BIOMARKER-001",.text "prognostic"],.array [.text "MED-ICH-E9R1-001",.text "population of interest"],.array [.text "MED-ICH-E9R1-001",.text "intercurrent events"]]),("pre_source_seal_path",.text "experiments/sealed_predictions/medicine_foundation_complete_pre_source.json"),("pre_source_seal_hash",.text preSourceSeal),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-MED-PROGNOSIS-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "medicine-observation",.text "medicine:patient-baseline-state__baseline-to-future-outcome-support__conditioned-course-alternatives__care-context-horizon-and-censoring"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("expected_observation_label",.text "medicine:patient-baseline-state__baseline-to-future-outcome-support__conditioned-course-alternatives__care-context-horizon-and-censoring"),("falsification_condition",.text "Reject if any registered authoritative medical source contradicts a required relation, if another generated form preserves every dimension, or if any patient, arm, outcome, adverse, null, missing, consent or provenance distinction is erased."),("all_source_rows_required",.boolean true),("source_content_absent_until_after_complete_branch_seal",.boolean true),("target_inaccessible_before_prediction_seal",.boolean true),("failed_source_transports_and_content_responses_preserved",.boolean true)]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-erased-aggregate-or-answer-only",false),("patient-baseline-state",true)]),("relation",[("relation-imported-fitted-or-erased",false),("baseline-to-future-outcome-support",true)]),("organization",[("organization-collapsed",false),("conditioned-course-alternatives",true)]),("observation",[("observation-boundary-unrecorded",false),("care-context-horizon-and-censoring",true)]),("record",[("favorable-result-without-complete-record",false),("complete-protocol-state-transition-adverse-null-record",true)]),("provenance",[("authority-consensus-prior-or-target-selected-law",false),("root-bound-forward-forcing",true)]),("generality",[("single-patient-favorable-study",false),("positive-finite-successor-and-unfavorable-closure",true)]),("extension",[("free-fit-exception-opaque-model-or-extra-rule",false),("no-extra-rule",true)])]
def witnesses : List Bool := [Prognosis.carrierWitness,Prognosis.relationWitness,Prognosis.boundaryWitness]
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
 if PrognosisEvidence.dependencies.isEmpty || !(SFT.Biology.LifeOrganizationSource.distinctIds PrognosisEvidence.dependencies) then
  throw "Medicine dependencies are empty or repeated"
 if !(witnesses.all id) then throw "Medicine operational witness failed"
 let expected := (PrognosisSource.requirements.map (fun requirement => requirement.sourceId)).foldl
  (fun acc value => if acc.any (Text.equal value) then acc else acc++[value]) []
 if sourceIds.isEmpty || !(Text.equal (Canonical.render (.array (sourceIds.map Value.text))) (Canonical.render (.array (expected.map Value.text)))) then
  throw "Medicine source identities differ from the registered binding"
 if !Text.equal targetId "sft-med-prognosis-001-authority-correspondence" then throw "Medicine target identity is invalid"
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
end SFT.Medicine.PrognosisExperiment
