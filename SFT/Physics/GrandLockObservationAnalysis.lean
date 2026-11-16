import SFT.Physics.GrandLockDependency
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.GrandLockObservationAnalysis
open SFT.Host SFT.Host.Canonical GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceHash := "sha256:e233cd761aa874893d2c2a4e2b09f071297aee1204d531fce3d93429948177a3"
def sourceRecord (bytes : ByteArray) (record : Value) : Except String Value :=
 if Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then .ok record
 else .error "Grand Lock empirical reconciliation record changed"
def setEqual (a b : List String) : Bool := recordAll (fun n=>member n b) a && recordAll (fun n=>member n a) b
def uniqueVector (ids : List String) (empiricalCount : Value) : Bool := ids.length == (unique ids).length && ids.length==234 && sameValue empiricalCount (.integer 234)
def hashesRetained (hashes : List Bool) : Bool := recordAll id hashes
def measurementsRetained (measurements : List Bool) : Bool := recordAll id measurements
def legacyExact (legacy legacyRows : List String) : Bool := setEqual legacy legacyRows
def adverseExact (adverse physics : List String) : Bool := adverse.length==(unique adverse).length && adverse.length==14 && recordAll (fun n=>member n physics) adverse
def sourcesExact (sources : List String) (sourceCount : Value) : Bool := sources.length==(unique sources).length && sources.length==147 && sameValue sourceCount (.integer 147)
def boundaryExact (boundary : Value) (requiredTrue : List (String × Value)) : Bool := ThermometryMeasurement.literalBoolean (getDefault boundary "measurements_select_formal_survivor") false && recordAll (fun (_,v)=>ThermometryMeasurement.literalBoolean v true) requiredTrue
def receiptBound (formalReceipt : Value) : Bool := sameValue formalReceipt (.text "sha256:ae18f67371c8e7054430935d6b5e5f3162f24cf9cba073769384bf7ba467d817")
def certificateFields (ids legacy adverse physics sources : List String) (hashes measurements : List Bool) (legacyRows : List String) (empiricalCount sourceCount boundary : Value) (requiredTrue : List (String × Value)) (formalReceipt : Value) : Value := .object [
 ("unique_complete_empirical_vector",.boolean (uniqueVector ids empiricalCount)),
 ("all_empirical_and_external_hashes",.boolean (hashesRetained hashes)),
 ("all_available_measurement_receipts_retained",.boolean (measurementsRetained measurements)),
 ("legacy_shape_exact",.boolean (legacyExact legacy legacyRows)),
 ("adverse_scope_vector_exact",.boolean (adverseExact adverse physics)),
 ("external_source_vector_exact",.boolean (sourcesExact sources sourceCount)),
 ("methodological_boundary",.boolean (boundaryExact boundary requiredTrue)),
 ("formal_receipt_bound",.boolean (receiptBound formalReceipt))]
def recordCertificate (record : Value) : Except String Value := do
 let rows ← array (← field record "empirical_claims")
 let ids ← recordMap (fun row=>do text (← field row "claim_id")) rows
 let legacy ← stringList (← field record "legacy_empirical_materialization_without_separate_measurement_receipt")
 let adverse ← stringList (← field record "unfavorable_or_scope_boundary_ids")
 let physics ← stringList (← field record "physics_claim_ids")
 let sources ← stringList (← field record "unique_external_source_ids")
 let boundary ← field record "methodological_boundary"
 let boundaryFields ← match boundary with
  | .object fs=>pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _=>throw "TypeError"
 let requiredTrue := recordFilter (fun (key,_)=> !Text.equal key "measurements_select_formal_survivor") boundaryFields
 let hashes ← recordMap (fun row=>do pure (SymmetricRecords.truthy (← field row "empirical_validation_hash") && SymmetricRecords.truthy (← field row "external_validation_hash"))) rows
 let measurements ← recordMap (fun row=>do pure (SymmetricRecords.truthy (getDefault row "measurement_receipt_hash") || member (← text (← field row "claim_id")) legacy)) rows
 let legacyRows ← recordMap (fun row=>do text (← field row "claim_id")) (recordFilter (fun row=> !SymmetricRecords.truthy (getDefault row "measurement_receipt_hash")) rows)
 let empiricalCount ← field record "empirical_claim_count"
 let sourceCount ← field record "unique_external_source_id_count"
 let formal ← field record "formal_grand_lock"
 let formalReceipt ← field formal "receipt_hash"
 pure (certificateFields ids legacy adverse physics sources hashes measurements legacyRows empiricalCount sourceCount boundary requiredTrue formalReceipt)
#print axioms sourceRecord
#print axioms recordCertificate
end SFT.Physics.GrandLockObservationAnalysis
