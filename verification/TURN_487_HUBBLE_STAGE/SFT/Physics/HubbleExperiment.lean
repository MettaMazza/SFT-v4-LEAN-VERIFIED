import SFT.Physics.ObservationPrediction
import SFT.Physics.CosmicIntervals
set_option maxRecDepth 100000
namespace SFT.Physics.HubbleExperiment
open SFT.Host SFT.Host.Canonical
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001"
def experimentId : String := "SFT-EXP-PHYS-COSMO-HUBBLE-CALIBRATION-001"
def expectedLabel : String := "sealed-leading-and-depth-seven-ratios-inside-complete-planck-shoes-ratio-interval"
def frozenRelation : String := "Both exact predictions 13/12 and 3305/3048 lie inside the complete one-standard-uncertainty late/early interval formed from the registered Planck and SH0ES records."
def sourcePath : String := "experiments/external_sources/physics/snapshots/planck-shoes-hubble-abstract-record.json"
def snapshotHash : String := "sha256:4f5bc28ad7a691b9b1fb64bb68a30546f5c82ea7f2e9797f4ade713cad498c04"
def falsification : String := "Either sealed exact ratio lies outside the complete outward-propagated late/early interval; either route, central value, uncertainty, unit or qualification is omitted; source custody changes; or a tampered comparison is accepted."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PLANCK-2018-HUBBLE-INTERVAL","PLANCK-2018-VI-HUBBLE","abstract base-Lambda-CDM Hubble central value and 68-percent uncertainty","sealed-leading-and-depth-seven-ratios-inside-complete-planck-shoes-ratio-interval"⟩,⟨"SHOES-2022-HUBBLE-INTERVAL","SHOES-2022-BASELINE-HUBBLE","abstract baseline Cepheid-SN Ia central value and total reported uncertainty","sealed-leading-and-depth-seven-ratios-inside-complete-planck-shoes-ratio-interval"⟩]

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
 Text.equal (Text.append "sha256:" (SHA256.digest bytes)) snapshotHash

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

theorem completeTargetCount : targetRows.length = 2 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := do
 let (a,b,c) ← CosmicIntervals.hubbleWitnesses
 .ok (a && b && c)

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

end SFT.Physics.HubbleExperiment
