from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery/SFT/Chemistry'
for m in ['PhotoGrammar','PhotoEvidence','PhotoExperiment','PhotoValidation']:
 assert not (r/(m+'.lean')).exists(),m
s=(w/'solution_spec612.py').read_text().replace("['THERMOCHEMISTRY_BLUEPRINTS'][3]","['THERMOCHEMISTRY_BLUEPRINTS'][4]");(w/'photo_spec613.py').write_text(s)
for a,b in [('prepare_solution_grammar612.py','prepare_photo_grammar613.py'),('prepare_solution_experiment612.py','prepare_photo_experiment613.py'),('audit_solution612.py','audit_photo613.py'),('run_solution612.py','run_photo613.py'),('check_solution_validation612.py','check_photo_validation613.py'),('check_chemistry_independent612.py','check_chemistry_independent613.py')]:
 s=(w/a).read_text().replace('SolutionEquilibrium','Photochemistry').replace('Solubility','Photo').replace('Solution','Photo').replace('solution','photo').replace('612','613').replace('SFT-CHEM-SOLUTION-EQUILIBRIUM-001','SFT-CHEM-PHOTOCHEM-001')
 (w/b).write_text(s)
for f in ['prepare_photo_grammar613.py','prepare_photo_experiment613.py']:subprocess.run(['python3',str(w/f)],check=True)
s=(r/'PhotoEvidence.lean').read_text().replace('with carrier :=','with radiation :=');(r/'PhotoEvidence.lean').write_text(s)
