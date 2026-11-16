from pathlib import Path
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
s='''import SFT.Physics.SpinCondensationMeasurement
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
 matches : List (String × Value)
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
    ⟨setSample sample components state.components,setSample sample (.boolean (b && g && d)) state.matches,
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
'''
flags=[('finite','turbulence_finite_reynolds_limit_retained'),('compensation','spectrum_five_thirds_compensation_used'),('fourier','spectrum_fourier_plateau_observed'),('hilbert','spectrum_hilbert_plateau_observed'),('structureLimit','spectrum_structure_function_range_limitation_retained'),('threshold','normalized_half_one_threshold_not_universal_lab_temperature'),('emptyExponent','empty_alpha_eta_not_numerical_zero_measurements'),('allManganite','all_manganite_rows_retained'),('allRows','all_registered_rows_retained')]
for a,b in flags:s+=f' let {a} := ThermometryMeasurement.literalBoolean (← field target "{b}") true\n'
s+=''' let actualMatches := (manganese.matches.filter (fun row => SymmetricRecords.truthy row.2)).map (fun row => Value.text row.1)
 let nonmatching := samplePresent nonmatch manganese.matches && !SymmetricRecords.truthy (sampleValue nonmatch manganese.matches)
 let rejectComponent := fun key => samplePresent nonmatch manganese.components && !SymmetricRecords.truthy (PostNewtonianRecords.getDefault (sampleValue nonmatch manganese.components) key)
 pure (.object [
 ("positive_exact_carriers",.boolean ([beta.1,beta.2,nu.1,nu.2,gamma.1,gamma.2,delta.1,delta.2,md,ed].all (fun n => @decide (0<n) (Int.decLt 0 n)) && manganese.positive)),
 ("manganite_components",.object manganese.components),
 ("manganite_matches",.object manganese.matches),
 ("manganite_complete_five_rows",.boolean (manganese.matches.length==5 && (manganese.matches.map Prod.fst).eraseDups.length==5)),
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
end SFT.Physics.CriticalObservationMeasurement
'''
(r/'SFT/Physics/CriticalObservationMeasurement.lean').write_text(s)
