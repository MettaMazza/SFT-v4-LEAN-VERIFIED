from pathlib import Path
import json,hashlib,re,subprocess,os
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');mods=['TerminalCKM','TerminalQuarkRoots','TerminalCKMComparison','TerminalMatterRecords','TerminalCKMMeasurement']+['TerminalCKMEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]+['TerminalCKMEmpirical'+x for x in ['Witnesses','Grammar','Evidence','Experiment','Validation']]
assert 'Build completed successfully' in (w/'terminalckm938_empirical_build.log').read_text();cfg={'modules':mods,'source_sha256':{},'declarations':[],'theorems':[],'definitions_and_theorems':[]};lines=[]
for m in mods:
 p=r/'SFT/Physics'/f'{m}.lean';assert p.read_bytes()==(c/'SFT/Physics'/p.name).read_bytes();cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest();lines.append('import SFT.Physics.'+m)
 for kind,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',p.read_text(),re.M):
  full='SFT.Physics.'+m+'.'+name;cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(full)
p=r/'TerminalCKMFullAudit938.lean';p.write_text('\n'.join(lines+['#print axioms '+n for n in cfg['declarations']])+'\n');a=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),text=True);(w/'terminalckm938_all_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in cfg['declarations']),a;(w/'terminalckm938_all_proofs_config.json').write_text(json.dumps(cfg,indent=2));print('PASS',len(cfg['declarations']),'empty axioms across all original law,interval,record,classification and empirical modules')
