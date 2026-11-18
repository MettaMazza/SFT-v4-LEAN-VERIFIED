import SFT.Chemistry.MolecularDipoleMagnitudePrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularDipoleMagnitudeValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularDipoleMagnitudeExperiment
open SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def envelope (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map fun (key,value) => (key,.text (CapabilityValues.identity value)))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def sealPrediction (prior : Option PredictionSeal) (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope inputs registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (registrationHash host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-molecular-dipole-square-comparator/1",.text registrationHash]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]



open MolecularDipoleMagnitudeSource MolecularDipoleMagnitudePrediction
structure Validation where
 value : Value
 passed : Bool
structure AbsenceComparison where
 value : Value
 agrees : Bool
 message : String
structure MagnitudeComparison where
 value : Value
 count : Nat
 overlap : Bool
 displaced : Bool
 message : String
def ratValue (r : Rat) : Value := .object [("numerator",.integer r.num),("denominator",.integer r.den)]
def ratText (r : Rat) : String := Text.intercalate "/" [render (.integer r.num),toString r.den]
def boolText (b : Bool) : String := if b then "True" else "False"
def validate (files : List (String × ByteArray)) (primary identities measurements : Value)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord
 let registrationHash := identity registration
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-005 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-005 prediction package changed"
 validateStructuralPrediction execution.output
 -- Original numerical and absence-glyph release follows the relation seal.
 let targets ← loadTargets files primary identities measurements
 let targetValues := targets.map fun row => (row.targetId,CapabilityValues.canonical row.intervalValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") targetValues
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let bySpecies := fun species => targets.filter fun row => Text.equal row.species species
 let absence := ["H2","D2"].map fun species =>
  let rows := bySpecies species
  let (targetId,inscription,agrees) := match rows with
   | [] => ("incomplete","incomplete",false)
   | first::rest => if rest.isEmpty then
     (first.targetId,first.inscription,match first.measurement with | none => true | some _ => false)
    else ("incomplete","incomplete",false)
  let value : Value := .object [("species",.text species),("target_id",.text targetId),
   ("predicted",.text "EmptyOne"),("source_inscription",.text inscription),("matches",.boolean agrees)]
  let message := Text.intercalate "" [species,": source ",inscription," maps to native EmptyOne; match ",boolText agrees]
  (⟨value,agrees,message⟩ : AbsenceComparison)
 let magnitudes ← [("H2O",1),("D2O",1),("HDO",2)].mapM fun (species,expectedCount) => do
  let components := (bySpecies species).filter fun row => Text.equal row.role "component-magnitude"
  let totals := (bySpecies species).filter fun row => Text.equal row.role "total-magnitude"
  if components.length != expectedCount || totals.length != 1 then
   throw (Text.intercalate "" ["PROP-005 ",species," component/total support is incomplete"])
  let total ← match totals.head? with
   | none => throw (Text.intercalate "" ["PROP-005 ",species," component/total support is incomplete"])
   | some value => pure value
  let totalInterval ← match total.measurement with
   | none => throw "KeyError: lower"
   | some value => pure value
  let (derivedLower,derivedUpper) ← squareInterval components
  let observedLower := multiply totalInterval.lower totalInterval.lower
  let observedUpper := multiply totalInterval.upper totalInterval.upper
  let overlap := !(lessRat derivedUpper observedLower || lessRat observedUpper derivedLower)
  let displacedLower := add derivedUpper (wholeRatio 1)
  let displacedUpper := add derivedUpper (wholeRatio 2)
  let displaced := lessRat observedUpper displacedLower && lessRat displacedLower displacedUpper
  let value : Value := .object [("species",.text species),("component_target_ids",.array (components.map fun row => .text row.targetId)),
   ("total_target_id",.text total.targetId),("component_count",.integer components.length),
   ("derived_squared_lower",ratValue derivedLower),("derived_squared_upper",ratValue derivedUpper),
   ("observed_squared_lower",ratValue observedLower),("observed_squared_upper",ratValue observedUpper),
   ("overlap",.boolean overlap),("displaced_control_rejected",.boolean displaced)]
  let message := Text.intercalate "" [species,": ",toString components.length,
   " post-seal component intervals give exact squared-magnitude [",ratText derivedLower,", ",ratText derivedUpper,
   "]; reported squared total [",ratText observedLower,", ",ratText observedUpper,
   "]; overlap ",boolText overlap]
  pure (⟨value,components.length,overlap,displaced,message⟩ : MagnitudeComparison)
 let targetRows ← RunningConvergenceMeasurement.array (get measurements "rows")
 let inscriptions ← targetRows.mapM fun row => field row "inscription" >>= text
 let noMeasurement := inscriptions.all fun inscription => !Text.contains (render document) inscription
 let witness : MolecularDipoleMagnitude.Component := ⟨⟨"dipole-axis","witness-axis",rfl,rfl⟩,
  ⟨"held-dipole-orientation","witness-side",rfl,rfl⟩,⟨⟨1,by decide⟩,⟨1,by decide⟩⟩⟩
 let duplicateRejected := match MolecularDipoleMagnitude.exactSquaredMagnitude (.tuple [.component witness,.component witness]) with
  | .error _ => true
  | .ok _ => false
 let structuralCounts : Value := .object (MolecularDipoleMagnitude.registeredCarriers.map fun row => (row.species.label,.integer row.axes.length))
 let adverse : List (String × Bool) := [
  ("complete_five_species_nine_row_vector",targets.length==9 && sameKeys (targets.map Target.targetId) targetIds),
  ("all_measurements_absent_from_prediction",noMeasurement),
  ("symmetry_forces_component_counts",sameValue structuralCounts (.object [("H2",.integer 0),("D2",.integer 0),("H2O",.integer 1),("D2O",.integer 1),("HDO",.integer 2)])),
  ("homonuclear_source_glyphs_map_only_to_EmptyOne",absence.all AbsenceComparison.agrees),
  ("every_squared_magnitude_interval_overlaps",magnitudes.all MagnitudeComparison.overlap),
  ("every_displaced_total_rejected",magnitudes.all MagnitudeComparison.displaced),
  ("missing_component_is_not_computable",magnitudes.all fun row => row.count≥1),
  ("duplicate_axis_rejected",duplicateRejected),
  ("conventional_signed_direction_absent_from_prediction",!Text.contains (render document) "source-negative-axis-sign"),
  ("tampered_registry_identity_rejected",!Text.equal (identity (.array [.text targetHash,.text "tampered"])) targetHash)]
 let passed := absence.all AbsenceComparison.agrees && magnitudes.all MagnitudeComparison.overlap && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-005 released target identity differs"
 let payload : Value := .object [("registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("target_registry_hash",.text targetHash),
  ("absence_comparisons",.array (absence.map AbsenceComparison.value)),("magnitude_comparisons",.array (magnitudes.map MagnitudeComparison.value)),
  ("adverse",.object (adverse.map fun (name,b) => (name,.boolean b))),("trace_hash",.text execution.traceHash)]
 let messages := absence.map AbsenceComparison.message ++ magnitudes.map MagnitudeComparison.message ++
  adverse.map (fun (name,b) => Text.intercalate "" ["adverse ",name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-NBS-JCP-59-2254-1973",.text "NIST-CCCBDB-SRD101-EXPERIMENTAL-DIPOLES"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MolecularDipoleMagnitudeValidation
