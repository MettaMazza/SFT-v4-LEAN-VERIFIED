import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.StrongCPObservationEvidence
import SFT.Physics.StrongCPObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.StrongCPObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064"
def expectedLabel : String := "sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"
def frozenRelation : String := "The PSI result retains its null central status, positive 1.1 and 0.2 times ten-to-the-minus-26 uncertainty magnitudes and positive 1.8 times ten-to-the-minus-26 90-percent upper bound. The six proton modes retain 90-percent partial-lifetime lower limits 2.4e34, 1.6e34, 1.4e34, 7.3e33, 7.2e33 and 4.5e33 years. No source reports a statistically significant proton-decay signal; the explicitly retained candidates are background compatible. Thus no registered row violates the sealed aligned-One or fibre-preserving baryon-One predictions."
def sourcePath : String := "experiments/external_sources/physics/snapshots/strong-cp-baryon-stability-postseal-source-record.json"
def snapshotHash : String := "sha256:80475bde8d961642a902c84e0e1043c36a8a55d12430b72b18c6015e0c7a51db"
def falsification : String := "Reject if any source changes; the direct EDM record reports a confirmed nonempty displacement; any proton mode reports a statistically significant decay signal; a candidate or uncertainty is omitted or relabelled; a finite limit is called exact absence/infinity; target data select the formal law; or any hostile control passes incorrectly."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"NEDM-COMPLETE","NEDM-2020-PSI-PERMANENT-EDM","Central status, both uncertainties, 90-percent upper limit and unit","sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"⟩,⟨"PROTON-E-PI0","SUPERK-2020-PROTON-E-MU-PI0","Candidate record and 90-percent partial-lifetime lower limit","sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"⟩,⟨"PROTON-MU-PI0","SUPERK-2020-PROTON-E-MU-PI0","Candidate record and 90-percent partial-lifetime lower limit","sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"⟩,⟨"PROTON-E-ETA","SUPERK-2024-PROTON-E-MU-ETA","No-significant-excess status and 90-percent partial-lifetime lower limit","sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"⟩,⟨"PROTON-MU-ETA","SUPERK-2024-PROTON-E-MU-ETA","No-significant-excess status and 90-percent partial-lifetime lower limit","sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"⟩,⟨"PROTON-E-TWO-PI0","SUPERK-2026-PROTON-E-MU-TWO-PI0","Background-compatible candidate and 90-percent partial-lifetime lower limit","sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"⟩,⟨"PROTON-MU-TWO-PI0","SUPERK-2026-PROTON-E-MU-TWO-PI0","Background-compatible candidate and 90-percent partial-lifetime lower limit","sealed-strong-aligned-One-and-fibre-preserving-baryon-One-prediction"⟩]

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

def targetIds : List String := ["STRONG-CP-BARYON-STABILITY-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← StrongCPObservationRecords.authoritativeRecord files payload
 pure [("STRONG-CP-BARYON-STABILITY-WITHHELD-COMPLETE-RECORD",record)]
theorem completeTargetCount : targetRows.length=7 := rfl
theorem originalVaultTarget : targetIds=["STRONG-CP-BARYON-STABILITY-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.StrongCPObservationExperiment
