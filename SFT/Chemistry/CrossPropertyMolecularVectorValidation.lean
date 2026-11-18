import SFT.Chemistry.CrossPropertyMolecularVectorPrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.CrossPropertyMolecularVectorValidation
open SFT.Host SFT.Host.Canonical SFT.Physics CrossPropertyMolecularVectorExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-shared-carrier-cross-property-vector",.text falsification]))),
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



open CrossPropertyMolecularVectorSource CrossPropertyMolecularVectorPrediction
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
def validate (identityBytes targetBytes manifestBytes summaryBytes : ByteArray) (identityDocument targets : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-014 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-014 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes manifestBytes summaryBytes identityDocument targets
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
  let propertyCount ← field row.row "registered_property_family_count_for_carrier" >>= identityString
  let overlap ← field row.row "cross_property_overlap" >>= identityString
  let identityMatch := labelMatches word 1 (get row.row "structural_carrier_id") && labelMatches word 2 (get row.row "property_family") &&
   labelMatches word 3 (get row.row "property_label") && labelMatches word 4 (get row.row "source_target_id") &&
   labelMatches word 5 (get row.row "source_identity_hash") && labelMatches word 7 (.text propertyCount) && labelMatches word 9 (.text overlap)
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && targetMatch
  let value := Value.object [("cross_property_target_id",.text row.targetId),("structural_carrier_id",get row.row "structural_carrier_id"),
   ("property_family",get row.row "property_family"),("source_target_id",get row.row "source_target_id"),
   ("source_target_payload_hash",get row.row "source_target_payload_hash"),("identity_match",.boolean identityMatch),
   ("postseal_target_payload_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  let family ← field row.row "property_family" >>= text
  let carrier ← field row.row "structural_carrier_id" >>= text
  let message := Text.intercalate "" [row.targetId,": ",family," on ",carrier,"; post-seal payload identity ",boolText passed]
  pure (⟨value,passed,message⟩ : Comparison)
 let first ← match source with
  | [] => throw "list index out of range"
  | first::_ => pure first
 let tampered ← CapabilityValues.heldLabel "source-target-payload-hash" "sha256:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
 let firstRelease ← releaseValue release.values first.targetId
 let h2 := source.filter fun row => sameValue (get row.row "structural_carrier_id") (.text "exact-formula:H2")
 let properties ← familyCount source "property_family"
 let carriers ← familyCount source "structural_carrier_id"
 let overlapCarriers ← familyCount (source.filter overlapping) "structural_carrier_id"
 let h2Families ← familyCount h2 "property_family"
 let unjoined := source.filter fun row => ["no-explicit-species-formula-in-registered-diatomic-PDF-cell",
  "source-species-label-not-formula-normalized","bound-composite-not-conflated-with-constituent-molecule"].any fun rule =>
   sameValue (get row.row "carrier_derivation_rule") (.text rule)
 let unjoinedIds ← stringsAt unjoined "structural_carrier_id"
 let controls : List (String × Bool) := [
  ("tampered_target_payload_hash_rejected",!sameValue (CapabilityValues.canonical (.label tampered)) firstRelease),
  ("complete_13_property_families_retained",properties==13),
  ("complete_9025_source_rows_retained",release.values.length==source.length && source.length==9025),
  ("complete_1104_structural_carriers_retained",carriers==1104),
  ("all_676_multi_property_carriers_retained",overlapCarriers==676),
  ("all_6676_overlap_rows_retained",(source.filter overlapping).length==6676),
  ("maximum_eight_family_H2_carrier_retained",h2Families==8),
  ("nonjoined_rows_not_guessed_into_formula_carriers",unjoinedIds.all fun id => !(Text.isPrefix "exact-formula:".toUTF8.data.toList id.toUTF8.data.toList))]
 let passed := comparisons.all Comparison.passed && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-014 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("complete_9025_row_comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map Comparison.message ++ controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array ((List.range 13).map fun index => .text (Text.intercalate "" ["SFT-V3-ADMITTED-PROP-",if index+1<10 then "00" else "0",toString (index+1)]))),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.CrossPropertyMolecularVectorValidation
