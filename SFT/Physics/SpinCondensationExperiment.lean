import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.SpinCondensationEvidence
import SFT.Physics.SpinCondensationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.SpinCondensationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-SPIN-STATISTICS-CONDENSATION-046"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-SPIN-STATISTICS-CONDENSATION-046"
def expectedLabel : String := "sealed-spin-statistics-condensation__finite-bec-pauli-blocking-and-two-turn-spinor-pass__scale-boundaries-retained"
def frozenRelation : String := "The finite Bose record measures ground-state occupation, its increase under cooling, and a sharp transition at (94 +/- 5)/100 of the declared trap scale, giving the exact interval [89,99]/100. The finite two-spin-state Fermi record directly observes Pauli blocking and a factor-two reduction in effective collision cross section. The sealed alternating-state return is two complete turns, corresponding to 720 degrees; the neutron-interferometry result is 704 +/- 38 degrees, giving [666,742], which contains 720. All three physical routes agree with their respective sealed structural distinctions. The BEC scale ratio and collision-response factor are retained as external apparatus-dependent measurements rather than relabelled universal Fold proof scalars."
def sourcePath : String := "experiments/external_sources/physics/snapshots/spin-statistics-condensation-postseal-source-record.json"
def snapshotHash : String := "sha256:9d24c12e31092f34854c71c3dce2b355dd1d1f2ae6347a03bbea45ef01508cfa"
def falsification : String := "Reject if any source or row changes; finite bosons fail to accumulate in the measured ground state under cooling; Pauli blocking is absent in the declared identical-fermion regime; the complete spinor interval excludes 720 degrees; a trap-specific or response-specific value is relabelled as a universal formal scalar; an unfavorable row is omitted; or target data alter the sealed formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"FINITE-BEC","APS-JILA-BEC-GROUND-OCCUPATION-1996","Finite Bose-gas ground occupation, cooling direction and transition interval","sealed-spin-statistics-condensation__finite-bec-pauli-blocking-and-two-turn-spinor-pass__scale-boundaries-retained"⟩,⟨"PAULI-BLOCKING","NIST-JILA-PAULI-BLOCKING-2001","Direct two-spin-state Pauli-blocking measurement","sealed-spin-statistics-condensation__finite-bec-pauli-blocking-and-two-turn-spinor-pass__scale-boundaries-retained"⟩,⟨"TWO-TURN-SPINOR","RAUCH-COHERENT-SPINOR-ROTATION-1975","Neutron-interferometry two-turn return interval","sealed-spin-statistics-condensation__finite-bec-pauli-blocking-and-two-turn-spinor-pass__scale-boundaries-retained"⟩]

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

def targetIds : List String := ["SPIN-STATISTICS-CONDENSATION-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← SpinCondensationRecords.authoritativeRecord files payload
 pure [("SPIN-STATISTICS-CONDENSATION-WITHHELD-COMPLETE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=3 := rfl
theorem originalVaultTarget : targetIds=["SPIN-STATISTICS-CONDENSATION-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.SpinCondensationExperiment
