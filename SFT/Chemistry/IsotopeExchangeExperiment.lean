import SFT.Chemistry.IsotopeExchangeEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.IsotopeExchangeExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-ISOTOPE-EXCHANGE-006"
def experimentId : String := "SFT-EXP-CHEM-ISOTOPE-EXCHANGE-006"
def expectedLabel : String := "complete-isotope-exchange-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any isotope, carrier, conservation, quotient, example condition, nonideality, adverse row, page or byte is omitted; or an external quotient selects the law."
def sourceIds : List String := ["USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS","USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS","USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS","USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS","USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS","USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS","NUCHEM-005-008-SHARED-SOURCES","NUCHEM-005-008-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-006-ISOTOPES","SFT-CHEM-NUCHEM-006-CARRIERS","SFT-CHEM-NUCHEM-006-CONSERVATION","SFT-CHEM-NUCHEM-006-EXCHANGE-QUOTIENT","SFT-CHEM-NUCHEM-006-EQUILIBRIUM","SFT-CHEM-NUCHEM-006-MULTISPECIES","SFT-CHEM-NUCHEM-006-ADVERSE-ASSUMPTIONS","SFT-CHEM-NUCHEM-006-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ISOTOPE-EXCHANGE-006-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-isotope-exchange-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-ISOTOPE-EXCHANGE-006"),("claim_id",.text "SFT-CHEM-ISOTOPE-EXCHANGE-006"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-element-light-heavy-isotopes__held-distinct-chemical-carriers__positive-complete-four-count-inventory__exact-isotope-and-carrier-conservation__held-direction-positive-Take__exact-cross-product-exchange-quotient__equal-forward-reverse-closes-EmptyOne__successor-preserves-identities-and-totals"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-006-ISOTOPES",.text "USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS",.text "isotopes",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-006-CARRIERS",.text "USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS",.text "carriers",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-006-CONSERVATION",.text "USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS",.text "conservation",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-006-EXCHANGE-QUOTIENT",.text "USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS",.text "exchange quotient",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-006-EQUILIBRIUM",.text "USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS",.text "equilibrium",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-006-MULTISPECIES",.text "USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS",.text "multispecies",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-006-ADVERSE-ASSUMPTIONS",.text "NUCHEM-005-008-SHARED-SOURCES",.text "adverse assumptions",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-006-COMPLETE-SOURCES",.text "NUCHEM-005-008-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-ISOTOPE-EXCHANGE-006-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-isotope-exchange-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-isotope-exchange-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any isotope, carrier, conservation, quotient, example condition, nonideality, adverse row, page or byte is omitted; or an external quotient selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("mass-number-only",false),("held-element-light-heavy-isotopes",true)]),("carriers",[("phase-free-exchange",false),("held-distinct-chemical-carriers",true)]),("inventory",[("continuum-concentration-premise",false),("positive-complete-four-count-inventory",true)]),("conservation",[("isotope-label-overwrite",false),("exact-isotope-and-carrier-conservation",true)]),("direction",[("signed-exchange-extent",false),("held-direction-positive-Take",true)]),("quotient",[("fitted-exchange-constant",false),("exact-cross-product-exchange-quotient",true)]),("equilibrium",[("numerical-zero-net",false),("equal-forward-reverse-closes-EmptyOne",true)]),("extension",[("lookup-fractionation-factor",false),("successor-preserves-identities-and-totals",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if IsotopeExchangeEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([IsotopeExchange.identityWitness,IsotopeExchange.carriersWitness,IsotopeExchange.inventoryWitness,
  IsotopeExchange.conservationWitness,IsotopeExchange.directionWitness,IsotopeExchange.quotientWitness,
  IsotopeExchange.equilibriumWitness,IsotopeExchange.successorWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.IsotopeExchangeExperiment
