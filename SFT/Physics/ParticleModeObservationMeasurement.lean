import SFT.Physics.ParticleModeObservationAnalysis
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.ParticleModeObservationMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement ParticleModeObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def decode (target : Value) : Except String Target := do
 let readInt := fun key => do SectorAnchorRecords.originalInt (← field target key)
 let readRat := fun key => do YangMillsSpectrumMeasurement.exactInput (← field target key)
 let readFlag := fun key => do pure (ThermometryMeasurement.literalBoolean (← field target key) true)
 let readOrder := fun key => do (← array (← field target key)).mapM text
 .ok ⟨← readInt "generation_count_forced",
 ← readInt "neutrino_type_fit_center",
 ← readInt "neutrino_type_fit_uncertainty",
 ← readInt "neutrino_type_fit_denominator",
 ← readInt "neutrino_type_direct_center",
 ← readInt "neutrino_type_direct_uncertainty",
 ← readInt "neutrino_type_direct_denominator",
 ← readRat "electron_mass_MeV",
 ← readRat "muon_mass_MeV",
 ← readRat "tau_mass_MeV",
 ← readRat "electron_mass_uncertainty_MeV",
 ← readRat "muon_mass_uncertainty_MeV",
 ← readRat "tau_mass_uncertainty_MeV",
 ← readRat "electron_mean_life_lower_years",
 ← readRat "muon_mean_life_seconds",
 ← readRat "muon_mean_life_uncertainty_seconds",
 ← readRat "tau_mean_life_seconds",
 ← readRat "tau_mean_life_uncertainty_seconds",
 ← readOrder "charged_lepton_mass_order",
 ← readOrder "charged_lepton_lifetime_order",
 ← readFlag "neutrino_fit_is_model_dependent",
 ← readFlag "neutrino_direct_row_retained_without_adjustment",
 ← readFlag "neutrino_direct_row_did_not_select_the_forced_count",
 ← readFlag "terminal_charged_lepton_both_mass_ratio_intervals_pass",
 ← readFlag "terminal_quark_s_over_d_interval_passes",
 ← readFlag "terminal_quark_b_over_s_interval_passes",
 ← readFlag "terminal_quark_t_over_c_has_no_exact_scheme_matched_direct_comparator",
 ← readFlag "terminal_CKM_complete_four_row_vector_passes_three_standard_uncertainty_intervals",
 ← readFlag "positive_neutrino_PMNS_CP_vector_passes_registered_three_standard_uncertainty_support",
 ← readFlag "positive_neutrino_mass_sum_below_registered_direct_and_cosmological_bounds",
 ← readFlag "normal_neutrino_ordering_not_decisively_measured",
 ← readRat "heavy_charged_lepton_search_lower_mass_GeV",
 ← readRat "stable_heavy_charged_lepton_search_lower_mass_GeV",
 ← readFlag "all_registered_rows_retained"⟩
def exactParticleModeAnalysis (target : Value) : Except String Value := do .ok (exactAnalysis (← decode target))
end SFT.Physics.ParticleModeObservationMeasurement
