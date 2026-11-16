import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.ThermometryEvidence
import SFT.Physics.ThermometryRecords
set_option maxRecDepth 20000
namespace SFT.Physics.ThermometryExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-THERMAL-EQUILIBRIUM-044"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-THERMAL-EQUILIBRIUM-044"
def expectedLabel : String := "sealed-thermal-equilibrium__two-independent-thermometry-intervals-and-noise-response-pass__formal-coordinate-limits-retained"
def frozenRelation : String := "With all values carried as exact integers over 10^30 J/K, exact SI k_B is 13806490/10^30. The acoustic result is (13806484 +/- 28)/10^30 and therefore gives [13806456,13806512]/10^30; the Johnson-noise result is (13806510 +/- 170)/10^30 and gives [13806340,13806680]/10^30. Both intervals contain the exact carrier. The two measurement routes are physically distinct. The acoustic record identifies thermodynamic temperature with mean kinetic energy, and the electronic record reports Johnson noise power as jointly dependent on temperature and resistance to one part per million in its declared regime. No external row claims the Fold dyadic ladder or 3/4:1/4 response coordinates as universal measured values."
def sourcePath : String := "experiments/external_sources/physics/snapshots/thermal-equilibrium-postseal-source-record.json"
def snapshotHash : String := "sha256:8048a2397c064290a0b948b4238b4133c1a2e5c76a72ecf0c47222c9a951d7b5"
def falsification : String := "Reject if any source or row changes; either complete measured interval excludes exact SI k_B; the routes are not physically distinct; the kinetic-temperature or Johnson-noise response row is absent; a limitation row is omitted; an internal Fold coordinate is relabelled as directly measured; or target data alter the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"EXACT-KB","NIST-CODATA-2022-BOLTZMANN","Exact SI Boltzmann carrier","sealed-thermal-equilibrium__two-independent-thermometry-intervals-and-noise-response-pass__formal-coordinate-limits-retained"⟩,⟨"ACOUSTIC-THERMOMETRY","NIM-NIST-ACOUSTIC-BOLTZMANN-2017","Acoustic k_B interval and kinetic-temperature relation","sealed-thermal-equilibrium__two-independent-thermometry-intervals-and-noise-response-pass__formal-coordinate-limits-retained"⟩,⟨"JOHNSON-NOISE-THERMOMETRY","NIST-JOHNSON-NOISE-BOLTZMANN-2011","Electronic k_B interval and thermal-noise response relation","sealed-thermal-equilibrium__two-independent-thermometry-intervals-and-noise-response-pass__formal-coordinate-limits-retained"⟩]

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

def targetIds : List String := ["THERMAL-EQUILIBRIUM-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← ThermometryRecords.authoritativeRecord files payload
 pure [("THERMAL-EQUILIBRIUM-WITHHELD-COMPLETE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=3 := rfl
theorem originalVaultTarget : targetIds=["THERMAL-EQUILIBRIUM-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.ThermometryExperiment
