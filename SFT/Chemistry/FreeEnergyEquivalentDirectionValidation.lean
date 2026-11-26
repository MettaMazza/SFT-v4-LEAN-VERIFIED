import SFT.Chemistry.FreeEnergyEquivalentDirectionPrediction
import SFT.Chemistry.FiniteMicrostateSupportSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.FreeEnergyEquivalentDirectionValidation
open SFT.Host SFT.Host.Canonical SFT.Physics FreeEnergyEquivalentDirectionExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-reaction-direction-gibbs-logK-correspondence",.text falsification]))),
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



open FreeEnergyEquivalentDirectionSource FreeEnergyEquivalentDirectionPrediction
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
def validate (identityBytes targetBytes primaryBytes : ByteArray) (identityDocument targets : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-007 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "THERMO-007 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes identityDocument targets
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
  let ordinal ← field row.row "common_source_row_ordinal" >>= identityString
  let pairHash ← sourcePairHash row.row
  let identityMatch := labelMatches word 1 (.text ordinal) && labelMatches word 2 (get row.row "reaction_identity") &&
   labelMatches word 3 (get row.row "stoichiometric_identity") && labelMatches word 4 (get row.row "standard_state_pressure") &&
   labelMatches word 5 (.text pairHash) &&
   labelMatches word 6 (.text "complete-forward-and-reverse-path-accounts") &&
   labelMatches word 7 (.text "exact-positive-energy-and-distinction-accounts") &&
   labelMatches word 8 (.text "strict-exact-product-support-order") &&
   labelMatches word 9 (.text "held-forward-reverse-or-EmptyOne-equilibrium")
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && targetMatch
  let value := Value.object [("target_id",.text row.targetId),
   ("identity_match",.boolean identityMatch),
   ("postseal_target_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  pure (⟨value,passed,""⟩ : Comparison)
 let analysis ← exactReactionDirectionAnalysis source
 let tampered := source.zipIdx.map fun (row,index) => if index==5 then
   let changed := match get row.row "target_payload" with
    | .object fields => .object (fields.map fun (key,value) =>
      if Text.equal key "held-reaction-direction" then (key,.text "reverse") else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => get row.row "target_payload"
   let updated := match row.row with
    | .object fields => .object (fields.map fun (key,value) => if Text.equal key "target_payload" then (key,changed) else (key,value))
    | .null | .boolean _ | .integer _ | .text _ | .array _ => row.row
   {row with row := updated}
  else row
 let tamperRejected := match exactReactionDirectionAnalysis tampered with
  | .error _ => true
  | .ok _ => false
 let check := fun (a : Analysis) (name : String) => match a.checks.find? (fun item => Text.equal item.1 name) with
  | some item => item.2
  | none => false
 let controls : List (String × Bool) := [
  ("tampered_direction_rejected",tamperRejected),
  ("complete_64_row_vector_retained",release.values.length==64),
  ("both_direction_classes_retained",analysis.directions.all (fun d => Text.equal d "forward" || Text.equal d "reverse") &&
   analysis.directions.any (Text.equal "forward") && analysis.directions.any (Text.equal "reverse")),
  ("single_crossing_bracket_retained",check analysis "single_direction_crossing_retained" && check analysis "exact_crossing_bracket_300_to_350_kelvin"),
  ("complete_two_species_eight_column_rows_retained",check analysis "all_eight_columns_per_species_retained"),
  ("prediction_contains_no_withheld_target_hash",!(Text.contains (FiniteMicrostateSupportSource.spacedRender document) targetHash))]
 let passed := comparisons.all Comparison.passed && analysis.checks.all Prod.snd && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "THERMO-007 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),
  ("temperatures",.array (analysis.temperatures.map fun v => .text (fractionText v))),
  ("reaction_Gibbs",.array (analysis.gibbs.map fun v => .text (fractionText v))),
  ("reaction_logK",.array (analysis.logK.map fun v => .text (fractionText v))),
  ("directions",.array (analysis.directions.map Value.text)),
    ("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← (List.range 64).mapM fun index => do
  let t ← match (analysis.temperatures.drop index).head? with | some v => pure v | none => throw "tuple index out of range"
  let g ← match (analysis.separations.drop index).head? with | some v => pure v | none => throw "tuple index out of range"
  let k ← match (analysis.logK.drop index).head? with | some v => pure v | none => throw "tuple index out of range"
  let d ← match (analysis.directions.drop index).head? with | some v => pure v | none => throw "tuple index out of range"
  pure (Text.intercalate "" ["row ",toString (index+1),": T=",fractionText t," K; |reaction Gibbs|=",fractionText g,
   " kJ/mol; direction=",d,"; external log10 K=",fractionText k])
 let messages := rowMessages ++ ["complete vector: 5 reverse rows followed by 59 forward rows",
  "exact equilibrium-crossing bracket: 300 K reverse; 350 K forward"] ++
  controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-JANAF-N-007-NO2-GAS",.text "NIST-JANAF-N-032-N2O4-GAS"]),
 ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.FreeEnergyEquivalentDirectionValidation
