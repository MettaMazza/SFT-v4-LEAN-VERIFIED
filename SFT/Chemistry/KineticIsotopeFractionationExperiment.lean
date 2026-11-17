import SFT.Chemistry.KineticIsotopeFractionationEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.KineticIsotopeFractionationExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008"
def experimentId : String := "SFT-EXP-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008"
def expectedLabel : String := "complete-kinetic-isotope-fractionation-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any reaction path, resource point, product, rate, factor, steady state, correction, loss, estimate, limitation, unreported row, page or byte is omitted; or an external response selects the law."
def sourceIds : List String := ["NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934","NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934","NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934","NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934","NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934","NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934","NUCHEM-005-008-SHARED-SOURCES","NUCHEM-005-008-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-008-REACTION-PATH","SFT-CHEM-NUCHEM-008-TIME-RESOURCE","SFT-CHEM-NUCHEM-008-PRODUCTS","SFT-CHEM-NUCHEM-008-RATES","SFT-CHEM-NUCHEM-008-FACTOR","SFT-CHEM-NUCHEM-008-STEADY-STATE","SFT-CHEM-NUCHEM-008-ADVERSE-CORRECTIONS","SFT-CHEM-NUCHEM-008-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-kinetic-isotope-fractionation-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008"),("claim_id",.text "SFT-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-reaction-light-heavy-identities__positive-ordered-resource-intervals__positive-counted-isotope-products__exact-products-per-resource-rates__exact-light-heavy-rate-ratio__held-faster-class-or-EmptyOne__positive-Take-or-EmptyOne-remainder__finite-time-series-successor-recomputes"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-008-REACTION-PATH",.text "NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934",.text "reaction path",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-008-TIME-RESOURCE",.text "NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934",.text "time resource",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-008-PRODUCTS",.text "NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934",.text "products",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-008-RATES",.text "NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934",.text "rates",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-008-FACTOR",.text "NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934",.text "factor",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-008-STEADY-STATE",.text "NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934",.text "steady state",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-008-ADVERSE-CORRECTIONS",.text "NUCHEM-005-008-SHARED-SOURCES",.text "adverse corrections",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-008-COMPLETE-SOURCES",.text "NUCHEM-005-008-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-kinetic-isotope-fractionation-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-kinetic-isotope-fractionation-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any reaction path, resource point, product, rate, factor, steady state, correction, loss, estimate, limitation, unreported row, page or byte is omitted; or an external response selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("mass-only-rate",false),("held-reaction-light-heavy-identities",true)]),("support",[("continuous-time-premise",false),("positive-ordered-resource-intervals",true)]),("events",[("expected-product-yield",false),("positive-counted-isotope-products",true)]),("rates",[("fitted-rate-constants",false),("exact-products-per-resource-rates",true)]),("factor",[("imported-kinetic-isotope-effect",false),("exact-light-heavy-rate-ratio",true)]),("orientation",[("signed-rate-difference",false),("held-faster-class-or-EmptyOne",true)]),("inventory",[("negative-depleted-reactant",false),("positive-Take-or-EmptyOne-remainder",true)]),("extension",[("Rayleigh-continuum-premise",false),("finite-time-series-successor-recomputes",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if KineticIsotopeFractionationEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([KineticIsotopeFractionation.identityWitness,KineticIsotopeFractionation.supportWitness,KineticIsotopeFractionation.eventsWitness,
  KineticIsotopeFractionation.ratesWitness,KineticIsotopeFractionation.factorWitness,KineticIsotopeFractionation.orientationWitness,
  KineticIsotopeFractionation.inventoryWitness,KineticIsotopeFractionation.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.KineticIsotopeFractionationExperiment
