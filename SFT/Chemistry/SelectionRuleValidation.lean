import SFT.Chemistry.SelectionRuleExperiment
import SFT.Chemistry.SelectionTargets
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.SelectionRuleValidation
open SFT.Host SFT.Host.Canonical SFT.Physics SelectionRuleExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-NIST-H2-selection-comparator/1",.text experimentId]))),
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
 return Text.intercalate "" [← rowText row "target_id",": class ",← rowText row "observed_class",
  "; exact source hash ",← rowText row "source_record_hash","; pass ",boolText (rowPassed row)]
def measurementPayload (registrationHash : String) (prediction : PredictionSeal) (rows : List Value)
 (counts : List (String × Nat)) (adverse : List (String × Bool)) (traceHash : String) : Value :=
 .object [("registration_hash",.text registrationHash),("prediction_seal_hash",.text prediction.sealHash),
  ("comparisons",.array rows),("counts",.object (counts.map fun (key,n) => (key,.integer (.ofNat n)))),
  ("adverse",.object (adverse.map fun (key,b) => (key,.boolean b))),("trace_hash",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualHashes : List (String × String)) (identities targetDocument : Value)
 (transitionRows symmetryRows : List Value) (raw derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let document := predictionDocument
 let registrationHash := identity registration
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let targets ← SelectionTargets.targets actualHashes identities targetDocument transitionRows symmetryRows raw
 let targetValues ← targets.mapM fun row => do
  let id ← rowText row "target_id"
  pure (id,labelValue "held-external-selection-record" (identity row))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-custodian")
  targetValues (identity (.array [.text registrationHash,.text "sha256:94af2d38e07bbcdd4f70e74557c5f174ebff586f4d287db541bee00ae204b56f"])) (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-010 prediction package changed"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let entries ← match execution.output with
  | .table entries => .ok entries
  | .emptyOne _ | .label _ | .count _ | .ratio _ _ | .word _ | .pair _ _ => .error "ELEC-010 prediction law is incomplete"
 if entries.length != 8 then throw "ELEC-010 prediction law is incomplete"
 let comparisons ← targets.mapM fun row => do
  let id ← rowText row "target_id"
  let released ← match release.values.find? (fun pair => Text.equal pair.1 id) with
   | none => throw "ELEC-010 released target differs"
   | some pair => pure pair.2
  let observed ← rowText released "label"
  if !Text.equal observed (identity row) then throw "ELEC-010 released target differs"
  SelectionObservation.comparison row
 let counts ← SelectionObservation.counts comparisons
 let adverseValue ← SelectionObservation.controls counts
 let adverse ← match adverseValue with
  | .object fields => fields.mapM fun (key,v) => do
    match v with
    | .boolean b => pure (key,b)
    | .null | .integer _ | .text _ | .array _ | .object _ => throw "adverse record is not Boolean"
  | .null | .integer _ | .boolean _ | .text _ | .array _ => throw "adverse record is not an object"
 let passed := comparisons.all rowPassed && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ELEC-010 released identity differs"
 let payload := measurementPayload registrationHash prediction comparisons counts adverse execution.traceHash
 let rowMessages ← comparisons.mapM measurement
 let messages := rowMessages ++ counts.map (fun (key,n) => Text.intercalate "" ["count ",key,": ",toString n]) ++
  adverse.map (fun (key,b) => Text.intercalate "" ["adverse ",key,": ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text SelectionTargets.sourceId]),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.SelectionRuleValidation
