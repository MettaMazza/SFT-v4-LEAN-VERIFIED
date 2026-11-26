import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
for module in ['MolecularElectronAffinityExperiment','MolecularElectronAffinitySource','MolecularElectronAffinityPrediction','MolecularElectronAffinityValidation']:
 p=root/'SFT/Chemistry'/f'{module}.lean'
 paired=Path('work/electronaffinity1321_native1392');saved_c=paired/('SFT.Chemistry.'+module+'.c');stamp=paired/('SFT.Chemistry.'+module+'.c.source.json')
 if p.with_suffix('.olean').exists()and saved_c.exists()and stamp.exists():
  saved=json.loads(stamp.read_text())
  if saved=={'source':hashlib.sha256(p.read_bytes()).hexdigest(),'generated':hashlib.sha256(saved_c.read_bytes()).hexdigest()}:
   print('REUSE paired module '+module,flush=True);continue
 with open('work/'+module+'1321_build.log','w') as log:
  native=Path('work/electronaffinity1321_native1392');native.mkdir(exist_ok=True)
  generated=native/('SFT.Chemistry.'+module+'.c');before=hashlib.sha256(p.read_bytes()).hexdigest()
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-R',str(p.resolve().parents[2]),'-o',str(p.with_suffix('.olean')),'-c',str(generated),str(p.resolve())],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
  assert hashlib.sha256(p.read_bytes()).hexdigest()==before
  (native/('SFT.Chemistry.'+module+'.c.source.json')).write_text(json.dumps({'source':before,'generated':hashlib.sha256(generated.read_bytes()).hexdigest()}))
 print(module+' compiled',flush=True)
mods=['MolecularElectronAffinity','MolecularElectronAffinityGrammar','MolecularElectronAffinityEvidence','MolecularElectronAffinityExperiment','MolecularElectronAffinitySource','MolecularElectronAffinityPrediction','MolecularElectronAffinityValidation'];names=[]
for m in mods:
 s=(root/'SFT/Chemistry'/f'{m}.lean').read_text()
 names += ['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)]
p=Path('work/MolecularElectronAffinityAudit1321.lean');p.write_text('\n'.join('import SFT.Chemistry.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/electronaffinity1321_entry_audit.log','w') as log:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192',str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=Path('work/electronaffinity1321_entry_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names),(len(names),s[-3000:]);assert 'depends on axioms'not in s
Path('work/electronaffinity1321_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((root/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest() for m in mods}},indent=2)+'\n')
print('PASS '+str(len(names))+' empty-axiom declarations',flush=True)

a=json.loads(Path('work/electronaffinity1321_entry_audit_report.json').read_text())
a['source_sha256']={'SFT/Chemistry/'+m+'.lean':h for m,h in a['source_sha256'].items()}
Path('work/electronaffinity1321_full_audit_report.json').write_text(json.dumps(a,indent=2)+'\n')
