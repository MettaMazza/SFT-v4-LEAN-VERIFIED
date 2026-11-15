import SFT.Physics.ProtonRadius
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.ProtonRadiusMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals ProtonRadius
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactInterval (value uncertainty : Value) : Except String (Rat × Rat) := do
 let centre ← YangMillsSpectrumMeasurement.exactInput value
 let width ← YangMillsSpectrumMeasurement.exactInput uncertainty
 if !width.blt centre || !zero.blt width then throw "radius interval must remain strictly positive"
 pure (subtract centre width,add centre width)
def intervalContains (container contained : Rat × Rat) : Bool :=
 !contained.1.blt container.1 && !contained.2.blt contained.1 && !container.2.blt contained.2
def putInterval (key : String) (value : Rat × Rat) : List (String × (Rat × Rat)) → List (String × (Rat × Rat))
 | [] => [(key,value)]
 | (k,v)::xs => if Text.equal key k then (k,value)::xs else (k,v)::putInterval key value xs
def intervalLookup (key : String) : List (String × (Rat × Rat)) → Except String (Rat × Rat)
 | [] => .error (Text.append "KeyError: " key)
 | (k,v)::xs => if Text.equal key k then .ok v else intervalLookup key xs
def exactMeasurementAnalysis (target : Value) : Except String Value := do
 let scale ← field target "dimension_scale"
 let scaleInterval ← exactInterval (← field scale "value_fm") (← field scale "standard_uncertainty_fm")
 let coefficient ← terminalRadiusCoefficient
 let leading ← leadingRadiusMultiplier
 let predicted := (multiply scaleInterval.1 coefficient,multiply scaleInterval.2 coefficient)
 let scaleCentre ← YangMillsSpectrumMeasurement.exactInput (← field scale "value_fm")
 let predictedCentre := multiply scaleCentre coefficient
 let leadingInterval := (multiply scaleInterval.1 leading,multiply scaleInterval.2 leading)
 let current ← (← array (← field target "current_radius_rows")).foldlM (fun intervals row => do
  let key ← text (← field row "row_id")
  let value ← field row "value_fm"
  let interval ← if Text.equal key "PRad-electron-proton-scattering-2019" then do
   let stat ← YangMillsSpectrumMeasurement.exactInput (← field row "statistical_uncertainty_fm")
   let syst ← YangMillsSpectrumMeasurement.exactInput (← field row "systematic_uncertainty_fm")
   let width := add stat syst
   let centre ← YangMillsSpectrumMeasurement.exactInput value
   if !width.blt centre || !zero.blt width then throw "radius interval must remain strictly positive"
   pure (subtract centre width,add centre width)
  else exactInterval value (← field row "standard_uncertainty_fm")
  pure (putInterval key interval intervals)) []
 let historicalRow ← rowAt (← array (← field target "historical_adverse_rows")) 0
 let historical ← exactInterval (← field historicalRow "value_fm") (← field historicalRow "standard_uncertainty_fm")
 let muonic ← intervalLookup "muonic-hydrogen-current-reference" current
 let rows ← structuralFormulaCensus
 let adverse := rows.map fun row => (row,multiply row.coefficient scaleCentre)
 let inside := fun (value : Rat) => !value.blt muonic.1 && !muonic.2.blt value
 let accepted := adverse.filter (fun x => inside x.2)
 let scope ← match ← field target "scope_rows" with
  | .object fields => pure (fields.length==6 && fields.all (fun x => SymmetricRecords.truthy x.2))
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "TypeError"
 let pair := fun (v : Rat × Rat) => Value.array [ratValue v.1,ratValue v.2]
 let selected := match accepted with
  | [] => false
  | (row,_)::rest => match rest with
   | [] => row.chargeSupport==10 && Text.equal row.transportOrder "linear"
   | _::_ => false
 pure (.object [
 ("scale_interval_fm",pair scaleInterval),
 ("terminal_prediction_interval_fm",pair predicted),
 ("terminal_prediction_centre_fm",ratValue predictedCentre),
 ("leading_prediction_interval_fm",pair leadingInterval),
 ("current_intervals_fm",.object (current.map (fun (key,value) => (key,pair value)))),
 ("current_interval_results",.object (current.map (fun (key,value) => (key,.boolean (intervalContains value predicted))))),
 ("all_current_intervals_contain_prediction",.boolean (current.all (fun x => intervalContains x.2 predicted))),
 ("historical_CODATA_2014_interval_fm",pair historical),
 ("historical_conflict_retained",.boolean (predicted.2.blt historical.1)),
 ("adverse_formula_rows",.array (adverse.map (fun (row,radius) => .object [
 ("charge_support",.integer (.ofNat row.chargeSupport)),("transport_order",.text row.transportOrder),
 ("coefficient",ratValue row.coefficient),("structurally_selected",.boolean row.structurallySelected),
 ("radius_fm",ratValue radius),("inside_muonic_interval",.boolean (inside radius))]))),
 ("adverse_inside_muonic_interval",.array (accepted.map (fun (row,_) => .array [.integer (.ofNat row.chargeSupport),.text row.transportOrder]))),
 ("observation_uniquely_selects_ten_linear",.boolean selected),
 ("scope_rows_retained",.boolean scope)])
end SFT.Physics.ProtonRadiusMeasurement
