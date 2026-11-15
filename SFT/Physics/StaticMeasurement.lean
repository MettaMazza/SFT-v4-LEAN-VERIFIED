import SFT.Physics.StaticExteriorClockEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.StaticMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement StaticExteriorClockCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def requiredTargetRows : List String := ["v1_source_entry", "v1_static_spherical_vacuum", "v1_exterior_coefficient", "v1_exterior_domain", "v1_vacuum_flux", "v1_redshift_relation", "v1_weak_field_relation", "v1_horizon_radius", "existing_v3_flux_law", "existing_v3_clock_law", "existing_v3_horizon_law", "existing_v3_redshift_law", "existing_v3_measured_clock_status", "external_unique_spherical_vacuum", "external_static_exterior", "external_vacuum_equation", "external_time_coefficient", "external_radial_coefficient", "external_mass_parameter", "external_horizon_radius", "external_asymptotic_flatness", "external_spherical_vacuum_radiation", "nist_predicted_fractional_gradient_per_mm", "nist_full_cloud_corrected_gradient_per_mm", "nist_split_cloud_corrected_gradient_per_mm", "nist_fractional_frequency_uncertainty", "nist_measurement_count", "nist_higher_clock_direction", "nist_systematic_corrections_retained", "nist_result_consistent_with_predicted_redshift", "nist_measures_universal_Fold_clock_fraction", "completed_infinity_used_in_v3", "irrational_clock_rate_used_in_v3", "measured_parameter_fitted_into_v3"]
def targetRows (target : Value) (keys : List String) : Except String (List Value) := keys.mapM (field target)
def exactMeasurementAnalysis (target : Value) : Except String Value := do
 let c ← exteriorCertificate (.integer 12)
 let clock := c.exactClockPair
 let frac := StaticExteriorClockEvidence.frac
 let coeff := fun x : Option Rat => match x with | none => Value.array [] | some q => frac q
 let historical := sameValue (← field target "v1_exterior_coefficient") (.text "One-take-horizon-radius-over-radius") && sameValue (← field target "v1_vacuum_flux") (.text "radius-squared-times-radial-coefficient-response-equals-horizon-radius")
 let prerequisites ← targetRows target ["existing_v3_flux_law","existing_v3_clock_law","existing_v3_horizon_law","existing_v3_redshift_law","existing_v3_measured_clock_status"]
 let theory ← targetRows target ["external_unique_spherical_vacuum","external_static_exterior","external_vacuum_equation","external_time_coefficient","external_radial_coefficient","external_mass_parameter","external_horizon_radius","external_asymptotic_flatness","external_spherical_vacuum_radiation"]
 let units := sameValue (← field target "external_mass_parameter") (.text "m-equals-G-M-over-c-squared") && sameValue (← field target "external_horizon_radius") (.text "two-m-equals-two-G-M-over-c-squared")
 let nist ← targetRows target ["nist_predicted_fractional_gradient_per_mm","nist_full_cloud_corrected_gradient_per_mm","nist_split_cloud_corrected_gradient_per_mm","nist_fractional_frequency_uncertainty","nist_measurement_count","nist_higher_clock_direction","nist_systematic_corrections_retained","nist_result_consistent_with_predicted_redshift","nist_measures_universal_Fold_clock_fraction"]
 let direction := sameValue (← field target "nist_higher_clock_direction") (.text "higher-region-ticks-faster") && clock.farClockFaster
 let scope := sameValue (← field target "nist_result_consistent_with_predicted_redshift") (.boolean true) && sameValue (← field target "nist_measures_universal_Fold_clock_fraction") (.boolean false)
 let infinity := sameValue (← field target "completed_infinity_used_in_v3") (.boolean false)
 let irrational := sameValue (← field target "irrational_clock_rate_used_in_v3") (.boolean false)
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 let retained := keys.length==34 && keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredTargetRows.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)
 pure (.object [("formal_horizon",frac c.horizon),("formal_boundary_empty",.boolean c.horizonClockRecordEmpty),("formal_row_count",.integer (.ofNat c.rows.length)),("formal_fluxes_conserved",.boolean c.allFluxesEqualHorizon),("formal_well_relation",.boolean c.allWellRadiusProductsEqualHorizon),("formal_coefficients_complete_One",.boolean c.allComplementsCompleteOne),("formal_well_halves",.boolean c.wellHalvesEachSuccessor),("formal_field_quarters",.boolean c.fieldQuartersEachSuccessor),("formal_coefficients_increase",.boolean c.coefficientIncreasesEachSuccessor),("formal_near_coefficient",coeff clock.near.coefficient),("formal_far_coefficient",coeff clock.far.coefficient),("formal_near_rate",frac clock.nearRate),("formal_far_rate",frac clock.farRate),("formal_far_over_near_rate",frac clock.farOverNearRate),("formal_far_clock_faster",.boolean clock.farClockFaster),("historical_relation_retained",.boolean historical),("prerequisite_rows_retained",.array prerequisites),("external_theory_rows_retained",.array theory),("external_unit_conversion_matches",.boolean units),("nist_rows_retained",.array nist),("nist_direction_matches",.boolean direction),("nist_scope_preserved",.boolean scope),("no_completed_infinity",.boolean infinity),("no_irrational_clock",.boolean irrational),("all_target_rows_retained",.boolean retained),("fitted_value_used",.boolean false)])
end SFT.Physics.StaticMeasurement
