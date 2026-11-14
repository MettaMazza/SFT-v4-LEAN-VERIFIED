from pathlib import Path
w=Path('work')
def change(s):
 return s.replace('AtomicTransitionRate','AtomicFieldSplitting').replace('atomictransitionrate','atomicfieldsplitting').replace('atomic_transition_rate_successor','atomic_field_splitting_successor').replace('ATOMIC_TRANSITION_RATE_SPEC','ATOMIC_FIELD_SPLITTING_SPEC').replace('ATOMIC_TRANSITION_RATE_EMPIRICAL_SPEC','ATOMIC_FIELD_SPLITTING_EMPIRICAL_SPEC').replace('SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005','SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005').replace('957','958')
for name in ['check_atomictransitionrate_entry957.py','check_atomictransitionrate_original957.py','check_atomictransitionrate_empirical_original957.py','check_atomictransitionrate_program957.py','check_atomictransitionrate_independent957.py','prepare_atomictransitionrate_native957.py','audit_atomictransitionrate957_all.py','finish_atomictransitionrate957_checks.py','check_atomictransitionrateempirical_program957.py']:
 (w/change(name)).write_text(change((w/name).read_text()))
p=w/'constants-recovery/AtomicTransitionRateProgram957.lean';(p.parent/change(p.name)).write_text(change(p.read_text()))
