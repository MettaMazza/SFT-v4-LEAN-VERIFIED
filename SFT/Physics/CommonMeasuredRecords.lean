import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.CommonMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/common-scale-measured-value-successor-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/common-scale-measured-value-successor-source-record.json","sha256:4143fd2a2b5f480bc35c84e83b3febd9e04f72661b6c1607ba9bc7204ac61d00"),("experiments/external_sources/physics/snapshots/pdg-2026-electroweak-model.pdf","sha256:a102f6252b7190dc423200271dffa7c805cd15a50391b1c578853d2f777611cb"),("experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json","sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"),("claims/SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030/certificate.json","sha256:904ba1d325c5e5200cacb4ff09fdb0abe1b8328d6ae16177e29f2e596d4138bb"),("claims/SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053/certificate.json","sha256:3a19d721c429874f404e7b75601511f8ba0c39a68fae6f2c46f2010d12a492a4"),("claims/SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006/certificate.json","sha256:f598cd663a76f8137cf2e40c5e8154083b8196ec399751da8577ce9769f688d6")]
def sourceIds : List String := ["PDG-2026-ELECTROWEAK-SCALE-VECTOR", "PDG-2025-2026-STRONG-EM-COMPLETE-RUNNING-VECTOR"]
def boundaryValuesTrue (boundary : Value) : Bool :=
 match boundary with
 | .object fs => fs.all (fun (key,value) => Text.equal key "measurement_selected_formal_survivor" || ThermometryMeasurement.literalBoolean value true)
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false

def measurementNotSelected (boundary : Value) : Bool :=
 ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false

def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "common-scale successor source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-common-scale-measured-value-successor-source-record/1") then
  throw "common-scale successor schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:44d542f87d12844c02c321ac651008ae7ddd738a3b16e7d2c3d8700ec89eca55") then
  throw "common-scale formal receipt binding changed"
 if !sameValue (getDefault payload "electroweak_successor_receipt_hash") (.text "sha256:e93f04515944a1951b78463db3083350fbc77e6d8506edbcdc13178cedfbc852") then
  throw "electroweak successor receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 if !sameValue (.array (sources.map (fun row => getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then
  throw "complete common-scale source vector required"
 let boundary := getDefault payload "methodological_boundary" (.object [])
 if !boundaryValuesTrue boundary then throw "common-scale methodological boundary changed"
 if !measurementNotSelected boundary then throw "measurement-selection boundary changed"
 pure payload
def originalBoundary : Value := .object [("terminal_on_shell_value_is_tested_against_like_typed_on_shell_measurement",.boolean true),("support_eight_value_is_tested_against_like_typed_low_transfer_APV_measurement",.boolean true),("NuTeV_is_retained_as_a_source_identified_interpretation_sensitive_extraction",.boolean true),("NuTeV_mismatch_is_not_an_acceptance_condition",.boolean true),("eDIS_overlap_is_non_discriminating",.boolean true),("no_uncertainty_is_widened_or_rescaled",.boolean true),("measurement_selected_formal_survivor",.boolean false),("target_inaccessible_to_formal_derivation",.boolean true)]
theorem originalBoundaryValues : boundaryValuesTrue originalBoundary = true := rfl
theorem originalMeasurementBoundary : measurementNotSelected originalBoundary = true := rfl
#print axioms boundaryValuesTrue
#print axioms measurementNotSelected
#print axioms authoritativeRecord
#print axioms originalBoundaryValues
#print axioms originalMeasurementBoundary
end SFT.Physics.CommonMeasuredRecords
