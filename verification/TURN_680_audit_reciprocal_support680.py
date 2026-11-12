from pathlib import Path
import re,json,subprocess,os
w=Path('work');m='ReciprocalSupport';s=(w/'constants-recovery/SFT/Materials'/ (m+'.lean')).read_text();rows=re.findall(r'^\s*(def|theorem|structure|abbrev) (\w+)',s,re.M);prefix='SFT.Materials.'+m+'.';decl=[prefix+n for k,n in rows]
(w/'AuditReciprocalSupport680.lean').write_text('import SFT.Materials.ReciprocalSupport\n'+'\n'.join('#print axioms '+n for n in decl)+'\n')
env=dict(os.environ,LEAN_PATH=str((w/'constants-recovery/.lake/build/lib/lean').resolve()));p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','work/AuditReciprocalSupport680.lean'],env=env,capture_output=True,text=True);(w/'reciprocal680_proofs_audit.log').write_text(p.stdout+p.stderr);p.check_returncode();assert all("'"+n+"' does not depend on any axioms" in p.stdout for n in decl)
cfg=dict(modules=[m],declarations=decl,theorems=[prefix+n for k,n in rows if k=='theorem'],definitions_and_theorems=[prefix+n for k,n in rows if k in ['def','theorem','abbrev']]);(w/'reciprocal680_proofs_config.json').write_text(json.dumps(cfg,indent=2))
program=json.load(open(w/'matreciprocal680_audit_config.json'))
for k in cfg:cfg[k]+=program[k]
(w/'matreciprocal680_combined_config.json').write_text(json.dumps(cfg,indent=2));(w/'matreciprocal680_combined_audit.log').write_text(p.stdout+(w/'matreciprocal680_audit.log').read_text());print('PASS',len(rows),'mathematical;',len(cfg['declarations']),'combined;',len(cfg['theorems']),'theorems')
