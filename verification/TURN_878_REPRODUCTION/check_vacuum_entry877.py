from pathlib import Path
import json,hashlib,subprocess,re,os,sys
w=Path('work');r=(w/'constants-recovery').resolve();c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tag,low,n,build=sys.argv[1:];assert 'Build completed successfully' in (w/build).read_text()
mods=[tag+x for x in ['', 'Witnesses','Grammar','Controls','Evidence']];cfg={'modules':mods,'source_sha256':{},'declarations':[],'theorems':[],'definitions_and_theorems':[]};lines=[]
for m in mods:
 p=r/'SFT/Physics'/f'{m}.lean';s=p.read_text();assert (c/'SFT/Physics'/p.name).read_bytes()==p.read_bytes();cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest();lines.append('import SFT.Physics.'+m)
 for kind,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',s,re.M):
  full='SFT.Physics.'+m+'.'+name;cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(full)
lines+=['#print axioms '+x for x in cfg['declarations']];driver=r/f'{tag}FullAudit{n}.lean';driver.write_text('\n'.join(lines)+'\n');(w/f'{low}{n}_proofs_config.json').write_text(json.dumps(cfg,indent=2))
with (w/f'{low}{n}_audit.log').open('w') as f:subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M12288',str(driver)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),stdout=f,stderr=subprocess.STDOUT,check=True)
audit=(w/f'{low}{n}_audit.log').read_text();assert all("'"+x+"' does not depend on any axioms" in audit for x in cfg['declarations']);print('PASS',len(cfg['declarations']),'empty axiom declarations',flush=True)
for script in [f'prepare_{low}_native{n}.py',f'check_{low}_program{n}.py',f'check_{low}_independent{n}.py']:
 cmd=['python3',str(w/script)]
 if script==f'check_{low}_program{n}.py':cmd.append(str((w/f'circuit866_native_objects/{tag}Program{n}').resolve()))
 subprocess.run(cmd,check=True)
a=json.loads((w/f'{low}_program{n}_output.json').read_text());b=json.loads((w/f'{low}{n}_original_program.json').read_text());assert a==b
p=w/f'{low}_program{n}_report.json';report=json.loads(p.read_text());report['fresh_original_package_output_also_matches']=True;p.write_text(json.dumps(report,indent=2));print('PASS all source-specific entry checks',flush=True)
