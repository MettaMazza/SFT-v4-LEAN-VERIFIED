import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.VacuumPlanckEvidence
import SFT.Physics.VacuumPlanckRecords
set_option maxRecDepth 20000
namespace SFT.Physics.VacuumPlanckExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036"
def expectedLabel : String := "sealed-vacuum-share-and-normalized-Lambda__Planck-complete-68pc-intervals__CODATA-exact-speed-transport__local-global-type-control__corrected-primary-transcription__no-fit"
def frozenRelation : String := "The exact Fold vacuum share 11/16 is inside Planck's interval [6833/10000,1389/2000]. The normalized Fold magnitude 33/16 is inside [20499/10000,4167/2000]=3 times that interval. Using page-225 H0=67.68 +/- 0.42 km s^-1 Mpc^-1 and exact c=299792.458 km s^-1 transports Lambda to the exact positive interval [(33/16)(67.26/c)^2,(33/16)(68.10/c)^2] Mpc^-2. One/2^20 is below the global interval and is therefore retained only as the separately typed local boundary-energy floor."
def sourcePath : String := "experiments/external_sources/physics/snapshots/vacuum-density-planck-postseal-source-record.json"
def snapshotHash : String := "sha256:a0c8d15b9ab666329943cac4d5899ff5617871d1e1d9d6f60e5d4dd22eed4652"
def falsification : String := "Reject if any source identity or registered row changes; if 11/16 leaves the complete Planck vacuum interval; if 33/16 leaves its exact three-direction transported interval; if the Planck central budget ceases to close at the One; if dimensional transport is nonpositive or scale-inconsistent; if One/2^20 is relabeled as the global fraction; if the older H0 transcription is silently substituted; or if any target changes the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PLANCK-VACUUM-FRACTION","PLANCK-PLA-BASE-NRUN-TTTEEE-BAO-LENSING-68PC","Page 225 Omega_Lambda central value and 68-percent uncertainty","sealed-vacuum-share-and-normalized-Lambda__Planck-complete-68pc-intervals__CODATA-exact-speed-transport__local-global-type-control__corrected-primary-transcription__no-fit"⟩,⟨"PLANCK-MATTER-CLOSURE","PLANCK-PLA-BASE-NRUN-TTTEEE-BAO-LENSING-68PC","Page 225 Omega_m central value and 68-percent uncertainty","sealed-vacuum-share-and-normalized-Lambda__Planck-complete-68pc-intervals__CODATA-exact-speed-transport__local-global-type-control__corrected-primary-transcription__no-fit"⟩,⟨"PLANCK-HUBBLE-TRANSPORT","PLANCK-PLA-BASE-NRUN-TTTEEE-BAO-LENSING-68PC","Page 225 H0 central value and 68-percent uncertainty","sealed-vacuum-share-and-normalized-Lambda__Planck-complete-68pc-intervals__CODATA-exact-speed-transport__local-global-type-control__corrected-primary-transcription__no-fit"⟩,⟨"CODATA-EXACT-SPEED","NIST-CODATA-2022-EXACT-C","Exact speed of light in vacuum","sealed-vacuum-share-and-normalized-Lambda__Planck-complete-68pc-intervals__CODATA-exact-speed-transport__local-global-type-control__corrected-primary-transcription__no-fit"⟩,⟨"TRANSCRIPTION-AND-TYPE-CONTROLS","PLANCK-PLA-BASE-NRUN-TTTEEE-BAO-LENSING-68PC","Corrected H0 row and local/global adverse type control","sealed-vacuum-share-and-normalized-Lambda__Planck-complete-68pc-intervals__CODATA-exact-speed-transport__local-global-type-control__corrected-primary-transcription__no-fit"⟩]

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

def targetIds : List String := ["PLANCK-CODATA-WITHHELD-COMPLETE-VACUUM-SCALE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← VacuumPlanckRecords.authoritativeRecord files payload
 pure [("PLANCK-CODATA-WITHHELD-COMPLETE-VACUUM-SCALE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["PLANCK-CODATA-WITHHELD-COMPLETE-VACUUM-SCALE-RECORD"] := rfl
end SFT.Physics.VacuumPlanckExperiment
