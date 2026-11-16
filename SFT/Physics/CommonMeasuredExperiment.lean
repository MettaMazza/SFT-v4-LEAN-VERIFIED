import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.CommonMeasuredEvidence
import SFT.Physics.CommonMeasuredRecords
set_option maxRecDepth 20000
namespace SFT.Physics.CommonMeasuredExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054"
def expectedLabel : String := "common-scale-terminal-and-support-eight-values-inside-like-typed-measurements__running-direction-preserved__NuTeV-extraction-retained-but-not-rewarded-as-mismatch"
def frozenRelation : String := "The terminal on-shell share lies inside [22333,22351]/100000. The support-eight share 25/106 lies inside [2331,2367]/10000. The complete registered low-transfer vector preserves the sub-W direction. No mismatch, uncertainty multiplier, fitted rung or measurement-selected exception is admitted."
def sourcePath : String := "experiments/external_sources/physics/snapshots/common-scale-measured-value-successor-source-record.json"
def snapshotHash : String := "sha256:4143fd2a2b5f480bc35c84e83b3febd9e04f72661b6c1607ba9bc7204ac61d00"
def falsification : String := "Reject if a source or dependency changes; either forced value leaves its like-typed measured interval; the below-W direction reverses; a row or threshold boundary is omitted; NuTeV displacement is made a passing result; any uncertainty is widened; or target data alter the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PDG-COMMON-SCALE-ON-SHELL","PDG-2026-ELECTROWEAK-SCALE-VECTOR","printed page 23 on-shell row","common-scale-terminal-and-support-eight-values-inside-like-typed-measurements__running-direction-preserved__NuTeV-extraction-retained-but-not-rewarded-as-mismatch"⟩,⟨"PDG-COMMON-SCALE-LOW-TRANSFER","PDG-2026-ELECTROWEAK-SCALE-VECTOR","printed page 25 complete numeric low-transfer vector","common-scale-terminal-and-support-eight-values-inside-like-typed-measurements__running-direction-preserved__NuTeV-extraction-retained-but-not-rewarded-as-mismatch"⟩,⟨"PDG-COMPLETE-STRONG-EM-RUNNING","PDG-2025-2026-STRONG-EM-COMPLETE-RUNNING-VECTOR","complete admitted strong/electromagnetic source vector","common-scale-terminal-and-support-eight-values-inside-like-typed-measurements__running-direction-preserved__NuTeV-extraction-retained-but-not-rewarded-as-mismatch"⟩]

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

def targetIds : List String := ["PDG-COMMON-SCALE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← CommonMeasuredRecords.authoritativeRecord files payload
 pure [("PDG-COMMON-SCALE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=3 := rfl
theorem originalVaultTarget : targetIds=["PDG-COMMON-SCALE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"] := rfl
end SFT.Physics.CommonMeasuredExperiment
