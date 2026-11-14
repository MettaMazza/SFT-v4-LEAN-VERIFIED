from pathlib import Path
import json,hashlib,re,subprocess,os
w=Path('work').resolve();r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/';assert 'Build completed successfully' in (w/'terminalproton940_canonical_build.log').read_text();mods=['TerminalProton']+['TerminalProtonEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']];cfg={'modules':mods,'source_sha256':{},'declarations':[],'theorems':[],'definitions_and_theorems':[]};lines=[]
for m in mods:
 p=r/'SFT/Physics'/f'{m}.lean';assert p.read_bytes()==(c/'SFT/Physics'/p.name).read_bytes();cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest();lines.append('import SFT.Physics.'+m)
 for kind,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',p.read_text(),re.M):
  full='SFT.Physics.'+m+'.'+name;cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(full)
(w/'terminalproton940_proofs_config.json').write_text(json.dumps(cfg,indent=2));p=r/'LorentzFullAudit940.lean';p.write_text('\n'.join(lines+['#print axioms '+n for n in cfg['declarations']])+'\n')
with (w/'terminalproton940_audit.log').open('w') as f:subprocess.run([tc+'lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),stdout=f,stderr=subprocess.STDOUT,check=True)
a=(w/'terminalproton940_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in a for n in cfg['declarations']);print('PASS',len(cfg['declarations']),'empty axioms',flush=True)
with (w/'terminalproton940_native_prepare.log').open('w') as f:subprocess.run(['python3',str(w/'prepare_terminalproton_native940.py')],stdout=f,stderr=subprocess.STDOUT,check=True)
with (w/'terminalproton940_program_run.log').open('w') as f:subprocess.run(['python3',str(w/'check_terminalproton_program940.py'),str(w/'circuit866_native_objects/TerminalProtonProgram940')],stdout=f,stderr=subprocess.STDOUT,check=True)
with (w/'terminalproton940_independent_run.log').open('w') as f:subprocess.run(['python3',str(w/'check_terminalproton_independent940.py')],stdout=f,stderr=subprocess.STDOUT,check=True)
actual=json.load(open(w/'terminalproton_program940_output.json'));original=json.load(open(w/'terminalproton940_original_program.json'));assert actual==original
p=w/'terminalproton_program940_report.json';report=json.load(open(p));report['fresh_original_package_output_also_matches']=True;p.write_text(json.dumps(report,indent=2));print('PASS complete original program and independent validator',flush=True)
