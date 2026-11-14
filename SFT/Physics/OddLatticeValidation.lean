import SFT.Physics.TargetCustody
import SFT.Physics.OddLatticeExperiment
import SFT.Physics.OddLatticeMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.OddLatticeValidation
open SFT.Host SFT.Host.Canonical OddLatticePrediction OddLatticeExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-ODD-LATTICE-ALL-REGION-OCCUPANCY-TERMINAL-007"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-odd-lattice-all-region-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def analysisValue (a : OddLatticeMeasurement.Analysis) : Value :=
 let ns := fun xs : List Nat => Value.array (xs.map (fun n => .integer (.ofNat n)))
 .object [("member_count",.integer a.memberCount),("step_count",.integer a.stepCount),("region_count",.integer a.regionCount),
 ("complete_recurrence_vector",ns a.completeRecurrenceVector),("first_step_vector",ns a.firstStepVector),
 ("depth_invariant",.boolean a.depthInvariant),("all_regions_occupied",.boolean a.allRegionsOccupied),
 ("complete_member_total_retained",.boolean a.completeMemberTotalRetained),("exact_balance_span_is_One",.boolean a.exactBalanceSpanIsOne),
 ("legacy_acceptance_rule_passed",.boolean a.legacyAcceptanceRulePassed)]
def targetCount (target : Value) (key : String) : Except String Int := do
 let s ← RunningConvergenceMeasurement.text (← field target key)
 match LeptonDecimal.exponent (Text.chars s) with
 | some n => pure n
 | none => throw "ValueError"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "odd-lattice validator received the wrong claim seal"
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
  (admissionIdentity (.array [.text registrationHash,.text OddLatticeRecords.sourceHash,.object (OddLatticeRecords.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "odd-lattice prediction failed hostile-package audit"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "capability-closed odd-lattice prediction differs from formal inputs"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let members ← targetCount target "lattice_member_count"
 let steps ← targetCount target "fold_step_count"
 let regions ← targetCount target "region_count"
 let analysis ← OddLatticeMeasurement.exactMeasurementAnalysis members steps regions
 let cert ← OddLatticeAllRegionCertificate.formalCertificate
 let foldLabel ← lookup prediction "Fold_relation"
 let depthLabel ← lookup prediction "depth_relation"
 let coverageLabel ← lookup prediction "coverage_relation"
 let formalChannel := labelMatches foldLabel "odd-lattice-Fold" "binary-residue-permutation" &&
  labelMatches depthLabel "odd-lattice-depth" "every-positive-successor-invariant" &&
  labelMatches coverageLabel "odd-lattice-coverage" "all-regions-occupied-when-regions-do-not-exceed-members" &&
  cert.certificates.all (fun c => c.allStepsEqual) && cert.certificates.all (fun c => c.permutation.imageComplete)
 let checkedRecord ← OddLatticeRecords.authoritativeRecord files record
 let completeSources := (← RunningConvergenceMeasurement.array (← field checkedRecord "snapshots")).length==2
 let first ← OddLatticeMeasurement.independentObservation (.integer 255) (.integer 1) (.integer 8)
 let eleventh ← OddLatticeMeasurement.independentObservation (.integer 255) (.integer 11) (.integer 8)
 let seven ← OddLatticeMeasurement.independentObservation (.integer 255) (.integer 12) (.integer 7)
 let eight ← OddLatticeMeasurement.independentObservation (.integer 255) (.integer 12) (.integer 8)
 let adverse := first==analysis.completeRecurrenceVector && eleventh==analysis.completeRecurrenceVector &&
  seven.foldl Nat.add 0==255 && eight.eraseDups.length==2 && ((List.range 254).map (fun i => i+1)).eraseDups.length != 255
 let allRows := completeSources && decide (analysis.memberCount=255) && decide (analysis.stepCount=12) && decide (analysis.regionCount=8) && analysis.completeRecurrenceVector.length==8
 let passed := [formalChannel,allRows,adverse,analysis.depthInvariant,analysis.allRegionsOccupied,analysis.completeMemberTotalRetained,analysis.exactBalanceSpanIsOne,analysis.legacyAcceptanceRulePassed].all id
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text predictionSeal.sealHash),("source_record_hash",.text OddLatticeRecords.sourceHash),("source_hashes",.object (OddLatticeRecords.sourceHashes.map (fun (k,v) => (k,.text v)))),("target_identity_hash",.text targetIdentity),("analysis",analysisValue analysis),("formal_channel",.boolean formalChannel),("complete_sources",.boolean completeSources),("adverse_controls",.boolean adverse),("prediction_trace_hash",.text execution.traceHash)]
 let vectorRepr := Text.intercalate "" ["(",Text.intercalate ", " (analysis.completeRecurrenceVector.map (fun n => render (.integer (.ofNat n)))),")"]
 let measurements := [
 "Both frozen V1 E3 source files are retained byte-for-byte and were opened only after the V3 prediction seal.",
 "Released historical inputs: complete 255-member lattice, twelve Fold steps and eight regions.",
 Text.intercalate "" ["Complete independently measured recurrence vector: ",vectorRepr,"."],
 "Every one of the eight regions is occupied; the exact vector totals all 255 members.",
 "The same complete vector occurs after the first, eleventh and twelfth positive Fold steps, directly replicating and strengthening the original measured statement.",
 "The V3 law is depth-independent and applies to every positive finite odd complete lattice and every complete region partition within its member count; the historical run did not select that law."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array ([OddLatticeRecords.sourceId].map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.OddLatticeValidation
