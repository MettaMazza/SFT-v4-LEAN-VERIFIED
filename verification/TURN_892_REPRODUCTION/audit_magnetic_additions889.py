from pathlib import Path
import json,re,hashlib,subprocess,os
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cfg=json.load(open(w/'magnetic889_program_config_before_additions.json'));old=(w/'magnetic889_program_audit_before_additions.log').read_text();assert 'Build completed successfully' in (w/'magnetic889_additions_build.log').read_text()
for m,h in cfg['source_sha256'].items():
 assert hashlib.sha256((r/'SFT/Physics'/f'{m}.lean').read_bytes()).hexdigest()==h
for name in cfg['declarations']:assert "'"+name+"' does not depend on any axioms" in old
mods=['MagneticSquare','MagneticCovariance','MagneticSourceProofs'];names=[]
for m in mods:
 p=r/'SFT/Physics'/f'{m}.lean';data=p.read_bytes();assert data==(c/'SFT/Physics'/p.name).read_bytes();cfg['modules'].append(m);cfg['source_sha256'][m]=hashlib.sha256(data).hexdigest()
 for kind,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',data.decode(),re.M):
  full='SFT.Physics.'+m+'.'+name;names.append(full);cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(full)
p=r/'MagneticAdditionsAudit889.lean';p.write_text('\n'.join(['import SFT.Physics.'+m for m in mods]+['#print axioms '+n for n in names])+'\n')
with (w/'magnetic889_additions_audit.log').open('w') as f:subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p.resolve())],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),stdout=f,stderr=subprocess.STDOUT,check=True)
a=(w/'magnetic889_additions_audit.log').read_text();assert all("'"+name+"' does not depend on any axioms" in a for name in names)
(w/'magnetic889_audit.log').write_text(old+'\n'+a);(w/'magnetic889_proofs_config.json').write_text(json.dumps(cfg,indent=2))
(w/'magnetic889_unchanged_program_reuse.json').write_text(json.dumps(dict(status='PASS',original_source_sha256=json.load(open(w/'magnetic889_program_config_before_additions.json'))['source_sha256'],basis='Original operation,witnesses,grammar,controls and evidence unchanged byte-for-byte;retain full source/native program and4 independent-validator cases. New modules contain source-bound proof additions.',added_modules=mods,added_declarations=names),indent=2));print('PASS',len(names),'new declarations;',len(cfg['declarations']),'total;original program evidence retained')
