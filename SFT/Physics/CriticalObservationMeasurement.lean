import SFT.Physics.SpinCondensationMeasurement
import SFT.Physics.SymmetricRecords
namespace SFT.Physics.CriticalObservationMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def originalPositiveWhole : Value → Bool
 | .integer n => @decide (0<n) (Int.decLt 0 n)
 | .boolean _ | .null | .text _ | .array _ | .object _ => false
def contains (center uncertainty denominator numerator forcedDenominator : Int) : Bool :=
 let lower := center-uncertainty
 let upper := center+uncertainty
 [lower,upper,uncertainty,denominator,numerator,forcedDenominator].all (fun n => @decide (0<n) (Int.decLt 0 n)) &&
 decide (lower*forcedDenominator≤numerator*denominator) && decide (numerator*denominator≤upper*forcedDenominator)
def intField (target : Value) (key : String) : Except String Int := do
 SectorAnchorRecords.originalInt (← field target key)
-- The source dictionaries replace a repeated sample without moving its first position.
def setSample (sample : String) (value : Value) : List (String × Value) → List (String × Value)
 | [] => [(sample,value)]
 | (key,old)::rest => if Text.equal key sample then (key,value)::rest else (key,old)::setSample sample value rest
def samplePresent (sample : String) (rows : List (String × Value)) : Bool := rows.any (fun row => Text.equal row.1 sample)
def sampleValue (sample : String) (rows : List (String × Value)) : Value := PostNewtonianRecords.getDefault (.object rows) sample
structure Manganite where
 components : List (String × Value)
 matchRows : List (String × Value)
 positive : Bool
def manganiteRows (beta gamma delta : Int × Int) (denominator : Int) : List Value → Manganite → Except String Manganite
 | [],state => .ok state
 | row::rest,state => do
   let bc ← intField row "beta_center"
   let bu ← intField row "beta_uncertainty"
   let gc ← intField row "gamma_center"
   let gu ← intField row "gamma_uncertainty"
   let dc ← intField row "delta_center"
   let du ← intField row "delta_uncertainty"
   let sample ← text (← field row "sample")
   let b := contains bc bu denominator beta.1 beta.2
   let g := contains gc gu denominator gamma.1 gamma.2
   let d := contains dc du denominator delta.1 delta.2
   let components := Value.object [("beta",.boolean b),("gamma",.boolean g),("delta",.boolean d)]
   manganiteRows beta gamma delta denominator rest
    ⟨setSample sample components state.components,setSample sample (.boolean (b && g && d)) state.matchRows,
     state.positive && [bc,bu,gc,gu,dc,du].all (fun n => @decide (0<n) (Int.decLt 0 n))⟩
def exactCriticalityAnalysis (target : Value) : Except String Value := do
 let beta := (← intField target "critical_beta_numerator",← intField target "critical_beta_denominator")
 let nu := (← intField target "critical_nu_numerator",← intField target "critical_nu_denominator")
 let gamma := (← intField target "critical_gamma_numerator",← intField target "critical_gamma_denominator")
 let delta := (← intField target "critical_delta_numerator",← intField target "critical_delta_denominator")
 let md ← intField target "manganite_measurement_denominator"
 let manganese ← manganiteRows beta gamma delta md (← array (← field target "manganite_rows")) ⟨[],[],true⟩
 let expected ← array (← field target "manganite_expected_complete_vector_matches")
 let nonmatch ← text (← field target "manganite_expected_nonmatching_control")
 let ed ← intField target "erbium_measurement_denominator"
 let eb := contains (← intField target "erbium_beta_center") (← intField target "erbium_beta_uncertainty") ed beta.1 beta.2
 let eg := contains (← intField target "erbium_gamma_center") (← intField target "erbium_gamma_uncertainty") ed gamma.1 gamma.2
 let en := contains (← intField target "erbium_nu_center") (← intField target "erbium_nu_uncertainty") ed nu.1 nu.2
 let tc ← intField target "turbulence_measured_structure_center"
 let tu ← intField target "turbulence_measured_structure_uncertainty"
 let td ← intField target "turbulence_measured_structure_denominator"
 let tn ← intField target "turbulence_structure_numerator"
 let tf ← intField target "turbulence_structure_denominator"
 let plateau ← ["spectrum_physical_sample_reynolds_count","spectrum_sampling_frequency_hz","spectrum_fourier_plateau_lower_hz","spectrum_fourier_plateau_upper_hz","spectrum_hilbert_plateau_lower_hz","spectrum_hilbert_plateau_upper_hz"].mapM (intField target)
 let fl ← intField target "spectrum_fourier_plateau_lower_hz"
 let fu ← intField target "spectrum_fourier_plateau_upper_hz"
 let hl ← intField target "spectrum_hilbert_plateau_lower_hz"
 let hu ← intField target "spectrum_hilbert_plateau_upper_hz"
 let sn ← intField target "turbulence_spectrum_numerator"
 let sd ← intField target "turbulence_spectrum_denominator"
 let orientation ← field target "turbulence_spectrum_orientation"
 let finite := ThermometryMeasurement.literalBoolean (← field target "turbulence_finite_reynolds_limit_retained") true
 let compensation := ThermometryMeasurement.literalBoolean (← field target "spectrum_five_thirds_compensation_used") true
 let fourier := ThermometryMeasurement.literalBoolean (← field target "spectrum_fourier_plateau_observed") true
 let hilbert := ThermometryMeasurement.literalBoolean (← field target "spectrum_hilbert_plateau_observed") true
 let structureLimit := ThermometryMeasurement.literalBoolean (← field target "spectrum_structure_function_range_limitation_retained") true
 let threshold := ThermometryMeasurement.literalBoolean (← field target "normalized_half_one_threshold_not_universal_lab_temperature") true
 let emptyExponent := ThermometryMeasurement.literalBoolean (← field target "empty_alpha_eta_not_numerical_zero_measurements") true
 let allManganite := ThermometryMeasurement.literalBoolean (← field target "all_manganite_rows_retained") true
 let allRows := ThermometryMeasurement.literalBoolean (← field target "all_registered_rows_retained") true
 let actualMatches := (manganese.matchRows.filter (fun row => SymmetricRecords.truthy row.2)).map (fun row => Value.text row.1)
 let nonmatching := samplePresent nonmatch manganese.matchRows && !SymmetricRecords.truthy (sampleValue nonmatch manganese.matchRows)
 let rejectComponent := fun key => samplePresent nonmatch manganese.components && !SymmetricRecords.truthy (PostNewtonianRecords.getDefault (sampleValue nonmatch manganese.components) key)
 pure (.object [
 ("positive_exact_carriers",.boolean ([beta.1,beta.2,nu.1,nu.2,gamma.1,gamma.2,delta.1,delta.2,md,ed].all (fun n => @decide (0<n) (Int.decLt 0 n)) && manganese.positive)),
 ("manganite_components",.object manganese.components),
 ("manganite_matches",.object manganese.matchRows),
 ("manganite_complete_five_rows",.boolean (manganese.matchRows.length==5 && (manganese.matchRows.map Prod.fst).eraseDups.length==5)),
 ("manganite_expected_matches_exact",.boolean (sameValue (.array actualMatches) (.array expected))),
 ("manganite_nonmatch_retained",.boolean nonmatching),
 ("manganite_nonmatch_gamma_rejects",.boolean (rejectComponent "gamma")),
 ("manganite_nonmatch_delta_rejects",.boolean (rejectComponent "delta")),
 ("erbium_components",.object [("beta",.boolean eb),("gamma",.boolean eg),("nu",.boolean en)]),
 ("erbium_complete_vector_matches",.boolean (eb && eg && en)),
 ("structure_interval",.array [.integer (tc-tu),.integer (tc+tu)]),
 ("structure_interval_contains_two_thirds",.boolean (contains tc tu td tn tf)),
 ("finite_reynolds_boundary_retained",.boolean finite),
 ("spectrum_exact_magnitude",.boolean (decide (sn=5) && decide (sd=3))),
 ("spectrum_falling_orientation",.boolean (sameValue orientation (.text "falling"))),
 ("spectrum_five_thirds_compensation",.boolean compensation),
 ("spectrum_fourier_plateau",.boolean fourier),
 ("spectrum_hilbert_plateau",.boolean hilbert),
 ("spectrum_ranges_ordered",.boolean (plateau.all (fun n => @decide (0<n) (Int.decLt 0 n)) && decide (fl<fu) && decide (hl<hu))),
 ("spectrum_structure_limit_retained",.boolean structureLimit),
 ("threshold_boundary_retained",.boolean threshold),
 ("empty_exponent_boundary_retained",.boolean emptyExponent),
 ("all_manganite_rows_retained",.boolean allManganite),
 ("all_rows_retained",.boolean allRows)])
def originalTarget : Value := .object [("critical_beta_numerator",.integer (1)),("critical_beta_denominator",.integer (2)),("critical_nu_numerator",.integer (1)),("critical_nu_denominator",.integer (2)),("critical_gamma_numerator",.integer (1)),("critical_gamma_denominator",.integer (1)),("critical_delta_numerator",.integer (3)),("critical_delta_denominator",.integer (1)),("manganite_measurement_denominator",.integer (100)),("manganite_rows",.array [.object [("sample",.text "La00"),("beta_center",.integer (48)),("beta_uncertainty",.integer (5)),("gamma_center",.integer (105)),("gamma_uncertainty",.integer (8)),("delta_center",.integer (318)),("delta_uncertainty",.integer (20))],.object [("sample",.text "La02"),("beta_center",.integer (46)),("beta_uncertainty",.integer (4)),("gamma_center",.integer (108)),("gamma_uncertainty",.integer (7)),("delta_center",.integer (334)),("delta_uncertainty",.integer (20))],.object [("sample",.text "La04"),("beta_center",.integer (51)),("beta_uncertainty",.integer (4)),("gamma_center",.integer (100)),("gamma_uncertainty",.integer (6)),("delta_center",.integer (296)),("delta_uncertainty",.integer (15))],.object [("sample",.text "La06"),("beta_center",.integer (49)),("beta_uncertainty",.integer (4)),("gamma_center",.integer (103)),("gamma_uncertainty",.integer (6)),("delta_center",.integer (310)),("delta_uncertainty",.integer (15))],.object [("sample",.text "La08"),("beta_center",.integer (50)),("beta_uncertainty",.integer (4)),("gamma_center",.integer (101)),("gamma_uncertainty",.integer (6)),("delta_center",.integer (302)),("delta_uncertainty",.integer (15))]]),("manganite_expected_complete_vector_matches",.array [.text "La00",.text "La04",.text "La06",.text "La08"]),("manganite_expected_nonmatching_control",.text "La02"),("erbium_measurement_denominator",.integer (100)),("erbium_beta_center",.integer (48)),("erbium_beta_uncertainty",.integer (2)),("erbium_gamma_center",.integer (96)),("erbium_gamma_uncertainty",.integer (6)),("erbium_nu_center",.integer (49)),("erbium_nu_uncertainty",.integer (2)),("turbulence_structure_numerator",.integer (2)),("turbulence_structure_denominator",.integer (3)),("turbulence_measured_structure_center",.integer (679)),("turbulence_measured_structure_uncertainty",.integer (13)),("turbulence_measured_structure_denominator",.integer (1000)),("turbulence_finite_reynolds_limit_retained",.boolean true),("turbulence_spectrum_numerator",.integer (5)),("turbulence_spectrum_denominator",.integer (3)),("turbulence_spectrum_orientation",.text "falling"),("spectrum_physical_sample_reynolds_count",.integer (720)),("spectrum_sampling_frequency_hz",.integer (40000)),("spectrum_five_thirds_compensation_used",.boolean true),("spectrum_fourier_plateau_observed",.boolean true),("spectrum_fourier_plateau_lower_hz",.integer (40)),("spectrum_fourier_plateau_upper_hz",.integer (4000)),("spectrum_hilbert_plateau_observed",.boolean true),("spectrum_hilbert_plateau_lower_hz",.integer (20)),("spectrum_hilbert_plateau_upper_hz",.integer (2000)),("spectrum_structure_function_range_limitation_retained",.boolean true),("normalized_half_one_threshold_not_universal_lab_temperature",.boolean true),("empty_alpha_eta_not_numerical_zero_measurements",.boolean true),("all_manganite_rows_retained",.boolean true),("all_registered_rows_retained",.boolean true)]
theorem originalCompleteAnalysis : exactCriticalityAnalysis originalTarget=.ok (.object [("positive_exact_carriers",.boolean true),("manganite_components",.object [("La00",.object [("beta",.boolean true),("gamma",.boolean true),("delta",.boolean true)]),("La02",.object [("beta",.boolean true),("gamma",.boolean false),("delta",.boolean false)]),("La04",.object [("beta",.boolean true),("gamma",.boolean true),("delta",.boolean true)]),("La06",.object [("beta",.boolean true),("gamma",.boolean true),("delta",.boolean true)]),("La08",.object [("beta",.boolean true),("gamma",.boolean true),("delta",.boolean true)])]),("manganite_matches",.object [("La00",.boolean true),("La02",.boolean false),("La04",.boolean true),("La06",.boolean true),("La08",.boolean true)]),("manganite_complete_five_rows",.boolean true),("manganite_expected_matches_exact",.boolean true),("manganite_nonmatch_retained",.boolean true),("manganite_nonmatch_gamma_rejects",.boolean true),("manganite_nonmatch_delta_rejects",.boolean true),("erbium_components",.object [("beta",.boolean true),("gamma",.boolean true),("nu",.boolean true)]),("erbium_complete_vector_matches",.boolean true),("structure_interval",.array [.integer (666),.integer (692)]),("structure_interval_contains_two_thirds",.boolean true),("finite_reynolds_boundary_retained",.boolean true),("spectrum_exact_magnitude",.boolean true),("spectrum_falling_orientation",.boolean true),("spectrum_five_thirds_compensation",.boolean true),("spectrum_fourier_plateau",.boolean true),("spectrum_hilbert_plateau",.boolean true),("spectrum_ranges_ordered",.boolean true),("spectrum_structure_limit_retained",.boolean true),("threshold_boundary_retained",.boolean true),("empty_exponent_boundary_retained",.boolean true),("all_manganite_rows_retained",.boolean true),("all_rows_retained",.boolean true)]) := rfl
end SFT.Physics.CriticalObservationMeasurement
