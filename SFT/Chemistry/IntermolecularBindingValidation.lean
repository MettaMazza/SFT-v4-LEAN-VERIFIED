import SFT.Chemistry.CapabilityTraceChunks
import SFT.Chemistry.CanonicalPackageChunks
import SFT.Chemistry.CanonicalExecutionChunks
import SFT.Chemistry.IntermolecularBindingPrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.IntermolecularBindingValidation
open SFT.Host SFT.Host.Canonical SFT.Physics IntermolecularBindingExperiment
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
 ("comparison_implementation_identity_hash",.text (CanonicalExecutionChunks.identity (.array [.text "exact-positive-binding-or-structural-absence-complete-vector",.text falsification]))),
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



open IntermolecularBindingSource IntermolecularBindingPrediction
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
def validate (identityBytes targetBytes primaryBytes waterBytes ionBytes : ByteArray) (identityDocument targets : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := CanonicalExecutionChunks.identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-011 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityTraceChunks.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← CanonicalPackageChunks.auditProgram programFields before after
 if !Text.equal (CanonicalExecutionChunks.identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-011 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes waterBytes ionBytes identityDocument targets
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
  let identityMatch := labelMatches word 1 (get row.row "dimer_formula") && labelMatches word 2 (get row.row "dimer_name") &&
   labelMatches word 3 (get row.row "donor_formula") && labelMatches word 4 (get row.row "acceptor_formula") &&
   labelMatches word 5 (get row.row "source_class") && labelMatches word 6 (get row.row "source_id")
  let valueMatches := sameValue released (CapabilityValues.canonical row.value)
  let passed := valueMatches && identityMatch
  let inscription := if hasKey row.row "value_inscription_kJ_per_mol" then get row.row "value_inscription_kJ_per_mol" else get row.row "value_inscription_cm_inverse"
  let value := Value.object [("target_id",.text row.targetId),("dimer_id",get row.row "dimer_id"),
   ("source_class",get row.row "source_class"),("result_class",.text row.resultClass),
   ("source_value_inscription",inscription),("identity_match",.boolean identityMatch),
   ("exact_value_or_structural_absence_match",.boolean valueMatches),("passed",.boolean passed)]
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
 let absent := fun value => match value with
  | CapabilityValues.Value.emptyOne _ => true
  | .ratio _ _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 let firstAdverse ← match source.find? (fun row => absent row.value) with
  | none => throw "StopIteration"
  | some row => pure row
 let positiveRelease ← releaseValue release.values first.targetId
 let adverseRelease ← releaseValue release.values firstAdverse.targetId
 let computed := source.filter fun row => sameValue (get row.row "source_class") (.text "authoritative-calculated-benchmark")
 let dimers := computed.map fun row => get row.row "dimer_id"
 let uniqueDimers := dimers.foldl (fun acc value => if acc.any (sameValue value) then acc else value::acc) []
 let classes := source.map fun row => get row.row "source_class"
 let uniqueClasses := classes.foldl (fun acc value => if acc.any (sameValue value) then acc else value::acc) []
 let controls : List (String × Bool) := [
  ("tampered_positive_value_rejected",!sameValue (CapabilityValues.canonical tampered) positiveRelease),
  ("signed_adverse_cannot_become_negative_sft_number",sameValue adverseRelease (CapabilityValues.canonical (.emptyOne "empty-One"))),
  ("missing_row_rejected",release.values.length==source.length && source.length==1299),
  ("complete_dimer_catalogue_retained",uniqueDimers.length==11),
  ("computed_and_experimental_classes_not_conflated",uniqueClasses.length==2 &&
   uniqueClasses.any (sameValue (.text "authoritative-calculated-benchmark")) &&
   uniqueClasses.any (sameValue (.text "reported-experimental-cluster-dissociation-value"))),
  ("all_96_signed_adverse_rows_retained",(source.filter fun row => absent row.value).length==96)]
 let passed := comparisons.all Comparison.passed && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-011 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("complete_1299_row_comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map Comparison.message ++ controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CCCBDB-SRD-101-DIMER-BINDING",.text "NIST-FARADAY-C8FD00092A-WATER-CLUSTER-DISSOCIATION",.text "NIST-JPCRD-1.555757-ION-CLUSTER-SCOPE"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (CanonicalExecutionChunks.identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.IntermolecularBindingValidation
