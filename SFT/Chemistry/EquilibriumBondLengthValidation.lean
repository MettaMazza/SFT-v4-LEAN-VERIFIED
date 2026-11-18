import SFT.Chemistry.EquilibriumBondLengthSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.EquilibriumBondLengthValidation
open SFT.Host SFT.Host.Canonical SFT.Physics EquilibriumBondLengthExperiment
open SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def inputValues (lower upper : Rat) : Except String (List (String × CapabilityValues.Value)) := do
 return [("atomic-lower",← EquilibriumBondLengthSource.ratio lower),
  ("atomic-upper",← EquilibriumBondLengthSource.ratio upper)]
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-equilibrium-length-interval-comparator/1",.text registrationHash]))),
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



def ratValue (value : Rat) : Value := .object [("numerator",.integer value.num),("denominator",.integer (Int.ofNat value.den))]
def ratText (value : Rat) : String := Text.intercalate "" [render (.integer value.num),"/",render (.integer (Int.ofNat value.den))]
def boolText (b : Bool) : String := if b then "True" else "False"
def ratioFraction (value : CapabilityValues.Value) : Except String Rat :=
 match value with
 | .ratio n d => .ok (normalize (Int.ofNat n.value) d.value d.positive)
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "PROP-001 prediction is not an exact interval"
structure Validation where
 value : Value
 passed : Bool
def validate (scaleBytes identityBytes targetBytes sourceBytes : ByteArray)
 (scaleDocument identityDocument targetDocument sourceDocument : Value)
 (files : List (String × ByteArray)) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord
 let registrationHash := identity registration
 let (_,scaleLower,scaleUpper) ← EquilibriumBondLengthSource.loadScale scaleBytes scaleDocument
 let targets ← EquilibriumBondLengthSource.loadTargets identityBytes targetBytes sourceBytes identityDocument targetDocument sourceDocument files
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fs => .ok fs
  | .null | .text _ | .integer _ | .boolean _ | .array _ => .error "PROP-001 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues scaleLower scaleUpper
 let targetValues := targets.map fun row => (row.targetId,CapabilityValues.canonical row.interval)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian") targetValues
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-001 prediction package changed"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let entries ← match execution.output with
  | .table entries => if entries.length==2 then .ok entries else .error "PROP-001 prediction vector is incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => .error "PROP-001 prediction vector is incomplete"
 let results ← targets.mapM fun row => do
  let interval ← match entries.reverse.find? (fun p => match p.1 with
    | .label key => Text.equal key.label row.species
    | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false) with
   | some (_,value) => .ok value
   | none => .error (Text.intercalate "" ["'",row.species,"'"])
  let (lowerValue,upperValue) ← match interval with
   | .pair lower upper => .ok (lower,upper)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ => .error "PROP-001 prediction is not an exact interval"
  let predictedLower ← ratioFraction lowerValue
  let predictedUpper ← ratioFraction upperValue
  let overlap := !(predictedUpper.blt row.lower || row.upper.blt predictedLower)
  let displacedLower ← EquilibriumBondLengthSource.ratio (add predictedUpper (wholeRatio 1))
  let displacedUpper ← EquilibriumBondLengthSource.ratio (add predictedUpper (wholeRatio 2))
  let displaced := CapabilityValues.Value.pair displacedLower displacedUpper
  let displacedLeft ← match displaced with
   | .pair left _ => ratioFraction left
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ => .error "PROP-001 prediction is not an exact interval"
  let displacedRejected := row.upper.blt displacedLeft
  let comparison : Value := .object [("target_id",.text row.targetId),("species",.text row.species),
   ("predicted_lower",ratValue predictedLower),("predicted_upper",ratValue predictedUpper),
   ("observed_lower",ratValue row.lower),("observed_upper",ratValue row.upper),
   ("source_inscription",.text row.inscription),("overlap",.boolean overlap)]
  let message := Text.intercalate "" [row.species,": exact predicted interval [",ratText predictedLower,", ",ratText predictedUpper,
   "] angstrom; NIST ",row.inscription," within [",ratText row.lower,", ",ratText row.upper,
   "]; overlap ",boolText overlap]
  return (comparison,(row.species,displacedRejected),overlap,message)
 let comparisons := results.map fun r => r.1
 let adverse := results.map fun r => r.2.1
 let passed := (results.all fun r => r.2.2.1) && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-001 released target identity differs"
 let payload : Value := .object [("registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("scale_input_hash",.text scaleHash),("target_registry_hash",.text targetHash),
  ("comparisons",.array comparisons),("adverse",.array (adverse.map fun (name,b) => .array [.text name,.boolean b])),
  ("trace_hash",.text execution.traceHash)]
 let messages := (results.map fun r => r.2.2.2) ++ (adverse.map fun (name,b) => Text.intercalate "" ["adverse displaced ",name," interval rejected: ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CODATA-2022-ALL-CONSTANTS",.text "NIST-WEBBOOK-SRD69-H2-DIATOMIC-CONSTANTS",.text "NIST-WEBBOOK-SRD69-D2-DIATOMIC-CONSTANTS"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.EquilibriumBondLengthValidation
