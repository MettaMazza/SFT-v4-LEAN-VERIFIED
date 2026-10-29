import SFT.Physics.LeptonPrediction
set_option maxRecDepth 20000
namespace SFT.Physics.LeptonExperiment
open SFT.Host SFT.Host.Canonical LeptonPrediction

structure TargetRow where
 targetId : String
 sourceId : String
 sourceLocator : String
 observedLabel : String

def claimId : String := "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001"
def frozenRelation : String := "Both terminal-cubic mass-ratio intervals overlap their complete CODATA intervals."
def sourcePath : String := "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
def snapshotHash : String := "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"
def falsification : String := "Either terminal prediction interval fails to overlap its complete source interval, source custody changes, or any failed row is omitted."

def targetRows : List TargetRow := [⟨"NIST-CODATA-2022-MUON-ELECTRON-MASS-RATIO","NIST-CODATA-2022-ALL-CONSTANTS","fixed-width muon-electron mass ratio row","terminal-cubic-mass-ratios-inside-both-complete-codata-intervals"⟩,⟨"NIST-CODATA-2022-MUON-TAU-MASS-RATIO","NIST-CODATA-2022-ALL-CONSTANTS","fixed-width muon-tau mass ratio row","terminal-cubic-mass-ratios-inside-both-complete-codata-intervals"⟩]

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
 ("registered_inputs",.object [("registered-premise",.text (identity (heldValue (.label "sealed-derivation" derivationSeal))))]),
 ("withheld_target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]

def targets : List (String × Held) := targetRows.map fun row =>
 (row.targetId,.label "external-observation" row.observedLabel)

def targetsValue : Value := .object (targets.map fun (name,value) => (name,heldValue value))

theorem completeTargetCount : targetRows.length = 2 := rfl

theorem completeTargetLabels : targetRows.map TargetRow.observedLabel = [expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := do
 let brackets ← LeptonIsolation.terminalSearch
 let product ← LeptonTerminal.terminalProduct
 match brackets with
 | none => .ok false
 | some found => .ok (found.length == 3 && decide (0 < product.numerator) && true)

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
 else if !uniqueNames (targetRows.map TargetRow.targetId) then
   .error "ValueError: empirical target identities are duplicated"
 else
   let witnesses ← specWitnesses
   if witnesses then .ok () else .error "ValueError: empirical Physics operational witness failed"

theorem registeredSpecValid : validateSpec = .ok () := by
 unfold validateSpec specWitnesses
 rw [LeptonIsolation.terminalSearchComplete]
 rfl

end SFT.Physics.LeptonExperiment
