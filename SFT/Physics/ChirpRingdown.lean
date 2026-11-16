import SFT.Physics.CompactHorizon
namespace SFT.Physics.ChirpRingdown
open SFT.Host.Canonical GeneratorOperations LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := wholeRatio 1
def half : Rat := normalize 1 2 (by decide)
def quarter : Rat := normalize 1 4 (by decide)
def rat := RunningConvergenceCertificate.rat
def positiveWhole : CountInput → Except String Nat
 | .integer (.ofNat (n+1))=>.ok (n+1)
 | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _=>.error "a sequence depth must be a positive whole"
def positiveFraction (q : Rat) : Except String Rat := if zero.blt q then .ok q else .error "a wave carrier must be an exact positive fraction"
def positiveTake (larger smaller : Rat) : Except String Rat := do
 let larger ← positiveFraction larger
 let smaller ← positiveFraction smaller
 if !smaller.blt larger then throw "a retained take requires strict positive ordering"
 pure (subtract larger smaller)
structure Orbit where
 separation : Rat
 periodSquared : Rat
 orbitalFrequencySquared : Rat
 waveFrequencySquared : Rat
 bindingSupport : Rat
def orbitalRow (separation : Rat) : Except String Orbit := do
 let separation ← positiveFraction separation
 let period := multiply (multiply separation separation) separation
 let frequency ← LeptonRatios.divide one period
 let binding ← LeptonRatios.divide half separation
 pure ⟨separation,period,frequency,multiply (wholeRatio 4) frequency,binding⟩
def orbitalFields (r : Orbit) : List (String × Value) := [("separation",rat r.separation),("period_squared",rat r.periodSquared),("orbital_frequency_squared",rat r.orbitalFrequencySquared),("wave_frequency_squared",rat r.waveFrequencySquared),("binding_support",rat r.bindingSupport)]
structure InspiralRow where
 orbit : Orbit
 radiatedTake : Option Rat
def inspiralValue (r : InspiralRow) : Value := .object (orbitalFields r.orbit ++ [("radiated_take_from_prior",match r.radiatedTake with | none=>.array [] | some q=>rat q)])
def inspiralRows : List Rat → Option Rat → Except String (List InspiralRow)
 | [],_=>.ok []
 | s::rest,prior=>do
  let row ← orbitalRow s
  let take ← match prior with | none=>.ok none | some p=>do pure (some (← positiveTake row.bindingSupport p))
  pure (⟨row,take⟩::(← inspiralRows rest (some row.bindingSupport)))
def inspiralTrace (depth : CountInput) : Except String (List InspiralRow) := do
 let n ← positiveWhole depth
 inspiralRows (((List.range (n+1)).reverse).map (fun k=>wholeRatio (2^k))) none
def adjacent {α : Type} (relation : α → α → Bool) : List α → Bool
 | []=>true
 | [_]=>true
 | a::b::rest=>relation a b && adjacent relation (b::rest)
def inspiralCertificate (depth : CountInput) : Except String Value := do
 let rows ← inspiralTrace depth
 let last ← match rows.reverse with | []=>.error "IndexError" | h::_=>.ok h
 pure (.object [("rows",.array (rows.map inspiralValue)),("separation_strictly_falls",.boolean (adjacent (fun a b=>b.orbit.separation.blt a.orbit.separation) rows)),("period_squared_strictly_falls",.boolean (adjacent (fun a b=>b.orbit.periodSquared.blt a.orbit.periodSquared) rows)),("orbital_frequency_squared_strictly_rises",.boolean (adjacent (fun a b=>a.orbit.orbitalFrequencySquared.blt b.orbit.orbitalFrequencySquared) rows)),("wave_frequency_squared_strictly_rises",.boolean (adjacent (fun a b=>a.orbit.waveFrequencySquared.blt b.orbit.waveFrequencySquared) rows)),("quadrupole_is_twice_orbital",.boolean (rows.all (fun r=>r.orbit.waveFrequencySquared==multiply (wholeRatio 4) r.orbit.orbitalFrequencySquared))),("binding_support_strictly_rises",.boolean (adjacent (fun a b=>a.orbit.bindingSupport.blt b.orbit.bindingSupport) rows)),("every_successor_take_positive",.boolean (adjacent (fun _ b=>match b.radiatedTake with | none=>false | some q=>zero.blt q) rows)),("ends_at_horizon_contact",.boolean (last.orbit.separation==one))])
def mergerRecord : Value :=
 let radius := add quarter quarter
 .object [("initial_source_count",.integer 2),("component_mass",rat quarter),("component_radius",rat radius),("contact_separation",rat (add radius radius)),("joined_source_count",.integer 1),("radiation_record",.array [.text "quadrupole-take"]),("component_labels_retained",.array [.text "left-source",.text "right-source"]),("remnant_labels",.array [.text "joined-mass-support",.text "held-turn"])]
structure RingdownRow where
 tick : Nat
 amplitude : Rat
 toneKey : Value
 sourceCount : Value
def ringdownValue (r : RingdownRow) : Value := .object [("tick",.integer r.tick),("amplitude_support",rat r.amplitude),("tone_key",r.toneKey),("source_count",r.sourceCount)]
def ringdownRows : Nat → Nat → Rat → List RingdownRow
 | 0,_,_=>[]
 | n+1,tick,a=>⟨tick,a,PostNewtonianRecords.getDefault mergerRecord "remnant_labels",PostNewtonianRecords.getDefault mergerRecord "joined_source_count"⟩::ringdownRows n (tick+1) (multiply a half)
def ringdownTrace (depth : CountInput) : Except String (List RingdownRow) := do pure (ringdownRows (← positiveWhole depth) 1 one)
def ringdownCertificate (depth : CountInput) : Except String Value := do
 let rows ← ringdownTrace depth
 let first ← match rows with | []=>.error "IndexError" | h::_=>.ok h
 let last ← match rows.reverse with | []=>.error "IndexError" | h::_=>.ok h
 pure (.object [("rows",.array (rows.map ringdownValue)),("one_remnant",.boolean (rows.all (fun r=>RunningConvergenceMeasurement.sameValue r.sourceCount (.integer 1)))),("tone_held",.boolean (rows.all (fun r=>RunningConvergenceMeasurement.sameValue r.toneKey first.toneKey))),("amplitude_strictly_falls",.boolean (adjacent (fun a b=>b.amplitude.blt a.amplitude) rows)),("binary_damping",.boolean (adjacent (fun a b=>b.amplitude==multiply a.amplitude half) rows)),("all_reached_amplitudes_positive",.boolean (rows.all (fun r=>zero.blt r.amplitude))),("finite_floor_retained",.boolean (zero.blt last.amplitude))])
def theoremCertificate : Except String Value := do
 let inspirals ← [1,2,3,8,16].mapM (fun n=>inspiralCertificate (.integer (.ofNat n)))
 let ringdowns ← [1,2,3,8,16].mapM (fun n=>ringdownCertificate (.integer (.ofNat n)))
 let flag := StellarCertificate.flag
 let same := RunningConvergenceMeasurement.sameValue
 let get := PostNewtonianRecords.getDefault mergerRecord
 pure (.object [("inspirals",.array inspirals),("merger",mergerRecord),("ringdowns",.array ringdowns),("all_chirps_close",.boolean (inspirals.all (fun r=>flag r "separation_strictly_falls" && flag r "wave_frequency_squared_strictly_rises" && flag r "quadrupole_is_twice_orbital" && flag r "every_successor_take_positive" && flag r "ends_at_horizon_contact"))),("merger_closes",.boolean (same (get "initial_source_count") (.integer 2) && same (get "joined_source_count") (.integer 1) && same (get "contact_separation") (rat one) && !(same (get "radiation_record") (.array [])))),("all_ringdowns_close",.boolean (ringdowns.all (fun r=>flag r "one_remnant" && flag r "tone_held" && flag r "binary_damping" && flag r "all_reached_amplitudes_positive" && flag r "finite_floor_retained"))),("unique_ordered_sequence",.array [.text "inspiral-rising-chirp",.text "merger",.text "damped-ringdown"])])
#print axioms orbitalRow
#print axioms inspiralTrace
#print axioms ringdownTrace
#print axioms theoremCertificate
end SFT.Physics.ChirpRingdown
