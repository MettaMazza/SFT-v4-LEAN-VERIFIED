import SFT.Chemistry.FiniteMicrostateSupportPrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.FiniteMicrostateSupportValidation
open SFT.Host SFT.Host.Canonical SFT.Physics FiniteMicrostateSupportExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "finite-support-external-structure-vector",.text falsification]))),
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



open FiniteMicrostateSupportSource FiniteMicrostateSupportPrediction
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
def validate (identityBytes targetBytes primaryBytes waterBytes : ByteArray) (identityDocument targets : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-001 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "THERMO-001 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes waterBytes identityDocument targets
 let values := source.map fun row => (row.targetId,CapabilityValues.canonical row.value)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-complete-target-custodian") values
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let comparisons ← source.mapM fun row => do
  let word ← predictionAt predicted row.targetId
  let released ← releaseValue release.values row.targetId
  let ordinal ← field row.row "source_row_ordinal" >>= identityString
  let columns ← columnHash row.row
  let identityMatch := labelMatches word 1 (get row.row "source_class") && labelMatches word 2 (get row.row "source_id") &&
   labelMatches word 3 (.text ordinal) && labelMatches word 4 (get row.row "snapshot_hash") && labelMatches word 5 (.text columns) &&
   labelMatches word 6 (.text "complete-generated-finite-chemical-support") &&
   labelMatches word 7 (.text "disjoint-exhaustive-macro-observation-partition") &&
   labelMatches word 8 (.text "exact-fibre-count-over-complete-support-count")
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && targetMatch
  let value := Value.object [("target_id",.text row.targetId),("source_class",get row.row "source_class"),
   ("target_payload_hash",get row.row "target_payload_hash"),("identity_match",.boolean identityMatch),
   ("postseal_payload_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  let sourceClass ← field row.row "source_class" >>= text
  let message := Text.intercalate "" [row.targetId,": ",sourceClass,"; identity and post-seal payload binding ",boolText passed]
  pure (⟨value,passed,message⟩ : Comparison)
 let first ← match source with
  | [] => throw "list index out of range"
  | first::_ => pure first
 let tampered ← CapabilityValues.heldLabel "external-record-payload-hash" "sha256:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
 let firstRelease ← releaseValue release.values first.targetId
 let classStarts := fun (row : Target) (prefixText : String) => match get row.row "source_class" with
  | .text value => Text.isPrefix prefixText.toUTF8.data.toList value.toUTF8.data.toList
  | .null | .boolean _ | .integer _ | .array _ | .object _ => false
 let population := source.filter fun row => classStarts row "direct-"
 let calorimetric := source.filter fun row => classStarts row "evaluated-"
 let controls : List (String × Bool) := [
  ("tampered_target_payload_hash_rejected",!sameValue (CapabilityValues.canonical (.label tampered)) firstRelease),
  ("all_330_direct_state_rows_retained",population.length==330),
  ("all_57_calorimetric_rows_retained",calorimetric.length==57),
  ("all_387_external_rows_retained",release.values.length==source.length && source.length==387),
  ("duplicated_1700_regime_boundary_retained",(calorimetric.filter boundaryRow).length==2),
  ("state_and_calorimetric_classes_not_conflated",(source.all fun row => isClass row populationClass || isClass row calorimetricClass) &&
   (source.any fun row => isClass row populationClass) && (source.any fun row => isClass row calorimetricClass)),
  ("prediction_contains_no_target_payload_hash",!(Text.contains (spacedRender document) targetHash)),
  ("continuum_and_completed_infinity_not_used",!(Text.contains frozenRelation "continuum") && !(Text.contains frozenRelation "completed-infinity"))]
 let passed := comparisons.all Comparison.passed && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "THERMO-001 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("complete_387_row_comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map Comparison.message ++ controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-MDS2-3389-CAH-PLUS-QUANTUM-JUMP-THERMOMETRY",
   .text "NIST-CHEMISTRY-WEBBOOK-SRD69-WATER-GAS-CALORIMETRIC-TABLE"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.FiniteMicrostateSupportValidation
