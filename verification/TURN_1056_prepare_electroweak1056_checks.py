from pathlib import Path
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
def sub(s):
 for a,b in [('QuantumSupportObservation','ElectroweakMeasured'),('quantumobservation1055','electroweak1056'),('Program1055','Program1056'),('Empirical1055','Empirical1056'),('quantum_support_uncertainty_empirical_v1','electroweak_measured_value_successor_v1'),('quantum_support_uncertainty_validation_v1','electroweak_measured_value_successor_validation_v1'),('quantum_support_uncertainty_empirical_validator_v1','electroweak_measured_value_successor_validator_v1'),('QuantumSupportUncertaintyValidator','ElectroweakMeasuredValueSuccessorValidator'),('SFT-PHYS-VALIDATION-QUANTUM-SUPPORT-UNCERTAINTY-050','SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053'),("'quantumobservation',1055","'electroweak',1056")]:s=s.replace(a,b)
 s=s.replace('exec(Path("work/electroweak1056_spec_loader.py").read_text())','from sft.physics.electroweak_measured_value_successor_v1 import SPEC')
 return s
for k in ['program','fresh','grammar','independent','empirical','original']:(w/f'check_electroweak1056_{k}.py').write_text(sub((w/f'check_quantumobservation1055_{k}.py').read_text()))
for old,new in [('run_quantumobservation1055_native.py','run_electroweak1056_native.py'),('prepare_quantumobservation1055_empirical_native.py','prepare_electroweak1056_empirical_native.py'),('audit_quantumobservation1055.py','audit_electroweak1056.py')]: (w/new).write_text(sub((w/old).read_text()))
(w/'constants-recovery/ElectroweakMeasuredEmpirical1056.lean').write_text(sub((w/'constants-recovery/QuantumSupportObservationEmpirical1055.lean').read_text()));(r/'ElectroweakMeasuredProgram1056.lean').write_text(sub((r/'QuantumSupportObservationProgram1055.lean').read_text()))
