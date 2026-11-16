import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.FizeauEvidence
import SFT.Physics.FizeauRecords
set_option maxRecDepth 20000
namespace SFT.Physics.FizeauExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-VELOCITY-COMPOSITION-034"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-VELOCITY-COMPOSITION-034"
def expectedLabel : String := "sealed-exact-velocity-composition__water-slope-between-raw-and-corrected-relativistic-rows__ordinary-addition-control-strongly-disfavoured__air-control-compatible__systematics-retained__no-fit"
def frozenRelation : String := "The measured water slope is 274/1000 +/- 3/1000 rad s/m. It lies inside the complete reported relativistic-systematics bracket 248/1000 to 299/1000 and is more than ten times closer to its nearest relativistic row than to ordinary addition at 563/1000. The air result independently rejects ordinary addition and is compatible with relativistic composition. This is a post-seal discriminator, not a fit or precision confirmation; all source-stated systematics remain open."
def sourcePath : String := "experiments/external_sources/physics/snapshots/velocity-composition-fizeau-source-record.json"
def snapshotHash : String := "sha256:2d8f4c921c10e4d3917cce4c5cdeb83269c6f135d3d98c99d824ff3cc1fca1b7"
def falsification : String := "Reject if either source identity changes; if a registered measurement, control or limitation is omitted; if the water measured interval leaves the complete reported relativistic-systematics bracket; if ordinary addition is at least as close as both relativistic rows; if the air control no longer disfavors ordinary addition; if any target changes the sealed operation; or if a precision confirmation is claimed beyond the source."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"FIZEAU-WATER-MEASURED","ARXIV-1201.0501-FIZEAU-WATER-AIR","Figure 6 and Section V.C measured water slope and uncertainty","sealed-exact-velocity-composition__water-slope-between-raw-and-corrected-relativistic-rows__ordinary-addition-control-strongly-disfavoured__air-control-compatible__systematics-retained__no-fit"⟩,⟨"FIZEAU-WATER-RELATIVISTIC","ARXIV-1201.0501-FIZEAU-WATER-AIR","Figure 6 raw and corrected relativistic predictions","sealed-exact-velocity-composition__water-slope-between-raw-and-corrected-relativistic-rows__ordinary-addition-control-strongly-disfavoured__air-control-compatible__systematics-retained__no-fit"⟩,⟨"FIZEAU-WATER-ORDINARY-CONTROL","ARXIV-1201.0501-FIZEAU-WATER-AIR","Figure 6 nonrelativistic ordinary-addition prediction","sealed-exact-velocity-composition__water-slope-between-raw-and-corrected-relativistic-rows__ordinary-addition-control-strongly-disfavoured__air-control-compatible__systematics-retained__no-fit"⟩,⟨"FIZEAU-AIR-CONTROL","ARXIV-1201.0501-FIZEAU-WATER-AIR","Figure 8 and Section V.E air result","sealed-exact-velocity-composition__water-slope-between-raw-and-corrected-relativistic-rows__ordinary-addition-control-strongly-disfavoured__air-control-compatible__systematics-retained__no-fit"⟩,⟨"FIZEAU-SYSTEMATICS","ARXIV-1201.0501-FIZEAU-WATER-AIR","Section V.C-D calibration, profile and path-length boundaries","sealed-exact-velocity-composition__water-slope-between-raw-and-corrected-relativistic-rows__ordinary-addition-control-strongly-disfavoured__air-control-compatible__systematics-retained__no-fit"⟩]

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

def targetIds : List String := ["ARXIV-1201.0501-WITHHELD-COMPLETE-FIZEAU-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← FizeauRecords.authoritativeRecord files payload
 pure [("ARXIV-1201.0501-WITHHELD-COMPLETE-FIZEAU-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["ARXIV-1201.0501-WITHHELD-COMPLETE-FIZEAU-RECORD"] := rfl
end SFT.Physics.FizeauExperiment
