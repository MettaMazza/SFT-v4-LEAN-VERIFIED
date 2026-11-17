import SFT.Chemistry.PairExchangeExperiment
import SFT.Chemistry.PairExchangeControls
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.PairExchangeValidation
open SFT.Host SFT.Host.Canonical SFT.Physics PairExchangeExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-NIST-H2-pair-exchange-comparator/1",.text experimentId]))),
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
def configurationText : Option PairExchangeSource.Configuration → String
 | none => "absence"
 | some c => Text.intercalate "" ["{'positive_radial_recurrence': ",toString c.radial,
  ", 'source_family_label': '",c.family,"', 'axis_support_symbol': '",c.symbol,
  "', 'positive_occupancy_count': ",toString c.occupancy,"}"]
def stateMeasurement (row : PairExchangeComparison.StateComparison) : Except String String := do
 let s := row.source
 return Text.intercalate "" [s.targetId,": NIST ",s.stateRecord,"; term ",Text.append s.term.inscription s.term.suffix,
  "; positive spin multiplicity ",toString s.term.multiplicity,"; spin exchange ",
  ← PairExchangeComparison.textField s.fields "spin_exchange_class","; spatial exchange ",
  ← PairExchangeComparison.textField s.fields "spatial_exchange_class","; total ",
  ← PairExchangeComparison.textField s.fields "total_exchange_class","; same-cell observation ",
  ← PairExchangeComparison.textField s.fields "same_cell_record","; configuration ",configurationText s.configuration,
  "; energy inscription ",s.energyInscription,"; source glyph 0 is absence baseline ",boolText (Text.equal s.energyInscription "0"),
  "; pass ",boolText row.passed]
def pairMeasurement (row : PairExchangeComparison.PairComparison) : String :=
 let s := row.source
 Text.intercalate "" [s.targetId,": support ",configurationText (some s.configuration),"; singlet ",s.singlet.stateRecord,
  " at ",s.singlet.energyInscription,"; triplet ",s.triplet.stateRecord," at ",s.triplet.energyInscription,
  "; positive measured separation ",toString row.numerator.value,"/",toString row.denominator.value,
  " inverse-centimetre; held order ",s.order,"; pass ",boolText row.passed]
def measurementPayload (registrationHash : String) (prediction : PredictionSeal)
 (counts : List (String × Nat)) (states : List PairExchangeComparison.StateComparison)
 (pairs : List PairExchangeComparison.PairComparison) (adverse : List (String × Bool)) (traceHash : String) : Except String Value := do
 let stateValues ← states.mapM PairExchangeComparison.stateComparisonValue
 return .object [("registration_hash",.text registrationHash),("prediction_seal_hash",.text prediction.sealHash),
  ("counts",.object (counts.map fun (key,n) => (key,.integer (.ofNat n)))),
  ("state_comparisons",.array stateValues),("pair_comparisons",.array (pairs.map PairExchangeComparison.pairComparisonValue)),
  ("adverse",.object (adverse.map fun (key,b) => (key,.boolean b))),("trace_hash",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash identitySchema actualTargetHash targetSchema : String)
 (ids : List PairExchangeTargets.Identity) (rawStates rawPairs : List PairExchangeTargets.Target)
 (actualSnapshotHash : String) (events : List StateSymmetrySource.Event)
 (tamperedFirstHash derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let document ← PairExchangePrediction.predictionDocument actualIdentityHash identitySchema ids
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fs => fs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let program ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let (stateTargets,pairTargets) ← PairExchangeTargets.resolvedTargets actualIdentityHash identitySchema actualTargetHash targetSchema
  ids rawStates rawPairs actualSnapshotHash events
 let targetValues := (stateTargets.map fun s => (s.targetId,CapabilityValues.canonical s.targetValue)) ++
  (pairTargets.map fun p => (p.targetId,CapabilityValues.canonical p.targetValue))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-006 prediction package changed during execution"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) release.values
 let predicted ← PairExchangeComparison.predictionMap execution.output
 let states ← stateTargets.mapM (PairExchangeComparison.compareState predicted)
 let pairs ← pairTargets.mapM (PairExchangeComparison.comparePair predicted states)
 let counts ← PairExchangeComparison.counts states pairs
 let reference ← match references with
  | [] => .error "IndexError: tuple index out of range"
  | r::_ => .ok r
 let adverse ← PairExchangeControls.adverse states pairs counts actualSnapshotHash tamperedFirstHash reference.snapshotHash
 let passed := states.all PairExchangeComparison.StateComparison.passed && pairs.all PairExchangeComparison.PairComparison.passed && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then
  throw "ELEC-006 released target identity differs from custody"
 let payload ← measurementPayload registrationHash prediction counts states pairs adverse execution.traceHash
 let stateMessages ← states.mapM stateMeasurement
 let messages := stateMessages ++ pairs.map pairMeasurement ++
  counts.map (fun (key,n) => Text.intercalate "" ["complete count ",key,": ",toString n]) ++
  adverse.map (fun (key,b) => Text.intercalate "" ["adverse ",key,": ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text sourceId]),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms boolText
#print axioms configurationText
#print axioms stateMeasurement
#print axioms pairMeasurement
#print axioms measurementPayload
#print axioms validate
end SFT.Chemistry.PairExchangeValidation
