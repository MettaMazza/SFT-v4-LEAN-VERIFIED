import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.ParticleModeObservationEvidence
import SFT.Physics.ParticleModeObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.ParticleModeObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-PARTICLE-MODE-GENERATION-052"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-PARTICLE-MODE-GENERATION-052"
def expectedLabel : String := "sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"
def frozenRelation : String := "The forced count three lies in the PDG LEP-SLC precision interval [2989,3003]/1000. The independent direct determination 292/100 with stated uncertainty 5/100 is preserved exactly and has central-value displacement 8/5 stated uncertainties from three; it is neither adjusted nor used to select the result. Both terminal charged-lepton mass-ratio intervals, the available s/d and b/s quark ratio intervals, all four terminal CKM intervals and the positive-neutrino mass/mixing support pass their registered comparisons; t/c remains without an exact scheme-matched direct comparator. The charged-lepton records give m_e<m_mu<m_tau and lifetime_e>lifetime_mu>lifetime_tau. These measurements test the terminal polynomial and ordering consequences, not the superseded site-as-mass, universal rate-ratio, dimensional lifetime-equality or extra-spatial-dimension claims."
def sourcePath : String := "experiments/external_sources/physics/snapshots/particle-mode-generation-postseal-source-record.json"
def snapshotHash : String := "sha256:abf29f6244ad64e49b169489675627424bcdbdc3d38e8ceef4b1628681889cd5"
def falsification : String := "Reject if any source changes; the precision generation interval excludes three; the independent direct row is omitted, altered, rescaled or used to select the law; a registered terminal mass or mixing comparison fails; the charged-lepton mass/lifetime orders reverse; the missing t/c comparator is presented as measured; any search or model boundary is omitted; an old site coordinate is relabelled as mass; or target data alter the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"GENERATION-COUNT-COMPLETE","PDG-2025-LEPTON-SUMMARY","Precision neutrino-type fit and unchanged independent direct determination","sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"⟩,⟨"CHARGED-LEPTON-MASSES-LIFETIMES","PDG-2025-LEPTON-SUMMARY","Complete electron, muon and tau mass/lifetime rows","sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"⟩,⟨"HEAVY-LEPTON-SEARCH-LIMITS","PDG-2025-LEPTON-SUMMARY","Charged-heavy-lepton search boundaries","sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"⟩,⟨"CHARGED-LEPTON-RATIOS","NIST-CODATA-2022-ALL-CONSTANTS","Both terminal CODATA mass-ratio intervals","sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"⟩,⟨"QUARK-RATIOS","PDG-2025-QUARK-MASSES","Available complete quark ratios and absent t/c comparator","sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"⟩,⟨"CKM-VECTOR","PDG-2025-CKM-MATRIX","Complete terminal CKM four-row vector","sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"⟩,⟨"NEUTRINO-MASS-MIXING","PDG-2025-NEUTRINO-MIXING","Positive mass, PMNS, CP, ordering and bound vector","sealed-particle-mode-generation-transport__forced-three-matches-precision-measurement__independent-direct-row-retained-unchanged__terminal-lepton-quark-neutrino-and-CKM-vector__charged-lepton-longevity-order__no-site-mass-or-extra-dimension-import"⟩]

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

def targetIds : List String := ["PARTICLE-MODE-GENERATION-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← ParticleModeObservationRecords.authoritativeRecord files payload
 pure [("PARTICLE-MODE-GENERATION-WITHHELD-COMPLETE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=7 := rfl
theorem originalVaultTarget : targetIds=["PARTICLE-MODE-GENERATION-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.ParticleModeObservationExperiment
