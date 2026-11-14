from pathlib import Path
w=Path('work');s=(w/'prepare_hydrogenrydberg955.py').read_text().replace('HydrogenRydberg','AtomicTransitionRate').replace('hydrogenrydberg','atomictransitionrate').replace('955','957').replace('hydrogen_rydberg_successor_laws_v1','atomic_transition_rate_successor_laws_v1').replace('HYDROGEN_RYDBERG_SPEC','ATOMIC_TRANSITION_RATE_SPEC')
a=s.index("['protonCheck'");b=s.index(']:\n firstAxis',a)
body='''set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def selectionCheck : Bool := match AtomicTransition.transitionSelection with
 | .error _ => false
 | .ok s => s.orbitalStep==1
def exponentCheck : Bool := [1,2,3,4].map (fun n => (electricMultipoleExponent (.count (.integer (.ofNat n)))).toOption)==[some 3,some 5,some 7,some 9]
def lifetimeCheck : Bool := match exactLifetime [.fraction (normalize 1 8 (by decide)),.fraction (normalize 1 24 (by decide))] with
 | .error _ => false
 | .ok q => q==wholeRatio 6
def suppressionCheck : Bool := (List.range 16).all (fun n => match successorMultipoleRatio (.fraction (normalize (.ofNat (n+1)) 17 (by decide))) with
 | .error _ => false
 | .ok q => (wholeRatio 0).blt q && q.blt (wholeRatio 1))
'''
s=s[:a]+repr(['selectionCheck','exponentCheck','lifetimeCheck','suppressionCheck'])+','+repr(body)+')'+s[b:];(w/'prepare_atomictransitionrate957_generated.py').write_text(s);exec(compile(s,'transition-original-entry','exec'),{})
