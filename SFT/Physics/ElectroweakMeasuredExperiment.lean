import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.ElectroweakMeasuredEvidence
import SFT.Physics.ElectroweakMeasuredRecords
set_option maxRecDepth 20000
namespace SFT.Physics.ElectroweakMeasuredExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053"
def expectedLabel : String := "terminal-electroweak-forced-value-inside-direct-on-shell-measurement__compatible-WZ-reconstruction-passes__inconsistent-aggregate-quarantined-as-measurement-method-record__no-mismatch-admitted-as-closure"
def frozenRelation : String := "The exact forced terminal on-shell share lies inside the complete PDG interval [22333,22351]/100000. Its exact complement lies inside the outward-propagated compatible-input W/Z squared interval. No uncertainty is widened and no inconsistent aggregate is converted into a passing or failing SFT law."
def sourcePath : String := "experiments/external_sources/physics/snapshots/electroweak-measured-value-successor-source-record.json"
def snapshotHash : String := "sha256:e608503e4832c272911c0653dd6db9cf5b662647c4fd652908b7d2299e598057"
def falsification : String := "Reject if either source changes; the sealed exact share leaves the direct on-shell interval; its complement leaves the compatible W/Z squared interval; any uncertainty is widened; the inconsistent aggregate is deleted, used as a second law, or relabelled as an SFT result; or target data alter the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PDG-DIRECT-ON-SHELL-WEAK-SHARE","PDG-2025-STANDARD-MODEL-REVIEW","printed page 23 on-shell sin-squared row","terminal-electroweak-forced-value-inside-direct-on-shell-measurement__compatible-WZ-reconstruction-passes__inconsistent-aggregate-quarantined-as-measurement-method-record__no-mismatch-admitted-as-closure"⟩,⟨"PDG-COMPATIBLE-WZ-RECONSTRUCTION","PDG-2024-W-BOSON-LISTING","printed page 1 compatible W row with the complete Z row","terminal-electroweak-forced-value-inside-direct-on-shell-measurement__compatible-WZ-reconstruction-passes__inconsistent-aggregate-quarantined-as-measurement-method-record__no-mismatch-admitted-as-closure"⟩]

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

def targetIds : List String := ["PDG-ELECTROWEAK-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← ElectroweakMeasuredRecords.authoritativeRecord files payload
 pure [("PDG-ELECTROWEAK-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=2 := rfl
theorem originalVaultTarget : targetIds=["PDG-ELECTROWEAK-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"] := rfl
end SFT.Physics.ElectroweakMeasuredExperiment
