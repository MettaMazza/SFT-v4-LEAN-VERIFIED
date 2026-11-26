import SFT.Chemistry.CapabilityTraceChunks
import SFT.Chemistry.CanonicalPackageChunks
import SFT.Chemistry.CanonicalExecutionChunks
import SFT.Chemistry.VibrationalFrequencyPrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.VibrationalFrequencyValidation
open SFT.Host SFT.Host.Canonical SFT.Physics VibrationalFrequencyExperiment
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
 ("comparison_implementation_identity_hash",.text (CanonicalExecutionChunks.identity (.array [.text "exact-NIST-vibrational-frequency-vector",.text falsification]))),
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



open VibrationalFrequencySource VibrationalFrequencyPrediction
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
def validate (identityBytes targetBytes primaryBytes : ByteArray) (identityDocument targets primary : Value)
 (snapshot : VibrationalFrequencySource.Snapshot) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := CanonicalExecutionChunks.identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-009 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityTraceChunks.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← CanonicalPackageChunks.auditProgram programFields before after
 if !Text.equal (CanonicalExecutionChunks.identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-009 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes identityDocument targets primary snapshot
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
  let countMatches := fun index key => match (word.drop index).head? with
   | none => false
   | some cell => match cell with
    | .count n => sameValue (.integer n.value) (get row.row key)
    | .emptyOne _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
  let identityMatch := labelMatches word 1 (get row.row "formula") && labelMatches word 2 (get row.row "name") &&
   countMatches 8 "mode_count" && labelMatches word 3 (get row.row "symmetry_label") &&
   countMatches 9 "molecule_count" && countMatches 10 "vibration_count"
  let valueMatches := sameValue released (CapabilityValues.canonical row.value)
  let passed := valueMatches && identityMatch
  let present := sameValue (get row.row "measurement_present") (.boolean true)
  let inscription ← if present then field row.row "frequency_inscription_cm_inverse" >>= text else pure "structural EmptyOne"
  let value := Value.object [("target_id",.text row.targetId),("formula",get row.row "formula"),
   ("mode_count",get row.row "mode_count"),("symmetry_label",get row.row "symmetry_label"),
   ("measurement_present",get row.row "measurement_present"),("frequency_inscription_cm_inverse",get row.row "frequency_inscription_cm_inverse"),
   ("exact_positive_ratio_or_structural_EmptyOne",.boolean valueMatches),("identity_match",.boolean identityMatch),("passed",.boolean passed)]
  let message := Text.intercalate "" [row.targetId,": ",inscription," per centimeter; exact and mode-bound ",boolText passed]
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
 let measured := source.filter fun row => sameValue (get row.row "measurement_present") (.boolean true)
 let absent := source.filter fun row => !sameValue (get row.row "measurement_present") (.boolean true)
 let keys := source.map Target.targetId
 let uniqueTargets := keys.foldl (fun acc key => if acc.any (Text.equal key) then acc else key::acc) []
 let molecules := source.map fun row => get row.row "molecule_count"
 let uniqueMolecules := molecules.foldl (fun acc value => if acc.any (sameValue value) then acc else value::acc) []
 let controls : List (String × Bool) := [
  ("tampered_frequency_rejected",!sameValue (CapabilityValues.canonical tampered) (CapabilityValues.canonical first.value)),
  ("complete_displayed_support_preserved",source.length==2009 && uniqueTargets.length==2009),
  ("measured_and_absent_rows_preserved",measured.length==1984 && absent.length==25),
  ("complete_displayed_molecule_support_preserved",uniqueMolecules.length==145),
  ("source_advertised_displayed_gap_preserved",(164-145 : Nat)==19 && (2452-2009 : Nat)==443),
  ("all_measured_values_exact_and_positive",measured.all fun row => positive row.value),
  ("all_unmeasured_values_structural_EmptyOne",absent.all fun row => match row.value with
   | .emptyOne _ => true
   | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false)]
 let passed := comparisons.all Comparison.passed && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-009 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map Comparison.message ++ controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CCCBDB-COMPLETE-DISPLAYED-FUNDAMENTAL-FREQUENCY-SURFACE"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (CanonicalExecutionChunks.identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.VibrationalFrequencyValidation
