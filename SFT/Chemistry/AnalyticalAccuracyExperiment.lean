import SFT.Chemistry.AnalyticalAccuracyEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.AnalyticalAccuracyExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001"
def experimentId : String := "SFT-EXP-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001"
def expectedLabel : String := "complete-analytical-accuracy-trueness-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any registered analytical row, uncertainty, adverse result, page or byte is omitted; or an external result selects the law. Eight dimensions exhaust reference, measurand, support, comparison, trueness, uncertainty, boundary and extension."
def sourceIds : List String := ["NIST-SRM-1959-CERTIFICATE-2011","NIST-SRM-1959-CERTIFICATE-2011","NIST-SRM-1959-CERTIFICATE-2011","NIST-SRM-1959-CERTIFICATE-2011","NIST-SRM-1959-CERTIFICATE-2011","NIST-SRM-1959-CERTIFICATE-2011","NIST-SRM-1959-CERTIFICATE-2011","ANAL-001-005-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-ANAL-001-REFERENCE","SFT-CHEM-ANAL-001-VALUE-PAIRS","SFT-CHEM-ANAL-001-METHODS","SFT-CHEM-ANAL-001-UNCERTAINTY","SFT-CHEM-ANAL-001-BOUNDARY","SFT-CHEM-ANAL-001-STATUS","SFT-CHEM-ANAL-001-ADVERSE-LIMITS","SFT-CHEM-ANAL-001-COMPLETE-SOURCE"]
def snapshotHashes : List String := ["sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-analytical-accuracy-trueness-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001"),("claim_id",.text "SFT-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001"),("provenance",.text "observational_derivation"),("frozen_relation",.text "traceable-reference-identity__held-sample-measurand-method__complete-ordered-result-support__held-side-positive-distance-or-EmptyOne__exact-observed-reference-relation__complete-exact-uncertainty-support__registered-material-method-boundary__successor-retains-and-recomputes-all-results"),("target_references",.array [.array [.text "SFT-CHEM-ANAL-001-REFERENCE",.text "NIST-SRM-1959-CERTIFICATE-2011",.text "reference",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-001-VALUE-PAIRS",.text "NIST-SRM-1959-CERTIFICATE-2011",.text "value pairs",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-001-METHODS",.text "NIST-SRM-1959-CERTIFICATE-2011",.text "methods",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-001-UNCERTAINTY",.text "NIST-SRM-1959-CERTIFICATE-2011",.text "uncertainty",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-001-BOUNDARY",.text "NIST-SRM-1959-CERTIFICATE-2011",.text "boundary",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-001-STATUS",.text "NIST-SRM-1959-CERTIFICATE-2011",.text "status",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-001-ADVERSE-LIMITS",.text "NIST-SRM-1959-CERTIFICATE-2011",.text "adverse limits",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"],.array [.text "SFT-CHEM-ANAL-001-COMPLETE-SOURCE",.text "ANAL-001-005-SOURCE-INVENTORY",.text "complete source",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json",.text "sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-analytical-accuracy-trueness-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-analytical-accuracy-trueness-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any registered analytical row, uncertainty, adverse result, page or byte is omitted; or an external result selects the law. Eight dimensions exhaust reference, measurand, support, comparison, trueness, uncertainty, boundary and extension."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("reference",[("nominal-value-premise",false),("traceable-reference-identity",true)]),("measurand",[("result-without-measurand",false),("held-sample-measurand-method",true)]),("support",[("selected-result",false),("complete-ordered-result-support",true)]),("comparison",[("signed-error-scalar",false),("held-side-positive-distance-or-EmptyOne",true)]),("trueness",[("declared-accurate-label",false),("exact-observed-reference-relation",true)]),("uncertainty",[("single-certain-value",false),("complete-exact-uncertainty-support",true)]),("boundary",[("universal-method-accuracy",false),("registered-material-method-boundary",true)]),("extension",[("renormalized-new-results",false),("successor-retains-and-recomputes-all-results",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if AnalyticalAccuracyEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([AnalyticalAccuracy.referenceWitness,AnalyticalAccuracy.measurandWitness,AnalyticalAccuracy.supportWitness,
  AnalyticalAccuracy.comparisonWitness,AnalyticalAccuracy.truenessWitness,AnalyticalAccuracy.uncertaintyWitness,
  AnalyticalAccuracy.boundaryWitness,AnalyticalAccuracy.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.AnalyticalAccuracyExperiment
