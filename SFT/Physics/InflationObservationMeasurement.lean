import SFT.Physics.InflationObservationAnalysis
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.InflationObservationMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactInflationAnalysis (target : Value) : Except String Value := do
 let centre ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_scalar_index_central")
 let width ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_scalar_index_standard_uncertainty")
 let bound ← YangMillsSpectrumMeasurement.exactInput (← field target "bicep_planck_tensor_ratio_upper_95")
 let strict ← field target "tensor_bound_strict"
 let rows ← field target "all_registered_rows_retained"
 let a := InflationObservationAnalysis.exactAnalysis ⟨centre,width,bound,true,true⟩
 let below := if SymmetricRecords.truthy strict then Value.boolean a.tensorBelow else strict
 pure (.object [
 ("scalar_prediction",ratValue a.scalarPrediction),
 ("scalar_interval",.array [ratValue a.scalarInterval.1,ratValue a.scalarInterval.2]),
 ("scalar_inside_interval",.boolean a.scalarInside),("scalar_distance_from_central",ratValue a.scalarDistance),
 ("tensor_prediction",ratValue a.tensorPrediction),("tensor_upper_bound",ratValue a.tensorBound),
 ("tensor_strictly_below_bound",below),("tensor_bound_margin",ratValue a.tensorMargin),
 ("partition_complete",.boolean a.partitionComplete),("all_rows_retained",rows)])
end SFT.Physics.InflationObservationMeasurement
