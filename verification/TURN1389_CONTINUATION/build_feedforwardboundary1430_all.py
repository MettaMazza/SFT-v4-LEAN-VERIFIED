# Single owner for this existing build; concurrent callers reuse its current results.
import fcntl as _fl, json as _js, hashlib as _hh
from pathlib import Path as _P
_build_lock=_P('work/feedforwardboundary1430_build.lock').open('a')
_fl.flock(_build_lock,_fl.LOCK_EX)
def _current(suffix):
 p=_P('work/feedforwardboundary1430_'+suffix+'_report.json')
 if not p.exists(): return False
 a=_js.loads(p.read_text())
 if a.get('status')!='PASS': return False
 for k,h in a.get('source_sha256',{}).items():
  f=_P('work/turn1064_recovery')/(k if k.startswith('SFT/') else 'SFT/Consciousness/'+k+'.lean')
  if not f.exists() or _hh.sha256(f.read_bytes()).hexdigest()!=h:return False
 return True
if _current('full_entry_audit') and _current('experiment'):
 print('REUSE existing feedforwardboundary1430 build/audit/experiment',flush=True)
 raise SystemExit(0)
import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
for module in ['FeedforwardBoundary', 'FeedforwardBoundaryGrammar', 'FeedforwardBoundaryEvidence', 'FeedforwardBoundaryExperiment', 'FeedforwardBoundaryValidation']:
 p=root/'SFT/Consciousness'/f'{module}.lean'
 with open('work/'+module+'1374_build.log','w') as log:
  native=Path('work/feedforwardboundary1430_programme_native1381');native.mkdir(exist_ok=True)
  generated=native/('SFT.Consciousness.'+module+'.c');before=hashlib.sha256(p.read_bytes()).hexdigest()
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-R',str(p.resolve().parents[2]),'-o',str(p.with_suffix('.olean')),'-c',str(generated),str(p.resolve())],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
  assert hashlib.sha256(p.read_bytes()).hexdigest()==before
  (native/('SFT.Consciousness.'+module+'.c.source.json')).write_text(json.dumps({'source':before,'generated':hashlib.sha256(generated.read_bytes()).hexdigest()}))
 print(module+' compiled',flush=True)
mods=['StructuralModel','Source','FeedforwardBoundary','FeedforwardBoundaryGrammar','FeedforwardBoundaryEvidence','FeedforwardBoundaryExperiment','FeedforwardBoundaryValidation'];names=[]
for m in mods:
 s=(root/'SFT/Consciousness'/f'{m}.lean').read_text()
 names += ['SFT.Consciousness.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)]
p=Path('work/ObservationFullAudit1430.lean');p.write_text('\n'.join('import SFT.Consciousness.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/feedforwardboundary1430_full_entry_audit.log','w') as log:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192',str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=Path('work/feedforwardboundary1430_full_entry_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names),(len(names),s[-3000:]);assert 'depends on axioms'not in s
Path('work/feedforwardboundary1430_full_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((root/'SFT/Consciousness'/f'{m}.lean').read_bytes()).hexdigest() for m in mods}},indent=2)+'\n')
print('PASS '+str(len(names))+' empty-axiom declarations',flush=True)


subprocess.run(["python3","work/check_feedforwardboundary1430_experiment.py"],check=True)
