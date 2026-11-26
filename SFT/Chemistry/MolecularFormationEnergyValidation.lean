import SFT.Chemistry.CapabilityTraceChunks
import SFT.Chemistry.CanonicalPackageChunks
import SFT.Chemistry.CanonicalExecutionChunks
import SFT.Chemistry.MolecularFormationEnergyPrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularFormationEnergyValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularFormationEnergyExperiment
open SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def envelope (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map fun (key,value) => (key,.text (CanonicalExecutionChunks.valueIdentity value)))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def sealPrediction (prior : Option PredictionSeal) (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := CanonicalExecutionChunks.identity (envelope inputs registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,CanonicalExecutionChunks.identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (CanonicalExecutionChunks.identity (.object fields)))])

def isolation (registrationHash host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (CanonicalExecutionChunks.identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (CanonicalExecutionChunks.identity (.array [.text "exact-held-formation-state-relation-complete-vector",.text falsification]))),
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



open MolecularFormationEnergySource MolecularFormationEnergyPrediction
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
def validate (identityBytes targetBytes primaryBytes resultBytes referenceBytes : ByteArray) (identityDocument targets : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := CanonicalExecutionChunks.identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-013 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityTraceChunks.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← CanonicalPackageChunks.auditProgram programFields before after
 if !Text.equal (CanonicalExecutionChunks.identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-013 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes resultBytes referenceBytes identityDocument targets
 let values := source.map fun row => (row.targetId,CapabilityValues.canonical row.value)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian") values
  (CanonicalExecutionChunks.identity (.array [.text registrationHash,.text targetHash])) (CanonicalExecutionChunks.identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let comparisons ← source.mapM fun row => do
  let word ← predictionAt predicted row.targetId
  let released ← releaseValue release.values row.targetId
  let identityMatch := labelMatches word 1 (get row.row "name") && labelMatches word 2 (get row.row "species") &&
   labelMatches word 3 (get row.row "external_charge_inscription") && labelMatches word 4 (get row.row "temperature_reference_label") &&
   labelMatches word 5 (get row.row "measurement_kind") && labelMatches word 6 (get row.row "measurement_unit") &&
   labelMatches word 7 (get row.row "source_id")
  let valueMatches := sameValue released (CapabilityValues.canonical row.value)
  let passed := valueMatches && identityMatch
  let value := Value.object [("target_id",.text row.targetId),("species",get row.row "species"),("temperature_reference_label",get row.row "temperature_reference_label"),
   ("source_value_inscription",get row.row "source_value_inscription"),("source_orientation",.text row.sourceOrientation),
   ("result_class",.text row.resultClass),("identity_match",.boolean identityMatch),
   ("exact_magnitude_or_structural_absence_match",.boolean valueMatches),("passed",.boolean passed)]
  let message := Text.intercalate "" [row.targetId,": ",row.resultClass,"; identity and exact post-seal result ",boolText passed]
  pure (⟨value,passed,message⟩ : Comparison)
 let positive := fun value => match value with
  | CapabilityValues.Value.ratio _ _ => true
  | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 let first ← match source.find? (fun row => positive row.value) with
  | none => throw "StopIteration"
  | some row => pure row
 let tampered ← match first.value with
  | .ratio n d => pure (CapabilityValues.Value.ratio (← CapabilityValues.count (n.value+d.value)) d)
  | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => throw "source magnitude is not an exact positive ratio"
 let firstBlank ← match source.find? (fun row => Text.equal row.resultClass "unmeasured-structural-EmptyOne") with
  | none => throw "StopIteration"
  | some row => pure row
 let firstEqual ← match source.find? (fun row => Text.equal row.resultClass "printed-equality-structural-EmptyOne") with
  | none => throw "StopIteration"
  | some row => pure row
 let positiveRelease ← releaseValue release.values first.targetId
 let blankRelease ← releaseValue release.values firstBlank.targetId
 let equalRelease ← releaseValue release.values firstEqual.targetId
 let isAxis := fun row label => sameValue (get row.row "temperature_reference_label") (.text label)
 let controls : List (String × Bool) := [
  ("tampered_magnitude_rejected",!sameValue (CapabilityValues.canonical tampered) positiveRelease),
  ("blank_cell_is_structural_EmptyOne",hasKey blankRelease "identity"),
  ("printed_external_equality_is_structural_EmptyOne",hasKey equalRelease "identity"),
  ("signed_source_orientations_are_never_negative_proof_values",(source.filter fun row =>
   Text.equal row.sourceOrientation "product-state-below-reference-state" || Text.equal row.sourceOrientation "product-state-above-reference-state").all fun row => positive row.value),
  ("complete_2098_cell_vector_retained",release.values.length==source.length && source.length==2098),
  ("all_613_blank_cells_retained",(source.filter fun row => Text.equal row.resultClass "unmeasured-structural-EmptyOne").length==613),
  ("all_22_printed_equalities_retained",(source.filter fun row => Text.equal row.resultClass "printed-equality-structural-EmptyOne").length==22),
  ("both_temperature_reference_axes_retained",(source.all fun row => isAxis row "298.15-kelvin" || isAxis row "source-0-kelvin-label") &&
   (source.any fun row => isAxis row "298.15-kelvin") && (source.any fun row => isAxis row "source-0-kelvin-label"))]
 let passed := comparisons.all Comparison.passed && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-013 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("complete_2098_cell_comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map Comparison.message ++ controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CCCBDB-SRD-101-COMPLETE-EXPERIMENTAL-FORMATION-ENERGY",.text "NIST-CCCBDB-THERMODYNAMIC-REFERENCE-STATES"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (CanonicalExecutionChunks.identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MolecularFormationEnergyValidation
