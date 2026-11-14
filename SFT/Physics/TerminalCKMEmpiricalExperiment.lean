import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.TerminalCKMEmpiricalEvidence
set_option maxRecDepth 20000
namespace SFT.Physics.TerminalCKMEmpiricalExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-MATTER-CKM-TERMINAL-004"
def experimentId : String := "SFT-EXP-PHYS-MATTER-CKM-TERMINAL-004"
def expectedLabel : String := "terminal-CKM-s12-s23-s13-and-J-all-overlap-complete-PDG-three-sigma-intervals__observational-derivation-disclosed"
def frozenRelation : String := "The target-free terminal CKM successor places s12, s23, s13 and J inside their complete registered PDG three-standard-uncertainty intervals."
def sourcePath : String := "experiments/external_sources/physics/snapshots/matter-flavour-terminal-source-record.json"
def snapshotHash : String := "sha256:652b186e29c835c9cf8fdfd3393fe19c6a81917666989331c5ca060dc789ae9e"
def falsification : String := "Any sealed CKM interval misses its complete registered source interval, a row is omitted, the target enters the relation, or observational provenance is hidden."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PDG-CKM-S12-COMPLETE","MATTER-FLAVOUR-TERMINAL-AUTHORITATIVE-2025-2026","sin_theta12 complete row","terminal-CKM-s12-s23-s13-and-J-all-overlap-complete-PDG-three-sigma-intervals__observational-derivation-disclosed"⟩,⟨"PDG-CKM-S23-COMPLETE","MATTER-FLAVOUR-TERMINAL-AUTHORITATIVE-2025-2026","sin_theta23 complete row","terminal-CKM-s12-s23-s13-and-J-all-overlap-complete-PDG-three-sigma-intervals__observational-derivation-disclosed"⟩,⟨"PDG-CKM-S13-COMPLETE","MATTER-FLAVOUR-TERMINAL-AUTHORITATIVE-2025-2026","sin_theta13 complete row","terminal-CKM-s12-s23-s13-and-J-all-overlap-complete-PDG-three-sigma-intervals__observational-derivation-disclosed"⟩,⟨"PDG-CKM-J-COMPLETE","MATTER-FLAVOUR-TERMINAL-AUTHORITATIVE-2025-2026","Jarlskog complete row","terminal-CKM-s12-s23-s13-and-J-all-overlap-complete-PDG-three-sigma-intervals__observational-derivation-disclosed"⟩]

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

def specDependencies : List String := ["SFT-PHYS-MATTER-CKM-TERMINAL-004", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (TerminalCKMEmpiricalWitnesses.witnesses.all TerminalCKMEmpiricalWitnesses.Witness.passed)

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

end SFT.Physics.TerminalCKMEmpiricalExperiment
