import SFT.Chemistry.RadiotracerCustodyEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.RadiotracerCustodyExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009"
def experimentId : String := "SFT-EXP-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009"
def expectedLabel : String := "complete-radiotracer-custody-inference-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any tracer, chemistry, detector, location, count, recovery, loss, correction, inference, adverse row, page or byte is omitted; or an external RTD outcome selects the law."
def sourceIds : List String := ["IAEA-TCS-31-RADIOTRACER-RTD-2008","IAEA-TCS-31-RADIOTRACER-RTD-2008","IAEA-TCS-31-RADIOTRACER-RTD-2008","IAEA-TCS-31-RADIOTRACER-RTD-2008","IAEA-TCS-31-RADIOTRACER-RTD-2008","IAEA-TCS-31-RADIOTRACER-RTD-2008","IAEA-TCS-31-RADIOTRACER-RTD-2008","NUCHEM-009-012-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-009-TRACER-CHEMISTRY","SFT-CHEM-NUCHEM-009-OBSERVATION-SUPPORT","SFT-CHEM-NUCHEM-009-COUNTS","SFT-CHEM-NUCHEM-009-RECOVERY","SFT-CHEM-NUCHEM-009-LOCALIZATION","SFT-CHEM-NUCHEM-009-INFERENCE-BOUNDARY","SFT-CHEM-NUCHEM-009-ADVERSE-LIMITS","SFT-CHEM-NUCHEM-009-COMPLETE-SOURCE"]
def snapshotHashes : List String := ["sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiotracer-custody-inference-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009"),("claim_id",.text "SFT-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-tracer-and-chemical-carrier__positive-ordered-observation-support__complete-location-time-vector__positive-administered-and-observed-counts__exact-observed-per-administered-ratio__positive-Take-or-EmptyOne-unobserved__inference-bounded-by-observed-support__successor-preserves-identity-and-complete-record"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-009-TRACER-CHEMISTRY",.text "IAEA-TCS-31-RADIOTRACER-RTD-2008",.text "tracer chemistry",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-009-OBSERVATION-SUPPORT",.text "IAEA-TCS-31-RADIOTRACER-RTD-2008",.text "observation support",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-009-COUNTS",.text "IAEA-TCS-31-RADIOTRACER-RTD-2008",.text "counts",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-009-RECOVERY",.text "IAEA-TCS-31-RADIOTRACER-RTD-2008",.text "recovery",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-009-LOCALIZATION",.text "IAEA-TCS-31-RADIOTRACER-RTD-2008",.text "localization",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-009-INFERENCE-BOUNDARY",.text "IAEA-TCS-31-RADIOTRACER-RTD-2008",.text "inference boundary",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-009-ADVERSE-LIMITS",.text "IAEA-TCS-31-RADIOTRACER-RTD-2008",.text "adverse limits",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"],.array [.text "SFT-CHEM-NUCHEM-009-COMPLETE-SOURCE",.text "NUCHEM-009-012-SOURCE-INVENTORY",.text "complete source",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json",.text "sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiotracer-custody-inference-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-radiotracer-custody-inference-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any tracer, chemistry, detector, location, count, recovery, loss, correction, inference, adverse row, page or byte is omitted; or an external RTD outcome selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("activity-only-tracer",false),("held-tracer-and-chemical-carrier",true)]),("support",[("continuous-concentration-field",false),("positive-ordered-observation-support",true)]),("locations",[("selected-detector-location",false),("complete-location-time-vector",true)]),("events",[("expected-count-premise",false),("positive-administered-and-observed-counts",true)]),("recovery",[("fitted-recovery-coefficient",false),("exact-observed-per-administered-ratio",true)]),("loss",[("negative-missing-activity",false),("positive-Take-or-EmptyOne-unobserved",true)]),("inference",[("model-selected-localization",false),("inference-bounded-by-observed-support",true)]),("extension",[("renormalized-selected-series",false),("successor-preserves-identity-and-complete-record",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if RadiotracerCustodyEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([RadiotracerCustody.identityWitness,RadiotracerCustody.supportWitness,RadiotracerCustody.locationsWitness,
  RadiotracerCustody.eventsWitness,RadiotracerCustody.recoveryWitness,RadiotracerCustody.lossWitness,
  RadiotracerCustody.inferenceWitness,RadiotracerCustody.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.RadiotracerCustodyExperiment
