from pathlib import Path
import os,sys,subprocess,json,re,hashlib
w=Path('work');r=(w/'turn1064_recovery').resolve();tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=str(r)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');name=sys.argv[1];native=w/'nonordinary1395_native';native.mkdir(exist_ok=True);mods=['NonordinaryLaws']if name=='core'else(['NonordinaryExternalSource','NonordinaryExternalExperiment','NonordinaryExternalValidation']if name=='external'else[name+'Grammar',name+'Evidence']);H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
for m in mods:
 p=r/'SFT/Consciousness'/(m+'.lean');c=native/('SFT.Consciousness.'+m+'.c');stamp=native/('SFT.Consciousness.'+m+'.c.source.json')
 if p.with_suffix('.olean').exists()and c.exists()and stamp.exists()and json.loads(stamp.read_text())=={'source':H(p),'generated':H(c)}:print('REUSE',m,flush=True);continue
 with(w/(m+'1395_build.log')).open('w')as out:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-R',str(r),'-o',str(p.with_suffix('.olean')),'-c',str(c),str(p)],env=env,stdout=out,stderr=subprocess.STDOUT,check=True)
 stamp.write_text(json.dumps({'source':H(p),'generated':H(c)}));print('BUILT',m,flush=True)
names=[]
for m in mods:
 names+=['SFT.Consciousness.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',(r/'SFT/Consciousness'/(m+'.lean')).read_text(),re.M)]
a=w/(name+'1395Audit.lean');a.write_text('\n'.join('import SFT.Consciousness.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
log=w/(name+'1395_audit.log')
with log.open('w')as out:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192',str(a)],env=env,stdout=out,stderr=subprocess.STDOUT,check=True)
s=log.read_text();assert s.count('does not depend on any axioms')==len(names)and 'depends on axioms'not in s,s[-2500:]
(w/(name+'1395_audit_report.json')).write_text(json.dumps({'status':'PASS','count':len(names),'declarations':names,'source_sha256':{'SFT/Consciousness/'+m+'.lean':H(r/'SFT/Consciousness'/(m+'.lean'))for m in mods}},indent=2)+'\n');print('PASS',name,len(names),'empty-axiom declarations',flush=True)
