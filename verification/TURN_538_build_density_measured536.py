from pathlib import Path
import json,subprocess,os,concurrent.futures
r=Path('work/constants-recovery').resolve();canonical=Path('/Volumes/One Touch/SFT v4 Full model LEAN');items=json.loads(Path('work/density536_numeric_metadata.json').read_text());env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')+':'+str(canonical/'.lake/build/lib/lean'),LEAN_NUM_THREADS='1')
def build(item):
 m=item['module'];cmd=['/Users/dolltrading/.elan/bin/lean','-j','1','-M','12288','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean')),'-c',str(r/'.lake/build/ir/SFT/Physics'/(m+'.c')),'SFT/Physics/'+m+'.lean'];p=subprocess.run(cmd,cwd=r,env=env,text=True,capture_output=True);Path('work/build536_'+m+'.log').write_text(p.stdout+p.stderr);return dict(module=m,exit=p.returncode,command=cmd)
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:results=list(pool.map(build,items))
Path('work/build_backfill536_direct_report.json').write_text(json.dumps(results,indent=2)+'\n');print(results);assert all(x['exit']==0 for x in results)
