import SFT.Physics.QuadrupoleRadiatedPowerEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.QuadrupoleMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement QuadrupoleRadiatedPowerCertificate LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def requiredTargetRows : List String := ["v1_source_entry", "v1_leading_radiating_moment", "v1_radiative_rate", "v1_power_relation", "v1_static_control", "v1_amplitude_scaling", "v1_outward_transport", "existing_v3_quadrupole_first", "existing_v3_field_energy_square", "existing_v3_inverse_square", "existing_v3_boundary_rank_two", "existing_v3_source_conservation", "existing_v3_binary_coupling", "formal_prediction_commit_precedes_target_access", "formal_normalized_binary_comparison", "primary_system", "primary_observation_span", "primary_orbital_period", "primary_eccentricity", "primary_tracked_orbits", "primary_dominant_orbital_decay_cause", "primary_shklovskii_correction", "primary_galactic_correction", "primary_combined_external_correction", "primary_intrinsic_orbital_decay", "primary_spin_down_mass_loss_correction", "primary_measured_GW_orbital_decay", "primary_measured_fractional_precision", "primary_leading_quadrupole_prediction", "primary_next_order_3_5PN_correction", "primary_total_prediction", "primary_measured_over_predicted_ratio", "primary_95_percent_agreement_boundary", "primary_extreme_EOS_ratio", "primary_cumulative_periastron_normalized_chi_squared", "primary_leading_order_classification", "primary_next_order_classification", "primary_distance_uncertainty_currently_subdominant", "primary_observed_timing_error_dominates_current_intrinsic_uncertainty", "primary_future_limit_requires_kinematic_corrections", "primary_regime", "primary_black-hole_merger_comparison_requires_regime_caveat", "primary_alternative_scalar_theories_can_add_lower-moment-radiation", "primary_result_measures_universal_Fold_power_fraction", "external_values_select_formal_survivor", "negative_external_decay_sign_used_as_formal_proof_scalar", "measured_parameter_fitted_into_v3", "free_radiation_correction_added_to_v3"]
def targetRows (target : Value) (keys : List String) : Except String (List Value) := keys.mapM (field target)
def exactMeasurementAnalysis (target : Value) : Except String Value := do
 let c ← radiatedPowerCertificate (.integer 16)
 let frac := QuadrupoleRadiatedPowerEvidence.frac
 let formalRatio := normalize 1 1 (by decide)
 let measuredRatio := normalize 999963 1000000 (by decide)
 let uncertainty := normalize 63 1000000 (by decide)
 let boundary := normalize 13 100000 (by decide)
 let difference := subtract formalRatio measuredRatio
 let eosRatio := normalize 999958 1000000 (by decide)
 let eosUncertainty := normalize 64 1000000 (by decide)
 let firstRate ← match c.baseThirdRecord with
  | [] => .error "IndexError"
  | x::_ => .ok x
 let prerequisites ← targetRows target ["existing_v3_quadrupole_first","existing_v3_field_energy_square","existing_v3_inverse_square","existing_v3_boundary_rank_two","existing_v3_source_conservation","existing_v3_binary_coupling"]
 let corrections ← targetRows target ["primary_shklovskii_correction","primary_galactic_correction","primary_combined_external_correction","primary_intrinsic_orbital_decay","primary_spin_down_mass_loss_correction","primary_measured_GW_orbital_decay","primary_leading_quadrupole_prediction","primary_next_order_3_5PN_correction","primary_total_prediction","primary_measured_over_predicted_ratio"]
 let scope ← targetRows target ["primary_distance_uncertainty_currently_subdominant","primary_observed_timing_error_dominates_current_intrinsic_uncertainty","primary_future_limit_requires_kinematic_corrections","primary_regime","primary_black-hole_merger_comparison_requires_regime_caveat","primary_alternative_scalar_theories_can_add_lower-moment-radiation","primary_result_measures_universal_Fold_power_fraction"]
 let history := sameValue (← field target "v1_power_relation") (.text "coupling-paired-with-third-rate-paired-with-itself")
 let classification := sameValue (← field target "primary_leading_order_classification") (.text "quadrupole-formula-at-2.5PN-in-equations-of-motion")
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 let retained := keys.length==48 && keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredTargetRows.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)
 pure (.object [("formal_coupling",frac c.coupling),("formal_base_third_rate",frac firstRate),("formal_base_power",frac c.basePower),("formal_doubled_power",frac c.doubledPower),("formal_static_power_record",QuadrupoleRadiatedPowerEvidence.powerResult (.ok c.staticPowerRecord)),("formal_power_quadruples",.boolean c.powerQuadruples),("formal_shell_power_conserved",.boolean c.shellPowerConserved),("formal_successor_identity",.boolean c.successorIdentityHolds),("formal_normalized_binary_comparison",frac formalRatio),("measured_ratio",frac measuredRatio),("measured_uncertainty",frac uncertainty),("measured_difference_from_One",frac difference),("measured_contains_One_at_published_uncertainty",.boolean (!uncertainty.blt difference)),("measured_within_95_percent_boundary",.boolean (!boundary.blt difference)),("extreme_EOS_contains_One",.boolean (!eosUncertainty.blt (subtract formalRatio eosRatio))),("historical_relation_retained",.boolean history),("prerequisite_rows_retained",.array prerequisites),("primary_correction_rows_retained",.array corrections),("primary_scope_rows_retained",.array scope),("primary_quadrupole_classification_matches",.boolean classification),("all_target_rows_retained",.boolean retained),("negative_external_sign_used_as_proof",← field target "negative_external_decay_sign_used_as_formal_proof_scalar"),("fitted_value_used",← field target "measured_parameter_fitted_into_v3"),("free_correction_used",← field target "free_radiation_correction_added_to_v3")])
end SFT.Physics.QuadrupoleMeasurement
