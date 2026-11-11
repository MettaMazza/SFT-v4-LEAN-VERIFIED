from pathlib import Path
import subprocess,os,json
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));report=[]
for m in ['ExactComposition','CompositionGrammar','CompositionEvidence']:
 ir=r/'.lake/build/ir/SFT/Chemistry';ir.mkdir(parents=True,exist_ok=True);cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-o',str(r/'.lake/build/lib/lean/SFT/Chemistry'/(m+'.olean')),'-c',str(ir/(m+'.c')),'SFT/Chemistry/'+m+'.lean'];p=subprocess.run(cmd,cwd=r,env=env,capture_output=True,text=True);Path('work/build565_'+m+'.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(ir/(m+'.c')),'-o',str(ir/(m+'.c.o.export'))],check=True);report.append({'module':m,'command':cmd,'exit':0});print(m,'built',flush=True)
Path('work/composition565_build_report.json').write_text(json.dumps(report,indent=2))
