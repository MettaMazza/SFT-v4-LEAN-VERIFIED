import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
import time
while True:
 ready=True
 for tag in ['earth1448_source','earthinternalheat1467_core']:
  ap=Path('work/'+tag+'_entry_audit_report.json')
  if not ap.exists():ready=False;continue
  a=json.loads(ap.read_text())
  ready &= a['status']=='PASS' and all(hashlib.sha256((root/'SFT/EarthEnvironment'/(m+'.lean')).read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items())
 if ready:break
 time.sleep(15)
for module in ['EarthInternalHeatExperiment','EarthInternalHeatValidation']:
 p=root/'SFT/EarthEnvironment'/f'{module}.lean'
 with open('work/'+module+'1467_build.log','w') as log:
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 print(module+' compiled',flush=True)
mods=['StructuralModel','Source','EarthInternalHeat','EarthInternalHeatGrammar','EarthInternalHeatEvidence','EarthInternalHeatExperiment','EarthInternalHeatValidation'];names=[]
for m in mods:
 s=(root/'SFT/EarthEnvironment'/f'{m}.lean').read_text()
 names += ['SFT.EarthEnvironment.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)]
p=Path('work/EarthFullAudit1467.lean');p.write_text('\n'.join('import SFT.EarthEnvironment.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/earthinternalheat1467_full_entry_audit.log','w') as log:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192',str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=Path('work/earthinternalheat1467_full_entry_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names),(len(names),s[-3000:]);assert 'depends on axioms'not in s
Path('work/earthinternalheat1467_full_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((root/'SFT/EarthEnvironment'/f'{m}.lean').read_bytes()).hexdigest() for m in mods}},indent=2)+'\n')
print('PASS '+str(len(names))+' empty-axiom declarations',flush=True)


