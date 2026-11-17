import SFT.Chemistry.EquilibriumIsotopeFractionationEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.EquilibriumIsotopeFractionationExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007"
def experimentId : String := "SFT-EXP-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007"
def expectedLabel : String := "complete-equilibrium-isotope-fractionation-vector"
def falsification : String := "The claim halts if the survivor is nonunique; any isotope ratio, phase, factor, orientation, temperature, fit, estimate, discrepancy, unavailable row, page or byte is omitted; or an external factor selects the law."
def sourceIds : List String := ["USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION","USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION","USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION","USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION","USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION","USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS","NUCHEM-005-008-SHARED-SOURCES","NUCHEM-005-008-SOURCE-INVENTORY"]
def targetIds : List String := ["SFT-CHEM-NUCHEM-007-ISOTOPE-RATIOS","SFT-CHEM-NUCHEM-007-PHASES","SFT-CHEM-NUCHEM-007-FACTORS","SFT-CHEM-NUCHEM-007-ORIENTATION","SFT-CHEM-NUCHEM-007-TEMPERATURE","SFT-CHEM-NUCHEM-007-EQUILIBRIUM","SFT-CHEM-NUCHEM-007-ADVERSE-UNAVAILABLE","SFT-CHEM-NUCHEM-007-COMPLETE-SOURCES"]
def snapshotHashes : List String := ["sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-equilibrium-isotope-fractionation-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def registration : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007"),("claim_id",.text "SFT-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007"),("provenance",.text "observational_derivation"),("frozen_relation",.text "held-light-heavy-isotopes__held-distinct-phase-pair__positive-complete-isotope-counts__exact-heavy-per-light-ratios__exact-ratio-of-ratios__held-enrichment-or-EmptyOne-coincidence__exchange-balance-plus-stable-factor__complete-vector-successor-recomputes"),("target_references",.array [.array [.text "SFT-CHEM-NUCHEM-007-ISOTOPE-RATIOS",.text "USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION",.text "isotope ratios",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-007-PHASES",.text "USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION",.text "phases",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-007-FACTORS",.text "USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION",.text "factors",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-007-ORIENTATION",.text "USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION",.text "orientation",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-007-TEMPERATURE",.text "USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION",.text "temperature",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-007-EQUILIBRIUM",.text "USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS",.text "equilibrium",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-007-ADVERSE-UNAVAILABLE",.text "NUCHEM-005-008-SHARED-SOURCES",.text "adverse unavailable",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"],.array [.text "SFT-CHEM-NUCHEM-007-COMPLETE-SOURCES",.text "NUCHEM-005-008-SOURCE-INVENTORY",.text "complete sources",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json",.text "sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"]]),("observation_registry_path",.text "experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "chemical-observation",.text "complete-equilibrium-isotope-fractionation-vector"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("sealed_consequence_label",.text "complete-equilibrium-isotope-fractionation-vector"),("falsification_condition",.text "The claim halts if the survivor is nonunique; any isotope ratio, phase, factor, orientation, temperature, fit, estimate, discrepancy, unavailable row, page or byte is omitted; or an external factor selects the law."),("development_observation_disclosed",.boolean true),("observation_may_have_informed_question_and_candidate_relation",.boolean true),("not_claimed_as_unknown-target_forward_prediction",.boolean true),("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),("all_rows_required",.boolean true)]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("identity",[("anonymous-heavy-light",false),("held-light-heavy-isotopes",true)]),("phases",[("single-phase-ratio",false),("held-distinct-phase-pair",true)]),("inventory",[("continuum-abundance-premise",false),("positive-complete-isotope-counts",true)]),("ratios",[("decimal-isotope-ratio",false),("exact-heavy-per-light-ratios",true)]),("factor",[("fitted-fractionation-factor",false),("exact-ratio-of-ratios",true)]),("orientation",[("signed-delta-premise",false),("held-enrichment-or-EmptyOne-coincidence",true)]),("equilibrium",[("named-equilibrium-assumption",false),("exchange-balance-plus-stable-factor",true)]),("extension",[("selected-isotope-pair",false),("complete-vector-successor-recomputes",true)])]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if EquilibriumIsotopeFractionationEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([EquilibriumIsotopeFractionation.identityWitness,EquilibriumIsotopeFractionation.phasesWitness,EquilibriumIsotopeFractionation.inventoryWitness,
  EquilibriumIsotopeFractionation.ratiosWitness,EquilibriumIsotopeFractionation.factorWitness,EquilibriumIsotopeFractionation.orientationWitness,
  EquilibriumIsotopeFractionation.coincidenceWitness,EquilibriumIsotopeFractionation.extensionWitness].all id) then throw "Chemistry operational witness failed"
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
end SFT.Chemistry.EquilibriumIsotopeFractionationExperiment
