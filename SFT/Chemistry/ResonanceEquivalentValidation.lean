import SFT.Chemistry.ResonanceEquivalentSource
import SFT.Chemistry.ResonanceEquivalentControls
import SFT.Chemistry.ResonanceEquivalentExperiment
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.ResonanceEquivalentValidation
open SFT.Host SFT.Host.Canonical SFT.Physics ResonanceEquivalentExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-one-carrier-multiple-representation/1",.text falsification]))),
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

-- These are the scalar metadata fields of the original hash-bound registries.
def metadataString : Value → Except String String
 | .text s => .ok s
 | .integer n => .ok (Canonical.render (.integer n))
 | .boolean b => .ok (if b then "True" else "False")
 | .null => .ok "None"
 | .array _ | .object _ => .error "registered identity scalar required"
def stringField (row : Value) (key : String) : Except String String :=
 ConjugatedSupportAnalysis.field row key >>= metadataString

def normalizedIdentity (row : Value) : Except String ResonanceEquivalentPrediction.Identity := do
 let target ← stringField row "target_id"
 let ordinal ← stringField row "source_record_ordinal"
 let source ← stringField row "source_id"
 let authority ← stringField row "authority"
 let registered ← stringField row "registered_identity"
 let role ← stringField row "source_record_role"
 let custody ← stringField row "custody_class"
 pure ⟨target,ordinal,source,authority,registered,role,custody⟩
def analysisRow (row : Value) : Except String ResonanceEquivalentAnalysis.SourceRow := do
 let source ← stringField row "source_id"
 let custody ← stringField row "custody_class"
 let role ← stringField row "source_record_role"
 let outcome ← ConjugatedSupportAnalysis.field row "source_outcome"
 pure ⟨source,custody,role,outcome⟩
def releasedLabel (value : Value) : Except String CapabilityValues.Value := do
 let family ← stringField value "family"
 let label ← stringField value "label"
 let held ← CapabilityValues.heldLabel family label
 pure (.label held)
def findReleased (values : List (String × Value)) (key : String) : Except String Value :=
 match values.find? (fun p => Text.equal p.1 key) with
 | some p => .ok p.2
 | none => .error (Text.intercalate "" ["'",key,"'"])
def findPrediction (rows : ResonanceEquivalentComparison.Predictions) (key : String) : Except String (List CapabilityValues.Value) :=
 match rows.find? (fun p => Text.equal p.1 key) with
 | some p => .ok p.2
 | none => .error (Text.intercalate "" ["'",key,"'"])
def measurementPayload (registrationHash derivationSeal : String) (prediction : PredictionSeal)
 (analysis : Value) (comparisons : List ResonanceEquivalentComparison.Comparison)
 (controls : List (String × Value)) (traceHash : String) : Value := .object [
 ("registration",.text registrationHash),("sealed",.text derivationSeal),("prediction",.text prediction.sealHash),
 ("analysis",analysis),("comparisons",.array (comparisons.map ResonanceEquivalentComparison.comparisonValue)),
 ("controls",.object controls),("trace",.text traceHash)]
def messages (analysis : Value) (controls : List (String × Value)) : Except String (List String) := do
 let vectorHash ← stringField analysis "complete_target_vector_hash"
 let controlMessages ← controls.mapM (fun (key,value) => do
  let shown ← metadataString value
  pure (Text.intercalate "" ["control ",key,": ",shown]))
 pure ([
 "Fold witness: one carrier, three atom occurrences, two incidences and two exact complementary encodings",
 "successor: four atom occurrences and three incidences with complete prior prefixes and complement retained",
 "IUPAC resonance surface: one molecular entity represented through contributing structures",
 "IUPAC resonance-form surface: at least two formal structures where one structure is insufficient",
 "IUPAC contributing-structure surface: formal encodings are not separate species",
 "IUPAC resonance-form control: representation arrow is not an equilibrium arrow",
 "IUPAC delocalization surface: support is not localized between two atoms",
 "external wavefunction, coefficient and signed-charge inscriptions preserved downstream only",
 "one V1 incomplete record-search result preserved; corrected across all four records in claim-specific V2 without recapture",
 Text.append "complete exact target vector " vectorHash] ++ controlMessages)
structure Validation where
 value : Value
 passed : Bool
def validate (identityHash targetHash primaryHash : String) (identityDocument targetDocument primaryDocument : Value)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let identities ← ResonanceEquivalentSource.identities identityHash identityDocument
 let nativeIdentities ← identities.mapM normalizedIdentity
 let document := ResonanceEquivalentPrediction.programDocument nativeIdentities
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fields => fields
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let parsed ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let execution ← CapabilityExecution.execute parsed inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ORG-002 capability-closed package changed"
 let predictions ← ResonanceEquivalentComparison.predictionMap execution.output
 let rows ← ResonanceEquivalentSource.sourceRows identityHash targetHash primaryHash identityDocument targetDocument
 let targetValues ← rows.mapM (fun row => do
  let target ← stringField row "target_id"
  let payloadHash ← stringField row "target_payload_hash"
  let held ← CapabilityValues.heldLabel "external-complete-source-record-hash" payloadHash
  pure (target,CapabilityValues.canonical (.label held)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-complete-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash]))
  (identity (envelope registrationHash derivationSeal))
 let (_,released) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment released prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) released.values
 let comparisons ← rows.mapM (fun row => do
  let normalized ← normalizedIdentity row
  let payloadHash ← stringField row "target_payload_hash"
  let word ← findPrediction predictions normalized.targetId
  let releasedValue ← findReleased released.values normalized.targetId >>= releasedLabel
  ResonanceEquivalentComparison.compare normalized payloadHash word releasedValue)
 let normalizedRows ← rows.mapM analysisRow
 let analysis ← ResonanceEquivalentAnalysis.exactAnalysis normalizedRows primaryDocument
 let controls ← ResonanceEquivalentControls.controls normalizedRows released.values.length analysis document
 let passed ← ResonanceEquivalentControls.passed comparisons analysis controls
 let targetIdentity ← TargetCustody.identityFromRelease released
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ORG-002 target identity differs"
 let measurementMessages ← messages analysis controls
 return ⟨.object [
  ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash released prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
  ("all_rows_preserved",.boolean true),
  ("data_source_ids",.array ((normalizedRows.map (fun row => row.sourceId)).map Value.text)),
  ("measurements",.array (measurementMessages.map Value.text)),
  ("measurement_receipt_hash",.text (identity (measurementPayload registrationHash derivationSeal prediction analysis comparisons controls execution.traceHash))),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms metadataString
#print axioms stringField
#print axioms normalizedIdentity
#print axioms analysisRow
#print axioms releasedLabel
#print axioms findReleased
#print axioms findPrediction
#print axioms measurementPayload
#print axioms messages
#print axioms validate
end SFT.Chemistry.ResonanceEquivalentValidation
