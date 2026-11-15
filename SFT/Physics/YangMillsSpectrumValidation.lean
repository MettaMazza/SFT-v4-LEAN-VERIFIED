import SFT.Physics.TargetCustody
import SFT.Physics.YangMillsSpectrumExperiment
import SFT.Physics.YangMillsSpectrumMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.YangMillsSpectrumValidation
open SFT.Host SFT.Host.Canonical YangMillsSpectrumExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-yang-mills-singlet-gap-spectrum-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.family "physical-observation" && Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong Yang-Mills spectrum seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (YangMillsSpectrumRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "Yang-Mills prediction package audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "Yang-Mills spectrum prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← YangMillsSpectrumMeasurement.exactSpectrumAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let formal := YangMillsSpectrumWitnesses.witnesses.all YangMillsSpectrumWitnesses.Witness.passed
 let allRows := equals "row_count" (.integer 3) && equals "quantum_number_order" (.array [.text "0++",.text "2++",.text "0-+"]) && yes "scope_rows_retained"
 let controls := yes "all_central_masses_positive" && yes "all_lower_edges_positive" && yes "intervals_strictly_ordered_and_disjoint" && yes "ground_state_scalar" && yes "first_excitation_tensor"
 let rows ← RunningConvergenceMeasurement.array (← field target "precise_lattice_rows")
 let tamperedRows ← match rows with
  | [] => .error "IndexError"
  | first::rest => .ok (replaceField first "mass_mev" (.text "2400")::rest)
 let tampered := replaceField target "precise_lattice_rows" (.array tamperedRows)
 let tamperedAnalysis ← YangMillsSpectrumMeasurement.exactSpectrumAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "intervals_strictly_ordered_and_disjoint")
 let passed := formal && allRows && controls && tamperedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("source_hashes",hashes),("target_identity",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("all_rows",.boolean allRows),("controls",.boolean controls),("tampered_rejected",.boolean tamperedRejected),("trace",.text execution.traceHash)]
 let measurements := ["The PDG 2026 source record and complete PDF are hash-locked and released only after the Fold prediction seal.", "All three registered pure-gauge lattice mass and uncertainty rows are retained and evaluated with exact rational inscriptions.", "The 0++ interval 1627-1679 MeV, 2++ interval 2344-2408 MeV and 0-+ interval 2521-2601 MeV are each strictly positive and mutually ordered without overlap.", "The source identifies 0++ as the lattice ground state and 2++ as the first excitation; these quantum-number labels are retained external records, not separately forced by this Fold claim.", "The quenched approximation, neglected quark loops, glue/quark-state mixing, full-QCD requirements and high-statistics limitation are retained.", "The PDG nonidentification boundary is retained: no scalar below 2 GeV is established as predominantly glueball, and no unambiguous experimental glueball is claimed.", "No dimensionful lattice value selects, fits or numerically identifies the exact normalized Fold gap one-third.", "A deliberately altered lowest-mass row breaks interval ordering and is rejected."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array [.text YangMillsSpectrumRecords.sourceId]),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.YangMillsSpectrumValidation
