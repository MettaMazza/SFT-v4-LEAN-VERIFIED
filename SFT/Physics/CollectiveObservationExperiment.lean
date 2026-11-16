import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.CollectiveObservationEvidence
import SFT.Physics.CollectiveObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.CollectiveObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-COLLECTIVE-RADIATION-RESPONSE-042"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-COLLECTIVE-RADIATION-RESPONSE-042"
def expectedLabel : String := "sealed-collective-response__complete-blackbody-acoustic-laser-plasma-Alfven-record__no-fit"
def frozenRelation : String := "External blackbody measurement reports exponent 4 exactly, matching the forced rank-three-plus-energy exponent; doubling therefore remains the exact ratio 16. The historical Stefan coefficient is reported within 1/100 of the present value and spectrum shape agreement is retained, but no dimensional coefficient is manufactured from a normalized carrier. Acoustic and microwave cavity resonances were measured to part-per-million precision. NIST reports unmodified laser linewidths of at least 10,000,000 Hz and extended-cavity linewidths no more than 500,000 Hz, so linewidth remains positive and feedback narrows it by at least factor 20. Two NASA flights directly track electron density through plasma frequency, and NASA registers Alfvén waves from 2007 through 2014. All comparisons pass at their declared relation/value type without fitting."
def sourcePath : String := "experiments/external_sources/physics/snapshots/collective-radiation-postseal-source-record.json"
def snapshotHash : String := "sha256:fb68982f853344dbb055e0a7bb51512d6b3f631044ae3e89b81c86ec019c7470"
def falsification : String := "Reject if a source or row changes; if the measured blackbody exponent is not four; if measured linewidth is empty or feedback does not narrow it; if acoustic resonances, direct plasma-frequency density dependence or Alfvén observations are absent; if a dimensional coefficient is fitted from normalized structure; or if a target changes the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"BLACKBODY","NIST-COBLENTZ-BLACKBODY","Measured exponent, coefficient agreement and spectrum shape","sealed-collective-response__complete-blackbody-acoustic-laser-plasma-Alfven-record__no-fit"⟩,⟨"LASER","NIST-DIODE-LASER-LINEWIDTH","Measured positive linewidth and feedback narrowing","sealed-collective-response__complete-blackbody-acoustic-laser-plasma-Alfven-record__no-fit"⟩,⟨"ACOUSTIC","NBS-ACOUSTIC-CAVITY-1986","Measured cavity resonance frequencies and precision","sealed-collective-response__complete-blackbody-acoustic-laser-plasma-Alfven-record__no-fit"⟩,⟨"PLASMA","NASA-PLASMA-FREQUENCY-PROBE-1992","Direct plasma-frequency electron-density tracking on two flights","sealed-collective-response__complete-blackbody-acoustic-laser-plasma-Alfven-record__no-fit"⟩,⟨"ALFVEN","NASA-STEREO-ALFVEN-LIST","Registered in-situ Alfvén-wave observation interval","sealed-collective-response__complete-blackbody-acoustic-laser-plasma-Alfven-record__no-fit"⟩]

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

def targetIds : List String := ["COLLECTIVE-RADIATION-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← CollectiveObservationRecords.authoritativeRecord files payload
 pure [("COLLECTIVE-RADIATION-WITHHELD-COMPLETE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["COLLECTIVE-RADIATION-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.CollectiveObservationExperiment
