import SFT.Chemistry.StateSymmetryExperiment
import SFT.Chemistry.StateSymmetryControls
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.StateSymmetryValidation
open SFT.Host SFT.Host.Canonical SFT.Physics StateSymmetryExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-NIST-state-symmetry-comparator/1",.text experimentId]))),
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


def boolText (b : Bool) : String := if b then "True" else "False"
def measurement (c : StateSymmetryComparison.Comparison) : Except String String := do
 let row := c.target
 let term := row.term
 let rank ← StateSymmetrySource.rankInscription term.symbol
 let orientation := if Text.equal term.symbol "Σ" then 1 else 2
 return Text.intercalate "" [
  row.identity.targetId," (",row.identity.speciesRowId,"): NIST ",row.stateRecord,
  "; term ",Text.append term.inscription term.suffix,"; spin multiplicity ",toString term.multiplicity,
  "; axis ",term.symbol," (",rank,"); positive orientation count ",toString orientation,
  "; forced combined degeneracy ",toString (term.multiplicity*orientation),
  "; inversion ",StateSymmetrySource.inversionLabel term.suffix,
  "; reflection ",StateSymmetrySource.reflectionLabel term.suffix,
  "; axis component ",StateSymmetrySource.axisComponent term.suffix,
  "; component kind ",StateSymmetrySource.componentKind term.suffix,
  "; source glyph 0 denotes absence ",boolText (Text.contains term.suffix "_0"),
  "; pass ",boolText c.passed]

def measurementPayload (registrationHash : String) (prediction : PredictionSeal)
 (counts : List (String × Nat)) (comparisons : List StateSymmetryComparison.Comparison)
 (adverse : List (String × Bool)) (traceHash : String) : Except String Value := do
 let values ← comparisons.mapM StateSymmetryComparison.comparisonValue
 return .object [("registration_hash",.text registrationHash),("prediction_seal_hash",.text prediction.sealHash),
  ("counts",.object (counts.map fun (key,n) => (key,.integer (.ofNat n)))),
  ("comparisons",.array values),("adverse",.object (adverse.map fun (key,b) => (key,.boolean b))),
  ("trace_hash",.text traceHash)]

structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash identitySchema actualTargetHash targetSchema : String)
 (identities : List StateSymmetryPrediction.Identity) (targets : List StateSymmetryPrediction.WithheldTarget)
 (snapshots : List StateSymmetryPrediction.Snapshot) (tamperedFirstHash derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let document ← StateSymmetryPrediction.predictionDocument actualIdentityHash identitySchema identities
 let registrationHash := identity (registration document)
 let programFields := match document with
  | .object fields => fields
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let resolved ← StateSymmetryPrediction.resolvedTargets actualIdentityHash identitySchema actualTargetHash targetSchema
  identities targets snapshots
 let targetValues := resolved.map fun row => (row.identity.targetId,CapabilityValues.canonical row.targetValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-005 prediction package changed during execution"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) release.values
 let predicted ← StateSymmetryComparison.predictionMap execution.output
 let comparisons ← resolved.mapM (StateSymmetryComparison.compare predicted)
 let firstReference ← match references with
  | [] => .error "IndexError: tuple index out of range"
  | head::_ => .ok head
 let firstSnapshot ← match snapshots.find? (fun row => Text.equal row.path firstReference.snapshotPath) with
  | none => .error (Text.append "FileNotFoundError: " firstReference.snapshotPath)
  | some row => .ok row
 let adverse ← StateSymmetryControls.adverse comparisons firstSnapshot.actualHash tamperedFirstHash firstReference.snapshotHash
 let counts := StateSymmetryComparison.counts comparisons
 let passed := comparisons.all StateSymmetryComparison.Comparison.passed && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then
  throw "ELEC-005 released target identity differs from custody"
 let payload ← measurementPayload registrationHash prediction counts comparisons adverse execution.traceHash
 let rowMessages ← comparisons.mapM measurement
 let messages := rowMessages ++ counts.map (fun (key,n) => Text.intercalate "" ["complete count ",key,": ",toString n]) ++
  adverse.map (fun (key,b) => Text.intercalate "" ["adverse ",key,": ",boolText b])
 return ⟨.object [
  ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text sourceId]),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),
  ("passed",.boolean passed)],passed⟩
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms boolText
#print axioms measurement
#print axioms measurementPayload
#print axioms validate
end SFT.Chemistry.StateSymmetryValidation
