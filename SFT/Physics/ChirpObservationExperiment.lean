import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.ChirpObservationEvidence
import SFT.Physics.ChirpObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.ChirpObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-074"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-074"
def expectedLabel : String := "sealed-Fold-chirp-merger-ringdown-sequence-versus-complete-postseal-LIGO-vector"
def frozenRelation : String := "The complete empirical record supports all three forced waveform stages. GW151226 rises from 35 to 450 Hz and in amplitude over 55 cycles, retains positive radiated energy and records two initial components joining one final remnant. GW190521 retains a decaying least-damped l=m=2 remnant mode compatible with its full waveform analysis. Its short duration, conditional quasicircular interpretation and alternative-source boundary remain explicit. GW150914 is retained as observational development evidence, not counted as a blind target. No external value selects or modifies the 4096-form Claim 073 survivor, and no dimensional frequency or fitted damping value becomes a Fold proof scalar."
def sourcePath : String := "experiments/external_sources/physics/snapshots/gravitational-wave-chirp-ringdown-postseal-source-record.json"
def snapshotHash : String := "sha256:b24e9d1e8fc37f39bcbc692ac7cfaddbe7666bc4e161880ff45708d958ed1d92"
def falsification : String := "Reject if a post-seal source changes; rising frequency/amplitude, positive radiation, two-to-one merger or decaying quadrupolar remnant support fails; any uncertainty or conditional/model boundary is omitted; GW150914 is relabelled as blind; a dimensional target selects Claim 073; or any hostile control passes."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"GW151226-COMPLETE-CHIRP-MERGER","LIGO-VIRGO-GW151226-DISCOVERY-2016","all signal, source, remnant, energy, uncertainty and model-role rows","sealed-Fold-chirp-merger-ringdown-sequence-versus-complete-postseal-LIGO-vector"⟩,⟨"GW190521-COMPLETE-RINGDOWN","LIGO-VIRGO-GW190521-DISCOVERY-2020","all signal, remnant, mode, decay and conditional-scope rows","sealed-Fold-chirp-merger-ringdown-sequence-versus-complete-postseal-LIGO-vector"⟩]

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

def targetIds : List String := ["GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-WITHHELD-POSTSEAL-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← ChirpObservationRecords.authoritativeRecord files payload
 pure [("GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-WITHHELD-POSTSEAL-RECORD",record)]
theorem completeTargetCount : targetRows.length=2 := rfl
theorem originalVaultTarget : targetIds=["GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-WITHHELD-POSTSEAL-RECORD"] := rfl
end SFT.Physics.ChirpObservationExperiment
