import SFT.Chemistry.AnalyticalDetectionEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.AnalyticalDetectionExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004"
def experimentId : String := "SFT-EXP-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004"
def expectedLabel : String := "complete-detection-quantification-boundary-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any registered analytical row, uncertainty, adverse result, page or byte is omitted; or an external result selects the law. Eight dimensions exhaust identity, blank, levels, detection, errors, quantification, absence and extension."
def sourceIds : List String := ["NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166","NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166","NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166","NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166","NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166","NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166","NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166","ANAL-001-005-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-ANAL-004-IDENTITY","SFT-CHEM-ANAL-004-BLANK-LOW-LEVEL","SFT-CHEM-ANAL-004-BOUNDARIES","SFT-CHEM-ANAL-004-ERRORS","SFT-CHEM-ANAL-004-DETECTION-VALUES","SFT-CHEM-ANAL-004-QUANTIFICATION","SFT-CHEM-ANAL-004-ADVERSE-LIMITS","SFT-CHEM-ANAL-004-COMPLETE-SOURCE"]
def snapshotHashes : List String := ["sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-detection-quantification-boundary-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004"),("claim_id",.text "SFT-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-analyte-method-condition__complete-positive-blank-support__complete-positive-ordered-level-support__exact-blank-sample-distinguishability__false-positive-negative-custody__repeatability-and-recovery-required__detected-quantified-label-or-EmptyOne__successor-retains-and-recomputes-levels"),("target_references",.array [.array [.text "SFT-CHEM-ANAL-004-IDENTITY",.text "NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166",.text "identity",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-004-BLANK-LOW-LEVEL",.text "NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166",.text "blank low level",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-004-BOUNDARIES",.text "NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166",.text "boundaries",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-004-ERRORS",.text "NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166",.text "errors",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-004-DETECTION-VALUES",.text "NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166",.text "detection values",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-004-QUANTIFICATION",.text "NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166",.text "quantification",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-004-ADVERSE-LIMITS",.text "NIST-SP958-DETECTION-QUANTIFICATION-PAGES-164-166",.text "adverse limits",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-004-COMPLETE-SOURCE",.text "ANAL-001-005-SOURCE-INVENTORY",.text "complete source",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-detection-quantification-boundary-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-detection-quantification-boundary-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any registered analytical row, uncertainty, adverse result, page or byte is omitted; or an external result selects the law. Eight dimensions exhaust identity, blank, levels, detection, errors, quantification, absence and extension."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("unidentified-signal",false),("held-analyte-method-condition",true)]),("blank",[("single-numerical-zero-blank",false),("complete-positive-blank-support",true)]),("levels",[("selected-low-result",false),("complete-positive-ordered-level-support",true)]),("detection",[("declared-limit-number",false),("exact-blank-sample-distinguishability",true)]),("errors",[("false-results-erased",false),("false-positive-negative-custody",true)]),("quantification",[("detection-equals-quantification",false),("repeatability-and-recovery-required",true)]),("absence",[("negative-undetected-value",false),("detected-quantified-label-or-EmptyOne",true)]),("extension",[("threshold-refitted",false),("successor-retains-and-recomputes-levels",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if AnalyticalDetectionEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([AnalyticalDetection.identityWitness,AnalyticalDetection.blankWitness,AnalyticalDetection.levelsWitness,
  AnalyticalDetection.detectionWitness,AnalyticalDetection.errorsWitness,AnalyticalDetection.quantificationWitness,
  AnalyticalDetection.absenceWitness,AnalyticalDetection.extensionWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.AnalyticalDetectionExperiment
