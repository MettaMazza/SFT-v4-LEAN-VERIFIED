import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
for module in ['MolecularMeasurement','MolecularMeasurementGrammar','MolecularMeasurementEvidence']:
 p=root/'SFT/Chemistry'/f'{module}.lean'
 with open('work/'+module+'1235_build.log','w') as log:
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 print(module+' compiled',flush=True)
mods=['MolecularMeasurement','MolecularMeasurementGrammar','MolecularMeasurementEvidence'];names=[]
for m in mods:
 s=(root/'SFT/Chemistry'/f'{m}.lean').read_text()
 names += ['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)]
p=Path('work/MolecularMeasurementAudit1235.lean');p.write_text('\n'.join('import SFT.Chemistry.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/quantum1235_entry_audit.log','w') as log:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192',str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=Path('work/quantum1235_entry_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names),(len(names),s[-3000:]);assert 'depends on axioms'not in s
Path('work/quantum1235_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((root/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest() for m in mods}},indent=2)+'\n')
print('PASS '+str(len(names))+' empty-axiom declarations',flush=True)
p=subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','--run','work/MolecularMeasurementCoreProgram1235.lean'],env=env,capture_output=True,text=True)
Path('work/quantum1235_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:]
actual=json.loads(p.stdout);expected=json.loads(Path('work/quantum1235_core_expected.json').read_text());assert actual==expected
Path('work/quantum1235_core_report.json').write_text(json.dumps(dict(status='PASS',original_cases=len(expected),all_fields_match=True,source_sha256=hashlib.sha256((root/'SFT/Chemistry/MolecularMeasurement.lean').read_bytes()).hexdigest()),indent=2)+'\n')
print('PASS14 original constructor/reconstruction cases',flush=True)
