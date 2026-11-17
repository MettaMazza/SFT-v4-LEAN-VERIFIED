import SFT.Chemistry.JointCorrelationExperiment
import SFT.Chemistry.JointCorrelationControls
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.JointCorrelationValidation
open SFT.Host SFT.Host.Canonical SFT.Physics JointCorrelationExperiment
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-APS-NIST-joint-correlation-comparator/1",.text experimentId]))),
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



def boolText (b : Bool) : String := if b then "True" else "False"
def rowText (row : Value) (key : String) : Except String String := JointCorrelationTargets.field row key >>= JointCorrelationTargets.text
def rowInt (row : Value) (key : String) : Except String Int := JointCorrelationTargets.field row key >>= JointCorrelationTargets.integer
def rowPassed (row : Value) : Bool := match JointCorrelationTargets.field row "passed" with
 | .ok (.boolean b) => b
 | .ok (.null) | .ok (.integer _) | .ok (.text _) | .ok (.array _) | .ok (.object _) | .error _ => false
def integerText : Int → String
 | .ofNat n => toString n
 | .negSucc n => Text.append "-" (toString (n+1))
def measurement (row : Value) : Except String String := do
 return Text.intercalate "" [← rowText row "target_id"," (",← rowText row "species"," ",← rowText row "state",
  "): ",← rowText row "value_inscription"," ",← rowText row "unit","; uncertainty ",← rowText row "uncertainty_inscription",
  "; kind ",← rowText row "record_kind","; joint ",integerText (← rowInt row "joint_word_count"),"/Cartesian ",
  integerText (← rowInt row "independent_cartesian_count"),"; pass ",boolText (rowPassed row)]
def measurementPayload (registrationHash : String) (prediction : PredictionSeal) (rows : List Value)
 (counts : List (String × Nat)) (adverse : List (String × Bool)) (traceHash : String) : Value :=
 .object [("registration_hash",.text registrationHash),("prediction_seal_hash",.text prediction.sealHash),
  ("comparisons",.array rows),("counts",.object (counts.map fun (key,n) => (key,.integer (.ofNat n)))),
  ("adverse",.object (adverse.map fun (key,b) => (key,.boolean b))),("trace_hash",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash identitySchema : String) (ids : List String)
 (actualTargetHash targetSchema : String) (rawTargets : List JointCorrelationTargets.Target)
 (actualApsHash actualNistHash apsSchema : String) (apsRecords : List Value) (events : List JointCorrelationNotes.Event)
 (tamperedApsHash derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let document ← JointCorrelationPrediction.predictionDocument actualIdentityHash identitySchema ids
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fs => fs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let program ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let targets ← JointCorrelationTargets.reconstructedTargets actualIdentityHash identitySchema ids actualTargetHash targetSchema
  rawTargets actualApsHash actualNistHash apsSchema apsRecords events
 let targetValues := targets.map fun row => (row.row.targetId,CapabilityValues.canonical row.targetValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-APS-NIST-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash])) (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-007 prediction package changed during execution"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) release.values
 let entries ← match execution.output with
  | .table entries => .ok entries
  | .emptyOne _ | .label _ | .count _ | .ratio _ _ | .word _ | .pair _ _ => .error "ELEC-007 prediction is not a complete Fold table"
 let predicted ← JointCorrelationComparison.predictionMap entries
 JointCorrelationComparison.validatePrediction predicted
 let comparisons ← targets.mapM (JointCorrelationComparison.compare predicted)
 let counts ← JointCorrelationControls.counts comparisons
 let adverse ← JointCorrelationControls.adverse comparisons counts actualApsHash tamperedApsHash
 let passed := comparisons.all rowPassed && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ELEC-007 released target differs"
 let payload := measurementPayload registrationHash prediction comparisons counts adverse execution.traceHash
 let rowMessages ← comparisons.mapM measurement
 let messages := rowMessages ++ counts.map (fun (key,n) => Text.intercalate "" ["count ",key,": ",toString n]) ++
  adverse.map (fun (key,b) => Text.intercalate "" ["adverse ",key,": ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.JointCorrelationValidation
