from pathlib import Path
import json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work')
ints=[('becCenter','bec_transition_ratio_center'),('becUncertainty','bec_transition_ratio_uncertainty'),('becDenominator','bec_transition_ratio_denominator'),('correction','bec_reported_finite_population_correction_percent'),('spinStates','pauli_spin_state_count'),('collisionFactor','pauli_collision_cross_section_reduction_factor'),('forced','spinor_forced_return_degrees'),('spinCenter','spinor_measured_return_degrees_center'),('spinUncertainty','spinor_measured_return_degrees_uncertainty')]
flags=[('finite','bec_finite_population_measurement'),('ground','bec_ground_state_occupation_measured'),('cooling','bec_ground_share_increases_as_temperature_is_lowered'),('transition','bec_sharp_transition_feature_observed'),('pauli','pauli_blocking_directly_observed'),('oneTurn','spinor_one_turn_changes_held_orientation'),('twoTurns','spinor_two_turns_restore_identical_state'),('allRows','all_registered_rows_retained')]
s='import SFT.Host.Canonical\nnamespace SFT.Physics.SpinCondensationAnalysis\nopen SFT.Host.Canonical\nstructure Target where\n'+''.join(' '+a+' : Int\n' for a,b in ints)+''.join(' '+a+' : Bool\n' for a,b in flags)
s+='''
-- Exact original integer analysis; flags retain Python singleton-Boolean tests.
def exactAnalysis (t : Target) : Value :=
 let b := (t.becCenter-t.becUncertainty,t.becCenter+t.becUncertainty)
 let s := (t.spinCenter-t.spinUncertainty,t.spinCenter+t.spinUncertainty)
 let positive := [b.1,b.2,t.becUncertainty,t.becDenominator,t.correction,t.spinStates,t.collisionFactor,t.forced,t.spinUncertainty,s.1,s.2].all (fun x => @decide (0<x) (Int.decLt 0 x))
 .object [
 ("positive_exact_carriers",.boolean positive),
 ("bec_interval",.array [.integer b.1,.integer b.2]),
 ("spinor_interval",.array [.integer s.1,.integer s.2]),
 ("bec_interval_ordered",.boolean (decide (b.1≤b.2) && decide (b.2<t.becDenominator+1))),
 ("bec_finite_population",.boolean t.finite),
 ("bec_ground_measured",.boolean t.ground),
 ("bec_cooling_direction",.boolean t.cooling),
 ("bec_transition_observed",.boolean t.transition),
 ("pauli_observed",.boolean t.pauli),
 ("pauli_two_spin_states",.boolean (decide (t.spinStates=2))),
 ("pauli_reported_factor_retained",.boolean (decide (t.collisionFactor=2))),
 ("spinor_interval_contains_forced_return",.boolean (decide (s.1≤t.forced) && decide (t.forced≤s.2))),
 ("spinor_one_turn_changes",.boolean t.oneTurn),
 ("spinor_two_turns_restore",.boolean t.twoTurns),
 ("all_rows_retained",.boolean t.allRows)]
def registeredTarget : Target := ⟨94,5,100,3,2,2,720,704,38,true,true,true,true,true,true,true,true⟩
theorem originalBECInterval : (registeredTarget.becCenter-registeredTarget.becUncertainty,registeredTarget.becCenter+registeredTarget.becUncertainty)=(89,99) := rfl
theorem originalSpinInterval : (registeredTarget.spinCenter-registeredTarget.spinUncertainty,registeredTarget.spinCenter+registeredTarget.spinUncertainty)=(666,742) := rfl
theorem originalTwoTurnsContained : (decide ((666:Int)≤registeredTarget.forced) && decide (registeredTarget.forced≤742))=true := rfl
theorem originalTamperedSpinorRejected : (decide ((600:Int)-registeredTarget.spinUncertainty≤registeredTarget.forced) && decide (registeredTarget.forced≤600+registeredTarget.spinUncertainty))=false := rfl
end SFT.Physics.SpinCondensationAnalysis
'''
(r/'SFT/Physics/SpinCondensationAnalysis.lean').write_text(s)
(w/'spinobservation1049_fields.json').write_text(json.dumps(dict(ints=ints,flags=flags)))
s='import SFT.Physics.SpinCondensationAnalysis\nimport SFT.Physics.ThermometryMeasurement\nnamespace SFT.Physics.SpinCondensationMeasurement\nopen SFT.Host.Canonical RunningConvergenceMeasurement\ndef exactSpinStatisticsAnalysis (target : Value) : Except String Value := do\n'
for a,b in ints:s+=' let '+a+' ← SectorAnchorRecords.originalInt (← field target '+json.dumps(b)+')\n'
for a,b in flags:s+=' let '+a+' := ThermometryMeasurement.literalBoolean (← field target '+json.dumps(b)+') true\n'
s+=' pure (SpinCondensationAnalysis.exactAnalysis ⟨'+','.join(a for a,b in ints+flags)+'⟩)\nend SFT.Physics.SpinCondensationMeasurement\n';(r/'SFT/Physics/SpinCondensationMeasurement.lean').write_text(s)
