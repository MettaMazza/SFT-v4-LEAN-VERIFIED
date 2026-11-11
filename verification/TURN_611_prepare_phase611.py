from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery/SFT/Chemistry'
for m in ['PhaseGrammar','PhaseEvidence','PhaseExperiment','PhaseValidation']:
 assert not (r/(m+'.lean')).exists(),m
s=(w/'direction_spec610.py').read_text().replace("['THERMOCHEMISTRY_BLUEPRINTS'][1]","['THERMOCHEMISTRY_BLUEPRINTS'][2]");(w/'phase_spec611.py').write_text(s)
for a,b in [('prepare_direction_grammar610.py','prepare_phase_grammar611.py'),('prepare_direction_experiment610.py','prepare_phase_experiment611.py'),('audit_direction610.py','audit_phase611.py'),('run_direction610.py','run_phase611.py'),('check_direction_validation610.py','check_phase_validation611.py'),('check_chemistry_independent610.py','check_chemistry_independent611.py')]:
 s=(w/a).read_text().replace('ReactionDirection','ChemicalPhase').replace('Direction','Phase').replace('direction','phase').replace('610','611').replace('SFT-CHEM-THERMO-DIRECTION-001','SFT-CHEM-PHASE-CHEMICAL-001')
 (w/b).write_text(s)
for f in ['prepare_phase_grammar611.py','prepare_phase_experiment611.py']:subprocess.run(['python3',str(w/f)],check=True)
s=(r/'PhaseEvidence.lean').read_text().replace('with carrier :=','with region :=');(r/'PhaseEvidence.lean').write_text(s)
