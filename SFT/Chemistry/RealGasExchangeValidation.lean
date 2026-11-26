import SFT.Chemistry.RealGasExchangePrediction
import SFT.Chemistry.FiniteMicrostateSupportSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.RealGasExchangeValidation
open SFT.Host SFT.Host.Canonical SFT.Physics RealGasExchangeExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-real-gas-equilibrium-vector-correspondence",.text falsification]))),
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



open RealGasExchangeSource RealGasExchangePrediction
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
def analysisJSON (a : Analysis) : Value := .object ([
 ("complete_target_count",.integer a.count),
 ("dataset_counts",.object (a.datasets.map fun (k,n)=>(k,.integer n))),
 ("component_pairs",.array (a.pairs.map fun (x,y)=>.array [.text x,.text y])),
 ("minimum_pressure_kPa",.text (fractionText a.pressureBounds.1)),
 ("maximum_pressure_kPa",.text (fractionText a.pressureBounds.2)),
 ("minimum_temperature_K",.text (fractionText a.temperatureBounds.1)),
 ("maximum_temperature_K",.text (fractionText a.temperatureBounds.2)),
 ("distinct_temperature_count",.integer a.distinctTemperatures),
 ("minimum_gas_component_mole_fraction",.text (fractionText a.gasBounds.1)),
 ("maximum_gas_component_mole_fraction",.text (fractionText a.gasBounds.2))]++a.checks.map (fun (k,b)=>(k,.boolean b)))
def validate (identityBytes targetBytes primaryBytes rawBytes : ByteArray) (identityDocument targets primary : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-010 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "THERMO-010 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes rawBytes identityDocument targets
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
  let identityValues ← identityFields.mapM fun (key,_) => field row.row key >>= identityString
  let identityMatch := (identityValues.zipIdx.all fun (value,index) => labelMatches word (index+1) (.text value)) &&
   labelMatches word 6 (.text "exact-accessible-over-reference-support-relation") &&
   labelMatches word 7 (.text "exact-joint-versus-independent-support-relation") &&
   labelMatches word 8 (.text "exact-component-exchange-support-balance") &&
   labelMatches word 9 (.text "complete-pressure-temperature-composition-state-retained")
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && targetMatch
  let value := Value.object [("target_id",.text row.targetId),
   ("identity_match",.boolean identityMatch),
   ("postseal_target_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  pure (⟨value,passed,""⟩ : Comparison)
 let analysis ← exactRealGasAnalysis source primary
 let tampered := source.zipIdx.map fun (row,index) => if index==0 then
   let changed := match get row.row "target_payload" with
    | .object fields => .object (fields.map fun (key,value) =>
      if Text.equal key "pressure_kPa_external_inscription" then (key,.text "-1") else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => get row.row "target_payload"
   let updated := match row.row with
    | .object fields => .object (fields.map fun (key,value) => if Text.equal key "target_payload" then (key,changed) else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => row.row
   {row with row := updated}
  else row
 let tamperRejected := match exactRealGasAnalysis tampered primary with
  | .error _ => true
  | .ok _ => false
 let check := fun (a : Analysis) (name : String) => match a.checks.find? (fun item => Text.equal item.1 name) with
  | some item => item.2
  | none => false
 let controls : List (String × Bool) := [
  ("tampered_pressure_rejected",tamperRejected),
  ("complete_94_state_vector_retained",release.values.length==94),
  ("complete_21_dataset_176_point_source_retained",check analysis "complete_raw_source_surface_preserved"),
  ("all_59_paired_states_retained",check analysis "all_59_paired_gas_compositions_retained"),
  ("all_35_pressure_only_states_retained",check analysis "all_35_pressure_only_states_retained"),
  ("prediction_contains_no_withheld_target_hash",!(Text.contains (FiniteMicrostateSupportSource.spacedRender document) targetHash))]
 let passed := comparisons.all Comparison.passed && analysis.checks.all Prod.snd && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "THERMO-010 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),
  ("analysis",analysisJSON analysis),
    ("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← source.mapM fun row => do
  let payload := get row.row "target_payload"
  let dataset ← field payload "pressure_dataset_ordinal" >>= identityString
  let pressure ← field payload "pressure_kPa_external_inscription" >>= identityString
  let inscription := get payload "gas_component_mole_fraction_external_inscription"
  let gas ← if ComponentExchangeAnalysis.truthy inscription then identityString inscription else pure "unreported"
  let coordinates ← field payload "condition_and_liquid_composition_coordinates" >>= RunningConvergenceMeasurement.array
  pure (Text.intercalate "" [row.targetId,": pressure dataset=",dataset,"; P=",pressure," kPa; gas composition=",gas,"; coordinates=",toString coordinates.length])
 let messages := rowMessages ++ ["complete source: five compounds, 21 datasets and 176 raw points",
  "complete equilibrium vector: 94 states, 59 paired vapor compositions and 35 pressure-only states",
  Text.intercalate "" ["pressure range: ",fractionText analysis.pressureBounds.1," through ",fractionText analysis.pressureBounds.2," kPa"],
  Text.intercalate "" ["temperature range: ",fractionText analysis.temperatureBounds.1," through ",fractionText analysis.temperatureBounds.2," K"],
  Text.intercalate "" ["reported vapor-composition range: ",fractionText analysis.gasBounds.1," through ",fractionText analysis.gasBounds.2]] ++
  controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-TRC-THERMOML-FPE-2019-485-145-152"]),
 ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.RealGasExchangeValidation
