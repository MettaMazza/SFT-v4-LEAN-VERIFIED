import SFT.Physics.CommonMeasuredAnalysis
import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.CommonMeasuredMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement CommonMeasuredAnalysis
-- Decoding the immutable source record and its original declared controls.
-- General converted-Fraction calculations are retained by exactAnalysis.
def originalRows (values : List Value) (key : String) : Except String (List Row) :=
 values.mapM (fun row => do
  .ok ⟨← text (← field row key),← decimalField row "center",← decimalField row "standard_uncertainty"⟩)

def originalRecordTarget (v : Value) : Except String Target := do
 let schemes ← originalRows (← array (← field v "scheme_rows")) "scheme"
 let low ← originalRows (← array (← field v "low_transfer_rows")) "row_id"
 let classes ← (← array (← field v "displayed_measurement_classes")).mapM text
 let yes := fun key => ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault v key) true
 .ok ⟨schemes,low,classes,yes "below_W_effective_theory_and_beta_sign_change_retained",
 yes "threshold_matching_discontinuities_retained",yes "complete_strong_and_electromagnetic_vector_receipt_retained",
 yes "NuTeV_extraction_retained_unchanged",yes "NuTeV_extraction_is_not_a_required_mismatch_or_SFT_result",
 yes "all_source_rows_retained_unchanged"⟩

def pair (v : Rat × Rat) : Value := .array [RunningConvergenceCertificate.rat v.1,RunningConvergenceCertificate.rat v.2]
def intervals (v : Intervals) : Value := .object (v.map (fun (k,b)=>(k,pair b)))
def analysisValue (a : Analysis) : Value := .object [
 ("scheme_intervals",intervals a.schemeIntervals),
 ("low_transfer_intervals",intervals a.lowTransferIntervals),
 ("terminal_inside_on_shell_interval",.boolean a.terminalInsideOnShell),
 ("support_eight_inside_APV_interval",.boolean a.supportEightInsideAPV),
 ("E158_interval_above_MS_Z",.boolean a.e158AboveMSZ),
 ("APV_interval_above_MS_Z",.boolean a.apvAboveMSZ),
 ("eDIS_interval_overlaps_MS_Z",.boolean a.edisOverlapsMSZ),
 ("complete_scheme_rows",.boolean a.completeSchemes),
 ("complete_low_transfer_rows",.boolean a.completeLowTransfer),
 ("complete_displayed_classes",.boolean a.completeDisplayedClasses),
 ("threshold_boundary_retained",.boolean a.thresholdBoundary),
 ("strong_EM_receipt_retained",.boolean a.strongEMReceipt),
 ("NuTeV_extraction_retained",.boolean a.nuTeVRetained),
 ("NuTeV_not_rewarded_as_mismatch",.boolean a.nuTeVNotMismatch),
 ("all_source_rows_retained",.boolean a.allRowsRetained)]
def exactCommonScaleAnalysis (v : Value) : Except String Value := do
 .ok (analysisValue (← exactAnalysis (← originalRecordTarget v)))
end SFT.Physics.CommonMeasuredMeasurement
