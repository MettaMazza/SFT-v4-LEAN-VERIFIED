import SFT.Chemistry.RadiolysisNetworkEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.RadiolysisNetworkExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012"
def experimentId : String := "SFT-EXP-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012"
def expectedLabel : String := "complete-radiation-chemistry-reaction-network-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any resource, species, channel, event, yield, condition, reaction, correction, tentative or adverse row, page or byte is omitted; or an external G value selects the law."
def sourceIds : List String := ["NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE","NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE","NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE","NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE","NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE","NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE","NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE","NUCHEM-009-012-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-012-RESOURCE-HANDOFF","SFT-CHEM-NUCHEM-012-SPECIES","SFT-CHEM-NUCHEM-012-NETWORK","SFT-CHEM-NUCHEM-012-YIELDS","SFT-CHEM-NUCHEM-012-CONDITIONS","SFT-CHEM-NUCHEM-012-PARTITION-CLOSURE","SFT-CHEM-NUCHEM-012-ADVERSE-UNCERTAINTY","SFT-CHEM-NUCHEM-012-COMPLETE-SOURCE"]
def snapshotHashes : List String := ["sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiation-chemistry-reaction-network-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012"),("claim_id",.text "SFT-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012"),("provenance",.text "observational_derivation"),("frozen_relation",.text "explicit-positive-deposited-resource-handoff__held-medium-reactant-product-identities__complete-directed-reaction-network__positive-product-event-counts__exact-product-per-deposited-resource-ratio__exact-complete-channel-partition-of-One__explicit-reaction-or-EmptyOne-termination__successor-retains-and-recomputes-complete-network"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-012-RESOURCE-HANDOFF",.text "NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE",.text "resource handoff",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-012-SPECIES",.text "NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE",.text "species",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-012-NETWORK",.text "NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE",.text "network",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-012-YIELDS",.text "NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE",.text "yields",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-012-CONDITIONS",.text "NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE",.text "conditions",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-012-PARTITION-CLOSURE",.text "NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE",.text "partition closure",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-012-ADVERSE-UNCERTAINTY",.text "NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE",.text "adverse uncertainty",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-012-COMPLETE-SOURCE",.text "NUCHEM-009-012-SOURCE-INVENTORY",.text "complete source",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiation-chemistry-reaction-network-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-radiation-chemistry-reaction-network-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any resource, species, channel, event, yield, condition, reaction, correction, tentative or adverse row, page or byte is omitted; or an external G value selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("handoff",[("chemistry-defines-deposited-energy",false),("explicit-positive-deposited-resource-handoff",true)]),("identity",[("anonymous-radical-yield",false),("held-medium-reactant-product-identities",true)]),("network",[("single-net-equation",false),("complete-directed-reaction-network",true)]),("events",[("continuum-concentration-premise",false),("positive-product-event-counts",true)]),("yield",[("fitted-G-value",false),("exact-product-per-deposited-resource-ratio",true)]),("partition",[("selected-major-products",false),("exact-complete-channel-partition-of-One",true)]),("closure",[("negative-consumption-ledger",false),("explicit-reaction-or-EmptyOne-termination",true)]),("extension",[("differential-kinetic-model-premise",false),("successor-retains-and-recomputes-complete-network",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if RadiolysisNetworkEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([RadiolysisNetwork.handoffWitness,RadiolysisNetwork.identityWitness,RadiolysisNetwork.networkWitness,
  RadiolysisNetwork.eventsWitness,RadiolysisNetwork.yieldWitness,RadiolysisNetwork.partitionWitness,
  RadiolysisNetwork.closureWitness,RadiolysisNetwork.extensionWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.RadiolysisNetworkExperiment
