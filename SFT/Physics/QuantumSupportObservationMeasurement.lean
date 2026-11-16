import SFT.Physics.CriticalObservationMeasurement
namespace SFT.Physics.QuantumSupportObservationMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement CriticalObservationMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactQuantumSupportBellAnalysis (target : Value) : Except String Value := do
 let n0 ← intField target "bell_parameter_center"
 let n1 ← intField target "bell_parameter_standard_uncertainty"
 let n2 ← intField target "bell_parameter_denominator"
 let n3 ← intField target "local_factorization_bound_numerator"
 let n4 ← intField target "local_factorization_bound_denominator"
 let n5 ← intField target "light_travel_budget_nanoseconds_center_thousandths"
 let n6 ← intField target "light_travel_budget_nanoseconds_uncertainty_thousandths"
 let n7 ← intField target "trial_duration_nanoseconds_center_hundredths"
 let n8 ← intField target "trial_duration_nanoseconds_uncertainty_hundredths"
 let n9 ← intField target "experimental_trials_lower_bound"
 let n10 ← intField target "reported_excess_standard_deviations_lower_bound"
 let n11 ← intField target "reported_p_value_upper_power_of_ten_exponent_magnitude"
 let n12 ← intField target "locality_margin_reported_standard_deviations"
 let b0 := ThermometryMeasurement.literalBoolean (← field target "deterministic_entanglement_generation") true
 let b1 := ThermometryMeasurement.literalBoolean (← field target "memory_robust_statistical_method") true
 let b2 := ThermometryMeasurement.literalBoolean (← field target "random_number_generators_used_for_setting_choices") true
 let b3 := ThermometryMeasurement.literalBoolean (← field target "measurement_independence_is_a_declared_experimental_assumption") true
 let b4 := ThermometryMeasurement.literalBoolean (← field target "authors_state_assumptions_cannot_be_fully_avoided") true
 let b5 := ThermometryMeasurement.literalBoolean (← field target "all_registered_rows_retained") true
 let b6 := ThermometryMeasurement.literalBoolean (← field target "two_settings_per_site") true
 let b7 := ThermometryMeasurement.literalBoolean (← field target "binary_outcome_per_site") true
 let center := n0
 let uncertainty := n1
 let denominator := n2
 let local_numerator := n3
 let local_denominator := n4
 let lower := (center-uncertainty)
 let upper := (center+uncertainty)
 let budget_lower_thousandths := (n5-n6)
 let duration_upper_thousandths := (10*(n7+n8))
 let local_scaled := (local_numerator*denominator)
 let measured_scaled_denominator := local_denominator
 pure (.object [("positive_exact_carriers",.boolean ([lower,upper,uncertainty,denominator,local_numerator,local_denominator,n10,n11,n9,budget_lower_thousandths,duration_upper_thousandths,n12].all (fun value => @decide (0<value) (Int.decLt 0 value)))),
 ("bell_interval",.array [.integer lower,.integer upper]),
 ("complete_interval_above_local_bound",.boolean (decide ((lower*local_denominator)>local_scaled))),
 ("central_excess_above_twenty_two_uncertainties",.boolean (decide (((center*local_denominator)-local_scaled)>((22*uncertainty)*measured_scaled_denominator)))),
 ("reported_significance_retained",.boolean ((decide (n10=22)) && (decide (n11=108)))),
 ("million_trial_lower_bound_retained",.boolean (decide (n9=1000000))),
 ("binary_two_setting_record",.boolean (b6 && b7)),
 ("deterministic_entanglement_generation_retained",.boolean b0),
 ("space_like_interval_separation",.boolean (decide (duration_upper_thousandths<budget_lower_thousandths))),
 ("memory_control_retained",.boolean b1),
 ("random_setting_method_retained",.boolean b2),
 ("measurement_independence_assumption_retained",.boolean b3),
 ("unavoidable_assumption_statement_retained",.boolean b4),
 ("all_rows_retained",.boolean b5)])
def originalTarget : Value := .object [("bell_parameter_center",.integer (20747)),("bell_parameter_standard_uncertainty",.integer (33)),("bell_parameter_denominator",.integer (10000)),("local_factorization_bound_numerator",.integer (2)),("local_factorization_bound_denominator",.integer (1)),("reported_excess_standard_deviations_lower_bound",.integer (22)),("reported_p_value_upper_power_of_ten_exponent_magnitude",.integer (108)),("experimental_trials_lower_bound",.integer (1000000)),("two_settings_per_site",.boolean true),("binary_outcome_per_site",.boolean true),("deterministic_entanglement_generation",.boolean true),("spatial_separation_metres_center_millimetres",.integer (32824)),("spatial_separation_uncertainty_tenths_of_millimetre",.integer (46)),("light_travel_budget_nanoseconds_center_thousandths",.integer (109489)),("light_travel_budget_nanoseconds_uncertainty_thousandths",.integer (15)),("trial_duration_nanoseconds_center_hundredths",.integer (10740)),("trial_duration_nanoseconds_uncertainty_hundredths",.integer (26)),("locality_margin_reported_standard_deviations",.integer (8)),("memory_robust_statistical_method",.boolean true),("random_number_generators_used_for_setting_choices",.boolean true),("measurement_independence_is_a_declared_experimental_assumption",.boolean true),("authors_state_assumptions_cannot_be_fully_avoided",.boolean true),("all_registered_rows_retained",.boolean true)]
theorem originalCompleteAnalysis : exactQuantumSupportBellAnalysis originalTarget = .ok (.object [("positive_exact_carriers",.boolean true),("bell_interval",.array [.integer (20714),.integer (20780)]),("complete_interval_above_local_bound",.boolean true),("central_excess_above_twenty_two_uncertainties",.boolean true),("reported_significance_retained",.boolean true),("million_trial_lower_bound_retained",.boolean true),("binary_two_setting_record",.boolean true),("deterministic_entanglement_generation_retained",.boolean true),("space_like_interval_separation",.boolean true),("memory_control_retained",.boolean true),("random_setting_method_retained",.boolean true),("measurement_independence_assumption_retained",.boolean true),("unavoidable_assumption_statement_retained",.boolean true),("all_rows_retained",.boolean true)]) := rfl
end SFT.Physics.QuantumSupportObservationMeasurement
