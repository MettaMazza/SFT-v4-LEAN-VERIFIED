import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.AtomicFieldSplittingEmpiricalEvidence
set_option maxRecDepth 20000
namespace SFT.Physics.AtomicFieldSplittingEmpiricalExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005"
def experimentId : String := "SFT-EXP-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005"
def expectedLabel : String := "sealed-two-J-plus-one-and-linear-Zeeman-match-NIST__degenerate-hydrogen-linear-Stark-matches-NBS__nondegenerate-cesium-quadratic-Stark-matches-NIST"
def frozenRelation : String := "The sealed 2J+1 multiplicity and linear Zeeman response equal the NIST weak-field law; retained degeneracy equals the NBS linear hydrogen Stark class; absent degeneracy equals the NIST quadratic cesium class, whose 750 V across 0.005 m exactly translates to 1500 V/cm."
def sourcePath : String := "experiments/external_sources/physics/snapshots/atomic-field-splitting-successor-source-record.json"
def snapshotHash : String := "sha256:5093c824cec5438a98f82fd5e75460e737a001a11471d12dbd7cd67b930661df"
def falsification : String := "The claim fails if multiplicity or a field order differs, the degeneracy discriminator fails, the exact voltage/spacing translation fails, a displayed value or uncertainty status changes, target access precedes sealing, or observational provenance is concealed."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"NIST-WEAK-FIELD-ZEEMAN","NIST-NBS-ATOMIC-FIELD-SPLITTING-2026","NIST Atomic Spectroscopy Zeeman Effect page","sealed-two-J-plus-one-and-linear-Zeeman-match-NIST__degenerate-hydrogen-linear-Stark-matches-NBS__nondegenerate-cesium-quadratic-Stark-matches-NIST"⟩,⟨"NBS-HYDROGEN-LINEAR-STARK","NIST-NBS-ATOMIC-FIELD-SPLITTING-2026","NBS Special Publication 617 hydrogen linear-Stark record","sealed-two-J-plus-one-and-linear-Zeeman-match-NIST__degenerate-hydrogen-linear-Stark-matches-NBS__nondegenerate-cesium-quadratic-Stark-matches-NIST"⟩,⟨"NIST-CESIUM-QUADRATIC-STARK","NIST-NBS-ATOMIC-FIELD-SPLITTING-2026","NIST cesium-15s quadratic-Stark voltage-reference record","sealed-two-J-plus-one-and-linear-Zeeman-match-NIST__degenerate-hydrogen-linear-Stark-matches-NBS__nondegenerate-cesium-quadratic-Stark-matches-NIST"⟩]

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

theorem completeTargetCount : targetRows.length = 3 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel,expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (AtomicFieldSplittingEmpiricalWitnesses.witnesses.all AtomicFieldSplittingEmpiricalWitnesses.Witness.passed)

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

end SFT.Physics.AtomicFieldSplittingEmpiricalExperiment
