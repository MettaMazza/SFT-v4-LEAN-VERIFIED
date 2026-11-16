import SFT.Physics.GrandLockObservationBaseValidation
import SFT.Physics.GrandLockObservationAnalysis
namespace SFT.Physics.GrandLockObservationValidation
open SFT.Host SFT.Host.Canonical GrandLockObservationBaseValidation GrandLockObservationAnalysis RunningConvergenceMeasurement PostNewtonianRecords
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def replaceField (record : Value) (key : String) (value : Value) : Value := match record with
 | .object fields=>.object (fields.map fun (name,v)=>(name,if Text.equal name key then value else v))
 | .null | .boolean _ | .integer _ | .text _ | .array _=>record
def missingRow (record : Value) : Except String Value := do
 let rows ← array (← field record "empirical_claims")
 pure (replaceField record "empirical_claims" (.array (rows.drop 1)))
def missingAdverse (record : Value) : Except String Value := do
 let rows ← array (← field record "unfavorable_or_scope_boundary_ids")
 pure (replaceField record "unfavorable_or_scope_boundary_ids" (.array (rows.drop 1)))
def falseLegacy (record : Value) : Value := replaceField record "legacy_empirical_materialization_without_separate_measurement_receipt" (.array [])
def selector (record : Value) : Except String Value := do
 let boundary ← field record "methodological_boundary"
 pure (replaceField record "methodological_boundary" (replaceField boundary "measurements_select_formal_survivor" (.boolean true)))
def allChecks (record : Value) : Bool := match record with
 | .object fields=>fields.all (fun (_,v)=>SymmetricRecords.truthy v)
 | .null | .boolean _ | .integer _ | .text _ | .array _=>false
def validate (snapshot : ByteArray) (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim "SFT-PHYS-VALIDATION-GRAND-LOCK-076" then throw "wrong Grand Lock empirical seal"
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest snapshot)) GrandLockObservationAnalysis.sourceHash then throw "Grand Lock empirical source changed"
 let formal ← field record "formal_grand_lock"
 let receiptPath ← text (← field formal "receipt_path")
 let receiptHash ← text (← field formal "receipt_file_sha256")
 let receiptBytes ← fileBytes files receiptPath
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest receiptBytes)) receiptHash then throw "formal Grand Lock receipt file changed"
 let inputPath ← text (← field record "prelock_input_path")
 let inputHash ← text (← field record "prelock_input_sha256")
 let inputBytes ← fileBytes files inputPath
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest inputBytes)) inputHash then throw "pre-lock Grand Lock input changed"
 let certificate ← recordCertificate record
 if !allChecks certificate then throw "complete empirical reconciliation did not close"
 let missingCertificate ← recordCertificate (← missingRow record)
 let adverseCertificate ← recordCertificate (← missingAdverse record)
 let legacyCertificate ← recordCertificate (falseLegacy record)
 let selectorCertificate ← recordCertificate (← selector record)
 let rejected := fun c key=> !SymmetricRecords.truthy (getDefault c key)
 let controls := [rejected missingCertificate "unique_complete_empirical_vector",rejected adverseCertificate "adverse_scope_vector_exact",rejected legacyCertificate "legacy_shape_exact",rejected selectorCertificate "methodological_boundary"]
 if !controls.all id then throw "Grand Lock empirical hostile control failed"
 let base ← GrandLockObservationBaseValidation.validate snapshot derivationSeal host implementation before after
 let rows ← array (← field record "empirical_claims")
 let ids ← rows.mapM (fun row=>field row "claim_id")
 let sources ← field record "unique_external_source_ids"
 let adverse ← field record "unfavorable_or_scope_boundary_ids"
 let legacy ← field record "legacy_empirical_materialization_without_separate_measurement_receipt"
 let payload : Value := .object [("sealed",.text derivationSeal),("source",.text GrandLockObservationAnalysis.sourceHash),("certificate",certificate),("controls",.array (controls.map Value.boolean)),("empirical_claim_ids",.array ids),("external_source_ids",sources),("adverse_ids",adverse),("legacy_ids",legacy)]
 let measurements : List String := ["Complete immutable reconciliation of 234 empirically tested Physics claims.", "All 147 distinct registered external source identities remain present.", "Every empirical and external validation hash and every available separate measurement receipt remains bound.", "Six older materialization shapes without a separate measurement-receipt field are explicitly retained, not silently upgraded.", "All fourteen detected unfavorable-result or scope-boundary claims remain in the same evidence vector.", "Observation remains empirical evidence; prior observations are not relabelled as unseen predictions and never select a formal survivor."]
 let passed := base.passed && allChecks certificate && controls.all id
 let output := replaceField (replaceField (replaceField (replaceField (replaceField base.value "all_rows_preserved" (.boolean true)) "data_source_ids" sources) "measurements" (.array (measurements.map Value.text))) "measurement_receipt_hash" (.text (admissionIdentity payload))) "passed" (.boolean passed)
 pure ⟨output,passed⟩
#print axioms validate
end SFT.Physics.GrandLockObservationValidation
