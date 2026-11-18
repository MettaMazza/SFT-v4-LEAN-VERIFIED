import SFT.Chemistry.ActivityAmountEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.ActivityAmountExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-ACTIVITY-AMOUNT-TIME-003"
def experimentId : String := "SFT-EXP-CHEM-ACTIVITY-AMOUNT-TIME-003"
def expectedLabel : String := "complete-activity-amount-time-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any identity, amount form, event, interval, activity, reference time, uncertainty, correction, adverse or unavailable row, page or byte is omitted; or a measurement selects the law."
def sourceIds : List String := ["NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025","NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025","NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4324C-URANIUM-232-2025","NUCHEM-001-004-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-003-IDENTITY","SFT-CHEM-NUCHEM-003-AMOUNT-FORMS","SFT-CHEM-NUCHEM-003-ACTIVITY-UNIT","SFT-CHEM-NUCHEM-003-REFERENCE-TIME","SFT-CHEM-NUCHEM-003-MASSIC-ACTIVITY","SFT-CHEM-NUCHEM-003-UNCERTAINTY","SFT-CHEM-NUCHEM-003-TIME-RELATION","SFT-CHEM-NUCHEM-003-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ACTIVITY-AMOUNT-TIME-003-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-activity-amount-time-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-ACTIVITY-AMOUNT-TIME-003"),("claim_id",.text "SFT-CHEM-ACTIVITY-AMOUNT-TIME-003"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-nuclide-species__positive-counted-initial-occurrences__positive-counted-transformations__positive-counted-resource-intervals__exact-transformations-per-resource__positive-Take-or-EmptyOne-retained-amount__complete-activity-amount-time-vector__ledger-successor-recomputes-relation"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-003-IDENTITY",.text "NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025",.text "identity",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-003-AMOUNT-FORMS",.text "NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025",.text "amount forms",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-003-ACTIVITY-UNIT",.text "NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025",.text "activity unit",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-003-REFERENCE-TIME",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "reference time",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-003-MASSIC-ACTIVITY",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "massic activity",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-003-UNCERTAINTY",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "uncertainty",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-003-TIME-RELATION",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "time relation",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-003-COMPLETE-SOURCES",.text "NUCHEM-001-004-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ACTIVITY-AMOUNT-TIME-003-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-activity-amount-time-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-activity-amount-time-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any identity, amount form, event, interval, activity, reference time, uncertainty, correction, adverse or unavailable row, page or byte is omitted; or a measurement selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("anonymous-activity-number",false),("held-nuclide-species",true)]),("amount",[("continuum-amount-premise",false),("positive-counted-initial-occurrences",true)]),("events",[("expected-decay-number",false),("positive-counted-transformations",true)]),("time",[("continuous-time-premise",false),("positive-counted-resource-intervals",true)]),("activity",[("fitted-decay-constant",false),("exact-transformations-per-resource",true)]),("remaining",[("signed-amount-difference",false),("positive-Take-or-EmptyOne-retained-amount",true)]),("record",[("selected-reference-time",false),("complete-activity-amount-time-vector",true)]),("extension",[("differential-equation-premise",false),("ledger-successor-recomputes-relation",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if ActivityAmountEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([ActivityAmountTime.identityWitness,ActivityAmountTime.amountWitness,ActivityAmountTime.eventsWitness,
  ActivityAmountTime.timeWitness,ActivityAmountTime.activityWitness,ActivityAmountTime.remainingWitness,
  ActivityAmountTime.absenceWitness,ActivityAmountTime.successorWitness].all id) then throw "Chemistry operational witness failed"
 return ()
#print axioms claimId
#print axioms experimentId
#print axioms expectedLabel
#print axioms falsification
#print axioms sourceIds
#print axioms targetIds
#print axioms snapshotHashes
#print axioms predictionDocument
#print axioms registration
#print axioms programFields
#print axioms labelValue
#print axioms envelope
#print axioms dimensions
#print axioms distinct
#print axioms validateSpec
end SFT.Chemistry.ActivityAmountExperiment
