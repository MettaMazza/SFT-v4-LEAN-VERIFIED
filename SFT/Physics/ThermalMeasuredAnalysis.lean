import SFT.Physics.HeliumIsotope
import SFT.Physics.CosmicMeasuredMeasurement
namespace SFT.Physics.ThermalMeasuredAnalysis
open LeptonIntervals VacuumLedgerProofs SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Target where
 temperature : Rat × Rat
 helium : Rat × Rat
 deuterium : Rat × Rat
 recombination : Rat × Rat
 peakPositions : List Rat
 peakPositionWidths : List Rat
 peakAmplitudes : List Rat
 peakAmplitudeWidths : List Rat
 detectedPeakCount : Int
 freezeoutLabel : String
 captureLabel : String
 analyticPhysicalTyped : Bool
 angularMethodRecords : Bool
 nonintegerNotRewarded : Bool
 originalRowsRetained : Bool
 allRowsRetained : Bool
def interval (center width : Rat) : Except String (Rat × Rat) :=
 if !width.blt center || !zero.blt width then .error "thermal interval must remain positive"
 else .ok (subtract center width,add center width)
def exactAnalysis (target : Target) : Except String Value := do
 let temperature ← interval target.temperature.1 target.temperature.2
 let helium ← interval target.helium.1 target.helium.2
 let deuterium ← interval target.deuterium.1 target.deuterium.2
 let physicalHelium := (← HeliumIsotope.isotopeClosureLedger).physicalHeliumIsotopeShare
 let minor ← LeptonRatios.divide deuterium.2 (wholeRatio 100000)
 let within := CosmicComponentTransportMeasurement.within
 let pair := CosmicMeasuredMeasurement.pair
 .ok (.object [
 ("temperature_exponent_interval",pair temperature),
 ("physical_helium_interval",pair helium),
 ("deuterium_scaled_interval",pair deuterium),
 ("physical_helium_exact",RunningConvergenceCertificate.rat physicalHelium),
 ("temperature_exponent_One_passed",.boolean (within temperature (wholeRatio 1))),
 ("physical_helium_59_over_240_passed",.boolean (within helium physicalHelium)),
 ("analytic_and_physical_helium_separately_typed",.boolean target.analyticPhysicalTyped),
 ("deuterium_positive_minor_channel",.boolean (zero.blt deuterium.1 && minor.blt helium.1)),
 ("freezeout_sequence_retained",.boolean (target.freezeoutLabel=="approximately 1/6" && target.captureLabel=="approximately 1/7")),
 ("finite_recombination_record_retained",.boolean (target.recombination.2.blt target.recombination.1 && zero.blt target.recombination.2)),
 ("complete_peak_census_retained",.boolean (@decide (target.detectedPeakCount=18) (Int.decEq target.detectedPeakCount 18) && target.peakPositions.length==7 && target.peakPositionWidths.length==7 && target.peakAmplitudes.length==7 && target.peakAmplitudeWidths.length==7)),
 ("all_peak_rows_positive",.boolean ([target.peakPositions,target.peakPositionWidths,target.peakAmplitudes,target.peakAmplitudeWidths].all (fun xs => xs.all (fun x => zero.blt x)))),
 ("projection_boundary_retained_without_mismatch_reward",.boolean (target.angularMethodRecords && target.nonintegerNotRewarded)),
 ("all_source_rows_retained",.boolean (target.originalRowsRetained && target.allRowsRetained))])
end SFT.Physics.ThermalMeasuredAnalysis
