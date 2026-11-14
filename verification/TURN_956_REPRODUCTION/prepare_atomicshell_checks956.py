from pathlib import Path
w=Path('work')
def change(s):
 return s.replace('HydrogenRydberg','AtomicShellPeriodicity').replace('hydrogenrydberg','atomicshell').replace('hydrogen_rydberg_successor','atomic_shell_periodicity_successor').replace('HYDROGEN_RYDBERG_SPEC','ATOMIC_SHELL_PERIODICITY_SPEC').replace('HYDROGEN_RYDBERG_EMPIRICAL_SPEC','ATOMIC_SHELL_PERIODICITY_EMPIRICAL_SPEC').replace('SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005','SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005').replace('955','956').replace('AtomicShellPeriodicityRecords','AtomicShellRecords').replace('AtomicShellPeriodicityMeasurement','AtomicShellMeasurement').replace('atomicshellempirical','atomicshellperiodicityempirical')
for name in ['check_hydrogenrydberg_entry955.py','check_hydrogenrydberg_original955.py','check_hydrogenrydberg_empirical_original955.py','check_hydrogenrydberg_program955.py','check_hydrogenrydberg_independent955.py','prepare_hydrogenrydberg_native955.py','audit_hydrogenrydberg955_all.py','finish_hydrogenrydberg955_checks.py','check_hydrogenrydbergempirical_program955.py']:
 (w/change(name)).write_text(change((w/name).read_text()))
p=w/'constants-recovery/HydrogenRydbergProgram955.lean';(p.parent/change(p.name)).write_text(change(p.read_text()))
