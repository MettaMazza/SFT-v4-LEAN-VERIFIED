from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery/SFT/Chemistry'
for m in ['DirectionGrammar','DirectionEvidence','DirectionExperiment','DirectionValidation']:
 assert not (r/(m+'.lean')).exists(),m
s=(w/'thermochemistry_spec609.py').read_text().replace("['THERMOCHEMISTRY_BLUEPRINTS'][0]","['THERMOCHEMISTRY_BLUEPRINTS'][1]");(w/'direction_spec610.py').write_text(s)
for a,b in [('prepare_thermochemistry_grammar609.py','prepare_direction_grammar610.py'),('prepare_thermochemistry_experiment609.py','prepare_direction_experiment610.py'),('audit_thermochemistry609.py','audit_direction610.py'),('run_thermochemistry609.py','run_direction610.py'),('check_thermochemistry_validation609.py','check_direction_validation610.py'),('check_chemistry_independent609.py','check_chemistry_independent610.py')]:
 s=(w/a).read_text().replace('ReactionThermochemistry','ReactionDirection').replace('thermochemistry','direction').replace('Thermochemistry','Direction').replace('609','610').replace('SFT-CHEM-THERMO-REACTION-001','SFT-CHEM-THERMO-DIRECTION-001').replace('DirectionSeal','ThermochemistrySeal')
 if a.startswith('audit_'):s=s.replace(",'ThermochemistrySeal','ThermochemistrySealInputs'",'')
 if a.startswith('run_'):s=s.replace("for m in ['DirectionGrammar','DirectionEvidence','ThermochemistrySeal','ThermochemistrySealInputs']:","for m in ['DirectionGrammar','DirectionEvidence']:")
 (w/b).write_text(s)
for f in ['prepare_direction_grammar610.py','prepare_direction_experiment610.py']:subprocess.run(['python3',str(w/f)],check=True)
s=(r/'DirectionEvidence.lean').read_text().replace('with carrier :=','with paths :=');(r/'DirectionEvidence.lean').write_text(s)
