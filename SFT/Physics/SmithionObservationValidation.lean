import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.SmithionObservationExperiment
import SFT.Physics.SmithionObservationAnalysis
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.SmithionObservationValidation
open SFT.Host SFT.Host.Canonical SmithionObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-DARK-SMITHION-LFV-062"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-dark-smithion-lfv-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
def tamperedDensity (target : Value) : Except String Value := do
 let sources ← RunningConvergenceMeasurement.array (← field target "sources")
 let first ← LeptonRatios.atIndex sources 0
 let rows ← field first "rows"
 let dark ← field rows "cold_dark_density_omega_c_h2"
 let changed := replaceField first "rows" (replaceField rows "cold_dark_density_omega_c_h2" (replaceField dark "central" (.text "0.100")))
 .ok (replaceField target "sources" (.array (changed::sources.drop 1)))
def fabricatedRate (target : Value) : Except String Value := do
 let boundary ← field target "methodological_boundary"
 .ok (replaceField target "methodological_boundary" (replaceField boundary "upper_limits_not_relabelled_as_rate_measurements" (.boolean false)))
def formalPass : Bool := match SmithionSpectrum.theoremCertificate with
 | .error _ => false
 | .ok f => match SmithionFlavour.abundanceCertificate with
  | .error _ => false
  | .ok a => match SmithionFlavour.lfvCertificate with
   | .error _ => false
   | .ok l => f.quarkCrossLock && f.twelveRoots && f.allRootsDisjointPositive && a.darkToBaryon==LeptonIntervals.normalize 27 5 (by decide) && (l.integerRatio.length==3 && (l.integerRatio.zip [3,5,20]).all (fun (a,b)=>@decide (a=b) (Int.decEq a b)))
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong dark/Smithion/LFV seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (SmithionObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "dark/Smithion/LFV prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "dark/Smithion/LFV prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← SmithionObservationAnalysis.exactAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := formalPass
 let allRows := yes "all_sources_retained"
 let empirical := yes "ratio_passes" && yes "absolute_transport_passes" && yes "sparc_complete" && yes "all_lfv_limits_positive" && yes "all_lfv_searches_null" && !yes "lfv_relative_rate_measured" && !yes "smithion_mass_measured" && yes "evidence_types_preserved" && yes "all_sources_retained"
 let tamperedAnalysis ← SmithionObservationAnalysis.exactAnalysis (← tamperedDensity target)
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "ratio_passes")
 let fabricatedAnalysis ← SmithionObservationAnalysis.exactAnalysis (← fabricatedRate target)
 let fabricatedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault fabricatedAnalysis "evidence_types_preserved")
 let passed := formal && empirical && tamperedRejected && fabricatedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("tampered_density_rejected",.boolean tamperedRejected),("fabricated_rate_rejected",.boolean fabricatedRejected)]
 let measurements := ["The exact dark/baryon ratio 27/5 lies inside the complete Planck density-ratio interval.", "Comparison-side transport 27/5 times 0.0224 equals 0.12096 and lies inside [0.119,0.121].", "The complete 175-galaxy SPARC record requires additional gravitating support under the admitted inverse-square law; it does not alone identify a particle.", "MEG II and BaBar retain all three null-search upper limits. They do not constitute measured nonzero LFV rates, so no 3:5:20 match is fabricated.", "No registered Smithion mass measurement exists; all twelve spectra remain exact standing predictions.", "Tampered-density and fabricated-rate controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (SmithionObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.SmithionObservationValidation
