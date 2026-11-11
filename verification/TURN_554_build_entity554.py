from pathlib import Path
import subprocess,os,json,re
r=Path('work/constants-recovery').resolve();w=r.parent;env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));report=[]
for m in ['EntityIdentity','EntityGrammar','EntityEvidence']:
 out=r/'.lake/build/lib/lean/SFT/Chemistry'/(m+'.olean');cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-o',str(out),'SFT/Chemistry/'+m+'.lean'];p=subprocess.run(cmd,cwd=r,env=env,capture_output=True,text=True);(w/('build554_'+m+'.log')).write_text(p.stdout+p.stderr);report.append({'module':m,'command':cmd,'exit':p.returncode});print(m,p.returncode,flush=True);assert p.returncode==0,p.stdout+p.stderr
names=[]
for m in ['EntityIdentity','EntityGrammar','EntityEvidence']:
 s=(r/'SFT/Chemistry'/(m+'.lean')).read_text();names+=['SFT.Chemistry.'+m+'.'+n for _,n in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',s,re.M)]
a=w/'AuditEntity554.lean';a.write_text('\n'.join('import SFT.Chemistry.'+m for m in ['EntityIdentity','EntityGrammar','EntityEvidence'])+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n');p=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(a)],env=env,capture_output=True,text=True);(w/'entity554_audit.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;assert all("'"+n+"' does not depend on any axioms" in p.stdout for n in names),p.stdout
(w/'entity554_build_report.json').write_text(json.dumps({'modules':report,'declarations':names,'empty_axiom_dependencies':True},indent=2));print('Audit passed',len(names),flush=True)
