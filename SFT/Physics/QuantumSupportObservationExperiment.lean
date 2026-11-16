import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.QuantumSupportObservationEvidence
import SFT.Physics.QuantumSupportObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.QuantumSupportObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-QUANTUM-SUPPORT-UNCERTAINTY-050"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-QUANTUM-SUPPORT-UNCERTAINTY-050"
def expectedLabel : String := "sealed-local-factorization-boundary__measured-CHSH-interval-above-two__locality-memory-and-assumption-boundaries-retained__no-ontic-randomness-import"
def frozenRelation : String := "The exact measured S interval [20714,20780]/10000 lies wholly above the local-factorization bound two; its central excess exceeds twenty-two stated standard uncertainties and the reported P value is below 10^-108 across more than one million trials. The complete timing intervals preserve space-like separation, and the analysis retains its memory control. This physically rejects the sealed local-factorization class under the source's declared conditions while preserving deterministic complete-record admissibility, no signalling, and the explicit measurement-independence assumption. The distinct Walsh support-count product remains a formal/computational result and is not relabelled as a variance measurement."
def sourcePath : String := "experiments/external_sources/physics/snapshots/quantum-support-bell-postseal-source-record.json"
def snapshotHash : String := "sha256:51df41e3e1669d853ea3894b3ce039f6f631ad75d519bc632f26b013ff6a7ab1"
def falsification : String := "Reject if either source identity changes; the complete S interval touches or falls below two; the trial, significance, timing or memory records fail; measurement independence or any stated limitation is omitted; the result is presented as excluding all determinism; ontic randomness is imported; the Walsh support law is called a measured variance; or any target changes the sealed survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"BELL-S-INTERVAL","NATURE-STORZ-LOOPHOLE-FREE-BELL-2023","Complete measured CHSH-type S interval and local bound","sealed-local-factorization-boundary__measured-CHSH-interval-above-two__locality-memory-and-assumption-boundaries-retained__no-ontic-randomness-import"⟩,⟨"BELL-TRIALS-SIGNIFICANCE","NATURE-STORZ-LOOPHOLE-FREE-BELL-2023","Trial lower bound, standard-uncertainty excess and P-value record","sealed-local-factorization-boundary__measured-CHSH-interval-above-two__locality-memory-and-assumption-boundaries-retained__no-ontic-randomness-import"⟩,⟨"BELL-SPACE-LIKE-TIMING","NATURE-STORZ-LOOPHOLE-FREE-BELL-2023","Light-travel budget and trial-duration intervals","sealed-local-factorization-boundary__measured-CHSH-interval-above-two__locality-memory-and-assumption-boundaries-retained__no-ontic-randomness-import"⟩,⟨"BELL-MEMORY-CONTROL","NATURE-STORZ-LOOPHOLE-FREE-BELL-2023","Memory-robust statistical analysis","sealed-local-factorization-boundary__measured-CHSH-interval-above-two__locality-memory-and-assumption-boundaries-retained__no-ontic-randomness-import"⟩,⟨"BELL-ASSUMPTION-BOUNDARY","NATURE-STORZ-LOOPHOLE-FREE-BELL-2023","Measurement-independence and unavoidable-assumption statements","sealed-local-factorization-boundary__measured-CHSH-interval-above-two__locality-memory-and-assumption-boundaries-retained__no-ontic-randomness-import"⟩]

def registration : Value := .object [
 ("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("frozen_relation",.text frozenRelation),("source_snapshot_path",.text sourcePath),
 ("source_snapshot_hash",.text snapshotHash),
 ("target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("target_locators",.array (targetRows.map fun row => .array [.text row.targetId,.text row.sourceId,.text row.sourceLocator])),
 ("prediction_program",programDocument),("expected_observation_label",.text expectedLabel),
 ("falsification_condition",.text falsification),("all_rows_required",.boolean true),
 ("target_inaccessible_before_seal",.boolean true)]

def registrationHash : String := admissionIdentity registration

def targetIds : List String := ["NATURE-STORZ-2023-WITHHELD-COMPLETE-BELL-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← QuantumSupportObservationRecords.authoritativeRecord files payload
 pure [("NATURE-STORZ-2023-WITHHELD-COMPLETE-BELL-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["NATURE-STORZ-2023-WITHHELD-COMPLETE-BELL-RECORD"] := rfl
end SFT.Physics.QuantumSupportObservationExperiment
