import SFT.Physics.ThermalObservationAnalysis
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.ThermalObservationMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactThermalAnalysis (target : Value) : Except String Value := do
 let exponent ← YangMillsSpectrumMeasurement.exactInput (← field target "cmb_temperature_exponent_central")
 let exponentWidth ← YangMillsSpectrumMeasurement.exactInput (← field target "cmb_temperature_exponent_standard_uncertainty")
 let helium ← YangMillsSpectrumMeasurement.exactInput (← field target "primordial_helium_mass_fraction_central")
 let heliumWidth ← YangMillsSpectrumMeasurement.exactInput (← field target "primordial_helium_mass_fraction_standard_uncertainty")
 let deuterium ← YangMillsSpectrumMeasurement.exactInput (← field target "primordial_deuterium_times_100000_central")
 let deuteriumWidth ← YangMillsSpectrumMeasurement.exactInput (← field target "primordial_deuterium_times_100000_standard_uncertainty")
 let recombination ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_recombination_redshift_central")
 let recombinationWidth ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_recombination_redshift_standard_uncertainty")
 let peaks ← (← array (← field target "planck_tt_peak_multipoles")).mapM YangMillsSpectrumMeasurement.exactInput
 let peakWidths ← (← array (← field target "planck_tt_peak_multipole_uncertainties")).mapM YangMillsSpectrumMeasurement.exactInput
 let amplitudes ← (← array (← field target "planck_tt_peak_amplitudes")).mapM YangMillsSpectrumMeasurement.exactInput
 let amplitudeWidths ← (← array (← field target "planck_tt_peak_amplitude_uncertainties")).mapM YangMillsSpectrumMeasurement.exactInput
 let detected ← field target "planck_detected_peak_count"
 let freezeout ← field target "pdg_freezeout_neutron_proton_label"
 let capture ← field target "pdg_capture_entry_neutron_proton_label"
 let heliumLabel ← field target "pdg_analytic_helium_partition_label"
 let a ← ThermalObservationAnalysis.exactAnalysis ⟨exponent,exponentWidth,helium,heliumWidth,deuterium,deuteriumWidth,recombination,recombinationWidth,peaks,peakWidths,amplitudes,amplitudeWidths,
 if sameValue detected (.integer 18) then 18 else 0,
 if sameValue freezeout (.text "approximately 1/6") then "approximately 1/6" else "",
 if sameValue capture (.text "approximately 1/7") then "approximately 1/7" else "",
 if sameValue heliumLabel (.text "approximately 0.25") then "approximately 0.25" else "",true⟩
 let rows ← field target "all_registered_rows_retained"
 let pair := fun p : Rat × Rat => Value.array [ratValue p.1,ratValue p.2]
 pure (.object [
 ("temperature_exponent_interval",pair a.temperatureInterval),
 ("exact_one_inside_temperature_interval",.boolean a.oneInside),
 ("helium_interval",pair a.heliumInterval),("analytic_quarter",ratValue a.analyticQuarter),
 ("exact_quarter_excluded",.boolean a.quarterExcluded),("helium_gap_from_analytic_quarter",ratValue a.heliumGap),
 ("deuterium_interval",pair a.deuteriumInterval),("deuterium_positive_minor_channel",.boolean a.deuteriumMinor),
 ("recombination_interval",pair a.recombinationInterval),("finite_positive_recombination_support",.boolean a.finiteRecombination),
 ("peak_intervals",.array (a.peakIntervals.map pair)),("complete_seven_tt_peaks",.boolean a.completeSeven),
 ("detected_peak_count",detected),("finite_eighteen_peak_record",.boolean a.finiteEighteen),
 ("angular_integer_multiple_claim_rejected",.boolean a.angularIntegerRejected),
 ("freezeout_sequence_retained",.boolean a.freezeoutRetained),("analytic_quarter_label_retained",.boolean a.quarterLabelRetained),
 ("all_rows_retained",rows)])
end SFT.Physics.ThermalObservationMeasurement
