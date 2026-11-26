# Reuse the existing independent build instead of overlapping it.
import os as _build_os, time as _build_time, json as _build_json, hashlib as _build_hash
from pathlib import Path as _BuildPath
while True:
 try: _build_os.kill(68362,0)
 except ProcessLookupError: break
 _build_time.sleep(2)
def _existing_build_current(_suffix):
 _path=_BuildPath('work/identitycontinuity1409_'+_suffix+'_report.json')
 if not _path.exists(): return False
 _report=_build_json.loads(_path.read_text())
 if _report.get('status')!='PASS': return False
 for _key,_digest in _report.get('source_sha256',{}).items():
  _file=_BuildPath('work/turn1064_recovery')/(_key if _key.startswith('SFT/') else 'SFT/Consciousness/'+_key+'.lean')
  if not _file.exists() or _build_hash.sha256(_file.read_bytes()).hexdigest()!=_digest: return False
 return True
if _existing_build_current('full_entry_audit') and _existing_build_current('experiment'):
 print('REUSE completed independent identitycontinuity1409 build/audit/experiment',flush=True)
 raise SystemExit(0)
import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
for module in ['IdentityContinuity', 'IdentityContinuityGrammar', 'IdentityContinuityEvidence', 'IdentityContinuityExperiment', 'IdentityContinuityValidation']:
 p=root/'SFT/Consciousness'/f'{module}.lean'
 with open('work/'+module+'1374_build.log','w') as log:
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 print(module+' compiled',flush=True)
mods=['StructuralModel','Source','IdentityContinuity','IdentityContinuityGrammar','IdentityContinuityEvidence','IdentityContinuityExperiment','IdentityContinuityValidation'];names=[]
for m in mods:
 s=(root/'SFT/Consciousness'/f'{m}.lean').read_text()
 names += ['SFT.Consciousness.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)]
p=Path('work/ObservationFullAudit1409.lean');p.write_text('\n'.join('import SFT.Consciousness.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/identitycontinuity1409_full_entry_audit.log','w') as log:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192',str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=Path('work/identitycontinuity1409_full_entry_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names),(len(names),s[-3000:]);assert 'depends on axioms'not in s
Path('work/identitycontinuity1409_full_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((root/'SFT/Consciousness'/f'{m}.lean').read_bytes()).hexdigest() for m in mods}},indent=2)+'\n')
print('PASS '+str(len(names))+' empty-axiom declarations',flush=True)


subprocess.run(["python3","work/check_identitycontinuity1409_experiment.py"],check=True)
