from pathlib import Path
import json,re,hashlib,subprocess,shutil,os
w=Path('work').resolve();r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/';cfg=json.load(open(w/'freephase883_proofs_config.json'));cfg.update(declarations=[],theorems=[],definitions_and_theorems=[]);lines=[]
for m in cfg['modules']:
 p=r/'SFT/Physics'/f'{m}.lean';data=p.read_bytes();target=c/'SFT/Physics'/p.name
 if target.read_bytes()!=data:shutil.copy2(p,target)
 cfg['source_sha256'][m]=hashlib.sha256(data).hexdigest();lines.append('import SFT.Physics.'+m)
 for kind,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',data.decode(),re.M):
  full='SFT.Physics.'+m+'.'+name;cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(full)
(w/'freephase883_proofs_config.json').write_text(json.dumps(cfg,indent=2));(r/'FreePhaseFullAudit883.lean').write_text('\n'.join(lines+['#print axioms '+n for n in cfg['declarations']])+'\n')
shutil.copy2(w/'freephase883_canonical_build.log',w/'freephase883_initial_canonical_build.log')
with (w/'freephase883_canonical_build.log').open('w') as f:subprocess.run([tc+'lake','build','SFT.Physics.FreePhaseEvidence'],cwd=c,env=dict(os.environ,LEAN_NUM_THREADS='1'),stdout=f,stderr=subprocess.STDOUT,check=True)
print('Final source-bound canonical build PASS',flush=True)
with (w/'freephase883_audit.log').open('w') as f:subprocess.run([tc+'lean','-j1',str(r/'FreePhaseFullAudit883.lean')],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),stdout=f,stderr=subprocess.STDOUT,check=True)
a=(w/'freephase883_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in a for n in cfg['declarations']);print('PASS',len(cfg['declarations']),'empty axioms',flush=True)
with (w/'freephase883_native_prepare.log').open('w') as f:subprocess.run(['python3',str(w/'prepare_freephase_native883.py')],stdout=f,stderr=subprocess.STDOUT,check=True)
with (w/'freephase883_program_run.log').open('w') as f:subprocess.run(['python3',str(w/'check_freephase_program883.py'),str(w/'circuit866_native_objects/FreePhaseProgram883')],stdout=f,stderr=subprocess.STDOUT,check=True)
with (w/'freephase883_independent_run.log').open('w') as f:subprocess.run(['python3',str(w/'check_freephase_independent883.py')],stdout=f,stderr=subprocess.STDOUT,check=True)
actual=json.load(open(w/'freephase_program883_output.json'));original=json.load(open(w/'freephase883_original_program.json'));assert actual==original
p=w/'freephase_program883_report.json';report=json.load(open(p));report['fresh_original_package_output_also_matches']=True;p.write_text(json.dumps(report,indent=2));print('PASS full original program and independent validator',flush=True)
