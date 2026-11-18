import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','11575'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'toxicity1276_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['efficacy1277', 'Efficacy', 'SFT-MED-EFFICACY-001'], ['effectiveness1278', 'Effectiveness', 'SFT-MED-EFFECTIVENESS-001'], ['safety1279', 'SafetyEvidence', 'SFT-MED-SAFETY-001'], ['benefitharm1280', 'BenefitHarm', 'SFT-MED-BENEFIT-HARM-001'], ['absolute1281', 'AbsoluteRelativeEffect', 'SFT-MED-ABSOLUTE-RELATIVE-EFFECT-001'], ['heterogeneity1282', 'TreatmentHeterogeneity', 'SFT-MED-TREATMENT-HETEROGENEITY-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
