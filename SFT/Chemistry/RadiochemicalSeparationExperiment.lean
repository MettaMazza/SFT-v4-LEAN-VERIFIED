import SFT.Chemistry.RadiochemicalSeparationEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.RadiochemicalSeparationExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010"
def experimentId : String := "SFT-EXP-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010"
def expectedLabel : String := "complete-radiochemical-separation-decontamination-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any species, stream, balance, recovery, decontamination, stage, detection limit, uncertainty, adverse result, page or byte is omitted; or an external separation value selects the law."
def sourceIds : List String := ["DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING","DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING","DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING","DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING","DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING","DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING","DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING","NUCHEM-009-012-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-010-SPECIES","SFT-CHEM-NUCHEM-010-STREAMS","SFT-CHEM-NUCHEM-010-BALANCE","SFT-CHEM-NUCHEM-010-RECOVERY","SFT-CHEM-NUCHEM-010-DECONTAMINATION","SFT-CHEM-NUCHEM-010-STAGES","SFT-CHEM-NUCHEM-010-ADVERSE-UNCERTAINTY","SFT-CHEM-NUCHEM-010-COMPLETE-SOURCE"]
def snapshotHashes : List String := ["sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiochemical-separation-decontamination-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010"),("claim_id",.text "SFT-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-target-and-contaminant-species__complete-feed-product-waste-streams__positive-species-resolved-counts__exact-target-and-contaminant-conservation__exact-product-target-per-feed-target-ratio__exact-contaminant-fraction-ratio__positive-Take-or-EmptyOne-residual__successor-composes-balanced-stages"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-010-SPECIES",.text "DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING",.text "species",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-010-STREAMS",.text "DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING",.text "streams",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-010-BALANCE",.text "DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING",.text "balance",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-010-RECOVERY",.text "DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING",.text "recovery",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-010-DECONTAMINATION",.text "DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING",.text "decontamination",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-010-STAGES",.text "DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING",.text "stages",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-010-ADVERSE-UNCERTAINTY",.text "DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING",.text "adverse uncertainty",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-010-COMPLETE-SOURCE",.text "NUCHEM-009-012-SOURCE-INVENTORY",.text "complete source",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiochemical-separation-decontamination-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-radiochemical-separation-decontamination-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any species, stream, balance, recovery, decontamination, stage, detection limit, uncertainty, adverse result, page or byte is omitted; or an external separation value selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("total-radioactivity-only",false),("held-target-and-contaminant-species",true)]),("streams",[("product-only-record",false),("complete-feed-product-waste-streams",true)]),("inventory",[("continuum-concentration-premise",false),("positive-species-resolved-counts",true)]),("balance",[("unrecorded-process-loss",false),("exact-target-and-contaminant-conservation",true)]),("recovery",[("percent-recovery-premise",false),("exact-product-target-per-feed-target-ratio",true)]),("decontamination",[("fitted-separation-factor",false),("exact-contaminant-fraction-ratio",true)]),("absence",[("numerical-zero-contaminant",false),("positive-Take-or-EmptyOne-residual",true)]),("extension",[("selected-best-stage",false),("successor-composes-balanced-stages",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if RadiochemicalSeparationEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([RadiochemicalSeparation.identityWitness,RadiochemicalSeparation.streamsWitness,RadiochemicalSeparation.inventoryWitness,
  RadiochemicalSeparation.balanceWitness,RadiochemicalSeparation.recoveryWitness,RadiochemicalSeparation.decontaminationWitness,
  RadiochemicalSeparation.absenceWitness,RadiochemicalSeparation.extensionWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.RadiochemicalSeparationExperiment
