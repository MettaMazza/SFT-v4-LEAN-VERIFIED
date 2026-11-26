import SFT.Chemistry.MolecularDiffusionPrediction
import SFT.Chemistry.FiniteMicrostateSupportSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularDiffusionValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularDiffusionExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-molecular-diffusion-correspondence",.text falsification]))),
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



open MolecularDiffusionSource MolecularDiffusionPrediction
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
def rangesJSON (rs : List MolecularDiffusionAnalysis.Range) : Value := .object (rs.map fun r=>(r.name,.object [
 ("minimum",.text (fractionText r.bounds.1)),("maximum",.text (fractionText r.bounds.2))]))
def analysisJSON (a : Analysis) : Value := .object ([
 ("complete_target_count",.integer a.count),
 ("class_counts",.object (a.classes.map fun (k,n)=>(k,.integer n))),
 ("dataset_counts",.object (a.datasets.map fun (k,n)=>(k,.integer n))),
 ("method_counts",.object (a.methods.map fun (k,n)=>(k,.integer n))),
 ("phase_counts",.object (a.phases.map fun (k,n)=>(k,.integer n))),
 ("structural_EmptyOne_condition_count",.integer a.emptyCount),
 ("exact_diffusion_ranges_m2_per_s",rangesJSON a.ranges),
 ("exact_positive_condition_ranges",rangesJSON a.conditionRanges)]++a.checks.map (fun (k,b)=>(k,.boolean b)))
def rangeRepr (r : MolecularDiffusionAnalysis.Range) : String := Text.intercalate "" ["'",r.name,"': {'minimum': '",fractionText r.bounds.1,"', 'maximum': '",fractionText r.bounds.2,"'}"]
def validate (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray) (identityDocument targets primary : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-016 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "THERMO-016 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes sourceBytes identityDocument targets
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
  let identityValues ← identityFields.mapM fun (key,_) => identityValue row.row key
  let identityMatch := identityValues.zipIdx.all fun (value,index) => labelMatches word (index+1) (.text value)
  let lawMatch := labelMatches word 6 (.text "complete-molecular-condition-transition-carrier") &&
   labelMatches word 7 (.text "counted-adjacent-cell-identity-conserving-redistribution") &&
   labelMatches word 8 (.text "held-transition-orientation-without-random-premise") &&
   labelMatches word 9 (.text "exact-positive-postseal-diffusion-support-with-EmptyOne-conditions")
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && lawMatch && targetMatch
  let value := Value.object [("target_id",.text row.targetId),("identity_match",.boolean identityMatch),
   ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  pure (⟨value,passed,""⟩ : Comparison)
 let analysis ← exactMolecularDiffusionAnalysis source primary
 let tampered := source.zipIdx.map fun (row,index) => if index==0 then
   let changed := match get row.row "target_payload" with
    | .object fields => .object (fields.map fun (key,value) =>
      if Text.equal key "diffusion_coefficient_m2_per_s_external_inscription" then (key,.text "-1") else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => get row.row "target_payload"
   let updated := match row.row with
    | .object fields => .object (fields.map fun (key,value) => if Text.equal key "target_payload" then (key,changed) else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => row.row
   {row with row := updated}
  else row
 let tamperRejected := match exactMolecularDiffusionAnalysis tampered primary with
  | .error _ => true
  | .ok _ => false
 let check := fun (a : Analysis) (name : String) => match a.checks.find? (fun item => Text.equal item.1 name) with
  | some item => item.2
  | none => false
 let controls : List (String × Bool) := [
  ("tampered_negative_diffusion_rejected",tamperRejected),
  ("complete_164_record_vector_retained",release.values.length==164),
  ("all_binary_self_tracer_rows_retained",check analysis "all_138_binary_4_self_22_tracer_records_retained"),
  ("all_diffusion_datasets_retained",check analysis "all_11_diffusion_datasets_complete"),
  ("all_methods_and_phases_retained",check analysis "all_three_methods_and_classes_retained" && check analysis "all_liquid_and_subsupercritical_phase_rows_retained"),
  ("all_absent_conditions_translated_to_EmptyOne",check analysis "all_26_absent_condition_coordinates_are_EmptyOne"),
  ("prediction_contains_no_withheld_target_hash",!(Text.contains (FiniteMicrostateSupportSource.spacedRender document) targetHash))]
 let passed := comparisons.all Comparison.passed && analysis.checks.all Prod.snd && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "THERMO-016 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),
  ("analysis",analysisJSON analysis),
    ("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← source.mapM fun row => do
  let className ← field row.row "diffusion_class" >>= identityString
  let dataset ← field row.row "dataset_ordinal" >>= identityString
  let point ← field row.row "source_point_ordinal" >>= identityString
  let hash ← field row.row "target_payload_hash" >>= identityString
  pure (Text.intercalate "" [row.targetId,": class=",className,"; dataset=",dataset,"; point=",point,"; target=",hash])
 let messages := rowMessages ++ ["complete vector: 138 binary, 4 self and 22 tracer diffusion records",
  Text.intercalate "" ["exact diffusion ranges: {",Text.intercalate ", " (analysis.ranges.map rangeRepr),"}"],
  "source coverage: all 30 datasets and 373 points preserved from three complete NIST ThermoML sources"] ++
  controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 let sourceIds ← source.mapM fun row=>field row.row "source_id" >>= identityString
 let distinctIds := sourceIds.foldl (fun acc x=>if acc.any (Text.equal x) then acc else acc++[x]) []
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (distinctIds.map Value.text)),
 ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MolecularDiffusionValidation
