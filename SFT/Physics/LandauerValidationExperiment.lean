import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.LandauerValidationEvidence
set_option maxRecDepth 20000
namespace SFT.Physics.LandauerValidationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-THERMO-LANDAUER-EMPIRICAL-019"
def experimentId : String := "SFT-EXP-PHYS-THERMO-LANDAUER-EMPIRICAL-019"
def expectedLabel : String := "two-state-bit-reset-to-one__finite-positive-environmental-heat__long-cycle-mean-saturates-Landauer-bound__thermal-reservoir-and-ensemble-scope-retained__no-half-One-to-joule-identity"
def frozenRelation : String := "The exact Fold one-distinction reset predicts a nonfree environmental transfer for physical erasure.  Primary theory identifies the symmetric thermal-reservoir ensemble bound as k_B T ln 2 and primary experiment finds long-cycle mean heat saturating it; all distribution, reservoir, average and long-cycle scope rows are retained, while native half-One is not falsely identified with a dimensional energy number."
def sourcePath : String := "experiments/external_sources/physics/snapshots/landauer-erasure-source-record.json"
def snapshotHash : String := "sha256:76a746eb8760816598724a2db17fb7cd1f3a07325e69193525d313fecea4d27f"
def falsification : String := "Reject if the source snapshot changes; if a registered reset, heat, bound, experiment or scope row is omitted; if physical reliable erasure has no positive environment transfer; if long-cycle mean heat does not approach the registered bound; if the thermal coefficient enters the Fold proof; or if native half-One is misreported as a dimensional numerical equality."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"LANDAUER-TWO-TO-ONE-RESET","PIECHOCINSKA-PRA-2000","page 1 reset from two possible bit states to one","two-state-bit-reset-to-one__finite-positive-environmental-heat__long-cycle-mean-saturates-Landauer-bound__thermal-reservoir-and-ensemble-scope-retained__no-half-One-to-joule-identity"⟩,⟨"LANDAUER-THERMAL-BOUND","PIECHOCINSKA-PRA-2000","abstract and equations 19/52 average heat bound with reservoir scope","two-state-bit-reset-to-one__finite-positive-environmental-heat__long-cycle-mean-saturates-Landauer-bound__thermal-reservoir-and-ensemble-scope-retained__no-half-One-to-joule-identity"⟩,⟨"LANDAUER-EXPERIMENTAL-SATURATION","BERUT-NATURE-2012","abstract and Figure 3 long-cycle mean-heat saturation","two-state-bit-reset-to-one__finite-positive-environmental-heat__long-cycle-mean-saturates-Landauer-bound__thermal-reservoir-and-ensemble-scope-retained__no-half-One-to-joule-identity"⟩,⟨"LANDAUER-SCOPE-CONTROL","BERUT-NATURE-2012","one-bit bistable memory and long-cycle limiting mean","two-state-bit-reset-to-one__finite-positive-environmental-heat__long-cycle-mean-saturates-Landauer-bound__thermal-reservoir-and-ensemble-scope-retained__no-half-One-to-joule-identity"⟩]

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

def sourceMatches (bytes : ByteArray) : Bool :=
 Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) snapshotHash

def checkSource (bytes : ByteArray) : Except String Unit :=
 if sourceMatches bytes then .ok () else .error "ValueError: external measurement snapshot differs from registration"

def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]

def targets : List (String × Value) := targetRows.map fun row =>
 (row.targetId,labelValue "external-observation" row.observedLabel)

def targetsValue : Value := .object targets

theorem completeTargetCount : targetRows.length = 4 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel,expectedLabel,expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (LandauerValidationWitnesses.witnesses.all LandauerValidationWitnesses.Witness.passed)

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-PHYS-").isPrefixOf (Text.chars claimId) ||
    !(Text.chars "SFT-EXP-PHYS-").isPrefixOf (Text.chars experimentId) then
   .error "ValueError: empirical Physics identity is invalid"
 else if specDependencies.isEmpty || specDimensions.length != 8 || targetRows.isEmpty then
   .error "ValueError: empirical Physics law lacks dependencies, eight dimensions or targets"
 else if !uniqueNames (specDimensions.map Prod.fst) then
   .error "ValueError: empirical Physics law contains duplicate dimensions"
 else if !(specDimensions.all (fun d => d.2.length == 2)) then
   .error "ValueError: each empirical dimension must exhaust two registered forms"
 else if !(specDimensions.all (fun d => (d.2.filter id).length == 1)) then
   .error "ValueError: dimension requires one preserving form"
 else if !nonblank expectedLabel || !nonblank falsification then
   .error "ValueError: empirical prediction or falsification condition is missing"
 else if !uniqueNames (targetRows.map ObservationCarrier.ExternalTargetRow.targetId) then
   .error "ValueError: empirical target identities are duplicated"
 else
   let witnesses ← specWitnesses
   if witnesses then .ok () else .error "ValueError: empirical Physics operational witness failed"

theorem registeredSpecValid : validateSpec = .ok () := rfl

theorem sourceMatchesOriginal (bytes : ByteArray) :
 sourceMatches bytes = Text.equal (Text.append "sha256:" (SHA256.digest bytes)) snapshotHash := by
 unfold sourceMatches
 rw [SHA256Chunks.digestPreserved]

end SFT.Physics.LandauerValidationExperiment
