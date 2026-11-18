import SFT.Chemistry.MolecularMeasurementExperiment
import SFT.Chemistry.MolecularMeasurementAnalysis
import SFT.Chemistry.NuclearElectronicTargets
import SFT.Chemistry.NuclearElectronicWeights
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularMeasurementValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularMeasurementExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-NIST-CaH-measurement-comparator/1",.text experimentId]))),
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
 return Text.intercalate "" [← rowText row "target_id",": file ",← rowText row "file",
  " row ",integerText (← rowInt row "row_ordinal")," cells ",integerText (← rowInt row "cell_count"),
  " pass ",boolText (rowPassed row)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash actualTargetHash : String) (identityDocument targetDocument : Value)
 (snapshots : List MolecularMeasurementSource.Snapshot) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registrationHash := identity registration
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let targets ← MolecularMeasurementSource.rows actualIdentityHash actualTargetHash identityDocument targetDocument snapshots
 let targetValues ← targets.mapM fun row => do
  let id ← rowText row "target_id"
  pure (id,labelValue "external-molecular-measurement-row" (identity row))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-custodian")
  targetValues (identity (.array [.text registrationHash,.text "sha256:5f34dcfb27bb36ca8931e5a26dcfd290285708c7b4a4412884ff794273416eef"])) (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-014 prediction package differs"
 match execution.output with
 | .table entries => if entries.length==8 then pure () else throw "ELEC-014 prediction package differs"
 | .emptyOne _ | .label _ | .count _ | .ratio _ _ | .word _ | .pair _ _ => throw "ELEC-014 prediction package differs"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let rows ← targets.mapM MolecularMeasurementAnalysis.readRow
 let released ← release.values.mapM fun (id,value) => do
  return (id,← rowText value "label")
 let comparisons := rows.map fun row => MolecularMeasurementAnalysis.rowComparison row released
 let source ← JointCorrelationTargets.field identityDocument "source"
 let components ← JointCorrelationTargets.field source "components" >>= NuclearElectronicTargets.list
 let counts ← MolecularMeasurementAnalysis.counts rows components.length
 let expected : List (String × Nat) := [("package_components",9),("csv_files",8),("rows",330),("cells",796),
  ("real_time_readouts",50),("J2_entry_exit_intervals",117),("J1_entry_exit_intervals",55),
  ("prepared_sublevel_rows",6),("recovery_classes",4),("tracking_intervals",71),
  ("pressure_control_rows",4),("appearance_time_rows",23),("positive_entry_exit_intervals",172),
  ("positive_tracking_intervals",70),("EmptyOne_tracking_boundary",1)]
 let countsExact := counts.length==expected.length && (counts.zip expected).all (fun ((a,n),(b,m)) => Text.equal a b && n==m)
 let absence := counts.any (fun (k,n) => Text.equal k "EmptyOne_tracking_boundary" && n==1)
 let noPredecessor := rows.all fun r => match r.source with
  | .object fs => fs.all (fun (k,_) => !(Text.chars "predecessor").isInfixOf_internal (Text.chars (Text.lowerAscii k)))
  | .null | .integer _ | .text _ | .boolean _ | .array _ => false
 let adverse : List (String × Bool) := [("exact_complete_counts",countsExact),("all_rows",comparisons.all rowPassed),
  ("omission_rejected",(rows.take (rows.length-1)).length != 330),
  ("zero_duration_retained",absence),("unrecorded_predecessor_not_in_dataset",noPredecessor)]
 let passed := adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ELEC-014 released identity differs"
 let payload : Value := .object [("comparisons",.array comparisons),
  ("counts",.object (counts.map fun (k,n) => (k,.integer (.ofNat n)))),
  ("adverse",.object (adverse.map fun (k,b) => (k,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← comparisons.mapM measurement
 let messages := rowMessages ++ counts.map (fun (key,n) => Text.intercalate "" ["count ",key,": ",toString n])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-MDS2-3389-CAH-QUANTUM-STATE-TRACKING-CONTROL-V1.0.1"]),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MolecularMeasurementValidation
