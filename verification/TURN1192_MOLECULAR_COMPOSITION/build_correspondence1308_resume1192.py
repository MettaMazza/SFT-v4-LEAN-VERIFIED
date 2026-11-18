import os,subprocess,json,re,hashlib
from pathlib import Path
w=Path('work');root=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']),LEAN_NUM_THREADS='1')
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean');cmd=['python3','work/run_lean_guarded.py',lean,'-j1','-M8192'];mods=['MolecularCorrespondence','MolecularCorrespondenceDerivation','MolecularCorrespondenceGrammar','MolecularCorrespondenceEvidence'];names=[]
# Reuse this exact completed build/audit/source-output receipt when the queued
# continuation reaches it; changes invalidate reuse rather than refreshing it.
existing=w/'correspondence1308_full_audit_report.json'
core=w/'correspondence1308_core_report.json'
if existing.exists() and core.exists():
 a=json.loads(existing.read_text());c=json.loads(core.read_text())
 actual={str(Path('SFT/Chemistry')/(m+'.lean')):hashlib.sha256((root/'SFT/Chemistry'/(m+'.lean')).read_bytes()).hexdigest()for m in mods}
 if a.get('status')==c.get('status')=='PASS' and a.get('source_sha256')==c.get('source_sha256')==actual:
  assert json.loads((w/'correspondence1308_core_output.json').read_text())==json.loads((w/'correspondence1308_core_expected.json').read_text())
  assert (w/'correspondence1308_full_audit.log').read_text().count('does not depend on any axioms')==a['count']
  print('Reused current four-module build,empty-axiom audit and complete original core-output equality',flush=True)
  raise SystemExit(0)
for module in mods[3:]:
 p=root/'SFT/Chemistry'/f'{module}.lean'
 with(w/(module+'1308_build.log')).open('w')as log:subprocess.run(cmd+['-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 names+=['SFT.Chemistry.'+module+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',p.read_text(),re.M)]
 print(module+' compiled',flush=True)
names=['SFT.Chemistry.'+m+'.'+n for m in mods for n in re.findall(r'^(?:def|theorem)\s+(\w+)',(root/'SFT/Chemistry'/(m+'.lean')).read_text(),re.M)]
p=w/'MolecularCorrespondenceAudit1308.lean';p.write_text(''.join('import SFT.Chemistry.'+m+'\n'for m in mods)+''.join('#print axioms '+n+'\n'for n in names))
with(w/'correspondence1308_full_audit.log').open('w')as log:subprocess.run(cmd+[str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=(w/'correspondence1308_full_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names);assert 'depends on axioms:'not in s
hashes={str(Path('SFT/Chemistry')/(m+'.lean')):hashlib.sha256((root/'SFT/Chemistry'/(m+'.lean')).read_bytes()).hexdigest()for m in mods}
(w/'correspondence1308_full_audit_report.json').write_text(json.dumps(dict(status='PASS',count=len(names),declarations=names,source_sha256=hashes),indent=2)+'\n');print('PASS',len(names),'empty-axiom declarations',flush=True)
with(w/'correspondence1308_core_output.json').open('w')as out,(w/'correspondence1308_core_execution.log').open('w')as err:subprocess.run(cmd+['--run','work/MolecularCorrespondenceCoreProgram1308.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'correspondence1308_core_output.json').read_text());e=json.loads((w/'correspondence1308_core_expected.json').read_text());assert a==e,[(i,x,y)for i,(x,y)in enumerate(zip(a,e))if x!=y]
(w/'correspondence1308_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(a),source_sha256=hashes,all_certificate_fields_and_guards=True),indent=2)+'\n');print('PASS original',len(a),'full certificate/guard cases',flush=True)
