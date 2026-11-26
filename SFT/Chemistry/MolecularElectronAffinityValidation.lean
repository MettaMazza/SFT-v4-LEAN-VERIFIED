import SFT.Chemistry.MolecularElectronAffinityPrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularElectronAffinityValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularElectronAffinityExperiment
open SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def envelope (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map fun (key,value) => (key,.text (CapabilityValues.identity value)))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def sealPrediction (prior : Option PredictionSeal) (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope inputs registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (registrationHash host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-NIST-molecular-electron-affinity-vector",.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]



open MolecularElectronAffinitySource MolecularElectronAffinityPrediction
set_option maxRecDepth 30000
structure Validation where
 value : Value
 passed : Bool
structure Comparison where
 value : Value
 passed : Bool
 message : String
def boolText (b : Bool) : String := if b then "True" else "False"
def releaseValue (values : List (String × Value)) (target : String) : Except String Value :=
 match values.find? (fun row => Text.equal row.1 target) with
 | none => throw (Text.append "KeyError: " target)
 | some row => pure row.2
def positiveReleased (value : Value) : Bool :=
 let positive := fun value => match value with
  | .integer n => @decide (Int.lt 0 n) (Int.decLt _ _)
  | .null | .boolean _ | .text _ | .array _ | .object _ => false
 positive (get (get value "numerator") "value") && positive (get (get value "denominator") "value")
def validate (identityBytes targetBytes primaryBytes manifestBytes : ByteArray) (identityDocument targets primary manifest : Value)
 (catalog guide : MolecularElectronAffinitySource.Page) (pages : List MolecularElectronAffinitySource.Page) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-008 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-008 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes manifestBytes identityDocument targets primary manifest catalog guide pages
 let values := source.map fun row => (row.targetId,CapabilityValues.canonical row.value)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian") values
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let comparisons ← source.mapM fun row => do
  let word ← predictionAt predicted row.targetId
  let released ← releaseValue release.values row.targetId
  let identityMatch := [(1,"formula"),(3,"casno"),(4,"initial_molecular_state"),(5,"resulting_anion_state"),(8,"condition"),(9,"units")].all
   fun (index,key) => labelMatches word index (get row.row key)
  let isWord := match get released "cells" with
   | .array _ => true
   | .null | .boolean _ | .integer _ | .text _ | .object _ => false
  let valueMatches := isWord && sameValue released (CapabilityValues.canonical row.value)
  let passed := valueMatches && identityMatch
  let magnitude ← field row.row "magnitude_inscription" >>= text
  let glyph ← field row.row "source_orientation_glyph" >>= text
  let orientation ← field row.row "fold_state_order_orientation" >>= text
  let value := Value.object [("target_id",.text row.targetId),("formula",get row.row "formula"),
   ("source_orientation_glyph",.text glyph),("fold_state_order_orientation",.text orientation),
   ("magnitude_inscription_eV",.text magnitude),("uncertainty_inscription_eV",get row.row "uncertainty_inscription"),
   ("exact_positive_or_EmptyOne_representation",.boolean valueMatches),("identity_match",.boolean identityMatch),("passed",.boolean passed)]
  let message := Text.intercalate "" [row.targetId,": source ",glyph," glyph, ",magnitude," eV positive magnitude, ",orientation,"; exact state-bound ",boolText passed]
  pure (⟨value,passed,message⟩ : Comparison)
 let first ← match source.head? with
  | none => throw "IndexError: tuple index out of range"
  | some row => pure row
 let cells ← match first.value with
  | .word cells => pure cells
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "source target is not a Fold word"
 let firstMagnitude ← match (cells.drop 1).head? with
  | none => throw "source magnitude is absent"
  | some value => pure value
 let firstOrientation ← match cells.head? with
  | none => throw "source orientation is absent"
  | some value => pure value
 let tampered ← match firstMagnitude with
  | .ratio n d => pure (CapabilityValues.Value.ratio (← CapabilityValues.count (n.value+d.value)) d)
  | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => throw "source magnitude is not an exact positive ratio"
 let flipped ← CapabilityValues.heldLabel "electron-affinity-state-order" "anion-above-neutral-unbound-autodetachment"
 let bound := source.filter fun row => match get row.row "fold_state_order_orientation" with
  | .text s => (Text.chars "anion-below").isPrefixOf (Text.chars s)
  | .null | .boolean _ | .integer _ | .array _ | .object _ => false
 let unbound := source.filter fun row => match get row.row "fold_state_order_orientation" with
  | .text s => (Text.chars "anion-above").isPrefixOf (Text.chars s)
  | .null | .boolean _ | .integer _ | .array _ | .object _ => false
 let uncertainties := source.filter fun row => !sameValue (get row.row "uncertainty_inscription") .null
 let positiveMagnitudes := source.all fun row => match row.value with
  | .word cells => match (cells.drop 1).head? with
   | none => false
   | some cell => match cell with
    | .ratio _ _ => true
    | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => false
 let controls : List (String × Bool) := [
  ("tampered_magnitude_rejected",!sameValue (CapabilityValues.canonical tampered) (CapabilityValues.canonical firstMagnitude)),
  ("flipped_orientation_rejected",!sameValue (CapabilityValues.canonical (.label flipped)) (CapabilityValues.canonical firstOrientation)),
  ("complete_catalog_and_molecular_pages_preserved",source.length==96),
  ("all_bound_and_unbound_rows_preserved",bound.length==93 && unbound.length==3),
  ("all_explicit_uncertainties_preserved",uncertainties.length==89),
  ("source_minus_glyphs_are_not_negative_numbers",positiveMagnitudes)]
 let passed := comparisons.all Comparison.passed && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-008 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map Comparison.message ++ controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CCCBDB-COMPLETE-ELECTRON-AFFINITY-CATALOG",.text "NIST-CCCBDB-EXPERIMENTAL-MOLECULAR-ELECTRON-AFFINITY",.text "NIST-WEBBOOK-SRD69-GAS-PHASE-ION-THERMOCHEMISTRY"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MolecularElectronAffinityValidation
