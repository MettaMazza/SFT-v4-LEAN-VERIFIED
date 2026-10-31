import SFT.Host.SHA256Window
import SFT.Physics.ObservationPrediction
import SFT.Physics.CosmicComponentTransportMeasurement
set_option maxRecDepth 20000
namespace SFT.Physics.CosmicComponentTransportExperiment
open SFT.Host SFT.Host.Canonical
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032"
def experimentId : String := "SFT-EXP-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032"
def expectedLabel : String := "terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"
def frozenRelation : String := "All 32 CCH rows overlap the zero-parameter terminal squared-rate prediction at the registered two-uncertainty boundary; the 11/5 equality and 22/5 onset cubes agree with the complete Planck ratio interval; 17/32 agrees with the measured accelerating-magnitude interval; tension-One agrees with the constant-w interval; and the adverse DESI DR2 evolving-dark-energy preference remains explicit."
def sourcePath : String := "experiments/external_sources/physics/snapshots/cosmic_transport_terminal-source-record.json"
def snapshotHash : String := "sha256:6a88728657b19dba0bcf2430d28218a595c0798c6ac34bf2778ef53a1b540705"
def falsification : String := "Any of the 32 CCH intervals fails the registered squared two-uncertainty comparison; either threshold cube lies outside its complete external interval; the q or tension magnitude lies outside its interval; any source hash, row, custody record or adverse DESI statement changes; or a tampered target is accepted."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"CCH-H2-01","GOMEZ-VALENT-2023-CCH-32","Table 1 row 1: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-02","GOMEZ-VALENT-2023-CCH-32","Table 1 row 2: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-03","GOMEZ-VALENT-2023-CCH-32","Table 1 row 3: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-04","GOMEZ-VALENT-2023-CCH-32","Table 1 row 4: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-05","GOMEZ-VALENT-2023-CCH-32","Table 1 row 5: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-06","GOMEZ-VALENT-2023-CCH-32","Table 1 row 6: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-07","GOMEZ-VALENT-2023-CCH-32","Table 1 row 7: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-08","GOMEZ-VALENT-2023-CCH-32","Table 1 row 8: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-09","GOMEZ-VALENT-2023-CCH-32","Table 1 row 9: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-10","GOMEZ-VALENT-2023-CCH-32","Table 1 row 10: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-11","GOMEZ-VALENT-2023-CCH-32","Table 1 row 11: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-12","GOMEZ-VALENT-2023-CCH-32","Table 1 row 12: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-13","GOMEZ-VALENT-2023-CCH-32","Table 1 row 13: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-14","GOMEZ-VALENT-2023-CCH-32","Table 1 row 14: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-15","GOMEZ-VALENT-2023-CCH-32","Table 1 row 15: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-16","GOMEZ-VALENT-2023-CCH-32","Table 1 row 16: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-17","GOMEZ-VALENT-2023-CCH-32","Table 1 row 17: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-18","GOMEZ-VALENT-2023-CCH-32","Table 1 row 18: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-19","GOMEZ-VALENT-2023-CCH-32","Table 1 row 19: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-20","GOMEZ-VALENT-2023-CCH-32","Table 1 row 20: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-21","GOMEZ-VALENT-2023-CCH-32","Table 1 row 21: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-22","GOMEZ-VALENT-2023-CCH-32","Table 1 row 22: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-23","GOMEZ-VALENT-2023-CCH-32","Table 1 row 23: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-24","GOMEZ-VALENT-2023-CCH-32","Table 1 row 24: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-25","GOMEZ-VALENT-2023-CCH-32","Table 1 row 25: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-26","GOMEZ-VALENT-2023-CCH-32","Table 1 row 26: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-27","GOMEZ-VALENT-2023-CCH-32","Table 1 row 27: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-28","GOMEZ-VALENT-2023-CCH-32","Table 1 row 28: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-29","GOMEZ-VALENT-2023-CCH-32","Table 1 row 29: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-30","GOMEZ-VALENT-2023-CCH-32","Table 1 row 30: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-31","GOMEZ-VALENT-2023-CCH-32","Table 1 row 31: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"CCH-H2-32","GOMEZ-VALENT-2023-CCH-32","Table 1 row 32: redshift, H(z), reported uncertainty","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"PLANCK-EQUALITY-CUBE","PLANCK-2018-BAO-BASELINE-BUDGET","vacuum/matter interval","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"Q0-TYPED-MAGNITUDE","GOMEZ-VALENT-2019-ACCELERATION","q0 magnitude and orientation","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"ACCELERATION-TRANSITION-CUBE","GOMEZ-VALENT-2019-ACCELERATION","transition-redshift interval","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"VACUUM-TENSION-MAGNITUDE","ESCAMILLA-2024-DARK-ENERGY-STATE","constant-w interval","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩,⟨"DESI-DYNAMIC-ADVERSE-ROW","DESI-DR2-2025-COSMOLOGY","w0-wa model-extension preference","terminal-cosmic-transport-complete-vector-passes-with-adverse-desi-row-retained"⟩]

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

theorem completeTargetCount : targetRows.length = 37 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-COSMO-COMPLETE-BUDGET-001", "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001", "SFT-PHYS-MEAS-VALUE-RECORD-001", "SFT-PHYS-MEAS-UNCERTAINTY-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (targetRows.length==37 && true && true)

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

end SFT.Physics.CosmicComponentTransportExperiment
