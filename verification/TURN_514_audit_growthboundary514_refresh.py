from pathlib import Path
import json,re,subprocess,os
r=Path('work/constants-recovery').resolve();p=Path('work/auditgrowthboundary514_config.json');cfg=json.loads(p.read_text());env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for stem,c in cfg.items():
 names=[];ths=[];defs=[]
 for m in c['modules']:
  s=(r/'SFT/Physics'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1]
  for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
   full=ns+'.'+n;names.append(full)
   if kind=='theorem':ths.append(full)
   if kind in ['def','theorem']:defs.append(full)
 c.update(declarations=names,theorems=ths,definitions_and_theorems=defs)
 a=Path('work/Auditgrowthboundary514_'+stem+'.lean');a.write_text('\n'.join('import SFT.Physics.'+m for m in c['modules'])+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
 result=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M2048',str(a)],env=env,text=True,capture_output=True);Path('work/auditgrowthboundary514_'+stem+'.log').write_text(result.stdout+result.stderr)
 assert result.returncode==0,result.stdout+result.stderr
 assert all("'"+n+"' does not depend on any axioms" in result.stdout for n in names)
 print(stem,len(names),'zero-axiom declarations',flush=True)
p.write_text(json.dumps(cfg,indent=2)+'\n')
