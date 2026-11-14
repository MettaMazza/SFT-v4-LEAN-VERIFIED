from pathlib import Path
import subprocess,os,json
r=Path('work/constants-recovery');env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()));results=[]
for m in ['CollatzComplete','CollatzGrammar','CollatzEvidence']:
 p=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M12288',str(r/'SFT/Mathematics'/(m+'.lean')),'-o',str(r/'.lake/build/lib/lean/SFT/Mathematics'/(m+'.olean'))],capture_output=True,text=True,env=env)
 Path('work',m+'_863_build.log').write_text(p.stdout+p.stderr);print(m,p.returncode,flush=True);p.check_returncode();results.append(dict(module=m,exit_code=0))
Path('work/collatz863_final_build.json').write_text(json.dumps(results,indent=2))
subprocess.run(['python3','work/audit_collatz_all863.py'],check=True)
