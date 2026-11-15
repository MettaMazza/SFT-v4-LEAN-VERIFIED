from pathlib import Path
import re,subprocess,os,hashlib,json,shutil
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');mods=['LandauerValidation'+s for s in ['Witnesses','Grammar','Evidence','Experiment','Validation']];ns=[];ths=[];sha={}
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';s=p.read_text();assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M);shutil.copy2(p,w/'constants-recovery/SFT/Physics'/p.name);sha[m]=hashlib.sha256(p.read_bytes()).hexdigest()
 namespace=re.search(r'^namespace (\S+)',s,re.M)[1]
 ns.extend(namespace+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M));ths.extend(namespace+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M))
p=w/'landauervalidation994_all_audit.lean';p.write_text('import SFT.Physics.LandauerValidationEvidence\nimport SFT.Physics.LandauerValidationValidation\n'+''.join('#print axioms '+n+'\n' for n in ns));x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'landauervalidation994_all_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(ns),x.stdout[-3000:]
(w/'landauervalidation994_all_proofs_config.json').write_text(json.dumps(dict(modules=mods,declarations=ns,theorems=ths,definitions_and_theorems=ns,source_sha256=sha),indent=2));print('PASS',len(ns),'empty axiom declarations')
