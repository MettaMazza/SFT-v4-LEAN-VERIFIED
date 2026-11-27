import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
import time
while True:
 audit=Path('work/earth1448_structural_entry_audit_report.json')
 if audit.exists():
  a=json.loads(audit.read_text())
  if a['status']=='PASS' and all(hashlib.sha256((root/'SFT/EarthEnvironment'/(m+'.lean')).read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items()):break
 time.sleep(15)
for module in ['EarthAtmosphericRadiativeBudget','EarthAtmosphericRadiativeBudgetGrammar','EarthAtmosphericRadiativeBudgetEvidence']:
 p=root/'SFT/EarthEnvironment'/f'{module}.lean'
 with open('work/'+module+'1486_build.log','w') as log:
  gen=Path('work/airradiationresolved1542_native')/('SFT.EarthEnvironment.'+module+'.c')
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-o',str(p.with_suffix('.olean')),'-c',str(gen),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
  gen.with_name(gen.name+'.source.json').write_text(json.dumps({'source':hashlib.sha256(p.read_bytes()).hexdigest(),'generated':hashlib.sha256(gen.read_bytes()).hexdigest()}))
 print(module+' compiled',flush=True)
mods=['EarthAtmosphericRadiativeBudget','EarthAtmosphericRadiativeBudgetGrammar','EarthAtmosphericRadiativeBudgetEvidence'];names=[]
for m in mods:
 s=(root/'SFT/EarthEnvironment'/f'{m}.lean').read_text()
 names += ['SFT.EarthEnvironment.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)]
p=Path('work/ObservationCoreAudit1486.lean');p.write_text('\n'.join('import SFT.EarthEnvironment.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/earthairradiation1486_core_entry_audit.log','w') as log:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192',str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=Path('work/earthairradiation1486_core_entry_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names),(len(names),s[-3000:]);assert 'depends on axioms'not in s
Path('work/earthairradiation1486_core_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((root/'SFT/EarthEnvironment'/f'{m}.lean').read_bytes()).hexdigest() for m in mods}},indent=2)+'\n')
print('PASS '+str(len(names))+' empty-axiom declarations',flush=True)


subprocess.run(["python3","work/build_earthairradiation1542_rest.py"],check=True)
