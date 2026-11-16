import SFT.Physics.ReggeMeasuredAnalysis
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.ReggeMeasuredMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement ReggeMeasuredAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def decode (target : Value) : Except String Target := do
 let sources ← field target "sources"
 let values ← match sources with
  | .object fs => pure (fs.map Prod.snd)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 let rows ← values.mapM (fun item => do
  let row ← field item "reported_record"
  let number := fun key => do YangMillsSpectrumMeasurement.exactInput (← field row key)
  .ok (⟨← text (← field row "state"),← SectorAnchorRecords.originalInt (← field row "spin_J"),
   ← text (← field row "JPC"),← text (← field row "table_status"),
   ← number "mass_MeV",← number "mass_standard_uncertainty_MeV",← number "width_MeV",← number "width_lower_uncertainty_MeV"⟩ : Row))
 let custody ← field target "custody"
 .ok ⟨rows,ThermometryMeasurement.literalBoolean (← field custody "no_slope_intercept_or_residual_fit") true,
  ThermometryMeasurement.literalBoolean (← field custody "no_uncertainty_or_width_widening") true⟩
def exactReggeAnalysis (target : Value) : Except String Value := do exactAnalysis (← decode target)
end SFT.Physics.ReggeMeasuredMeasurement
