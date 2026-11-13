from pathlib import Path
import os,subprocess,json
r=Path('work/constants-recovery').resolve();w=Path('work');env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));results=[]
for m in ['MetallicMaterialSource','MetallicMaterialGrammar','MetallicMaterialEvidence','MetallicMaterialExperiment','MetallicMaterialValidation']:
 cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','SFT/Materials/'+m+'.lean','-o',str(r/'.lake/build/lib/lean/SFT/Materials'/(m+'.olean')),'-c',str(r/'.lake/build/ir/SFT/Materials'/(m+'.c'))]
 with (w/('matmetal828_'+m+'_build.log')).open('w') as f:p=subprocess.run(cmd,cwd=r,env=env,stdout=f,stderr=subprocess.STDOUT)
 results.append(dict(module=m,command=cmd,exit=p.returncode));(w/'matmetal828_build.json').write_text(json.dumps(results,indent=2));print(m,p.returncode,flush=True)
 if p.returncode:break
