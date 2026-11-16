import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.StellarObservationAnalysis
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure StellarRow where
 slope : Rat
 uncertainty : Rat
 lowerMass : Rat
 upperMass : Rat
def rowValue (r : StellarRow) : Value := .object [("slope",RunningConvergenceCertificate.rat r.slope),("uncertainty",RunningConvergenceCertificate.rat r.uncertainty),("lower_mass_ratio",RunningConvergenceCertificate.rat r.lowerMass),("upper_mass_ratio",RunningConvergenceCertificate.rat r.upperMass)]
def intervalContains (a b x : Rat) : Bool := !x.blt a && !b.blt x
def exactAnalysis (record : Value) : Except String Value := do
 let sources ← array (← field record "sources")
 let rows : Nat → String → Except String Value := fun i key=>do field (← field (← LeptonRatios.atIndex sources i) "rows") key
 let number := fun row key=>do YangMillsSpectrumMeasurement.exactInput (← field row key)
 let solar ← rows 0 "solar_structure_inversion"
 let stellar ← rows 1 "piecewise_main_sequence_mass_luminosity"
 let sparc ← rows 2 "sparc_catalogue"
 let btfr ← rows 3 "baryonic_tully_fisher"
 let bullet ← rows 4 "bullet_cluster_separation"
 let moon ← rows 5 "lunar_synchronous_rotation"
 let mercury ← rows 6 "mercury_spin_orbit_resonance"
 let central ← number solar "convective_boundary_observed_central_solar_radius_fraction"
 let uncertainty ← number solar "convective_boundary_observed_uncertainty"
 let reference ← number solar "convective_boundary_reference_model_fraction"
 let stellarRows ← (← array (← field stellar "complete_rows")).mapM (fun row=>do
  pure (⟨← number row "slope",← number row "slope_uncertainty",← number row "lower_mass_ratio",← number row "upper_mass_ratio"⟩ : StellarRow))
 let intervals := stellarRows.map (fun row=>(subtract row.slope row.uncertainty,add row.slope row.uncertainty))
 let four := intervals.map (fun (a,b)=>intervalContains a b (wholeRatio 4))
 let three := intervals.map (fun (a,b)=>intervalContains a b (wholeRatio 3))
 let bc ← number btfr "reported_central_slope"
 let bu ← number btfr "reported_central_slope_uncertainty"
 let systematic ← (← array (← field btfr "reported_systematic_slope_interval")).mapM YangMillsSpectrumMeasurement.exactInput
 let low ← LeptonRatios.atIndex systematic 0
 let high ← LeptonRatios.atIndex systematic 1
 let orbit ← number moon "orbit_duration_hours_approximate"
 let rotation ← number moon "rotation_duration_hours"
 let declared ← field stellar "row_count"
 let cycles ← field mercury "rotation_cycles"
 let orbitCycles ← field mercury "orbital_cycles"
 let rat := RunningConvergenceCertificate.rat
 let interval := fun (a b : Rat)=>Value.array [rat a,rat b]
 pure (.object [
 ("solar_observed_interval",interval (subtract central uncertainty) (add central uncertainty)),
 ("solar_reference_model_value",rat reference),
 ("solar_reference_inside_observed_interval",.boolean (intervalContains (subtract central uncertainty) (add central uncertainty) reference)),
 ("solar_sound_precision_order",rat (← number solar "sound_speed_and_adiabatic_index_reported_precision_order")),
 ("solar_density_precision_order",rat (← number solar "density_inversion_reported_precision_order")),
 ("solar_reference_not_sft_prediction",.boolean (Text.contains (← text (← field solar "sft_use")) "not an SFT-derived")),
 ("stellar_row_count",.integer (.ofNat stellarRows.length)),("stellar_declared_row_count",declared),
 ("stellar_rows",.array (stellarRows.map rowValue)),("stellar_intervals",.array (intervals.map (fun (a,b)=>interval a b))),
 ("stellar_contains_four",.array (four.map Value.boolean)),("stellar_contains_three",.array (three.map Value.boolean)),
 ("only_high_mass_row_contains_four",.boolean (four==[false,false,false,false,true,false])),
 ("only_very_high_mass_row_contains_three",.boolean (three==[false,false,false,false,false,true])),
 ("all_six_stellar_rows_retained",.boolean (stellarRows.length==6 && sameValue declared (.integer 6))),
 ("sparc_galaxy_count",← field sparc "disk_galaxy_count"),("btfr_galaxy_count",← field btfr "galaxy_count"),
 ("btfr_intrinsic_scatter",rat (← number btfr "intrinsic_scatter_fraction")),
 ("btfr_central_interval",interval (subtract bc bu) (add bc bu)),
 ("btfr_central_contains_four",.boolean (intervalContains (subtract bc bu) (add bc bu) (wholeRatio 4))),
 ("btfr_systematic_interval",.array (systematic.map rat)),("btfr_systematic_contains_four",.boolean (intervalContains low high (wholeRatio 4))),
 ("bullet_separation_significance",rat (← number bullet "mass_baryon_peak_separation_significance")),
 ("bullet_mass_follows_galaxies",.boolean (sameValue (← field bullet "mass_peak_follows") (.text "collisionless-galaxy-distribution-rather-than-dominant-x-ray-plasma"))),
 ("moon_orbit_hours",rat orbit),("moon_rotation_hours",rat rotation),("moon_one_to_one",.boolean (orbit==rotation)),
 ("mercury_rotation_period_days",rat (← number mercury "sidereal_rotation_period_days")),
 ("mercury_rotation_uncertainty_days",rat (← number mercury "sidereal_rotation_period_uncertainty_days")),
 ("mercury_rotation_cycles",cycles),("mercury_orbital_cycles",orbitCycles),
 ("mercury_is_three_to_two_boundary",.boolean (sameValue cycles (.integer 3) && sameValue orbitCycles (.integer 2))),
 ("mercury_is_not_one_to_one",.boolean (!sameValue cycles orbitCycles)),("all_sources_retained",.boolean (sources.length==7))])
#print axioms exactAnalysis
end SFT.Physics.StellarObservationAnalysis
