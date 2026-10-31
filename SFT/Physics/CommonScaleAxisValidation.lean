import SFT.Physics.CommonScaleAxisPrediction
namespace SFT.Physics.CommonScaleAxisValidation
open SFT.Host SFT.Host.Canonical CommonScaleAxisPrediction CommonScaleAxisMeasurement
open RunningConvergenceMeasurement (field array sameValue)
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def sourceHashesValue : Value := .object (sourceHashes.map (fun (p,h) => (p,.text h)))
def envelope (sealedHash : String) (inputs : List (String × CapabilityValues.Value)) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map (fun (key,v) => (key,.text (identity (CapabilityValues.canonical v)))))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text (identity (.array [.text sealedHash,.text frozenRelation]))),
 ("experiment_registration_hash",.text (identity (registration inputs)))]

def sealPrediction (old : Option PredictionSeal) (sealedHash : String) (inputs : List (String × CapabilityValues.Value))
 (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match old with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
  let env := identity (envelope sealedHash inputs)
  let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),
    ("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
  .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def outputMapping (output : CapabilityValues.Value) (keys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length == keys.length then .ok (keys.zip cells) else .error "common-scale prediction has wrong Fold shape"
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => .error "common-scale prediction has wrong Fold shape"

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (registrationHash : String) (execution : CapabilityExecution.Execution)
 (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-common-scale-axis-comparator/1",.text registrationHash,.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),
 ("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registrationHash : String) (release : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text release.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text release.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text release.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

def requiredAnalysis : List String := ["terminal_inside_on_shell_interval","leading_support_eight_inside_APV_interval","E158_interval_strictly_above_MS_Z","APV_interval_strictly_above_MS_Z","eDIS_interval_overlaps_MS_Z","NuTeV_adverse_interval_above_terminal_on_shell","scheme_rows_complete","low_transfer_rows_complete","figure_classes_complete","threshold_boundary_retained","running_certificate_passed","terminal_electroweak_certificate_passed","proton_Planck_certificate_passed"]
def measurements : List String := ["The exact common axis, terminal held-support chain and scale-ratio law sealed before release of any coupling or dimensional target.","The terminal on-shell weak share lies inside the complete PDG 2026 on-shell interval without a fitted rung or correction.","The exact leading support-eight weak share 25/106 lies inside the complete registered cesium APV interval; this is a post-seal correspondence, not the selector of support eight.","The full SLAC E158 and cesium APV intervals lie above the MS Z interval, matching the sealed sub-W descending direction.","The eDIS interval overlaps the Z interval and remains non-discriminating; the NuTeV on-shell interval lies above the terminal interval and remains an explicit adverse row with its interpretation concerns.","The complete PDG weak-running figure is retained by immutable source hash; no unprinted coordinates are reverse-digitized.","The PDG W-threshold minimum and sign change are retained, so the finite monotone Fold branch is not overclaimed as one universal all-energy curve.","The already admitted complete strong and electromagnetic multi-scale vectors, terminal electroweak comparison and proton-Planck hierarchy comparison remain hash-bound dependencies of this one-axis result.","Changing the on-shell target to a disjoint interval rejects the correspondence."]
structure Validation where
 value : Value
 passed : Bool

def validate (files : List (String × ByteArray)) (record running : Value) (certificates : List (String × Value))
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong common-scale seal"
 let inputs ← formalPredictionInputs
 let registrationHash := identity (registration inputs)
 let programFields ← objectFields (predictionDocument inputs)
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let target ← authoritativeRecord files record running certificates
 let targetId ← RunningConvergencePrediction.item targetIds 0
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") [(targetId,target)]
  (identity (.array [.text registrationHash,sourceHashesValue])) (identity (envelope derivationSeal inputs))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none derivationSeal inputs execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "common-scale hostile-package audit failed"
 let (_,release) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment release predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
  targetIds release.values
 let prediction ← outputMapping execution.output (inputs.map Prod.fst)
 if !sameValue (inputsValue prediction) (inputsValue inputs) then throw "common-scale prediction changed"
 let released ← field (.object release.values) targetId
 let analysis ← exactMeasurementAnalysis released
 let controls := requiredAnalysis.all (fun key => isTrue (get analysis key))
 let changed ← exactMeasurementAnalysis (← tamperedTarget released)
 let tamperedRejected := !isTrue (get changed "terminal_inside_on_shell_interval")
 let rows := ["scheme_rows_complete","low_transfer_rows_complete","figure_classes_complete"].all (fun key => isTrue (get analysis key)) &&
   (← objectFields (← field released "inherited_certificates")).length == 3
 let passed := controls && tamperedRejected && rows
 let targetIdentity ← TargetCustody.identityFromRelease release
 let comparison : Value := .object [
  ("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("source_hashes",sourceHashesValue),
  ("target_identity",.text targetIdentity),("analysis",analysis),("all_rows",.boolean rows),
  ("controls",.boolean controls),("tampered_rejected",.boolean tamperedRejected),("trace",.text execution.traceHash)]
 pure ⟨.object [
  ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),
  ("target_custody_certificate",custodyCertificate registrationHash release predictionSeal),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
  ("all_rows_preserved",.boolean rows),("data_source_ids",.array (sourceIds.map Value.text)),
  ("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (identity comparison)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩

theorem resealRejected (old : PredictionSeal) (sealedHash : String) (inputs : List (String × CapabilityValues.Value))
 (execution : CapabilityExecution.Execution) : sealPrediction (some old) sealedHash inputs execution = .error "prediction is already sealed and cannot be replaced" := rfl
end SFT.Physics.CommonScaleAxisValidation
