import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.HiggsObservationEvidence
import SFT.Physics.HiggsObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.HiggsObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-HIGGS-SYMMETRY-TERMINAL-066"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-HIGGS-SYMMETRY-TERMINAL-066"
def expectedLabel : String := "sealed-terminal-Higgs-ratio-and-self-coupling-versus-complete-current-record"
def frozenRelation : String := "Using the post-seal PDG dimensional reference v = 12311/50 GeV, the sealed ratio predicts exactly m_H = 31557437733819647/251923197734500 GeV = 125.266104978... GeV. The PDG 2025 listed average is 626/5 +/- 11/100 GeV, whose reported-uncertainty interval [12509/100,12531/100] contains the prediction; the exact displacement from its central value is 16653377460247/251923197734500 GeV. ATLAS reports 12511/100 +/- 11/100 GeV and CMS reports 3126/25 +/- 3/25 GeV; their exact positive offsets remain in the certificate and are not called aggregate failures. The exact native lambda is 6570778165695741824959729/50772238045420788745992200. The 2026 ATLAS-CMS 95-percent normalized kappa-lambda interval, recorded as a below-reference direction of magnitude 71/100 through 61/10, contains the SFT normalized unity correspondence but does not yet resolve native lambda precisely."
def sourcePath : String := "experiments/external_sources/physics/snapshots/higgs-terminal-postseal-source-record.json"
def snapshotHash : String := "sha256:62d866e1b94f43e7cb73c9da46ac672434e00b4f8bc628b17f4060e8fb019d21"
def falsification : String := "Reject if any source changes; the sealed mass prediction lies outside the complete authoritative aggregate interval; normalized unity lies outside the direct self-coupling interval; an individual offset or uncertainty is omitted; a broad limit is called a precision measurement; target data select or modify the formal law; a signed external coordinate becomes a Fold proof scalar; or any hostile control passes incorrectly."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"ELECTROWEAK-SCALE","PDG-2024-ELECTROWEAK-VACUUM-SCALE","PDG electroweak dimensional reference","sealed-terminal-Higgs-ratio-and-self-coupling-versus-complete-current-record"⟩,⟨"PDG-HIGGS-AVERAGE","PDG-2025-HIGGS-MASS-AVERAGE","PDG average, uncertainty, scale factor and exact interval","sealed-terminal-Higgs-ratio-and-self-coupling-versus-complete-current-record"⟩,⟨"ATLAS-HIGGS-MASS","ATLAS-2023-COMBINED-HIGGS-MASS","ATLAS value and statistical, systematic and combined uncertainties","sealed-terminal-Higgs-ratio-and-self-coupling-versus-complete-current-record"⟩,⟨"CMS-HIGGS-MASS","CMS-2024-FOUR-LEPTON-HIGGS-MASS","CMS value and reported uncertainty","sealed-terminal-Higgs-ratio-and-self-coupling-versus-complete-current-record"⟩,⟨"ATLAS-CMS-KAPPA-LAMBDA","ATLAS-CMS-2026-HIGGS-PAIR-COMBINATION","Combined normalized trilinear interval and signal-strength record","sealed-terminal-Higgs-ratio-and-self-coupling-versus-complete-current-record"⟩]

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

def targetIds : List String := ["HIGGS-TERMINAL-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← HiggsObservationRecords.authoritativeRecord files payload
 pure [("HIGGS-TERMINAL-WITHHELD-COMPLETE-RECORD",record)]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["HIGGS-TERMINAL-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.HiggsObservationExperiment
