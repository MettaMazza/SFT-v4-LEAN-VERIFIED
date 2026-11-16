import SFT.Physics.YangMillsSpectrumMeasurement
import SFT.Physics.CollectiveRadiationCertificate
namespace SFT.Physics.CollectiveObservationMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def integerInput : Value → Except String Int
 | .integer n => .ok n
 | .boolean true => .ok 1
 | .boolean false => .ok 0
 | .text _ | .null | .array _ | .object _ => .error "TypeError"
def integerEquals (v : Value) (n : Int) : Bool :=
 match integerInput v with | .ok k => @decide (k=n) (Int.decEq k n) | .error _ => false
def binaryPower : Int → Rat
 | .ofNat n => wholeRatio (2^n)
 | .negSucc n => natRatio 1 (2^(n+1)) (Nat.pow_pos (by decide))

def exactCollectiveAnalysis (target : Value) : Except String Value := do
 let low ← YangMillsSpectrumMeasurement.exactInput (← field target "laser_unmodified_linewidth_lower_hz")
 let high ← YangMillsSpectrumMeasurement.exactInput (← field target "laser_extended_cavity_linewidth_upper_hz")
 let exponent ← field target "blackbody_exponent"
 let power ← integerInput exponent
 let agreement ← YangMillsSpectrumMeasurement.exactInput (← field target "blackbody_historical_stefan_constant_relative_agreement_upper")
 let shape ← field target "blackbody_spectrum_shape_agreement_reported"
 let acoustic ← field target "acoustic_resonance_measurement_precision_label"
 let factor ← LeptonRatios.divide low high
 let plasma ← field target "plasma_frequency_direct_density_function_reported"
 let direct ← if SymmetricRecords.truthy plasma then do
   pure (Value.boolean (integerEquals (← field target "plasma_probe_flight_count") 2))
  else pure plasma
 let last ← integerInput (← field target "alfven_observation_year_last")
 let first ← integerInput (← field target "alfven_observation_year_first")
 let rows ← field target "all_registered_rows_retained"
 pure (.object [
 ("blackbody_exponent_matches",.boolean (integerEquals exponent 4)),
 ("blackbody_double_ratio",ratValue (binaryPower power)),
 ("blackbody_coefficient_agreement",.boolean (!(natRatio 1 100 (by decide)).blt agreement)),
 ("blackbody_shape_agreement",shape),
 ("acoustic_precision_retained",.boolean (sameValue acoustic (.text "part-per-million"))),
 ("laser_positive",.boolean (zero.blt low && zero.blt high)),
 ("laser_narrowing_factor_floor",ratValue factor),
 ("laser_feedback_narrows",.boolean (!factor.blt (wholeRatio 20))),
 ("plasma_direct_relation",direct),
 ("alfven_year_count",.integer (last-first+1)),
 ("alfven_record_complete",.boolean (@decide (first=2007) (Int.decEq first 2007) && @decide (last=2014) (Int.decEq last 2014))),
 ("all_rows_retained",rows)])

theorem originalFourthPower : binaryPower 4=wholeRatio 16 := rfl
theorem originalAdverseExponent : integerEquals (.integer 3) 4=false := rfl
def originalTarget : Value := .object [("acoustic_resonance_measurement_precision_label",.text "part-per-million"),("all_registered_rows_retained",.boolean true),("alfven_observation_year_first",.integer (2007)),("alfven_observation_year_last",.integer (2014)),("blackbody_exponent",.integer (4)),("blackbody_historical_stefan_constant_relative_agreement_upper",.text "0.01"),("blackbody_spectrum_shape_agreement_reported",.boolean true),("laser_extended_cavity_linewidth_upper_hz",.integer (500000)),("laser_unmodified_linewidth_lower_hz",.integer (10000000)),("plasma_frequency_direct_density_function_reported",.boolean true),("plasma_probe_flight_count",.integer (2))]
theorem originalCompleteAnalysis : exactCollectiveAnalysis originalTarget=.ok (.object [("blackbody_exponent_matches",.boolean true),("blackbody_double_ratio",.object [("numerator",.integer (16)),("denominator",.integer (1))]),("blackbody_coefficient_agreement",.boolean true),("blackbody_shape_agreement",.boolean true),("acoustic_precision_retained",.boolean true),("laser_positive",.boolean true),("laser_narrowing_factor_floor",.object [("numerator",.integer (20)),("denominator",.integer (1))]),("laser_feedback_narrows",.boolean true),("plasma_direct_relation",.boolean true),("alfven_year_count",.integer (8)),("alfven_record_complete",.boolean true),("all_rows_retained",.boolean true)]) := rfl
end SFT.Physics.CollectiveObservationMeasurement
