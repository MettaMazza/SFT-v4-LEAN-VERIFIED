import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ElectroweakMeasuredAnalysis
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ElectroweakMeasuredMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement ElectroweakMeasuredAnalysis
-- Decoder for the hash-bound original source record and its two declared controls.
-- General converted-Fraction analysis remains exactAnalysis, over arbitrary Rat inputs.
def originalRecordTarget (v : Value) : Except String Target := do
 let q0 ← decimalField v "on_shell_sin_squared_center"
 let q1 ← decimalField v "on_shell_sin_squared_standard_uncertainty"
 let q2 ← decimalField v "z_mass_GeV"
 let q3 ← decimalField v "z_mass_standard_uncertainty_GeV"
 let q4 ← decimalField v "compatible_w_mass_GeV"
 let q5 ← decimalField v "compatible_w_mass_standard_uncertainty_GeV"
 let q6 ← decimalField v "all_input_w_mass_GeV"
 let q7 ← decimalField v "all_input_w_mass_standard_uncertainty_GeV"
 .ok ⟨q0,q1,q2,q3,q4,q5,q6,q7,ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault v "all_input_aggregate_contains_source_identified_incompatible_CDF_2022_input") true,ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault v "source_reports_including_CDF_2022_produces_very_poor_consistency") true,ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault v "all_input_aggregate_is_not_used_as_a_physical_target") true,ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault v "all_source_rows_retained_unchanged") true⟩
def ratio := RunningConvergenceCertificate.rat
def pair (v : Rat × Rat) : Value := .array [ratio v.1,ratio v.2]
def analysisValue (a : Analysis) : Value := .object [
 ("direct_on_shell_interval",pair a.directOnShellInterval),
 ("compatible_WZ_squared_interval",pair a.compatibleWZSquaredInterval),
 ("all_input_WZ_squared_method_record",pair a.allInputWZSquaredMethodRecord),
 ("forced_sine_inside_direct_interval",.boolean a.forcedSineInsideDirectInterval),
 ("forced_cosine_inside_compatible_WZ_interval",.boolean a.forcedCosineInsideCompatibleWZInterval),
 ("exact_partition",.boolean a.exactPartition),
 ("incompatible_input_disclosure_retained",.boolean a.incompatibleInputDisclosureRetained),
 ("poor_consistency_disclosure_retained",.boolean a.poorConsistencyDisclosureRetained),
 ("inconsistent_aggregate_not_used_as_target",.boolean a.inconsistentAggregateNotUsedAsTarget),
 ("all_source_rows_retained",.boolean a.allSourceRowsRetained)]
def exactElectroweakAnalysis (v : Value) : Except String Value := do
 .ok (analysisValue (← exactAnalysis (← originalRecordTarget v)))
end SFT.Physics.ElectroweakMeasuredMeasurement
