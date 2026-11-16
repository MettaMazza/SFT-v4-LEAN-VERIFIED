import SFT.Physics.CriticalMeasuredAnalysis
namespace SFT.Physics.CriticalMeasuredMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals CriticalMeasuredAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- JSON source records use integer Fraction numerators and denominators.
-- General converted rational inputs are retained by CriticalMeasuredAnalysis.
def fraction (value : Value) (key : String) (denominator : Int) : Except String Rat := do
 let n ← SectorAnchorRecords.originalInt (← field value key)
 LeptonRatios.divide (normalize n 1 (by decide)) (normalize denominator 1 (by decide))
def yes (value : Value) (key : String) : Except String Bool := do
 .ok (ThermometryMeasurement.literalBoolean (← field value key) true)
def decode (target : Value) : Except String Target := do
 let record ← field target "record"
 let measured ← field (← field target "original") "registered_target"
 let denominator ← SectorAnchorRecords.originalInt (← field measured "manganite_measurement_denominator")
 let rows ← array (← field measured "manganite_rows")
 let materials ← rows.mapM (fun row => do
  .ok (⟨← text (← field row "sample"),← fraction row "beta_center" denominator,← fraction row "beta_uncertainty" denominator,
   ← fraction row "gamma_center" denominator,← fraction row "gamma_uncertainty" denominator,
   ← fraction row "delta_center" denominator,← fraction row "delta_uncertainty" denominator⟩ : Material))
 let key ← field record "manganite_complete_structural_key"
 let ids ← (← array (← field key "sample_ids")).mapM text
 let structuralTrueCount := match key with
  | .object fs => (fs.filter (fun (k,v) => !Text.equal k "sample_ids" && ThermometryMeasurement.literalBoolean v true)).length
  | .null | .boolean _ | .integer _ | .text _ | .array _ => 0
 let boundary ← field record "methodological_boundary"
 let ed ← SectorAnchorRecords.originalInt (← field measured "erbium_measurement_denominator")
 let td ← SectorAnchorRecords.originalInt (← field measured "turbulence_measured_structure_denominator")
 let erbium := fun k => do .ok (← fraction measured (Text.append (Text.append "erbium_" k) "_center") ed,
  ← fraction measured (Text.append (Text.append "erbium_" k) "_uncertainty") ed)
 .ok ⟨materials,ids,structuralTrueCount,
  ← yes boundary "La02_individual_displacements_are_retained_but_not_rewarded_as_a_result",
  ← erbium "beta",← erbium "gamma",← erbium "nu",
  (← fraction measured "turbulence_measured_structure_center" td,← fraction measured "turbulence_measured_structure_uncertainty" td),
  ← yes measured "spectrum_five_thirds_compensation_used",← yes measured "spectrum_fourier_plateau_observed",← yes measured "spectrum_hilbert_plateau_observed",
  ← yes measured "turbulence_finite_reynolds_limit_retained",← yes measured "spectrum_structure_function_range_limitation_retained",← yes measured "normalized_half_one_threshold_not_universal_lab_temperature",
  ← yes (← field record "registered_target_source") "all_original_rows_retained",← yes measured "all_manganite_rows_retained",← yes measured "all_registered_rows_retained"⟩
def exactCriticalityAnalysis (target : Value) : Except String Value := do
 exactAnalysis (← decode target)
end SFT.Physics.CriticalMeasuredMeasurement
