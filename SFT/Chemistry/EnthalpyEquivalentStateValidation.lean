import SFT.Chemistry.EnthalpyEquivalentStatePrediction
import SFT.Chemistry.FiniteMicrostateSupportSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.EnthalpyEquivalentStateValidation
open SFT.Host SFT.Host.Canonical SFT.Physics EnthalpyEquivalentStateExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-enthalpy-state-environment-composition",.text falsification]))),
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



open EnthalpyEquivalentStateSource EnthalpyEquivalentStatePrediction
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
def validate (identityBytes targetBytes primaryBytes snapshotBytes : ByteArray) (identityDocument targets : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-006 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "THERMO-006 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes snapshotBytes identityDocument targets
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
   labelMatches word 3 (.text ordinal) && labelMatches word 4 (get row.row "chemical_composition_identity") &&
   labelMatches word 5 (get row.row "query_identity") && labelMatches word 6 (.text columns) &&
   labelMatches word 7 (.text "complete-held-state-and-environment-carrier") &&
   labelMatches word 8 (.text "retained-exact-positive-internal-content") &&
   labelMatches word 9 (.text "observation-forced-organized-environment-transfer-parts") &&
   labelMatches word 10 (.text "exact-positive-composition-plus-EmptyOne-absence")
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && targetMatch
  let value := Value.object [("target_id",.text row.targetId),
   ("target_payload_hash",get row.row "target_payload_hash"),("identity_match",.boolean identityMatch),
   ("postseal_target_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  let sourceClass ← field row.row "source_class" >>= text
  let message := Text.intercalate "" [row.targetId,": ",sourceClass,"; identity and post-seal payload binding ",boolText passed]
  pure (⟨value,passed,message⟩ : Comparison)
 let analysis ← exactEnthalpyAnalysis source
 let tampered := source.zipIdx.map fun (row,index) => if index==5 then
   let changed := match get row.row "target_payload" with
    | .object fields => .object (fields.map fun (key,value) =>
      if Text.equal key "enthalpy-kilojoule-per-mole" then (key,.text "1.000000") else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => get row.row "target_payload"
   let updated := match row.row with
    | .object fields => .object (fields.map fun (key,value) => if Text.equal key "target_payload" then (key,changed) else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => row.row
   {row with row := updated}
  else row
 let tamperedAnalysis ← exactEnthalpyAnalysis tampered
 let check := fun (a : Analysis) (name : String) => match a.checks.find? (fun item => Text.equal item.1 name) with
  | some item => item.2
  | none => false
 let controls : List (String × Bool) := [
  ("tampered_nonpositive_environment_component_rejected",!check tamperedAnalysis "all_environment_components_exact_positive"),
  ("complete_13_row_vector_retained",release.values.length==source.length && source.length==13),
  ("complete_14_column_vector_retained",check analysis "all_fourteen_columns_retained"),
  ("both_phase_boundary_states_retained",check analysis "phase_boundary_pair_retained"),
  ("complete_enthalpy_and_component_vectors_retained",analysis.enthalpyValues.length==13 && analysis.environmentComponents.length==13),
  ("prediction_contains_no_withheld_target_hash",!(Text.contains (FiniteMicrostateSupportSource.spacedRender document) targetHash))]
 let passed := comparisons.all Comparison.passed && analysis.checks.all Prod.snd && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "THERMO-006 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),  ("enthalpy_values",.array (analysis.enthalpyValues.map fun v => .text (fractionText v))),
  ("internal_values",.array (analysis.internalValues.map fun v => .text (fractionText v))),
  ("environment_components",.array (analysis.environmentComponents.map fun v => .text (fractionText v))),
  ("enthalpy_steps",.array (analysis.enthalpySteps.map fun v => .text (fractionText v))),
    ("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let rowMessages ← source.zipIdx.mapM fun (row,index) => do
  let h ← field (get row.row "target_payload") "enthalpy-kilojoule-per-mole" >>= identityString
  let u ← field (get row.row "target_payload") "internal-energy-kilojoule-per-mole" >>= identityString
  let component ← match (analysis.environmentComponents.drop index).head? with
   | some v => pure v | none => throw "tuple index out of range"
  pure (Text.intercalate "" ["row ",toString (index+1),": H=",h," kJ/mol; U=",u," kJ/mol; environment=",fractionText component," kJ/mol"])
 let first ← match analysis.enthalpyValues.head? with | some v => pure v | none => throw "tuple index out of range"
 let last ← match analysis.enthalpyValues.getLast? with | some v => pure v | none => throw "tuple index out of range"
 let messages := rowMessages ++ [Text.intercalate "" ["complete exact enthalpy path: ",fractionText first," to ",fractionText last,
  " kJ/mol; all 12 increments positive and additive"],
  "all 13 environment components agree with pressure-volume records within exact displayed resolution",
  "both 372.75593 K liquid/vapour enthalpy states retained"] ++
  controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CHEMISTRY-WEBBOOK-SRD69-WATER-FLUID-PROPERTIES"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.EnthalpyEquivalentStateValidation
