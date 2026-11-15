from pathlib import Path
import re,json,subprocess,hashlib,os,shutil
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cfg=json.load(open(w/'quantumgravity1000_all_proofs_config.json'))
for m,h in cfg['source_sha256'].items():assert hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest()==h,m
m='FiniteQuantumGravityGeneral';p=r/f'SFT/Physics/{m}.lean';s=p.read_text();names=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)];f=w/'quantumgravity1000_general_audit.lean';f.write_text('import SFT.Physics.'+m+'\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(f)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'quantumgravity1000_general_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
cfg['modules'].append(m);cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest()
for key in ['declarations','theorems','definitions_and_theorems']:cfg[key]+=names
shutil.copy2(p,w/'constants-recovery/SFT/Physics'/p.name);(w/'quantumgravity1000_complete_proofs_config.json').write_text(json.dumps(cfg,indent=2));(w/'quantumgravity1000_complete_audit.log').write_text((w/'quantumgravity1000_all_audit.log').read_text()+'\n'+x.stdout);print('PASS',len(names),'new;',len(cfg['declarations']),'emptyaxiomdeclarations')
