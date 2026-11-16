import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.SmithionObservationEvidence
import SFT.Physics.SmithionObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.SmithionObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-DARK-SMITHION-LFV-062"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-DARK-SMITHION-LFV-062"
def expectedLabel : String := "sealed-dark-smithion-lfv-law__27-over-5-and-absolute-density-transport-pass-planck__sparc-requires-non-baryonic-gravitating-support-under-derived-inverse-square-law__all-lfv-upper-limits-retained-without-fabricated-rate-ratio__smithion-masses-standing-predictions"
def frozenRelation : String := "The exact 27/5 ratio lies inside the complete Planck dark/baryon interval, and 27/5 times 0.0224 gives 0.12096 inside the reported cold-dark interval [0.119,0.121]. The 175-galaxy SPARC record rejects finite baryon-only inverse-square asymptotics and supports additional gravitating matter under the admitted law. MEG II and BaBar provide three positive upper limits after null searches, not three measured rates; the 3:5:20 and 4:1 LFV predictions remain standing tests. No measured Smithion mass exists, so all twelve mass-ratio enclosures remain standing predictions rather than fabricated measured-value matches."
def sourcePath : String := "experiments/external_sources/physics/snapshots/dark-smithion-lfv-postseal-source-record.json"
def snapshotHash : String := "sha256:ed0dba82cdd49f67258eb152466a629d9086804197d2c56bcfdc49e2849345f3"
def falsification : String := "Reject if any source changes; 27/5 leaves the complete Planck ratio interval; 0.12096 leaves the complete cold-dark interval; the galaxy discrepancy row is omitted; an LFV limit is altered or relabelled as a rate; a Smithion is relabelled as measured without a source; target data select the formal law; or any hostile control passes incorrectly."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PLANCK-DARK-BARYON-COMPLETE","PLANCK-2018-VI-ABSTRACT-DENSITIES","Both density central values and both reported uncertainties","sealed-dark-smithion-lfv-law__27-over-5-and-absolute-density-transport-pass-planck__sparc-requires-non-baryonic-gravitating-support-under-derived-inverse-square-law__all-lfv-upper-limits-retained-without-fabricated-rate-ratio__smithion-masses-standing-predictions"⟩,⟨"SPARC-175-GALAXY-DISCRIMINATOR","SPARC-2016-175-GALAXY-MASS-MODELS","Complete observed-to-baryonic velocity sample statement","sealed-dark-smithion-lfv-law__27-over-5-and-absolute-density-transport-pass-planck__sparc-requires-non-baryonic-gravitating-support-under-derived-inverse-square-law__all-lfv-upper-limits-retained-without-fabricated-rate-ratio__smithion-masses-standing-predictions"⟩,⟨"MEGII-MU-E-UPPER-LIMIT","MEGII-2025-MU-E-GAMMA","Null result and complete 90-percent upper limit","sealed-dark-smithion-lfv-law__27-over-5-and-absolute-density-transport-pass-planck__sparc-requires-non-baryonic-gravitating-support-under-derived-inverse-square-law__all-lfv-upper-limits-retained-without-fabricated-rate-ratio__smithion-masses-standing-predictions"⟩,⟨"BABAR-TAU-E-UPPER-LIMIT","BABAR-2010-TAU-LFV-GAMMA","Null result and complete 90-percent upper limit","sealed-dark-smithion-lfv-law__27-over-5-and-absolute-density-transport-pass-planck__sparc-requires-non-baryonic-gravitating-support-under-derived-inverse-square-law__all-lfv-upper-limits-retained-without-fabricated-rate-ratio__smithion-masses-standing-predictions"⟩,⟨"BABAR-TAU-MU-UPPER-LIMIT","BABAR-2010-TAU-LFV-GAMMA","Null result and complete 90-percent upper limit","sealed-dark-smithion-lfv-law__27-over-5-and-absolute-density-transport-pass-planck__sparc-requires-non-baryonic-gravitating-support-under-derived-inverse-square-law__all-lfv-upper-limits-retained-without-fabricated-rate-ratio__smithion-masses-standing-predictions"⟩,⟨"SMITHION-MEASUREMENT-STATUS","SPARC-2016-175-GALAXY-MASS-MODELS","No registered measured penta/hepta Smithion mass","sealed-dark-smithion-lfv-law__27-over-5-and-absolute-density-transport-pass-planck__sparc-requires-non-baryonic-gravitating-support-under-derived-inverse-square-law__all-lfv-upper-limits-retained-without-fabricated-rate-ratio__smithion-masses-standing-predictions"⟩]

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

def targetIds : List String := ["DARK-SMITHION-LFV-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← SmithionObservationRecords.authoritativeRecord files payload
 pure [("DARK-SMITHION-LFV-WITHHELD-COMPLETE-RECORD",record)]
theorem completeTargetCount : targetRows.length=6 := rfl
theorem originalVaultTarget : targetIds=["DARK-SMITHION-LFV-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.SmithionObservationExperiment
