from pathlib import Path
import json,hashlib,subprocess,re,os,sys
w=Path('work');r=(w/'constants-recovery').resolve();c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tag,low,n,build=sys.argv[1:];assert 'Build completed successfully' in (w/build).read_text()
mods=['GravityAuthoritativeRecords','GravityAuthoritativeWitnesses']+[tag+x for x in ['Witnesses','Grammar','Evidence','Experiment','Validation']];cfg={'modules':mods,'source_sha256':{},'declarations':[],'theorems':[],'definitions_and_theorems':[]};lines=[]
for m in mods:
 p=r/'SFT/Physics'/f'{m}.lean';s=p.read_text();assert (c/'SFT/Physics'/p.name).read_bytes()==p.read_bytes();cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest();lines.append('import SFT.Physics.'+m)
 for kind,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',s,re.M):
  full='SFT.Physics.'+m+'.'+name;cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(full)
lines+=['#print axioms '+x for x in cfg['declarations']];driver=r/f'{tag}FullAudit{n}.lean';driver.write_text('\n'.join(lines)+'\n');(w/f'{low}{n}_proofs_config.json').write_text(json.dumps(cfg,indent=2))
with (w/f'{low}{n}_audit.log').open('w') as f:subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M12288',str(driver)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),stdout=f,stderr=subprocess.STDOUT,check=True)
audit=(w/f'{low}{n}_audit.log').read_text();assert all("'"+x+"' does not depend on any axioms" in audit for x in cfg['declarations']);print('PASS',len(cfg['declarations']),'empty axiom declarations',flush=True)
print('Audit complete; native checks scheduled separately',flush=True)
