import SFT.Chemistry.NuclideCarrierEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.NuclideCarrierExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001"
def experimentId : String := "SFT-EXP-CHEM-NUCLEAR-CHEMICAL-CARRIER-001"
def expectedLabel : String := "complete-nuclide-chemical-carrier-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any element, nuclide, state, species, phase, occurrence, uncertainty, adverse or unavailable row, page or byte is omitted; or an external value selects the law."
def sourceIds : List String := ["NIST-NUCLEAR-PHYSICS-DATA-ISOTOPIC-COMPOSITION","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-SRM-4239A-STRONTIUM-90-2022","NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025","NIST-SRM-4239A-STRONTIUM-90-2022","NUCHEM-001-004-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-001-ELEMENT","SFT-CHEM-NUCHEM-001-NUCLIDE","SFT-CHEM-NUCHEM-001-STATE","SFT-CHEM-NUCHEM-001-SPECIES","SFT-CHEM-NUCHEM-001-PHASE","SFT-CHEM-NUCHEM-001-AMOUNT","SFT-CHEM-NUCHEM-001-UNCERTAINTY","SFT-CHEM-NUCHEM-001-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-NUCLEAR-CHEMICAL-CARRIER-001-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-nuclide-chemical-carrier-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-NUCLEAR-CHEMICAL-CARRIER-001"),("claim_id",.text "SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-element-identity__positive-nucleon-count__held-nuclear-state__held-chemical-species__held-chemical-phase__positive-counted-occurrence__complete-nuclide-species-vector__fresh-occurrence-preserves-identity"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-001-ELEMENT",.text "NIST-NUCLEAR-PHYSICS-DATA-ISOTOPIC-COMPOSITION",.text "element",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-001-NUCLIDE",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "nuclide",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-001-STATE",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "state",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-001-SPECIES",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "species",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-001-PHASE",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "phase",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-001-AMOUNT",.text "NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025",.text "amount",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-001-UNCERTAINTY",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "uncertainty",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"],.array [.text "SFT-CHEM-NUCHEM-001-COMPLETE-SOURCES",.text "NUCHEM-001-004-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json",.text "sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-NUCLEAR-CHEMICAL-CARRIER-001-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-nuclide-chemical-carrier-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-nuclide-chemical-carrier-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any element, nuclide, state, species, phase, occurrence, uncertainty, adverse or unavailable row, page or byte is omitted; or an external value selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("element",[("anonymous-radiation",false),("held-element-identity",true)]),("nuclide",[("element-only-identity",false),("positive-nucleon-count",true)]),("state",[("ground-state-assumption",false),("held-nuclear-state",true)]),("species",[("bare-nuclide-answer",false),("held-chemical-species",true)]),("phase",[("phase-free-species",false),("held-chemical-phase",true)]),("occurrence",[("continuum-amount-premise",false),("positive-counted-occurrence",true)]),("record",[("selected-nuclide-row",false),("complete-nuclide-species-vector",true)]),("extension",[("lookup-table-exception",false),("fresh-occurrence-preserves-identity",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if NuclideCarrierEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([NuclideChemicalCarrier.elementWitness,NuclideChemicalCarrier.nuclideWitness,NuclideChemicalCarrier.stateWitness,
  NuclideChemicalCarrier.speciesWitness,NuclideChemicalCarrier.phaseWitness,NuclideChemicalCarrier.occurrenceWitness,
  NuclideChemicalCarrier.distinctWitness,NuclideChemicalCarrier.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.NuclideCarrierExperiment
