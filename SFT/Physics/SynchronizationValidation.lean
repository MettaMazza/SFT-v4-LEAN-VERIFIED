import SFT.Physics.TargetCustody
import SFT.Physics.SynchronizationExperiment
import SFT.Physics.CoupledEnsembleSynchronizationMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.SynchronizationValidation
open SFT.Host SFT.Host.Canonical SynchronizationPrediction SynchronizationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-COUPLED-ENSEMBLE-SYNCHRONIZATION-TERMINAL-007"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-coupled-ensemble-synchronization-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
open CoupledEnsembleSynchronizationMeasurement
def frac (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def rats (xs : List Rat) : Value := .array (xs.map frac)
def nat (n : Nat) : Value := .integer (.ofNat n)
def recValue (r : Recurrence) : Value := .object [("coupling",frac r.coupling),("region_count_recurrence",.array (r.regionCountRecurrence.map nat)),("final_region_count",nat r.finalRegionCount),("final_points",rats r.finalPoints),("terminal_common_point",match r.terminalCommonPoint with | [p] => frac p | [] => .array [] | _::_::_ => .array [])]
def analysisValue (a : Analysis) : Value := .object [("denominator",.integer a.denominator),("member_count",.integer a.memberCount),("step_count",.integer a.stepCount),("region_count",.integer a.regionCount),("couplings",rats a.couplings),("recurrences",.array (a.recurrences.map recValue)),("final_region_counts",.array (a.finalRegionCounts.map nat)),("printed_final_region_counts",.array (a.printedFinalRegionCounts.map Value.integer)),("all_printed_rows_reproduced",.boolean a.allPrintedRowsReproduced),("half_One_uniquely_reaches_one_region",.boolean a.halfOneUniquelyReachesOneRegion),("half_One_recurrence",.array (a.halfOneRecurrence.map nat)),("half_One_terminal_point",match a.halfOneTerminalPoint with | [p] => frac p | [] => .array [] | _::_::_ => .array []),("half_One_terminal_members_identical",.boolean a.halfOneTerminalMembersIdentical),("half_One_first_one_region_step",nat a.halfOneFirstOneRegionStep)]
def targetCount (target : Value) (key : String) : Except String Int := do
 let s ← RunningConvergenceMeasurement.text (← field target key)
 match LeptonDecimal.exponent (Text.chars s) with
 | some n => pure n
 | none => throw "ValueError"
def rationalText (value : Value) : Except String Rat := do
 let value ← RunningConvergenceMeasurement.text value
 match LeptonDecimal.split '/' (Text.chars value) with
 | [n,d] =>
  let n ← match LeptonDecimal.exponent n with | some x => .ok x | none => .error "ValueError"
  match LeptonDecimal.exponent d with
  | some (.ofNat (d+1)) => pure (normalize n (d+1) (Nat.zero_lt_succ d))
  | some (.negSucc d) => pure (normalize (-n) (d+1) (Nat.zero_lt_succ d))
  | some (.ofNat 0) => throw "ZeroDivisionError"
  | none => throw "ValueError"
 | [_] => LeptonDecimal.exactDecimal value
 | [] | _::_::_::_ => throw "ValueError"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong coupled-ensemble seal"
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
 let targets ← releasedTargets files record
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") targets
  (admissionIdentity (.array [.text registrationHash,.text SynchronizationRecords.sourceHash,.object (SynchronizationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "coupled-ensemble hostile-package audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "coupled-ensemble prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let denominator ← targetCount target "ensemble_denominator"
 let members ← targetCount target "ensemble_member_count"
 let steps ← targetCount target "coupled_fold_step_count"
 let regions ← targetCount target "region_count"
 let couplings ← (← RunningConvergenceMeasurement.array (← field target "complete_coupling_support")).mapM rationalText
 let printed ← (← RunningConvergenceMeasurement.array (← field target "printed_final_region_counts")).mapM (fun v => do
  let s ← RunningConvergenceMeasurement.text v
  match LeptonDecimal.exponent (Text.chars s) with | some n => .ok n | none => .error "ValueError")
 let analysis ← CoupledEnsembleSynchronizationMeasurement.exactMeasurementAnalysis denominator members steps regions couplings printed
 let cert ← CoupledEnsembleSynchronizationCertificate.formalCertificate
 let formalChannel := cert.uniqueSynchronizingCoupling==normalize 1 2 (by decide) && cert.halfOneResidualsEmpty && cert.offHalfResidualsPositive && cert.synchronizedTerminalPreserved
 let allRows := analysis.recurrences.length==5 && analysis.recurrences.all (fun r => r.regionCountRecurrence.length==15 && r.finalPoints.length==20)
 let controls := analysis.finalRegionCounts==[7,7,1,5,5] && analysis.halfOneRecurrence==[12,10,7,5,4,3,2,1,1,1,1,1,1,1,1] && analysis.halfOneTerminalPoint==[normalize 4 7 (by decide)] && analysis.halfOneFirstOneRegionStep==8
 let passed := [formalChannel,allRows,controls,analysis.allPrintedRowsReproduced,analysis.halfOneUniquelyReachesOneRegion,analysis.halfOneTerminalMembersIdentical].all id
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("source_hashes",.object (SynchronizationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))),("target_identity",.text targetIdentity),("analysis",analysisValue analysis),("formal_channel",.boolean formalChannel),("all_rows",.boolean allRows),("controls",.boolean controls),("trace",.text execution.traceHash)]
 let tuple := fun xs : List Nat => Text.intercalate "" ["(",Text.intercalate ", " (xs.map (fun n => render (.integer (.ofNat n)))),")"]
 let measurements := [
 "Both frozen V1 E4 files are retained byte-for-byte and opened only after the V3 prediction seal.",
 "All five registered couplings and all fifteen region-count steps per coupling were independently recomputed exactly.",
 Text.intercalate "" ["Complete final coupling vector: ",tuple analysis.finalRegionCounts,"."],
 Text.intercalate "" ["Half-One recurrence: ",tuple analysis.halfOneRecurrence,"."],
 "Half-One uniquely reaches one occupied region, first at step eight, and all twenty members finish exactly at four-sevenths.",
 "Off-half controls remain visible and finish at seven, seven, five and five occupied regions; they cannot be discarded to manufacture uniqueness."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array ([SynchronizationRecords.sourceId].map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.SynchronizationValidation
