from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
entries=[('heatwork1331', 'SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004', 'HeatWorkTransferPartitionValidation'), ('entropy1332', 'SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005', 'EntropyMultiplicityCorrespondenceValidation'), ('enthalpy1333', 'SFT-CHEM-ENTHALPY-EQUIVALENT-STATE-006', 'EnthalpyEquivalentStateValidation'), ('freeenergy1334', 'SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007', 'FreeEnergyEquivalentDirectionValidation'), ('potential1335', 'SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008', 'ComponentExchangeValidation'), ('activity1336', 'SFT-CHEM-ACTIVITY-NONIDEAL-COMPOSITION-009', 'SolutionActivityValidation')]
for tag,cid,last in entries:
 while True:
  c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
  if x['lean_status']=='complete':break
  import ast,re
  original=(w/('register_'+tag+'_1413.py')).read_text()
  names=ast.literal_eval(re.search(r'reports=(\[[^\n]+\])',original)[1]) + [tag+'_independent_report.json']
  if all((w/n).exists() for n in names) and all(by[d]['lean_status']=='complete' for d in x['v3_registration']['dependencies']):
   a=json.loads((w/(tag+'_full_audit_report.json')).read_text())
   if 'SFT/Chemistry/'+last+'.lean' in a.get('source_sha256',{}):
    print('REGISTER '+cid,flush=True);subprocess.run(['python3',str(w/('register_'+tag+'_1413.py'))],check=True);break
  time.sleep(15)
print('Chemistry source-bound registration batch finished',flush=True)
