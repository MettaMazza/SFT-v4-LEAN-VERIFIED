import SFT.Chemistry.RadiochemicalEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.RadiochemicalExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005"
def experimentId : String := "SFT-EXP-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005"
def expectedLabel : String := "complete-radiochemical-equilibrium-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any parent, daughter, interval, activity, regime, assumption, uncertainty, unavailable row, page or byte is omitted; or an external equilibrium label selects the law."
def sourceIds : List String := ["NIST-SRM-4239A-STRONTIUM-90-2022","NUCHEM-005-NIST-SRM-PAIR","NUCHEM-005-NIST-SRM-PAIR","NUCHEM-005-NIST-SRM-PAIR","NIST-SRM-4324C-URANIUM-232-2025","NUCHEM-005-NIST-SRM-PAIR","NUCHEM-005-008-SHARED-SOURCES","NUCHEM-005-008-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-005-PARENT-DAUGHTER","SFT-CHEM-NUCHEM-005-TIME-SUPPORT","SFT-CHEM-NUCHEM-005-ACTIVITY","SFT-CHEM-NUCHEM-005-RATIO-REGIME","SFT-CHEM-NUCHEM-005-TRANSIENT","SFT-CHEM-NUCHEM-005-SECULAR","SFT-CHEM-NUCHEM-005-ADVERSE-METHODS","SFT-CHEM-NUCHEM-005-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiochemical-equilibrium-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005"),("claim_id",.text "SFT-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-parent-daughter-identity__positive-ordered-resource-intervals__exact-counted-activity-pair__held-ratio-or-structural-absence__persistent-nonOne-ratio-forces-transient__persistent-One-ratio-forces-secular__complete-parent-daughter-time-vector__finite-successor-recomputes-regime"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-005-PARENT-DAUGHTER",.text "NIST-SRM-4239A-STRONTIUM-90-2022",.text "parent daughter",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-005-TIME-SUPPORT",.text "NUCHEM-005-NIST-SRM-PAIR",.text "time support",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-005-ACTIVITY",.text "NUCHEM-005-NIST-SRM-PAIR",.text "activity",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-005-RATIO-REGIME",.text "NUCHEM-005-NIST-SRM-PAIR",.text "ratio regime",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-005-TRANSIENT",.text "NIST-SRM-4324C-URANIUM-232-2025",.text "transient",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-005-SECULAR",.text "NUCHEM-005-NIST-SRM-PAIR",.text "secular",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-005-ADVERSE-METHODS",.text "NUCHEM-005-008-SHARED-SOURCES",.text "adverse methods",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-005-COMPLETE-SOURCES",.text "NUCHEM-005-008-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-radiochemical-equilibrium-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-radiochemical-equilibrium-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any parent, daughter, interval, activity, regime, assumption, uncertainty, unavailable row, page or byte is omitted; or an external equilibrium label selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("anonymous-activity-pair",false),("held-parent-daughter-identity",true)]),("support",[("continuous-time-premise",false),("positive-ordered-resource-intervals",true)]),("activity",[("fitted-decay-curve",false),("exact-counted-activity-pair",true)]),("relation",[("signed-activity-difference",false),("held-ratio-or-structural-absence",true)]),("transient",[("named-transient-assumption",false),("persistent-nonOne-ratio-forces-transient",true)]),("secular",[("approximate-equality-tolerance",false),("persistent-One-ratio-forces-secular",true)]),("record",[("selected-timepoint",false),("complete-parent-daughter-time-vector",true)]),("extension",[("differential-equation-premise",false),("finite-successor-recomputes-regime",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if RadiochemicalEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([RadiochemicalEquilibrium.identityWitness,RadiochemicalEquilibrium.supportWitness,RadiochemicalEquilibrium.activityWitness,
  RadiochemicalEquilibrium.ratioWitness,RadiochemicalEquilibrium.transientWitness,RadiochemicalEquilibrium.secularWitness,
  RadiochemicalEquilibrium.absenceWitness,RadiochemicalEquilibrium.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.RadiochemicalExperiment
