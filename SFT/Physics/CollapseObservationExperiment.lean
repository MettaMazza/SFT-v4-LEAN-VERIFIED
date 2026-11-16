import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.CollapseObservationEvidence
import SFT.Physics.CollapseObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.CollapseObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-STELLAR-NUCLEAR-COLLAPSE-070"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-STELLAR-NUCLEAR-COLLAPSE-070"
def expectedLabel : String := "sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record"
def frozenRelation : String := "The complete six NASA stage temperatures are (3/100,1/5,4/5,3/2,2,33/10) billion kelvin and strictly increase in the formal stage order; all durations (10000000,1000000,1000,1/10,2,1/100 years) remain and are not falsely called monotonic. Borexino reports 36/5 +3 -17/10 cpd per 100 tonnes, minimum significance five sigma at 99/100 confidence. SN1987A neutrinos were recorded by three detectors; the reported two-component preference exceeds 100:1 and the sub-One-second accretion component remains model-assisted. SN2014J records 847 and 1238 keV cobalt lines with fluxes 73/20 +/- 121/100 and 227/100 +/- 69/100 in 10^-4 photon units; the measured ratio 31/50 +/- 7/25 contains 17/25 and the spectrum significance is 113/10 sigma. GW170817 records the 810 nm strontium feature from 3/2 to 10 days, with 1/5-c broadening and 23/100-c blueshift."
def sourcePath : String := "experiments/external_sources/physics/snapshots/stellar-nuclear-collapse-postseal-source-record.json"
def snapshotHash : String := "sha256:4315620e6c801de49869a6fe693e61ae5b5b5ced82bd8896b733c50f7a4809bd"
def falsification : String := "Reject if any source changes; any stage, duration, detector, line, flux, uncertainty, confidence, feature or modelling boundary is omitted; the stage temperatures are not strictly ordered; the direct channel observations are absent; target data alter the sealed law; a fit enters; or any hostile control passes incorrectly."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"NASA-GSFC-COSMIC-ELEMENTS-STELLAR-STAGES","NASA-GSFC-COSMIC-ELEMENTS-STELLAR-STAGES","complete retained source row","sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record"⟩,⟨"BOREXINO-2020-CNO-NEUTRINOS","BOREXINO-2020-CNO-NEUTRINOS","complete retained source row","sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record"⟩,⟨"LOREDO-LAMB-2001-SN1987A-NEUTRINOS","LOREDO-LAMB-2001-SN1987A-NEUTRINOS","complete retained source row","sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record"⟩,⟨"DIEHL-2014-SN2014J-GAMMA-LINES","DIEHL-2014-SN2014J-GAMMA-LINES","complete retained source row","sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record"⟩,⟨"WATSON-2019-GW170817-STRONTIUM","WATSON-2019-GW170817-STRONTIUM","complete retained source row","sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record"⟩]

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

def targetIds : List String := ["STELLAR-NUCLEAR-COLLAPSE-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← CollapseObservationRecords.authoritativeRecord files payload
 pure [("STELLAR-NUCLEAR-COLLAPSE-WITHHELD-COMPLETE-RECORD",record)]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["STELLAR-NUCLEAR-COLLAPSE-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.CollapseObservationExperiment
