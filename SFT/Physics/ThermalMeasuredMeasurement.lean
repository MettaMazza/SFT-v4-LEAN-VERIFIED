import SFT.Physics.ThermalMeasuredAnalysis
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.ThermalMeasuredMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement ThermalMeasuredAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def decode (target : Value) : Except String Target := do
 let record ← field target "record"
 let measured ← field (← field target "original") "registered_target"
 let boundary ← field record "methodological_boundary"
 let rational := fun key => do YangMillsSpectrumMeasurement.exactInput (← field measured key)
 let pair := fun key => do pure (← rational (SFT.Host.Text.append key "_central"),← rational (SFT.Host.Text.append key "_standard_uncertainty"))
 let vector := fun key => do (← array (← field measured key)).mapM YangMillsSpectrumMeasurement.exactInput
 let yes := fun v key => do pure (ThermometryMeasurement.literalBoolean (← field v key) true)
 let detected ← field measured "planck_detected_peak_count"
 let freezeout ← field measured "pdg_freezeout_neutron_proton_label"
 let capture ← field measured "pdg_capture_entry_neutron_proton_label"
 .ok ⟨← pair "cmb_temperature_exponent",← pair "primordial_helium_mass_fraction",← pair "primordial_deuterium_times_100000",← pair "planck_recombination_redshift",
  ← vector "planck_tt_peak_multipoles",← vector "planck_tt_peak_multipole_uncertainties",← vector "planck_tt_peak_amplitudes",← vector "planck_tt_peak_amplitude_uncertainties",
  if sameValue detected (.integer 18) then 18 else 0,
  if sameValue freezeout (.text "approximately 1/6") then "approximately 1/6" else "",
  if sameValue capture (.text "approximately 1/7") then "approximately 1/7" else "",
  ← yes boundary "analytic_quarter_and_physical_59_over_240_are_separately_typed",
  ← yes boundary "angular_projection_rows_are_method_records_not_exact_internal_mode_values",
  ← yes boundary "noninteger_angular_positions_are_not_rewarded_as_a_result",
  ← yes (← field record "registered_target_source") "all_original_rows_retained",← yes measured "all_registered_rows_retained"⟩
def exactThermalAnalysis (target : Value) : Except String Value := do
 exactAnalysis (← decode target)
end SFT.Physics.ThermalMeasuredMeasurement
