from pathlib import Path
import subprocess,os,json,time,concurrent.futures
r=Path('work/constants-recovery');out=r/'SFT/Mathematics';jobs=[]
for i,start in enumerate(range(0,4999,100)):
 count=min(100,4999-start);m=f'PrimePairBlock{i}';(out/(m+'.lean')).write_text(f'import SFT.Mathematics.PrimePairCensus\nnamespace SFT.Mathematics.PrimePairCensus\nset_option maxRecDepth 200000\nset_option maxHeartbeats 100000000\ntheorem block{i} : blockPassed {start} {count}=true := by decide\nend SFT.Mathematics.PrimePairCensus\n');jobs.append(m)
env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()))
def build(m):
 start=time.time();p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',str(out/(m+'.lean')),'-o',str(r/'.lake/build/lib/lean/SFT/Mathematics'/(m+'.olean'))],capture_output=True,text=True,env=env);Path('work',m+'_861.log').write_text(p.stdout+p.stderr);result=dict(module=m,exit_code=p.returncode,seconds=round(time.time()-start,2));print(json.dumps(result),flush=True);return result
with concurrent.futures.ThreadPoolExecutor(max_workers=28) as pool:results=list(pool.map(build,jobs))
Path('work/prime861_blocks_report.json').write_text(json.dumps(results,indent=2));assert all(x['exit_code']==0 for x in results)
