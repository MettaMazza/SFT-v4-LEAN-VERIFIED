from pathlib import Path
import json,hashlib,re,subprocess,os
w=Path('work').resolve();r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/';assert 'Build completed successfully' in (w/'selfsource904_canonical_build.log').read_text();mods=['GravitySelfSource']+['GravitySelfSourceEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']];cfg={'modules':mods,'source_sha256':{},'declarations':[],'theorems':[],'definitions_and_theorems':[]};lines=[]
for m in mods:
 p=r/'SFT/Physics'/f'{m}.lean';assert p.read_bytes()==(c/'SFT/Physics'/p.name).read_bytes();cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest();lines.append('import SFT.Physics.'+m)
 for kind,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',p.read_text(),re.M):
  full='SFT.Physics.'+m+'.'+name;cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(full)
(w/'selfsource904_proofs_config.json').write_text(json.dumps(cfg,indent=2));p=r/'LorentzFullAudit904.lean';p.write_text('\n'.join(lines+['#print axioms '+n for n in cfg['declarations']])+'\n')
with (w/'selfsource904_audit.log').open('w') as f:subprocess.run([tc+'lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),stdout=f,stderr=subprocess.STDOUT,check=True)
a=(w/'selfsource904_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in a for n in cfg['declarations']);print('PASS',len(cfg['declarations']),'empty axioms',flush=True)
with (w/'selfsource904_native_prepare.log').open('w') as f:subprocess.run(['python3',str(w/'prepare_selfsource_native904.py')],stdout=f,stderr=subprocess.STDOUT,check=True)
with (w/'selfsource904_program_run.log').open('w') as f:subprocess.run(['python3',str(w/'check_selfsource_program904.py'),str(w/'circuit866_native_objects/SelfSourceProgram904')],stdout=f,stderr=subprocess.STDOUT,check=True)
with (w/'selfsource904_independent_run.log').open('w') as f:subprocess.run(['python3',str(w/'check_selfsource_independent904.py')],stdout=f,stderr=subprocess.STDOUT,check=True)
actual=json.load(open(w/'selfsource_program904_output.json'));original=json.load(open(w/'selfsource904_original_program.json'));assert actual==original
p=w/'selfsource_program904_report.json';report=json.load(open(p));report['fresh_original_package_output_also_matches']=True;p.write_text(json.dumps(report,indent=2));print('PASS complete original program and independent validator',flush=True)
