import SFT.Physics.FizeauAnalysis
import SFT.Physics.FizeauRecords
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.FizeauMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Preserve the original Fraction conversion, field order, Python and result,
-- exact output field names and len operation after the numerical core.
def exactFizeauAnalysis (target : Value) : Except String Value := do
 let measured ← YangMillsSpectrumMeasurement.exactInput (← field target "water_measured_slope_rad_s_per_m")
 let uncertainty ← YangMillsSpectrumMeasurement.exactInput (← field target "water_measured_standard_uncertainty_rad_s_per_m")
 let raw ← YangMillsSpectrumMeasurement.exactInput (← field target "relativistic_raw_prediction_rad_s_per_m")
 let corrected ← YangMillsSpectrumMeasurement.exactInput (← field target "relativistic_profile_and_dispersion_corrected_prediction_rad_s_per_m")
 let ordinary ← YangMillsSpectrumMeasurement.exactInput (← field target "ordinary_addition_prediction_rad_s_per_m")
 let a := FizeauAnalysis.exactAnalysis ⟨measured,uncertainty,raw,corrected,ordinary,true,true,[]⟩
 let airFirst ← field target "air_nonrelativistic_prediction_ruled_out"
 let air ← if SymmetricRecords.truthy airFirst then field target "air_measurements_compatible_with_relativistic_calculation" else pure airFirst
 let n ← FizeauRecords.recordLength (← field target "systematic_limitations_retained")
 pure (.object [
 ("measured",ratValue a.measured),("uncertainty",ratValue a.uncertainty),
 ("measured_interval",.array [ratValue a.measuredInterval.1,ratValue a.measuredInterval.2]),
 ("raw_relativistic",ratValue a.rawRelativistic),("corrected_relativistic",ratValue a.correctedRelativistic),
 ("ordinary_addition",ratValue a.ordinaryAddition),("raw_distance",ratValue a.rawDistance),
 ("corrected_distance",ratValue a.correctedDistance),("best_relativistic_distance",ratValue a.bestRelativisticDistance),
 ("ordinary_distance",ratValue a.ordinaryDistance),
 ("measurement_inside_complete_relativistic_systematics_bracket",.boolean a.measurementInsideCompleteRelativisticSystematicsBracket),
 ("relativistic_more_than_ten_times_closer",.boolean a.relativisticMoreThanTenTimesCloser),
 ("ordinary_outside_measurement_interval",.boolean a.ordinaryOutsideMeasurementInterval),
 ("air_control_retained",air),("all_limitations_retained",.boolean (n==4))])
end SFT.Physics.FizeauMeasurement
