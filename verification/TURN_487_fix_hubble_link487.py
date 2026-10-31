from pathlib import Path
import re,json,subprocess,hashlib
out=Path('work/native486');repairs=[]
for p in sorted(out.glob('Hubble*.c')):
 if p.stem=='HubbleProgram':continue
 s=p.read_text();old='initialize_work_constants_x2drecovery_SFT_Physics_'+p.stem;new='initialize_SFT_Physics_'+p.stem;assert s.count(old)==1,(p,s.count(old));t=s.replace(old,new);repairs.append(dict(module=p.stem,old=old,new=new,before_sha256=hashlib.sha256(s.encode()).hexdigest(),after_sha256=hashlib.sha256(t.encode()).hexdigest()));p.write_text(t)
 subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O3','-c',str(p),'-o',str(p.with_suffix('.o'))],check=True)
Path('work/hubble487_initializer_repairs.json').write_text(json.dumps(repairs,indent=2)+'\n')
with Path('work/hubble487_link.log').open('w') as f:subprocess.run(['python3','work/link_hubble486.py'],stdout=f,stderr=subprocess.STDOUT,check=True)
s=Path('work/native_hubble486.py').read_text();a=s.index("s=Path('work/check_hubble_program394.py')");exec(s[a:])
