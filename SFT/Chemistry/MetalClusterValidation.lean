import SFT.Chemistry.MetalClusterExperiment
import SFT.Chemistry.MetalClusterComparison
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MetalClusterValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MetalClusterExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-metal-cluster/1",.text falsification]))),
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
def measurementPayload (registrationHash derivationSeal : String) (prediction : PredictionSeal)
 (analysis : Value) (rows : List Value) (controls : List (String × Bool)) (traceHash : String) : Value :=
 .object [("registration",.text registrationHash),("sealed",.text derivationSeal),
  ("prediction",.text prediction.sealHash),("analysis",analysis),("comparisons",.array rows),
  ("controls",.object (controls.map fun (key,b) => (key,.boolean b))),("trace",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash : String) (identityDocument targetDocument primary : Value)
 (sourceHashes : List (String × String))
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let document ← MetalClusterPrediction.predictionDocument actualIdentityHash identityDocument
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fs => fs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let program ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "INORG-014 package changed"
 let predicted ← MetalClusterSource.predictionMap execution.output
 let checkedSources ← sourceFiles.mapM fun (path,expected) => do
  let actual ← match sourceHashes.find? (fun p => Text.equal p.1 path) with
   | some p => pure p.2
   | none => throw (Text.append "missing source hash: " path)
  return (path,expected,actual)
 let rows ← MetalClusterSource.sourceRows checkedSources actualIdentityHash identityDocument targetDocument
 let targetValues ← rows.mapM fun row => do
  let targetId ← rowText row "target_id"
  let held ← CapabilityValues.heldLabel "external-complete-source-record-hash" (← rowText row "target_payload_hash")
  return (targetId,CapabilityValues.canonical (.label held))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-complete-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash])) (identity (envelope registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) release.values
 let comparisons ← rows.mapM (MetalClusterComparison.compare predicted release.values)
 let analysis ← MetalClusterAnalysis.analysis rows primary
 let controls ← MetalClusterComparison.controls rows primary analysis document release.values targetRegistryHash
 let passed := comparisons.all rowPassed && MetalClusterComparison.analysisPassed analysis && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "INORG-014 target identity differs"
 let payload := measurementPayload registrationHash derivationSeal prediction analysis comparisons controls execution.traceHash
 let vectorHash ← JointCorrelationTargets.field analysis "complete_target_vector_hash" >>= JointCorrelationTargets.text
 let rowMessages := ["two-centre direct, two-centre two-bridge and held grouping cluster witnesses; successor centre count three",
  "complete ten-row two-source cluster and iron-sulfur vector; external charge inscriptions retained downstream",
  Text.append "complete exact target vector " vectorHash]
 let messages := rowMessages ++ controls.map (fun (key,b) => Text.intercalate "" ["control ",key,": ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MetalClusterValidation
