from pathlib import Path
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
def sub(s):return s.replace('Thermometry','SpinCondensation').replace('thermometry1042','spinobservation1049').replace('Program1042','Program1049').replace('Empirical1042','Empirical1049').replace('thermal_equilibrium','spin_statistics_condensation').replace('ThermalEquilibriumValidator','SpinStatisticsCondensationValidator').replace('SFT-PHYS-VALIDATION-THERMAL-EQUILIBRIUM-044','SFT-PHYS-VALIDATION-SPIN-STATISTICS-CONDENSATION-046').replace("'thermometry',1042","'spinobservation',1049")
for k in ['program','fresh','grammar','independent','empirical','original']:(w/f'check_spinobservation1049_{k}.py').write_text(sub((w/f'check_thermometry1042_{k}.py').read_text()))
for old,new in [('run_thermometry1042_native.py','run_spinobservation1049_native.py'),('prepare_thermometry1042_empirical_native.py','prepare_spinobservation1049_empirical_native.py'),('audit_thermometry1042.py','audit_spinobservation1049.py')]: (w/new).write_text(sub((w/old).read_text()))
(w/'constants-recovery/SpinCondensationEmpirical1049.lean').write_text(sub((w/'constants-recovery/ThermometryEmpirical1042.lean').read_text()))
(r/'SpinCondensationProgram1049.lean').write_text(sub((r/'ThermometryProgram1042.lean').read_text()))
