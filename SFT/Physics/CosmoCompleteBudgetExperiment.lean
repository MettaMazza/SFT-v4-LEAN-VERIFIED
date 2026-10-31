import SFT.Host.SHA256Window
import SFT.Physics.ObservationPrediction
import SFT.Physics.CosmoCompleteBudgetIntervals
set_option maxRecDepth 20000
namespace SFT.Physics.CosmoCompleteBudgetExperiment
open SFT.Host SFT.Host.Canonical
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-COSMO-COMPLETE-BUDGET-001"
def experimentId : String := "SFT-EXP-PHYS-COSMO-COMPLETE-BUDGET-001"
def expectedLabel : String := "sealed-refined-four-part-budget-inside-all-complete-planck-bao-intervals"
def frozenRelation : String := "All four refined values 11/16, 5/16, 25/512 and 135/512 lie inside their complete Planck+BAO intervals; all four earlier leading values lie outside their respective intervals."
def sourcePath : String := "experiments/external_sources/physics/snapshots/planck-2018-bao-budget-record.json"
def snapshotHash : String := "sha256:a8525585688e7ba818f8650fc0f8b73a449823d5e199a8be36e37b8e73a0e612"
def falsification : String := "Any refined component lies outside its complete interval; any earlier leading component is falsely labelled as passing; any required source row or uncertainty is omitted; custody changes; or a tampered comparison is accepted."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PLANCK-BAO-VACUUM-FRACTION","PLANCK-2018-BAO-BASELINE-BUDGET","complete direct vacuum interval","sealed-refined-four-part-budget-inside-all-complete-planck-bao-intervals"⟩,⟨"PLANCK-BAO-MATTER-FRACTION","PLANCK-2018-BAO-BASELINE-BUDGET","complete direct matter interval","sealed-refined-four-part-budget-inside-all-complete-planck-bao-intervals"⟩,⟨"PLANCK-BAO-BARYON-FRACTION","PLANCK-2018-BAO-BASELINE-BUDGET","physical baryon density divided by complete squared reduced-Hubble interval","sealed-refined-four-part-budget-inside-all-complete-planck-bao-intervals"⟩,⟨"PLANCK-BAO-COLD-DARK-FRACTION","PLANCK-2018-BAO-BASELINE-BUDGET","physical cold-dark density divided by complete squared reduced-Hubble interval","sealed-refined-four-part-budget-inside-all-complete-planck-bao-intervals"⟩]

def registration : Value := .object [
 ("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("frozen_relation",.text frozenRelation),("source_snapshot_path",.text sourcePath),
 ("source_snapshot_hash",.text snapshotHash),
 ("target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("target_locators",.array (targetRows.map fun row => .array [.text row.targetId,.text row.sourceId,.text row.sourceLocator])),
 ("prediction_program",programDocument),("expected_observation_label",.text expectedLabel),
 ("falsification_condition",.text falsification),("all_rows_required",.boolean true),
 ("target_inaccessible_before_seal",.boolean true)]

def registrationHash : String := identity registration

def sourceMatches (bytes : ByteArray) : Bool :=
 Text.equal (Text.append "sha256:" (SHA256Window.digest bytes)) snapshotHash

theorem sourceMatchesOriginal (bytes : ByteArray) :
 sourceMatches bytes = Text.equal (Text.append "sha256:" (SHA256.digest bytes)) snapshotHash := by
 unfold sourceMatches
 rw [SHA256Window.digestPreserved]

def checkSource (bytes : ByteArray) : Except String Unit :=
 if sourceMatches bytes then .ok () else .error "ValueError: external measurement snapshot differs from registration"

def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
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

def specDependencies : List String := ["SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001", "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001", "SFT-PHYS-MEAS-VALUE-RECORD-001", "SFT-PHYS-MEAS-UNCERTAINTY-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := CosmoCompleteBudgetIntervals.witnessCheck

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

end SFT.Physics.CosmoCompleteBudgetExperiment
