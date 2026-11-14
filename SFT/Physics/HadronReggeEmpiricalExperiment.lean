import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.HadronReggeEmpiricalEvidence
set_option maxRecDepth 20000
namespace SFT.Physics.HadronReggeEmpiricalExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-HADRON-REGGE-TERMINAL-005"
def experimentId : String := "SFT-EXP-PHYS-HADRON-REGGE-TERMINAL-005"
def expectedLabel : String := "sealed-nine-equals-eight-plus-one-and-twenty-seven-equals-ten-plus-eight-plus-eight-plus-one-match-PDG__complete-five-state-natural-parity-mass-vector-is-strictly-ordered__literal-common-squared-mass-step-is-rejected-by-complete-reported-intervals__exact-affine-Fold-law-retained-at-normalized-fixed-carrier-boundary__rho5-summary-omission-status-retained"
def frozenRelation : String := "The independent Fold counts equal PDG's 9=8+1 and 27=10+8+8+1 organizations.  The five registered resonance mass intervals rise strictly with spin, but the four exact squared-mass step intervals have empty common intersection.  Therefore literal exact equal spacing of these reported masses is rejected; the exact theorem remains the normalized fixed-carrier affine support law, without a fitted correction."
def sourcePath : String := "experiments/external_sources/physics/snapshots/hadron-regge-successor-source-record.json"
def snapshotHash : String := "sha256:c6e671212984fa6b6956a3d748c12c81879686b9198ca5a0818670fe63301358"
def falsification : String := "The claim fails if either sealed partition differs, the normalized affine successor ceases to be exact, any registered mass/uncertainty/status row is lost, strict ordering changes, the exact common-step result is misstated, a fitted correction is introduced, or target access precedes sealing."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PDG-LIGHT-MESON-MULTIPLET","PDG-HADRON-MULTIPLETS-REGGE-2025","PDG 2025 Quark Model nine equals octet plus singlet record","sealed-nine-equals-eight-plus-one-and-twenty-seven-equals-ten-plus-eight-plus-eight-plus-one-match-PDG__complete-five-state-natural-parity-mass-vector-is-strictly-ordered__literal-common-squared-mass-step-is-rejected-by-complete-reported-intervals__exact-affine-Fold-law-retained-at-normalized-fixed-carrier-boundary__rho5-summary-omission-status-retained"⟩,⟨"PDG-LIGHT-BARYON-MULTIPLETS","PDG-HADRON-MULTIPLETS-REGGE-2025","PDG 2025 Quark Model twenty-seven equals ten plus eight plus eight plus one record","sealed-nine-equals-eight-plus-one-and-twenty-seven-equals-ten-plus-eight-plus-eight-plus-one-match-PDG__complete-five-state-natural-parity-mass-vector-is-strictly-ordered__literal-common-squared-mass-step-is-rejected-by-complete-reported-intervals__exact-affine-Fold-law-retained-at-normalized-fixed-carrier-boundary__rho5-summary-omission-status-retained"⟩,⟨"PDG-NATURAL-PARITY-TRAJECTORY","PDG-HADRON-MULTIPLETS-REGGE-2025","PDG 2025 rho/a summary rows and rho5 listing with complete uncertainties and status","sealed-nine-equals-eight-plus-one-and-twenty-seven-equals-ten-plus-eight-plus-eight-plus-one-match-PDG__complete-five-state-natural-parity-mass-vector-is-strictly-ordered__literal-common-squared-mass-step-is-rejected-by-complete-reported-intervals__exact-affine-Fold-law-retained-at-normalized-fixed-carrier-boundary__rho5-summary-omission-status-retained"⟩]

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

def specDependencies : List String := ["SFT-PHYS-HADRON-REGGE-TERMINAL-005", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (HadronReggeEmpiricalWitnesses.witnesses.all HadronReggeEmpiricalWitnesses.Witness.passed)

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

end SFT.Physics.HadronReggeEmpiricalExperiment
