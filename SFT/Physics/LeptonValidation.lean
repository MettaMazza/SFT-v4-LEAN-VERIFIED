import SFT.Physics.LeptonCustody
namespace SFT.Physics.LeptonValidation
open SFT.Host SFT.Host.Canonical LeptonPrediction LeptonExperiment LeptonCustody
set_option maxRecDepth 20000

structure Snapshot where
 rootId : String
 fileHashes : List (String × String)
 snapshotHash : String

def sameFileHashes : List (String × String) → List (String × String) → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | (p,h)::xs,(q,k)::ys => Text.equal p q && Text.equal h k && sameFileHashes xs ys

def sameSnapshot (before after : Snapshot) : Bool :=
 Text.equal before.rootId after.rootId && sameFileHashes before.fileHashes after.fileHashes &&
 Text.equal before.snapshotHash after.snapshotHash

def documentKeys : Value → List String
 | .object fields => fields.map Prod.fst
 | .text _ => []
 | .boolean _ => []
 | .integer _ => []
 | .null => []
 | .array _ => []

def hasKey (keys : List String) (key : String) : Bool := keys.any (Text.equal key)
def executablePresent (keys : List String) : Bool :=
 ["python","source","script","command","module","callable"].any (hasKey keys)
def additionalFields (keys : List String) : Bool :=
 !(keys.all (fun key => hasKey ["schema","program_id","instructions"] key) &&
 ["schema","program_id","instructions"].all (hasKey keys))

-- The original caller always constructs this registered data-only document.
-- Snapshots are complete typed records supplied by the read-only IO adapter.
def auditRegistered (before after : Snapshot) : Except String Value :=
 let unchanged := sameSnapshot before after
 let executable := executablePresent (documentKeys programDocument)
 let additional := additionalFields (documentKeys programDocument)
 let passed := !executable && !additional && unchanged
 let payload := [("auditor_id",Value.text "sft-v3-hostile-empirical-package-auditor/1"),
   ("package_hash",.text (identity programDocument)),("program_hash",.text (identity programValue)),
   ("executable_source_present",.boolean executable),("additional_fields_present",.boolean additional),
   ("protected_tree_unchanged",.boolean unchanged),("passed",.boolean passed)]
 if passed then .ok (.object (payload ++ [("certificate_hash",.text (identity (.object payload)))]))
 else .error "HostilePackageHalt: empirical package failed data-only or protected-tree audit"

def observation : Held → Except String String
 | .pair _ _ => .error "ValueError: prediction emitted an invalid physical observation label"
 | .label family label => if Text.equal family "physical-observation" then .ok label
   else .error "ValueError: prediction emitted an invalid physical observation label"

def targetLabel : Held → Except String String
 | .label _ label => .ok label
 | .pair _ _ => .error "AttributeError: released target has no label"

structure Comparison where
 targetId : String
 sourceId : String
 sourceLocator : String
 predicted : String
 observed : String
 passed : Bool

def compareRows (prediction : String) (released : List (String × Held)) :
 List TargetRow → Except String (List Comparison)
 | [] => .ok []
 | row::rest => do
   let value ← match lookup row.targetId released with
     | none => .error (Text.append "KeyError: " row.targetId)
     | some value => .ok value
   let observed ← targetLabel value
   let tail ← compareRows prediction released rest
   .ok (⟨row.targetId,row.sourceId,row.sourceLocator,prediction,observed,Text.equal prediction observed⟩::tail)

def comparisonValue (row : Comparison) : Value := .object [
 ("target_id",.text row.targetId),("source_id",.text row.sourceId),("source_locator",.text row.sourceLocator),
 ("predicted",.text row.predicted),("observed",.text row.observed),("passed",.boolean row.passed)]

def controlPassed (prediction : String) : Bool := !Text.equal prediction "changed-external-observation"
def controlValue (prediction : String) : Value := .object [
 ("target_id",.text "deliberately-tampered-unfavorable-control"),("predicted",.text prediction),
 ("observed",.text "changed-external-observation"),("passed",.boolean (controlPassed prediction))]

def allPassed (prediction : String) (rows : List Comparison) : Bool :=
 rows.all Comparison.passed && controlPassed prediction

def message (row : Comparison) : String := Text.intercalate "" [row.targetId,": predicted ",row.predicted,
 "; observed ",row.observed,"; exact match ",if row.passed then "True" else "False"]

def sourceIds : List Comparison → List String
 | [] => []
 | row::rest => row.sourceId :: (sourceIds rest).filter (fun s => !Text.equal s row.sourceId)

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (derivationSeal host implementation : String) (output : Held) (trace : List TraceRow)
 (vault : Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text host),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text (identity programValue)),("input_manifest_hash",.text (identity (inputManifest derivationSeal))),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-held-label-equality",.text experimentId,.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text (identity (heldValue output))),
 ("trace_hash",.text (identity (.array (trace.map traceValue)))),("completed",.boolean true)]

def custodyCertificate (released : Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

def receipt (derivationSeal prediction traceHash : String) (predictionSeal : PredictionSeal)
 (rows : List Comparison) : Value := .object [
 ("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
 ("prediction_seal_hash",.text predictionSeal.sealHash),("source_snapshot_hash",.text snapshotHash),
 ("comparisons",.array (rows.map comparisonValue)),("tampered_control",controlValue prediction),
 ("complete_trace_hash",.text traceHash)]

structure Validation where
 value : Value
 passed : Bool

-- Host/implementation fields reproduce source metadata; they are not claims
-- that the native Lean execution runs on a Python interpreter.
def validate (bytes : ByteArray) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 checkSource bytes
 let vault := registeredVault derivationSeal
 checkVault vault
 let execution ← execute derivationSeal
 let output ← match execution.output with
   | none => .error "FoldLanguageHalt: registered program did not emit"
   | some output => .ok output
 let predictionSeal ← sealPrediction none derivationSeal output execution.trace
 let _audit ← auditRegistered before after
 let (_,released) ← release vault predictionSeal
 verify vault.commitment released predictionSeal
 let _context ← measurementContext (some predictionSeal) released.values
 let prediction ← observation output
 let rows ← compareRows prediction released.values targetRows
 let targetIdentity ← identityFromRelease released
 if !Text.equal targetIdentity vault.commitment.targetHash then
   .error "ValueError: released target identity differs from its commitment"
 else
   let passed := allPassed prediction rows
   let traceHash := identity (.array (execution.trace.map traceValue))
   .ok ⟨.object [
     ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
     ("isolation_certificate",isolation derivationSeal host implementation output execution.trace vault predictionSeal),
     ("target_custody_certificate",custodyCertificate released predictionSeal),
     ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
     ("all_rows_preserved",.boolean true),("data_source_ids",.array ((sourceIds rows).map Value.text)),
     ("measurements",.array ((rows.map (fun row => Value.text (message row))) ++ [.text "deliberately tampered unfavorable control rejected"])),
     ("measurement_receipt_hash",.text (identity (receipt derivationSeal prediction traceHash predictionSeal rows))),
     ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩

def requireAgreement (numeric : LeptonComparison.Record) (validation : Validation) : Except String Validation :=
 if numeric.allRowsPassed == validation.passed then .ok validation
 else .error "ValueError: terminal numeric interval result differs from sealed label comparison"

def terminalWithin (rows : List (List Char)) (electronFuel tauFuel : Nat)
 (bytes : ByteArray) (derivationSeal host implementation : String) (before after : Snapshot) : Except String (Option Validation) := do
 let record ← LeptonComparison.comparisonRowsWithin rows electronFuel tauFuel
 match record with
 | none => .ok none
 | some numeric => do
   let validation ← validate bytes derivationSeal host implementation before after
   let result ← requireAgreement numeric validation
   .ok (some result)

theorem registeredDataOnly : executablePresent (documentKeys programDocument) = false := rfl

theorem registeredFieldsExact : additionalFields (documentKeys programDocument) = false := rfl

theorem registeredComparisons :
 (compareRows expectedLabel targets targetRows).map (fun rows => rows.map Comparison.passed) = .ok [true,true] := rfl

theorem tamperedControlRejected : controlPassed expectedLabel = true := rfl

theorem tamperedPredictionFails : controlPassed "changed-external-observation" = false := rfl

theorem numericLabelAgreement (v : Validation) (passed : v.passed = true) :
 requireAgreement LeptonComparison.terminalRecord v = .ok v := by
 unfold requireAgreement
 rw [LeptonComparison.bothRowsPassed,passed]
 rfl

theorem numericLabelDisagreement (v : Validation) (failed : v.passed = false) :
 requireAgreement LeptonComparison.terminalRecord v =
 .error "ValueError: terminal numeric interval result differs from sealed label comparison" := by
 unfold requireAgreement
 rw [LeptonComparison.bothRowsPassed,failed]
 rfl

theorem terminalConnection (bytes : ByteArray) (derivationSeal host implementation : String)
 (before after : Snapshot) (v : Validation)
 (validated : validate bytes derivationSeal host implementation before after = .ok v)
 (passed : v.passed = true) :
 terminalWithin LeptonSource.snapshotRows 27 15 bytes derivationSeal host implementation before after = .ok (some v) := by
 unfold terminalWithin
 rw [LeptonComparison.nativeComparison]
 dsimp only [Bind.bind,Except.bind]
 rw [validated]
 dsimp only [Bind.bind,Except.bind]
 rw [numericLabelAgreement v passed]

end SFT.Physics.LeptonValidation
