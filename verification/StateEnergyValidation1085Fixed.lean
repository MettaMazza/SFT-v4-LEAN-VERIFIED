import SFT.Chemistry.StateEnergyTargets
import SFT.Chemistry.StateEnergyOrderPrediction
import SFT.Chemistry.StateEnergyControls
import SFT.Chemistry.StateEnergyOrderExperiment
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.StateEnergyValidation
open SFT.Host SFT.Host.Canonical SFT.Physics StateEnergyOrderExperiment
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-NIST-state-energy-order-comparator/1",.text experimentId]))),
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

abbrev J := Canonical.Value

def rowOfResolved (row : StateEnergyTargets.Resolved) : Except String StateEnergyComparison.Row := do
 let target ← StateEnergyControls.shown row.original "target_id"
 let species ← StateEnergyControls.shown row.original "species_row_id"
 let state ← StateEnergyControls.shown row.original "state_record"
 let inscription ← StateEnergyControls.shown row.original "energy_inscription"
 let quality ← StateEnergyControls.shown row.original "source_quality"
 let ground ← StateEnergyControls.boolField row.original "is_source_designated_ground_state"
 let n ← StateEnergyControls.field row.original "exact_gap_from_species_ground_numerator"
 let d ← StateEnergyControls.field row.original "exact_gap_from_species_ground_denominator"
 match n with
 | .integer a => match d with
  | .integer b => pure ⟨row,target,species,state,inscription,quality,ground,a,b⟩
  | .null | .text _ | .boolean _ | .array _ | .object _ => throw "registered exact gap integers required"
 | .null | .text _ | .boolean _ | .array _ | .object _ => throw "registered exact gap integers required"

def insertPrediction (rows : List (String × CapabilityValues.Value)) (key : String) (value : CapabilityValues.Value) :=
 if rows.any (fun p=>Text.equal p.1 key) then rows.map (fun p=>if Text.equal p.1 key then (key,value) else p)
 else rows++[(key,value)]
def predictionMap : CapabilityValues.Value → Except String (List (String × CapabilityValues.Value))
 | .table entries => do
  if entries.length != 22 then throw "ELEC-004 prediction vector is incomplete"
  entries.foldlM (fun rows (left,right)=>match left with
   | .label key => pure (insertPrediction rows key.label right)
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "prediction key has no label") []
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => .error "ELEC-004 prediction vector is incomplete"

def lawMatches : CapabilityValues.Value → Bool
 | .label held => Text.equal held.family "state-order-law" && Text.equal held.label "unique-structural-least-plus-positive-successors"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false

def compareAll (predictions : List (String × CapabilityValues.Value)) (rows : List StateEnergyComparison.Row) : Except String (List J × Nat) := do
 let _checked ← rows.mapM (fun row=>do
  if !(predictions.any (fun p=>Text.equal p.1 row.speciesId)) then
   throw (Text.join ["'",row.speciesId,"'"])
  pure ())
 predictions.foldlM (fun (comparisons,pairs) (species,value)=>do
  if !lawMatches value then throw "ELEC-004 sealed order law changed"
  let (records,count) ← StateEnergyComparison.compareSpecies species (rows.filter (fun row=>Text.equal row.speciesId species))
  pure (comparisons++records,pairs+count)) ([],0)

def validate (identityHash targetHash : String) (identitySchema targetSchema : J)
 (identities : List StateEnergyTargets.Identity) (rawTargets : List StateEnergyTargets.Target)
 (snapshots : List StateEnergyTargets.Snapshot) (derivationSeal host implementation firstHash changedHash : String)
 (before after : Snapshot) : Except String J := do
 validateSpec
 if !Text.equal identityHash StateEnergyTargets.identityRegistryHash then throw "ELEC-004 identity registry changed"
 if !ConjugatedSupportAnalysis.isText identitySchema "sft-v3-state-energy-order-identities/1" || identities.length != 306 then
  throw "ELEC-004 identity support is incomplete"
 let document := StateEnergyOrderPrediction.programDocument (identities.map OrbitalSupportTargets.Identity.speciesRowId)
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fields => fields
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let parsed ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let targets ← StateEnergyTargets.resolvedTargets identityHash targetHash identitySchema targetSchema identities rawTargets snapshots
 let rows ← targets.mapM rowOfResolved
 let env := envelope registrationHash derivationSeal
 let targetValues := rows.map fun row=>(row.targetId,CapabilityValues.canonical row.resolved.targetValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian") targetValues
  (identity (.array [.text registrationHash,.text targetRegistryHash])) (identity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-004 prediction package changed"
 let (_,released) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment released prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) released.values
 let predictions ← predictionMap execution.output
 let (comparisons,pairs) ← compareAll predictions rows
 let first ← match references with
  | [] => .error "tuple index out of range"
  | row::_ => .ok row
 let controls ← StateEnergyControls.adverse comparisons pairs firstHash first.snapshotHash changedHash
 let passed ← StateEnergyControls.passed comparisons controls
 let targetIdentity ← TargetCustody.identityFromRelease released
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ELEC-004 released target differs"
 let measurements ← StateEnergyControls.measurements comparisons pairs controls
 let payload := StateEnergyControls.measurementPayload registrationHash prediction.sealHash comparisons pairs controls execution.traceHash
 pure (.object [
 ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
 ("isolation_certificate",isolation host implementation execution vault prediction),
 ("target_custody_certificate",custodyCertificate registrationHash released prediction),
 ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
 ("data_source_ids",.array [.text "NIST-CHEMISTRY-WEBBOOK-SRD69-DIATOMIC-CONSTANTS-2025"]),
 ("measurements",.array (measurements.map Canonical.Value.text)),("measurement_receipt_hash",.text (identity payload)),
 ("falsification_condition",.text falsification),("passed",.boolean passed)])
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms rowOfResolved
#print axioms insertPrediction
#print axioms predictionMap
#print axioms lawMatches
#print axioms compareAll
#print axioms validate
end SFT.Chemistry.StateEnergyValidation
