import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
set_option maxRecDepth 20000
namespace SFT.Physics.ThermalMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/thermal-history-measured-value-successor-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/thermal-history-measured-value-successor-source-record.json","sha256:9b62430aa48d7f3d1811327ca147c133777c9e7c37cfcfff3e927f04e7a68641"),("experiments/external_sources/physics/snapshots/thermal-history-postseal-source-record.json","sha256:8ce41a6c68923395da2502fbb8e078dc770ac2c7648c966b241d8c671273a0d8"),("experiments/external_sources/physics/snapshots/arxiv-1012.3164-cmb-temperature-redshift.pdf","sha256:aa79c65170e84d6a8dc71dbd0876538c19619a1c926453ce5a54bd96d3f1efb7"),("experiments/external_sources/physics/snapshots/arxiv-2601.22238-primordial-helium.pdf","sha256:72f646a345c36b77211e6035d3a78345498f0766cf9fc0a54932ebe0dd670c6a"),("experiments/external_sources/physics/snapshots/arxiv-1710.11129-primordial-deuterium.pdf","sha256:1a6ec19d6568b8854a40e9dd587906f99a8ea94ecd2d5c712ad86aa506b93f4a"),("experiments/external_sources/physics/snapshots/arxiv-1807.06205-planck-overview.pdf","sha256:dca932893b7d2724aa2b8d33170fc1b5682c425dd56fcd3c5d7b2098d377db5c"),("experiments/external_sources/physics/snapshots/arxiv-1807.06209-planck-cosmological-parameters.pdf","sha256:8e172730faf07c9f4ff3fdcc7043f76ed67df6f76066d47df30d693025b6ce77"),("experiments/external_sources/physics/snapshots/pdg-2025-bbang-nucleosynthesis.pdf","sha256:1843c1d9025aa33c059700708f1041c4462364cdb582325f0c685a6ba1b38484"),("claims/SFT-PHYS-THERMAL-HISTORY-RECOMBINATION-TERMINAL-037/certificate.json","sha256:d3b85781f4413b1fe50145852f202342bb18ea31ef3db510a295f221d60c6bb3"),("claims/SFT-PHYS-THERMAL-HELIUM-ISOTOPE-TERMINAL-057/certificate.json","sha256:1222b7660115f66ca7f69affed5464c2ef65cc83e1c16dd7bf47d038a9019fa7")]
def sourceIds : List String := ["NOTERDAEME-ET-AL-2011-CMB-TEMPERATURE", "AVER-ET-AL-2026-PRIMORDIAL-HELIUM", "COOKE-PETTINI-STEIDEL-2018-DEUTERIUM", "PLANCK-2018-OVERVIEW-PEAKS", "PLANCK-2018-COSMOLOGICAL-PARAMETERS", "PDG-2025-BBN-REVIEW"]
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
   throw (Text.append "thermal successor source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-thermal-history-measured-value-successor-source-record/1") then
  throw "thermal successor schema changed"
 if !sameValue (getDefault payload "physical_isotope_receipt_hash") (.text "sha256:a3b3a44a0d3add7032680427c3b2b504147c0eb824d05fa5d044cef454c5ebc4") then
  throw "physical helium receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 if !sameValue (.array (sources.map (fun row => getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then
  throw "complete thermal source vector required"
 let boundary := getDefault payload "methodological_boundary" (.object [])
 if !boundaryValuesTrue boundary then throw "thermal methodological boundary changed"
 if !measurementNotSelected boundary then throw "thermal measurement-selection boundary changed"
 let source ← field payload "registered_target_source"
 let path ← text (← field source "path")
 let _ ← fileBytes files path
 .ok (.object [("record",payload),("original",← field bundle "original")])
def originalBoundary : Value := .object [("analytic_quarter_and_physical_59_over_240_are_separately_typed",.boolean true),("physical_helium_value_was_sealed_before_measurement_release",.boolean true),("all_temperature_deuterium_recombination_and_peak_rows_are_retained",.boolean true),("angular_projection_rows_are_method_records_not_exact_internal_mode_values",.boolean true),("noninteger_angular_positions_are_not_rewarded_as_a_result",.boolean true),("no_uncertainty_is_widened_or_rescaled",.boolean true),("measurement_selected_formal_survivor",.boolean false),("target_inaccessible_to_formal_derivation",.boolean true)]
theorem originalBoundaryValues : boundaryValuesTrue originalBoundary = true := rfl
theorem originalMeasurementBoundary : measurementNotSelected originalBoundary = true := rfl
#print axioms boundaryValuesTrue
#print axioms measurementNotSelected
#print axioms authoritativeRecord
#print axioms originalBoundaryValues
#print axioms originalMeasurementBoundary
end SFT.Physics.ThermalMeasuredRecords
