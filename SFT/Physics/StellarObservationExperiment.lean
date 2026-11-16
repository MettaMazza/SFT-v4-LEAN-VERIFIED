import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.StellarObservationEvidence
import SFT.Physics.StellarObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.StellarObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-STELLAR-GALACTIC-TIDAL-068"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-STELLAR-GALACTIC-TIDAL-068"
def expectedLabel : String := "sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"
def frozenRelation : String := "The NASA solar record reports sound-speed and adiabatic-index inference at the 1/10000 precision order and density at 1/1000; its reference-model convective boundary 1427/2000 lies inside the observed 713/1000 +/- 1/1000 interval and is retained only as external structure evidence. The complete six stellar slopes are 507/250, 1143/250, 5743/1000, 4329/1000, 3967/1000 and 573/200 with their six reported uncertainties; the 3967/1000 row contains four and the 573/200 row contains three, while the other four do not and remain explicit. SPARC contributes all 175 galaxies. The 153-galaxy baryonic Tully-Fisher result is 77/20 +/- 9/100 with intrinsic scatter 3/50: its central interval excludes four, while the reported systematic interval [7/2,4] contains the sealed endpoint. The Bullet Cluster records an eight-sigma mass/plasma separation. The Moon records equal approximately-655-hour orbital and rotation periods. MESSENGER records Mercury's 29323073/500000 +/- 11/1000000 day rotation and experimentally verifies its 3:2 resonance, preserving the separately generated eccentric-resonance boundary."
def sourcePath : String := "experiments/external_sources/physics/snapshots/stellar-galactic-tidal-postseal-source-record.json"
def snapshotHash : String := "sha256:37f777d96a7d4844e16f4fbe57ad1fa150882eb097f5426c6e5481d47a713f6c"
def falsification : String := "Reject if any source identity changes; any of the six stellar regimes, both Tully-Fisher interval classes, the full galaxy counts, the Bullet separation, the Moon terminal or the Mercury boundary is omitted; the formal law is changed after target release; a central offset is concealed; a conventional reference model is called an SFT prediction; a fitted parameter enters; or any hostile control passes incorrectly."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"NASA-NTRS-HELIOSEISMOLOGY-2001","NASA-NTRS-HELIOSEISMOLOGY-2001","complete retained source row","sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"⟩,⟨"EKER-2018-MAIN-SEQUENCE-RELATIONS","EKER-2018-MAIN-SEQUENCE-RELATIONS","complete retained source row","sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"⟩,⟨"SPARC-2016-ROTATION-CURVES","SPARC-2016-ROTATION-CURVES","complete retained source row","sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"⟩,⟨"LELLI-2019-BARYONIC-TULLY-FISHER","LELLI-2019-BARYONIC-TULLY-FISHER","complete retained source row","sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"⟩,⟨"CLOWE-2006-BULLET-CLUSTER","CLOWE-2006-BULLET-CLUSTER","complete retained source row","sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"⟩,⟨"NASA-GRC-MOON-SYNCHRONOUS-ROTATION","NASA-GRC-MOON-SYNCHRONOUS-ROTATION","complete retained source row","sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"⟩,⟨"NASA-NTRS-MESSENGER-MERCURY-RESONANCE","NASA-NTRS-MESSENGER-MERCURY-RESONANCE","complete retained source row","sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record"⟩]

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

def targetIds : List String := ["STELLAR-GALACTIC-TIDAL-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← StellarObservationRecords.authoritativeRecord files payload
 pure [("STELLAR-GALACTIC-TIDAL-WITHHELD-COMPLETE-RECORD",record)]
theorem completeTargetCount : targetRows.length=7 := rfl
theorem originalVaultTarget : targetIds=["STELLAR-GALACTIC-TIDAL-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.StellarObservationExperiment
