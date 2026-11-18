import SFT.Chemistry.AnalyticalSensitivityEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.AnalyticalSensitivityExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-ANALYTICAL-SENSITIVITY-003"
def experimentId : String := "SFT-EXP-CHEM-ANALYTICAL-SENSITIVITY-003"
def expectedLabel : String := "complete-analytical-sensitivity-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any registered analytical row, uncertainty, adverse result, page or byte is omitted; or an external result selects the law. Eight dimensions exhaust identity, input, response, change, relation, domain, noise and extension."
def sourceIds : List String := ["NIST-SP-260-126-NTRM-GAS-STANDARDS","NIST-SP-260-126-NTRM-GAS-STANDARDS","NIST-SP-260-126-NTRM-GAS-STANDARDS","NIST-SP-260-126-NTRM-GAS-STANDARDS","NIST-SP-260-126-NTRM-GAS-STANDARDS","NIST-SP-260-126-NTRM-GAS-STANDARDS","NIST-SP-260-126-NTRM-GAS-STANDARDS","ANAL-001-005-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-ANAL-003-IDENTITY","SFT-CHEM-ANAL-003-INPUT-SUPPORT","SFT-CHEM-ANAL-003-RESPONSE-SUPPORT","SFT-CHEM-ANAL-003-SENSITIVITY","SFT-CHEM-ANAL-003-NONLINEARITY","SFT-CHEM-ANAL-003-DOMAIN","SFT-CHEM-ANAL-003-DRIFT-NOISE","SFT-CHEM-ANAL-003-COMPLETE-SOURCE"]
def snapshotHashes : List String := ["sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ANALYTICAL-SENSITIVITY-003-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-analytical-sensitivity-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-ANALYTICAL-SENSITIVITY-003"),("claim_id",.text "SFT-CHEM-ANALYTICAL-SENSITIVITY-003"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-analyte-method-condition__positive-ordered-input-support__paired-complete-response-support__held-response-side-positive-change-or-EmptyOne__exact-local-response-per-input-ratio__finite-registered-segment-domain__complete-drift-noise-custody__successor-retains-and-adds-segment"),("target_references",.array [.array [.text "SFT-CHEM-ANAL-003-IDENTITY",.text "NIST-SP-260-126-NTRM-GAS-STANDARDS",.text "identity",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-003-INPUT-SUPPORT",.text "NIST-SP-260-126-NTRM-GAS-STANDARDS",.text "input support",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-003-RESPONSE-SUPPORT",.text "NIST-SP-260-126-NTRM-GAS-STANDARDS",.text "response support",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-003-SENSITIVITY",.text "NIST-SP-260-126-NTRM-GAS-STANDARDS",.text "sensitivity",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-003-NONLINEARITY",.text "NIST-SP-260-126-NTRM-GAS-STANDARDS",.text "nonlinearity",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-003-DOMAIN",.text "NIST-SP-260-126-NTRM-GAS-STANDARDS",.text "domain",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-003-DRIFT-NOISE",.text "NIST-SP-260-126-NTRM-GAS-STANDARDS",.text "drift noise",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-003-COMPLETE-SOURCE",.text "ANAL-001-005-SOURCE-INVENTORY",.text "complete source",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ANALYTICAL-SENSITIVITY-003-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-analytical-sensitivity-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-analytical-sensitivity-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any registered analytical row, uncertainty, adverse result, page or byte is omitted; or an external result selects the law. Eight dimensions exhaust identity, input, response, change, relation, domain, noise and extension."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("anonymous-response",false),("held-analyte-method-condition",true)]),("input",[("continuum-input-premise",false),("positive-ordered-input-support",true)]),("response",[("response-fit-only",false),("paired-complete-response-support",true)]),("change",[("signed-response-change",false),("held-response-side-positive-change-or-EmptyOne",true)]),("relation",[("fitted-global-slope",false),("exact-local-response-per-input-ratio",true)]),("domain",[("universal-linearity",false),("finite-registered-segment-domain",true)]),("noise",[("drift-noise-erased",false),("complete-drift-noise-custody",true)]),("extension",[("refitted-history",false),("successor-retains-and-adds-segment",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if AnalyticalSensitivityEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([AnalyticalSensitivity.identityWitness,AnalyticalSensitivity.inputWitness,AnalyticalSensitivity.responseWitness,
  AnalyticalSensitivity.changeWitness,AnalyticalSensitivity.relationWitness,AnalyticalSensitivity.domainWitness,
  AnalyticalSensitivity.noiseWitness,AnalyticalSensitivity.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.AnalyticalSensitivityExperiment
