from pathlib import Path
import json,subprocess,hashlib,sys
w=Path('work');r=w/'turn1064_recovery';slot=int(sys.argv[1]);plan=json.loads((w/'consciousness65_1314_plan.json').read_text());remaining=[];start=False
for row in plan:
 if row['module']=='DeterminismSelfOpacity':start=True
 if start:remaining.append(row)
def current_report(path):
 if not path.exists():return False
 a=json.loads(path.read_text())
 if a.get('status')!='PASS':return False
 for k,h in a.get('source_sha256',{}).items():
  p=r/k if k.startswith('SFT/')else r/'SFT/Consciousness'/(k+'.lean')
  if not p.exists()or hashlib.sha256(p.read_bytes()).hexdigest()!=h:return False
 return True
for row in remaining[slot::3]:
 tag=row['scripts'][-1].removeprefix('check_').removesuffix('_empirical.py')
 for script in row['scripts']:
  if script.startswith('build_'):
   if current_report(w/(tag+'_full_entry_audit_report.json')):
    if current_report(w/(tag+'_experiment_report.json')):print('REUSE',script,flush=True);continue
    script='check_'+tag+'_experiment.py'
  elif script.endswith('_program.py'):
   if current_report(w/(tag+'_program_report.json')) and (w/(tag+'_independent_report.json')).exists():print('REUSE',script,flush=True);continue
  elif script.endswith('_empirical.py'):
   if current_report(w/(tag+'_empirical_report.json')):print('REUSE',script,flush=True);continue
  print('RUN',script,flush=True);subprocess.run(['python3',str(w/script)],check=True)
print('Assigned original checks completed',flush=True)
