import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.ReggeMeasuredEvidence
import SFT.Physics.ReggeMeasuredRecords
set_option maxRecDepth 20000
namespace SFT.Physics.ReggeMeasuredExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-HADRON-REGGE-MEASURED-VALUE-060"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-HADRON-REGGE-MEASURED-VALUE-060"
def expectedLabel : String := "zero-parameter-three-fifths-base-and-six-fifths-step__all-five-exact-squared-carriers-inside-complete-measured-resonance-supports__rho5-omission-retained__no-pole-error-mismatch-reward"
def frozenRelation : String := "The forced squared carriers 3/5, 9/5, 3, 21/5 and 27/5 all lie inside their corresponding complete measured resonance-support intervals. All five rows and the rho5 omission status are retained. No fitted slope, intercept, residual, selected row, uncertainty widening or mismatch-as-success remains."
def sourcePath : String := "experiments/external_sources/physics/snapshots/hadron-regge-measured-value-successor-source-record.json"
def snapshotHash : String := "sha256:6877a2e12365b035d3391a1a28af2f49693d8a749df276be3c772491a50ca356"
def falsification : String := "Reject if a source or dependency changes; any exact carrier leaves its most restrictive measured resonance support; a row or status is missing; a width or uncertainty is widened; a coefficient or correction is fitted; a mismatch is rewarded; or targets alter the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"REGGE-RESONANCE-J1","PDG-2025-RHO-770","mass, mass uncertainty, width, width uncertainty and listing status","zero-parameter-three-fifths-base-and-six-fifths-step__all-five-exact-squared-carriers-inside-complete-measured-resonance-supports__rho5-omission-retained__no-pole-error-mismatch-reward"⟩,⟨"REGGE-RESONANCE-J2","PDG-2025-A2-1320","mass, mass uncertainty, width, width uncertainty and listing status","zero-parameter-three-fifths-base-and-six-fifths-step__all-five-exact-squared-carriers-inside-complete-measured-resonance-supports__rho5-omission-retained__no-pole-error-mismatch-reward"⟩,⟨"REGGE-RESONANCE-J3","PDG-2025-RHO3-1690","mass, mass uncertainty, width, width uncertainty and listing status","zero-parameter-three-fifths-base-and-six-fifths-step__all-five-exact-squared-carriers-inside-complete-measured-resonance-supports__rho5-omission-retained__no-pole-error-mismatch-reward"⟩,⟨"REGGE-RESONANCE-J4","PDG-2025-A4-1970","mass, mass uncertainty, width, width uncertainty and listing status","zero-parameter-three-fifths-base-and-six-fifths-step__all-five-exact-squared-carriers-inside-complete-measured-resonance-supports__rho5-omission-retained__no-pole-error-mismatch-reward"⟩,⟨"REGGE-RESONANCE-J5","PDG-2025-RHO5-2350","mass, mass uncertainty, width, width uncertainty and listing status","zero-parameter-three-fifths-base-and-six-fifths-step__all-five-exact-squared-carriers-inside-complete-measured-resonance-supports__rho5-omission-retained__no-pole-error-mismatch-reward"⟩]

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

def targetIds : List String := ["HADRON-REGGE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← ReggeMeasuredRecords.authoritativeRecord files payload
 pure [("HADRON-REGGE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD",record)]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["HADRON-REGGE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"] := rfl
end SFT.Physics.ReggeMeasuredExperiment
