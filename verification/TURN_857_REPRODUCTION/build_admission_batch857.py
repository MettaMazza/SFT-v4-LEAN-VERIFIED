from pathlib import Path
import subprocess,os,json,concurrent.futures
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));w=Path('work')
def build(m):
 log=w/f'admission857_{m}_build.log';cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','SFT/Foundation/'+m+'.lean','-o',str(r/'.lake/build/lib/lean/SFT/Foundation'/(m+'.olean')),'-c',str(r/'.lake/build/ir/SFT/Foundation'/(m+'.c'))];result=subprocess.run(cmd,cwd=r,env=env,capture_output=True,text=True);log.write_text(result.stdout+result.stderr);print(m,result.returncode,flush=True);return {'module':m,'command':cmd,'exit':result.returncode,'log':str(log)}
rows=[build('AdmissionGrammarCore')];assert rows[0]['exit']==0
with concurrent.futures.ThreadPoolExecutor(max_workers=28) as pool:
 for row in pool.map(build,['AdmissionGrammarBlock'+str(i) for i in range(32)]):rows.append(row);(w/'admission857_build_report.json').write_text(json.dumps(rows,indent=2))
assert all(x['exit']==0 for x in rows)
for m in ['AdmissionGrammar','AdmissionControls','AdmissionEvidence']:
 row=build(m);rows.append(row);(w/'admission857_build_report.json').write_text(json.dumps(rows,indent=2));assert row['exit']==0
