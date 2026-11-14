import SFT.Physics.AtomicFieldSplittingProofs
import SFT.Physics.AtomicFieldSplittingRecords
namespace SFT.Physics.AtomicFieldSplittingMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals AtomicFieldSplittingRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def label : String := "sealed-two-J-plus-one-and-linear-Zeeman-match-NIST__degenerate-hydrogen-linear-Stark-matches-NBS__nondegenerate-cesium-quadratic-Stark-matches-NIST"
def operatingField (cesium : Value) : Except String Rat := do
 LeptonRatios.divide (← decimalField cesium "quadratic_voltage_range_V") (← decimalField cesium "electrode_spacing_m")
def classificationFromRecord (record : Value) : Except String String := do
 let sources ← field record "sources"
 let zeeman ← field (← field sources "nist_zeeman") "reported_record"
 if !sameValue (← field zeeman "sublevel_count_relation") (.text "2J+1") then
  throw "NIST Zeeman multiplicity relation changed"
 if !sameValue (← field zeeman "weak_field_energy_relation") (.text "delta-E=g*M*mu_B*B") || !sameValue (← field zeeman "field_order") (.text "linear") then
  throw "NIST weak-field Zeeman relation changed"
 if !((← decimalField zeeman "wavenumber_shift_coefficient_cm_inverse_per_tesla") == normalize 23343 50000 (by decide)) then
  throw "NIST displayed Zeeman coefficient changed"
 if !sameValue (← field zeeman "coefficient_status") (.text "NIST displayed value; no uncertainty reported on page") then
  throw "NIST Zeeman uncertainty disclosure changed"
 let hydrogen ← field (← field sources "nbs_hydrogen_linear_stark") "reported_record"
 if !sameValue (← field hydrogen "response_order") (.text "linear") || !Text.contains (← text (← field hydrogen "measurement_protocol")) "linear energy shift" then
  throw "NBS hydrogen linear-Stark record changed"
 let cesium ← field (← field sources "nist_cesium_quadratic_stark") "reported_record"
 if !sameValue (← field cesium "response_relation") (.text "frequency-shift=(polarizability/2)*electric-field-squared") then
  throw "NIST cesium quadratic-Stark relation changed"
 if !sameValue (← field cesium "response_order") (.text "quadratic") || !((← decimalField cesium "polarizability_displayed_hz_per_field_squared") == normalize 1 2 (by decide)) then
  throw "NIST cesium response class changed"
 let operating ← operatingField cesium
 let crossing ← LeptonRatios.divide operating (VacuumLedgerProofs.wholeRatio 100)
 if !(operating == VacuumLedgerProofs.wholeRatio 150000) || !(crossing == (← decimalField cesium "first_level_crossing_field_V_per_cm")) then
  throw "NIST cesium voltage/spacing/field cross-check failed"
 if !sameValue (← field cesium "uncertainty_status") (.text "no uncertainty reported for these displayed design values") then
  throw "NIST cesium uncertainty disclosure changed"
 let multiplicity ← AtomicFieldSplitting.magneticSublevelCount (.count (.integer 4))
 if !(multiplicity==5) then throw "sealed magnetic multiplicity witness failed"
 let g := normalize 3 2 (by decide)
 let f := normalize 2 5 (by decide)
 let twice := multiply (VacuumLedgerProofs.wholeRatio 2) f
 let z2 ← AtomicFieldSplitting.zeemanShiftMagnitude (.fraction g) (.count (.integer 2)) (.fraction twice)
 let z ← AtomicFieldSplitting.zeemanShiftMagnitude (.fraction g) (.count (.integer 2)) (.fraction f)
 if !(z2 == multiply (VacuumLedgerProofs.wholeRatio 2) z) then throw "sealed Zeeman linear scaling failed"
 let dipole := normalize 4 7 (by decide)
 let l2 ← AtomicFieldSplitting.linearStarkMagnitude (.fraction dipole) (.fraction twice)
 let l ← AtomicFieldSplitting.linearStarkMagnitude (.fraction dipole) (.fraction f)
 if !(l2 == multiply (VacuumLedgerProofs.wholeRatio 2) l) then throw "sealed degenerate Stark scaling failed"
 let q2 ← AtomicFieldSplitting.quadraticStarkMagnitude (.fraction dipole) (.fraction twice)
 let q ← AtomicFieldSplitting.quadraticStarkMagnitude (.fraction dipole) (.fraction f)
 if !(q2 == multiply (VacuumLedgerProofs.wholeRatio 4) q) then throw "sealed nondegenerate Stark scaling failed"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := match AtomicFieldSplitting.zeemanShiftMagnitude (.fraction (normalize 3 2 (by decide))) (.count (.integer 1)) (.fraction (normalize 2 5 (by decide))) with
 | .error _ => false
 | .ok z2 => match AtomicFieldSplitting.zeemanShiftMagnitude (.fraction (normalize 3 2 (by decide))) (.count (.integer 1)) (.fraction (normalize 1 5 (by decide))) with
  | .error _ => false
  | .ok z => match AtomicFieldSplitting.quadraticStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 2 5 (by decide))) with
   | .error _ => false
   | .ok q2 => match AtomicFieldSplitting.quadraticStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 1 5 (by decide))) with
    | .error _ => false
    | .ok q => z2 == multiply (VacuumLedgerProofs.wholeRatio 2) z && q2 == multiply (VacuumLedgerProofs.wholeRatio 4) q
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.AtomicFieldSplittingMeasurement
