import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
set_option maxRecDepth 20000
namespace SFT.Physics.CriticalMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/criticality-measured-value-successor-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/criticality-measured-value-successor-source-record.json","sha256:5a4db9bd5af7028de244c97e18e75fd4d2cd0b7004a6778c8581b493c99537f5"),("experiments/external_sources/physics/snapshots/criticality-universality-turbulence-postseal-source-record.json","sha256:7c3cb34584f3581b46c9c9e1f91d2c550cfd8441761a512fee767baf8cc801fa"),("experiments/external_sources/physics/snapshots/cetin-manganite-critical-exponents-2026.html","sha256:afd0f783bd40b8ed376238eda9b254387c75c0c26ecc57488ab9b81b33d1d455"),("experiments/external_sources/physics/snapshots/lin-erbium-critical-scattering-1993.html","sha256:d8b6495b7defb46daa4d1162967d11b4680012ebd4a8e6d60e8892b83b9b3564"),("experiments/external_sources/physics/snapshots/mccomb-turbulence-structure-exponent-2014.pdf","sha256:0c9f4321b52f78fe64b02684b4139a450955c12092c4faf8487f49bf6ff1d0f5"),("experiments/external_sources/physics/snapshots/huang-turbulence-spectrum-2010.pdf","sha256:1bff196a24bc3f852dd384469c5f8e4112fcdf717c2416190ad44b0012ac06cb"),("claims/SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047/certificate.json","sha256:3f6af79001628c06e1c04a08b4e17c349ffa2205d6c574a865eb8be0ecedd6c0")]
def sourceIds : List String := ["SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026", "MCMASTER-LIN-ERBIUM-CRITICAL-SCATTERING-1993", "APS-MCCOMB-TURBULENCE-STRUCTURE-2014", "APS-HUANG-TURBULENCE-SPECTRUM-2010"]
def boundaryValuesTrue (boundary : Value) : Bool :=
 match boundary with
 | .object fs => fs.all (fun (key,value) => Text.equal key "measurement_selected_formal_survivor" || ThermometryMeasurement.literalBoolean value true)
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false

def measurementNotSelected (boundary : Value) : Bool :=
 ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false

def authoritativeRecord (files : List (String × ByteArray)) (bundle : Value) : Except String Value := do
 let payload ← field bundle "record"
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "criticality successor source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-criticality-measured-value-successor-source-record/1") then
  throw "criticality successor schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:0601d19640943c4b99eb8cccf061e3115c520773eac5e762bf7c5b7440339b25") then
  throw "criticality formal receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 if !sameValue (.array (sources.map (fun row => getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then
  throw "complete criticality source vector required"
 let boundary := getDefault payload "methodological_boundary" (.object [])
 if !boundaryValuesTrue boundary then throw "criticality methodological boundary changed"
 if !measurementNotSelected boundary then throw "criticality measurement-selection boundary changed"
 let source ← field payload "registered_target_source"
 let path ← text (← field source "path")
 let _ ← fileBytes files path
 .ok (.object [("record",payload),("original",← field bundle "original")])
def originalBoundary : Value := .object [("each_material_class_key_is_derived_from_transition_order_interaction_range_and_complete_exponent_vector",.boolean true),("all_five_material_keys_are_retained",.boolean true),("all_fifteen_exponent_values_enter_one_complete_unit_normalized_residual_ledger",.boolean true),("La02_individual_displacements_are_retained_but_not_rewarded_as_a_result",.boolean true),("erbium_and_both_turbulence_routes_remain_independent_tests",.boolean true),("no_uncertainty_is_widened_or_rescaled",.boolean true),("measurement_selected_formal_survivor",.boolean false),("target_inaccessible_to_formal_derivation",.boolean true)]
theorem originalBoundaryValues : boundaryValuesTrue originalBoundary = true := rfl
theorem originalMeasurementBoundary : measurementNotSelected originalBoundary = true := rfl
#print axioms boundaryValuesTrue
#print axioms measurementNotSelected
#print axioms authoritativeRecord
#print axioms originalBoundaryValues
#print axioms originalMeasurementBoundary
end SFT.Physics.CriticalMeasuredRecords
