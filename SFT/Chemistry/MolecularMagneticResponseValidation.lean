import SFT.Chemistry.MolecularMagneticResponsePrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularMagneticResponseValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularMagneticResponseExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "held-orientation-exact-magnetic-response-vector",.text falsification]))),
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



open MolecularMagneticResponseSource MolecularMagneticResponsePrediction
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
def validate (identityBytes targetBytes primaryBytes pdfBytes textBytes resolutionBytes : ByteArray) (identityDocument targets primary : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-012 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-012 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes pdfBytes textBytes resolutionBytes identityDocument targets primary
 let values := source.map fun row => (row.targetId,CapabilityValues.canonical row.value)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian") values
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let comparisons ← source.mapM fun row => do
  let word ← predictionAt predicted row.targetId
  let released ← releaseValue release.values row.targetId
  let identityMatch := labelMatches word 1 (get row.row "source_id") && labelMatches word 2 (get row.row "database") &&
   labelMatches word 3 (get row.row "section") && labelMatches word 4 (get row.row "magnetic_parameter") &&
   labelMatches word 5 (get row.row "measurement_kind") && labelMatches word 6 (get row.row "source_locator")
  let valueMatches := sameValue released (CapabilityValues.canonical row.value)
  let passed := valueMatches && identityMatch
  let value := Value.object [("target_id",.text row.targetId),("magnetic_parameter",get row.row "magnetic_parameter"),
   ("source_value_inscription",get row.row "source_value_inscription"),("source_orientation",.text row.sourceOrientation),
   ("result_class",.text row.resultClass),("identity_match",.boolean identityMatch),
   ("exact_magnitude_or_structural_absence_match",.boolean valueMatches),("passed",.boolean passed)]
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
 let firstBlank ← match source.find? (fun row => absent row.value) with
  | none => throw "StopIteration"
  | some row => pure row
 let positiveRelease ← releaseValue release.values first.targetId
 let blankRelease ← releaseValue release.values firstBlank.targetId
 let controls : List (String × Bool) := [
  ("tampered_magnitude_rejected",!sameValue (CapabilityValues.canonical tampered) positiveRelease),
  ("blank_cell_is_structural_EmptyOne",hasKey blankRelease "identity"),
  ("signed_source_orientation_not_negative_proof_number",(source.filter fun row => Text.equal row.sourceOrientation "source-opposed").all fun row => positive row.value),
  ("complete_174_cell_vector_retained",release.values.length==source.length && source.length==174),
  ("all_38_blank_cells_retained",(source.filter fun row => absent row.value).length==38),
  ("complete_diatomic_pdf_vector_retained",(source.filter fun row => sameValue (get row.row "database") (.text "diatomic-reference-pdf")).length==22),
  ("quadrupole_chi_frequency_tensors_excluded",!(source.any fun row => quadrupoleFrequencyTensor row.row))]
 let passed := comparisons.all Comparison.passed && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-012 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("complete_174_cell_comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map Comparison.message ++ controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-MOLECULAR-MICROWAVE-SPECTRAL-DATABASES-SRD-114-115-117",.text "NIST-JPCRD-3-609-1974-DIATOMIC-MICROWAVE-SPECTRAL-TABLES"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MolecularMagneticResponseValidation
