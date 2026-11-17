import SFT.Chemistry.RadioactiveTransformationEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.RadioactiveTransformationExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"
def experimentId : String := "SFT-EXP-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"
def expectedLabel : String := "complete-radioactive-chemical-transformation-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any parent, daughter, chemical state, channel, edge, equilibrium, assumption, disagreement, page or byte is omitted; or an external network selects the law."
def sourceIds : List String := ["NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4324C-URANIUM-232-2025","NIST-SRM-4324C-URANIUM-232-2025","NIST-SRM-4324C-URANIUM-232-2025","NUCHEM-001-004-SHARED-SOURCES","NUCHEM-001-004-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-002-PARENT","SFT-CHEM-NUCHEM-002-DAUGHTER","SFT-CHEM-NUCHEM-002-CHEMICAL-STATES","SFT-CHEM-NUCHEM-002-CHANNELS","SFT-CHEM-NUCHEM-002-NETWORK","SFT-CHEM-NUCHEM-002-EQUILIBRIUM","SFT-CHEM-NUCHEM-002-ADVERSE-METHODS","SFT-CHEM-NUCHEM-002-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radioactive-chemical-transformation-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"),("claim_id",.text "SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-parent-nuclide__held-daughter-nuclide__held-parent-daughter-species__held-decay-channel__positive-counted-transformations__complete-directed-transformation-network__structural-EmptyOne-no-edge__successor-retains-prior-network"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-002-PARENT",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "parent",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-002-DAUGHTER",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "daughter",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-002-CHEMICAL-STATES",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "chemical states",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-002-CHANNELS",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "channels",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-002-NETWORK",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "network",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-002-EQUILIBRIUM",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "equilibrium",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-002-ADVERSE-METHODS",.text "NUCHEM-001-004-SHARED-SOURCES",.text "adverse methods",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-002-COMPLETE-SOURCES",.text "NUCHEM-001-004-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radioactive-chemical-transformation-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-radioactive-chemical-transformation-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any parent, daughter, chemical state, channel, edge, equilibrium, assumption, disagreement, page or byte is omitted; or an external network selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("parent",[("parent-number-only",false),("held-parent-nuclide",true)]),("daughter",[("anonymous-product",false),("held-daughter-nuclide",true)]),("chemistry",[("nuclear-edge-only",false),("held-parent-daughter-species",true)]),("channel",[("unlabelled-transition",false),("held-decay-channel",true)]),("events",[("continuum-decay-flow",false),("positive-counted-transformations",true)]),("network",[("selected-decay-edge",false),("complete-directed-transformation-network",true)]),("absence",[("numerical-zero-daughter",false),("structural-EmptyOne-no-edge",true)]),("extension",[("daughter-overwrites-parent",false),("successor-retains-prior-network",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if RadioactiveTransformationEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([RadioactiveChemicalTransformation.parentWitness,RadioactiveChemicalTransformation.daughterWitness,RadioactiveChemicalTransformation.speciesWitness,
  RadioactiveChemicalTransformation.channelWitness,RadioactiveChemicalTransformation.eventsWitness,RadioactiveChemicalTransformation.networkWitness,
  RadioactiveChemicalTransformation.absenceWitness,RadioactiveChemicalTransformation.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.RadioactiveTransformationExperiment
