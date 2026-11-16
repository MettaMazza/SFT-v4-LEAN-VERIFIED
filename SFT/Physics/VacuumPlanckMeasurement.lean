import SFT.Physics.VacuumPlanckAnalysis
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.VacuumPlanckMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactVacuumAnalysis (target : Value) : Except String Value := do
 let vacuum ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_vacuum_fraction_central")
 let vacuumWidth ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_vacuum_fraction_standard_uncertainty")
 let matter ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_matter_fraction_central")
 let matterWidth ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_matter_fraction_standard_uncertainty")
 let hubble ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_hubble_central_km_s_mpc")
 let hubbleWidth ← YangMillsSpectrumMeasurement.exactInput (← field target "planck_hubble_standard_uncertainty_km_s_mpc")
 let speed ← YangMillsSpectrumMeasurement.exactInput (← field target "codata_speed_km_s")
 let a ← VacuumPlanckAnalysis.exactAnalysis ⟨vacuum,vacuumWidth,matter,matterWidth,hubble,hubbleWidth,speed,true,true⟩
 let originalCorrection ← field target "older_hubble_transcription_corrected_without_rewriting_prior_receipts"
 let correction := if SymmetricRecords.truthy originalCorrection then Value.boolean a.primaryHubbleCorrectionRetained else originalCorrection
 let rows ← field target "all_registered_rows_retained"
 let pair := fun p : Rat × Rat => Value.array [ratValue p.1,ratValue p.2]
 pure (.object [
 ("vacuum_interval",pair a.vacuumInterval),("matter_interval",pair a.matterInterval),
 ("predicted_share",ratValue a.predictedShare),("share_inside_interval",.boolean a.shareInsideInterval),
 ("normalized_interval",pair a.normalizedInterval),("predicted_normalized",ratValue a.predictedNormalized),
 ("normalized_inside_interval",.boolean a.normalizedInsideInterval),("central_budget_closes",.boolean a.centralBudgetCloses),
 ("hubble_interval",pair a.hubbleInterval),("lambda_mpc_inverse_square_interval",pair a.lambdaInterval),
 ("lambda_mpc_inverse_square_central",ratValue a.lambdaCentral),("dimensional_transport_positive",.boolean a.dimensionalTransportPositive),
 ("local_floor",ratValue a.localFloor),("local_floor_outside_global_interval",.boolean a.localFloorOutsideGlobalInterval),
 ("half_one_mode_mean_outside_global_interval",.boolean a.halfOneModeMeanOutsideGlobalInterval),
 ("primary_hubble_correction_retained",correction),("all_rows_retained",rows)])
end SFT.Physics.VacuumPlanckMeasurement
