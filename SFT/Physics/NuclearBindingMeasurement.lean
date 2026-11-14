import SFT.Physics.NuclearBindingMeasuredRows
import SFT.Physics.NuclearBindingPeak
import SFT.Physics.CosmicComponentTransportMeasurement
namespace SFT.Physics.NuclearBindingMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement NuclearBindingMeasuredRows
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def insertRanked (row : Row × Nat) : List (Row × Nat) → List (Row × Nat)
 | [] => [row]
 | head::tail => if !row.1.binding.blt head.1.binding then row::head::tail else head::insertRanked row tail
def ranked : List (Row × Nat) → List (Row × Nat)
 | [] => []
 | row::tail => insertRanked row (ranked tail)
def fractionValue (q : Rat) : Value := .text (CosmicComponentTransportMeasurement.fractionText q)
def fullPeakRow (r : Row) : Value := .object [("mass_number",.integer r.mass),("charge_count",.integer r.charge),("neutron_count",.integer r.neutrons),("element",.text r.element),("binding_energy_per_nucleon_keV",fractionValue r.binding),("standard_uncertainty_keV",fractionValue r.uncertainty),("lower_keV",fractionValue r.lower),("upper_keV",fractionValue r.upper)]
def runnerRow (r : Row) : Value := .object [("mass_number",.integer r.mass),("charge_count",.integer r.charge),("element",.text r.element),("binding_energy_per_nucleon_keV",fractionValue r.binding),("standard_uncertainty_keV",fractionValue r.uncertainty)]
def formalCoordinate : Except String (Nat × Nat × Nat) := do
 let result ← NuclearBindingPeak.bindingPeakWithin 7 4
 match result with
 | none => .error "unreachable: source peak evaluation did not finish"
 | some v => pure (v.massNumber,v.chargeCount,v.neutronCount)
def analysisFromRows (rows : List Row) : Except String Value := do
 let ordered := ranked rows.zipIdx
 let peak ← match ordered with
  | [] => .error "IndexError: source row absent"
  | p::_ => .ok p
 let runner ← match ordered with
  | [] => .error "IndexError: source row absent"
  | [_] => .error "IndexError: source row absent"
  | _::r::_ => .ok r.1
 let rivals := rows.zipIdx.filter (fun r => r.2 != peak.2)
 let rivalUpper ← match rivals with
  | [] => .error "max() arg is an empty sequence"
  | r::rs => .ok (rs.foldl (fun best next => if best.blt next.1.upper then next.1.upper else best) r.1.upper)
 let d ← rowByCoordinate rows 2 1
 let he ← rowByCoordinate rows 4 2
 let c ← rowByCoordinate rows 12 6
 let fe56 ← rowByCoordinate rows 56 26
 let fe58 ← rowByCoordinate rows 58 26
 let ni ← rowByCoordinate rows 62 28
 let pb ← rowByCoordinate rows 208 82
 let u ← rowByCoordinate rows 238 92
 let light := d.upper.blt he.lower && he.lower.blt c.lower && c.lower.blt fe56.lower && fe56.lower.blt ni.lower
 let heavy := pb.upper.blt ni.lower && u.upper.blt pb.lower
 let (a,z,n) ← formalCoordinate
 let matchesCoordinate := (@decide (Int.ofNat a=peak.1.mass) (Int.decEq _ _)) && (@decide (Int.ofNat z=peak.1.charge) (Int.decEq _ _)) && (@decide (Int.ofNat n=peak.1.neutrons) (Int.decEq _ _))
 let anchors : List (String × Row) := [("deuterium",d),("helium4",he),("carbon12",c),("iron56",fe56),("iron58",fe58),("nickel62",ni),("lead208",pb),("uranium238",u)]
 pure (.object [("complete_measured_row_count",.integer (.ofNat rows.length)),("global_maximum",fullPeakRow peak.1),("runner_up",runnerRow runner),("global_rival_upper_keV",fractionValue rivalUpper),("peak_interval_separated_from_every_rival",.boolean (rivalUpper.blt peak.1.lower)),("light_curve_rises_to_peak",.boolean light),("heavy_curve_falls_from_peak",.boolean heavy),("anchor_intervals_keV",.object (anchors.map (fun (name,row) => (name,.array [fractionValue row.lower,fractionValue row.upper])))),("formal_coordinate_matches_measurement",.boolean matchesCoordinate),("iron_only_shortcut_rejected",.boolean (Text.equal peak.1.element "Ni" && Text.equal runner.element "Fe"))])
def measurementAnalysis (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 analysisFromRows (← measuredBindingRows bytes files payload)
def label : String := "sealed-zero-parameter-binding-ledger-uniquely-predicts-A62-Z28-N34__complete-AME2020-2548-positive-composite-row-census-identifies-Ni62-global-binding-per-nucleon-maximum__Ni62-lower-uncertainty-bound-exceeds-every-rival-upper-bound__light-anchor-rise-and-heavy-anchor-fall-close-an-interior-iron-nickel-maximum__unqualified-iron-only-maximum-replaced-by-exact-nickel62-coordinate"
def classificationFromAnalysis (analysis : Value) : Except String String := do
 if !sameValue (← field analysis "complete_measured_row_count") (.integer 2548) then throw "complete AME2020 measured vector was not retained"
 if !sameValue (← field analysis "global_maximum") (.object [("mass_number",.integer (62)),("charge_count",.integer (28)),("neutron_count",.integer (34)),("element",.text "Ni"),("binding_energy_per_nucleon_keV",.text "17589111/2000"),("standard_uncertainty_keV",.text "69/10000"),("lower_keV",.text "43972743/5000"),("upper_keV",.text "10993203/1250")]) then throw "AME2020 nickel-62 maximum row changed"
 let keys := ["peak_interval_separated_from_every_rival","light_curve_rises_to_peak","heavy_curve_falls_from_peak","formal_coordinate_matches_measurement","iron_only_shortcut_rejected"]
 if !(keys.all (fun key => sameValue ((field analysis key).toOption.getD .null) (.boolean true))) then throw "AME2020 binding-curve comparison failed"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromAnalysis (← measurementAnalysis bytes files payload)
end SFT.Physics.NuclearBindingMeasurement
