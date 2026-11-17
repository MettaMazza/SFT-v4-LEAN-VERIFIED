import SFT.Chemistry.BranchYieldEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.BranchYieldExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004"
def experimentId : String := "SFT-EXP-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004"
def expectedLabel : String := "complete-radioactive-branching-chemical-yield-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any channel, daughter, branch, recovery, method, assumption, discrepancy, uncertainty, unavailable row, page or byte is omitted; or external outcomes select the law."
def sourceIds : List String := ["NIST-SRM-4324C-URANIUM-232-2025","NIST-SRM-4324C-URANIUM-232-2025","NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4324C-URANIUM-232-2025","NIST-SRM-4324C-URANIUM-232-2025","NUCHEM-001-004-SHARED-SOURCES","NUCHEM-001-004-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-004-CHANNELS","SFT-CHEM-NUCHEM-004-DAUGHTERS","SFT-CHEM-NUCHEM-004-BRANCH-FRACTIONS","SFT-CHEM-NUCHEM-004-CHEMICAL-RECOVERY","SFT-CHEM-NUCHEM-004-PARTITION","SFT-CHEM-NUCHEM-004-METHODS","SFT-CHEM-NUCHEM-004-ADVERSE-UNCERTAINTY","SFT-CHEM-NUCHEM-004-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radioactive-branching-chemical-yield-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004"),("claim_id",.text "SFT-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-decay-channel__held-daughter-chemical-species__positive-counted-branch-events__positive-counted-recovered-events__exact-recovered-per-branch-ratio__complete-branch-partition-sums-to-One__complete-daughter-yield-vector__new-branch-repartitions-complete-total"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-004-CHANNELS",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "channels",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-004-DAUGHTERS",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "daughters",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-004-BRANCH-FRACTIONS",.text "NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025",.text "branch fractions",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-004-CHEMICAL-RECOVERY",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "chemical recovery",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-004-PARTITION",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "partition",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-004-METHODS",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "methods",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-004-ADVERSE-UNCERTAINTY",.text "NUCHEM-001-004-SHARED-SOURCES",.text "adverse uncertainty",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-004-COMPLETE-SOURCES",.text "NUCHEM-001-004-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radioactive-branching-chemical-yield-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-radioactive-branching-chemical-yield-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any channel, daughter, branch, recovery, method, assumption, discrepancy, uncertainty, unavailable row, page or byte is omitted; or external outcomes select the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("channel",[("unlabelled-yield",false),("held-decay-channel",true)]),("daughter",[("anonymous-product-amount",false),("held-daughter-chemical-species",true)]),("events",[("continuum-branch-probability",false),("positive-counted-branch-events",true)]),("recovery",[("fitted-chemical-recovery",false),("positive-counted-recovered-events",true)]),("yield",[("percentage-premise",false),("exact-recovered-per-branch-ratio",true)]),("partition",[("independent-branch-fractions",false),("complete-branch-partition-sums-to-One",true)]),("record",[("selected-favorable-daughter",false),("complete-daughter-yield-vector",true)]),("extension",[("renormalize-after-omission",false),("new-branch-repartitions-complete-total",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if BranchYieldEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([RadioactiveBranchYield.channelWitness,RadioactiveBranchYield.daughterWitness,RadioactiveBranchYield.eventsWitness,
  RadioactiveBranchYield.recoveryWitness,RadioactiveBranchYield.yieldWitness,RadioactiveBranchYield.partitionWitness,
  RadioactiveBranchYield.completeWitness,RadioactiveBranchYield.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.BranchYieldExperiment
