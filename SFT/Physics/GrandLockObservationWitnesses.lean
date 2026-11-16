import SFT.Physics.GrandLockObservationProofOriginal
namespace SFT.Physics.GrandLockObservationWitnesses
open GrandLockObservationAnalysis GrandLockObservationAnalysisProofs
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceWitnessProjection (record certificate : Value) (key : String)
 (h : recordCertificate record = .ok certificate) :
 (match recordCertificate record with | .error _ => false | .ok c => ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c key) true) =
 ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault certificate key) true :=
 congrArg (fun result : Except String Value => match result with | .error _ => false | .ok c => ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c key) true) h
#print axioms sourceWitnessProjection
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "unique_complete_empirical_vector") true
theorem witness0Passed : witness0=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "unique_complete_empirical_vector" originalComplete
#print axioms witness0Passed
def witness1 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "all_empirical_and_external_hashes") true
theorem witness1Passed : witness1=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "all_empirical_and_external_hashes" originalComplete
#print axioms witness1Passed
def witness2 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "all_available_measurement_receipts_retained") true
theorem witness2Passed : witness2=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "all_available_measurement_receipts_retained" originalComplete
#print axioms witness2Passed
def witness3 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "legacy_shape_exact") true
theorem witness3Passed : witness3=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "legacy_shape_exact" originalComplete
#print axioms witness3Passed
def witness4 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "adverse_scope_vector_exact") true
theorem witness4Passed : witness4=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "adverse_scope_vector_exact" originalComplete
#print axioms witness4Passed
def witness5 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "external_source_vector_exact") true
theorem witness5Passed : witness5=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "external_source_vector_exact" originalComplete
#print axioms witness5Passed
def witness6 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "methodological_boundary") true
theorem witness6Passed : witness6=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "methodological_boundary" originalComplete
#print axioms witness6Passed
def witness7 : Bool := match recordCertificate originalTarget with | .error _=>false | .ok c=>ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault c "formal_receipt_bound") true
theorem witness7Passed : witness7=true := sourceWitnessProjection originalTarget (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) "formal_receipt_bound" originalComplete
#print axioms witness7Passed
def witnesses : List Witness := [⟨"unique_complete_empirical_vector","unique complete empirical vector",witness0⟩,⟨"all_empirical_and_external_hashes","all empirical and external hashes",witness1⟩,⟨"all_available_measurement_receipts_retained","all available measurement receipts retained",witness2⟩,⟨"legacy_shape_exact","legacy shape exact",witness3⟩,⟨"adverse_scope_vector_exact","adverse scope vector exact",witness4⟩,⟨"external_source_vector_exact","external source vector exact",witness5⟩,⟨"methodological_boundary","methodological boundary",witness6⟩,⟨"formal_receipt_bound","formal receipt bound",witness7⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 have h : witnesses = [⟨"unique_complete_empirical_vector","unique complete empirical vector",true⟩,⟨"all_empirical_and_external_hashes","all empirical and external hashes",true⟩,⟨"all_available_measurement_receipts_retained","all available measurement receipts retained",true⟩,⟨"legacy_shape_exact","legacy shape exact",true⟩,⟨"adverse_scope_vector_exact","adverse scope vector exact",true⟩,⟨"external_source_vector_exact","external source vector exact",true⟩,⟨"methodological_boundary","methodological boundary",true⟩,⟨"formal_receipt_bound","formal receipt bound",true⟩] := by
  unfold witnesses
  rewrite [witness0Passed,witness1Passed,witness2Passed,witness3Passed,witness4Passed,witness5Passed,witness6Passed,witness7Passed]
  rfl
 rewrite [h]
 rfl
#print axioms allWitnessesPass
end SFT.Physics.GrandLockObservationWitnesses
