import SFT.Physics.YangMillsSpectrumMeasurement
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.CollapseObservationAnalysis
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def adjacent (less : Rat → Rat → Bool) : List Rat → Bool
 | []=>true
 | [_]=>true
 | a::b::rest=>less a b && adjacent less (b::rest)
def exactAnalysis (record : Value) : Except String Value := do
 let sources ← array (← field record "sources")
 let rows : Nat → String → Except String Value := fun i key=>do field (← field (← LeptonRatios.atIndex sources i) "rows") key
 let number := fun row key=>do YangMillsSpectrumMeasurement.exactInput (← field row key)
 let stages ← rows 0 "massive_star_burning_stages"
 let cno ← rows 1 "solar_cno_neutrino_detection"
 let collapse ← rows 2 "sn1987a_neutrino_reanalysis"
 let gamma ← rows 3 "sn2014j_nickel_cobalt_gamma_lines"
 let capture ← rows 4 "gw170817_strontium_identification"
 let stageRows ← array (← field stages "complete_rows")
 let temperatures ← stageRows.mapM (fun row=>number row "stage_temperature_billion_kelvin")
 let durations ← stageRows.mapM (fun row=>number row "duration_years")
 let d3 ← LeptonRatios.atIndex durations 3
 let d4 ← LeptonRatios.atIndex durations 4
 let ratio ← number gamma "measured_line_ratio"
 let uncertainty ← number gamma "measured_line_ratio_uncertainty"
 let branch ← number gamma "reported_branch_ratio"
 let rat := RunningConvergenceCertificate.rat
 pure (.object [
 ("stage_row_count",.integer (.ofNat stageRows.length)),("declared_stage_row_count",← field stages "row_count"),
 ("stage_temperatures_billion_kelvin",.array (temperatures.map rat)),("stage_temperatures_strict",.boolean (adjacent Rat.blt temperatures)),
 ("stage_durations_years",.array (durations.map rat)),("all_stage_durations_retained",.boolean (durations.length==6)),
 ("durations_strictly_decreasing",.boolean (adjacent (fun a b=>b.blt a) durations)),("oxygen_neon_duration_irregularity_retained",.boolean (d3.blt d4)),
 ("onion_support_reported",.boolean (ThermometryMeasurement.literalBoolean (← field stages "onion_support_reported") true)),
 ("cno_rate",rat (← number cno "cno_interaction_rate_cpd_per_100_tonnes")),
 ("cno_lower_uncertainty",rat (← number cno "lower_uncertainty_cpd_per_100_tonnes")),
 ("cno_upper_uncertainty",rat (← number cno "upper_uncertainty_cpd_per_100_tonnes")),
 ("cno_minimum_significance",rat (← number cno "minimum_significance_sigma")),
 ("cno_confidence",rat (← number cno "confidence_fraction")),
 ("collapse_detector_count",.integer (.ofNat (← array (← field collapse "detectors")).length)),
 ("collapse_probability_ratio",rat (← number collapse "minimum_two_to_one_component_probability_ratio")),
 ("collapse_accretion_duration_upper_seconds",rat (← number collapse "accretion_component_duration_upper_seconds")),
 ("collapse_model_assisted_retained",.boolean (Text.contains (← text (← field collapse "use_boundary")) "model-assisted")),
 ("gamma_line_energies_kev",.array [rat (← number gamma "cobalt_line_1_energy_kev"),rat (← number gamma "cobalt_line_2_energy_kev")]),
 ("gamma_fluxes",.array [rat (← number gamma "cobalt_line_1_flux_1e_minus_4_ph_cm2_s"),rat (← number gamma "cobalt_line_2_flux_1e_minus_4_ph_cm2_s")]),
 ("gamma_flux_uncertainties",.array [rat (← number gamma "cobalt_line_1_flux_uncertainty"),rat (← number gamma "cobalt_line_2_flux_uncertainty")]),
 ("gamma_ratio_interval",.array [rat (subtract ratio uncertainty),rat (add ratio uncertainty)]),
 ("gamma_branch_ratio",rat branch),("gamma_interval_contains_branch_ratio",.boolean (!(branch.blt (subtract ratio uncertainty)) && !(add ratio uncertainty).blt branch)),
 ("gamma_spectrum_significance",rat (← number gamma "spectrum_nonempty_significance_sigma")),
 ("gamma_model_assisted_retained",.boolean (Text.contains (← text (← field gamma "use_boundary")) "model-assisted")),
 ("capture_identified_element",← field capture "identified_element"),("capture_feature_nm",rat (← number capture "absorption_feature_nm")),
 ("capture_first_day",rat (← number capture "first_spectrum_days_after_merger")),
 ("capture_last_day",rat (← number capture "last_registered_spectrum_days_after_merger")),
 ("capture_broadening_c",rat (← number capture "feature_broadening_light_speed_fraction")),
 ("capture_blueshift_c",rat (← number capture "feature_blueshift_light_speed_fraction")),
 ("capture_model_assisted_retained",.boolean (Text.contains (← text (← field capture "use_boundary")) "modelling")),
 ("all_sources_retained",.boolean (sources.length==5))])
#print axioms exactAnalysis
end SFT.Physics.CollapseObservationAnalysis
