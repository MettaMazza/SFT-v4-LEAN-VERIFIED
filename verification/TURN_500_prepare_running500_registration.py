from pathlib import Path
import json,re,os,subprocess
rec=Path('work/constants-recovery').resolve()
mods=json.load(open('work/running500_modules.json'))+['RunningConvergencePublicInputs','RunningConvergenceMeasurement','RunningConvergencePrediction','RunningConvergenceValidation','RunningConvergenceMeasurementProofs']
cfg=dict(modules=mods,declarations=[],theorems=[],definitions_and_theorems=[])
for m in mods:
 s=(rec/'SFT/Physics'/f'{m}.lean').read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1]
 for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
  name=ns+'.'+n;cfg['declarations'].append(name)
  if kind=='theorem':cfg['theorems'].append(name)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(name)
for k in ['declarations','theorems','definitions_and_theorems']:cfg[k]=list(dict.fromkeys(cfg[k]))
Path('work/auditrunning500_config.json').write_text(json.dumps({'RunningConvergence':cfg},indent=2))
a=Path('work/Auditrunning500_RunningConvergence.lean');a.write_text('\n'.join('import SFT.Physics.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in cfg['declarations'])+'\n')
env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(rec/'.lake/build/lib/lean'))
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048',str(a)],env=env,capture_output=True,text=True)
Path('work/auditrunning500_RunningConvergence.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,(p.stdout+p.stderr)[-5000:]
for n in cfg['declarations']:assert "'"+n+"' does not depend on any axioms" in p.stdout,n
print('FINAL RUNNING AUDIT PASS',len(cfg['declarations']),len(cfg['theorems']))
p=Path('work/running500_validation_native_build_report.json');v=json.loads(p.read_text());[v.pop(k,None) for k in ['complete_candidates','full_census_blocks','all_cases_per_block']];p.write_text(json.dumps(v,indent=2)+'\n')
