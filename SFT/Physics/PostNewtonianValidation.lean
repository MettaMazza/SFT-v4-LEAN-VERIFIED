import SFT.Physics.TargetCustody
import SFT.Physics.PostNewtonianExperiment
import SFT.Physics.PostNewtonianMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.PostNewtonianValidation
open SFT.Host SFT.Host.Canonical PostNewtonianPrediction PostNewtonianExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-post-newtonian-fixed-point-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def lookup (rows : List (String × CapabilityValues.Value)) (key : String) : Except String CapabilityValues.Value :=
 match rows.find? (fun p => Text.equal p.1 key) with
 | some p => .ok p.2
 | none => .error (Text.append "KeyError: " key)
def labelMatches (v : CapabilityValues.Value) (family label : String) : Bool := match v with
 | .label held => Text.equal held.family family && Text.equal held.label label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
open PostNewtonianMeasurement
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record v1 v2 : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong D9m seal"
 let registration ← registrationRecord
 let registrationHash := admissionIdentity registration
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← formalPredictionInputs
 let orderedKeys := inputs.map Prod.fst
 let env := envelope derivationSeal inputs registrationHash
 let targets ← releasedTargets files record v1 v2
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") targets
  (admissionIdentity (.array [.text registrationHash,.text PostNewtonianRecords.sourceHash,.object (PostNewtonianRecords.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "D9m hostile audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "D9m prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← PostNewtonianMeasurement.exactMeasurementAnalysis target
 let admissible ← PostNewtonianFixedPoint.admissibleFixedPoints
 let formalChannel := admissible==[normalize 1 4 (by decide)] && analysis.errorsShrink && analysis.correctionsShrink && analysis.factorsBelowQuarter
 let allRows := analysis.allTargetRowsRetained && analysis.historicalCorrections.length==4 && analysis.externalRows.length==5
 let controls := analysis.structural.matter==normalize 7 16 (by decide) && analysis.structural.coupling==normalize 1 2 (by decide) && analysis.structural.fixed==normalize 1 4 (by decide) && analysis.historicalShrink && analysis.mapRowsMatch && analysis.universalNotClaimed && !analysis.fittedValueUsed
 let passed := formalChannel && allRows && controls
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("sources",.object (PostNewtonianRecords.sourceHashes.map (fun (k,v) => (k,.text v)))),("target",.text targetIdentity),("analysis",analysisValue analysis),("formal",.boolean formalChannel),("rows",.boolean allRows),("controls",.boolean controls)]
 let measurements := ["The V1, V2 and primary PN review identities are hash-locked and opened only after the V3 prediction seal.", "V3 independently forces source seven-sixteenths, coupling half-One, admissible fixed point quarter-One and excludes the seven-quarters algebraic root.", "Ten exact successor steps retain positive increasing fields below quarter-One while every error and every added correction shrinks by a factor below quarter-One.", "The complete V1 correction vector seven-fiftieths, seven-one-hundred-fiftieths, seven-thirteen-hundred-fiftieths and seven-one-hundred-nine-thousand-three-hundred-fiftieths is retained and strictly decreasing.", "The V2 self-source map, matter source, coupling and fixed point are reproduced exactly.", "The external review retains nonlinear iteration, the linear-plus-quadratic 1PN scalar structure, weak-field slow-motion near-zone scope, exterior matching and formal any-order hierarchy.", "External formal iteration is not inflated into a claim that every physical PN series converges numerically; the depth-independent convergence proof belongs to the exact registered Fold scalar map."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array ([PostNewtonianRecords.sourceId].map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.PostNewtonianValidation
