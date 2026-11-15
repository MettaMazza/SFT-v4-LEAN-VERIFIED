from pathlib import Path
import re,json,hashlib,subprocess,os,shutil
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cfg=json.load(open(w/'lattice998_complete_proofs_config.json'))
for m,h in cfg['source_sha256'].items():assert hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest()==h,m
mods=['LatticeOperatorBoundary','LatticeOperatorCycleCounts','LatticeOperatorCycle'];ns=[];ths=[]
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';s=p.read_text();assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M);names=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];ns+=names;ths+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)];cfg['modules'].append(m);cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest();shutil.copy2(p,w/'constants-recovery/SFT/Physics'/p.name)
p=w/'lattice999_derivations_audit.lean';p.write_text(''.join('import SFT.Physics.'+m+'\n' for m in mods)+''.join('#print axioms '+n+'\n' for n in ns));x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'lattice999_derivations_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(ns),x.stdout
cfg['declarations']+=ns;cfg['definitions_and_theorems']+=ns;cfg['theorems']+=ths;(w/'lattice999_all_proofs_config.json').write_text(json.dumps(cfg,indent=2));(w/'lattice999_all_audit.log').write_text((w/'lattice998_complete_audit.log').read_text()+'\n'+x.stdout);print('PASS',len(ns),'new declarations;',len(cfg['declarations']),'total empty axioms; prior evidence hash-matched and retained')
