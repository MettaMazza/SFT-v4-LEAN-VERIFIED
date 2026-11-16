import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.HorizonObservationEvidence
import SFT.Physics.HorizonObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.HorizonObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-COMPACT-HORIZON-THERMODYNAMICS-072"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-COMPACT-HORIZON-THERMODYNAMICS-072"
def expectedLabel : String := "sealed-compact-horizon-law-versus-complete-current-object-boundary"
def frozenRelation : String := "The external dimensional record contains the 7/5-solar-mass electron-degenerate limit. The independently measured neutral-fermion-supported PSR J0740 mass interval is [201/100,215/100] solar masses, wholly above 7/5. The conditional merger-remnant upper records 267/100 and 61/20 solar masses are both above that measured interval and remain explicitly model-assisted rather than direct TOV measurements. Together with the earlier horizon-scale shadow/ringdown receipt, the post-seal record supports the ordered finite white-dwarf, neutron-star and horizon-endpoint classes. No direct astrophysical Hawking-radiation or temperature measurement exists in the registered vector, so the exact mT=1/16 law remains an unconfirmed, falsifiable prediction rather than a rewarded absence."
def sourcePath : String := "experiments/external_sources/physics/snapshots/compact-horizon-postseal-source-record.json"
def snapshotHash : String := "sha256:670c9467f5638513c16345de4ce15da834ed46a358ed40371160d951e739921d"
def falsification : String := "Reject if any source changes; the measured neutral-fermion object no longer lies above the complete white-dwarf limit; either conditional remnant row is omitted or stripped of its condition; Hawking non-observation is counted as confirmation; target data select or modify Claim 071; an external signed coordinate becomes a Fold proof scalar; or any hostile control passes incorrectly."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"WHITE-DWARF-LIMIT","NASA-GSFC-WHITE-DWARF-CHANDRASEKHAR","electron degeneracy and complete reported 7/5 solar-mass limit","sealed-compact-horizon-law-versus-complete-current-object-boundary"⟩,⟨"PSR-J0740-MASS","FONSECA-2021-PSR-J0740-MASS","mass, uncertainty, credibility and timing method","sealed-compact-horizon-law-versus-complete-current-object-boundary"⟩,⟨"GW170817-REMNANT-LIMITS","LIGO-VIRGO-2019-GW170817-REMNANT","both conditional remnant limits and all model boundaries","sealed-compact-horizon-law-versus-complete-current-object-boundary"⟩]

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

def targetIds : List String := ["COMPACT-HORIZON-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← HorizonObservationRecords.authoritativeRecord files payload
 pure [("COMPACT-HORIZON-WITHHELD-COMPLETE-RECORD",record)]
theorem completeTargetCount : targetRows.length=3 := rfl
theorem originalVaultTarget : targetIds=["COMPACT-HORIZON-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.HorizonObservationExperiment
