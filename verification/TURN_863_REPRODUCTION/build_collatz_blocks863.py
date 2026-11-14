from pathlib import Path
import json,subprocess,os,time,concurrent.futures
r=Path('work/constants-recovery');report=json.loads(Path('work/collatz863_original_report.json').read_text());fuel=report['maximum_executed_steps'];assert report['starts']==100000
jobs=[]
for i in range(100):
 m=f'CollatzBlock{i}';(r/'SFT/Mathematics'/(m+'.lean')).write_text(f'import SFT.Mathematics.CollatzCensus\nnamespace SFT.Mathematics.CollatzCensus\nset_option maxRecDepth 200000\nset_option maxHeartbeats 100000000\ndef censusBlock{i} := (List.range 1000).map (fun j => let n := {1000*i}+j+1; (n,stepsWithin n {fuel}))\ntheorem block{i} : censusBlock{i}.all (fun row => row.2.isSome)=true := by decide\nend SFT.Mathematics.CollatzCensus\n');jobs.append(m)
env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()))
def run(m):
 st=time.time();p=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M12288',str(r/'SFT/Mathematics'/(m+'.lean')),'-o',str(r/'.lake/build/lib/lean/SFT/Mathematics'/(m+'.olean'))],capture_output=True,text=True,env=env);Path('work',m+'_863.log').write_text(p.stdout+p.stderr);result=dict(module=m,exit_code=p.returncode,seconds=round(time.time()-st,2));print(json.dumps(result),flush=True);return result
with concurrent.futures.ThreadPoolExecutor(max_workers=28) as pool:results=list(pool.map(run,jobs))
Path('work/collatz863_blocks_report.json').write_text(json.dumps(results,indent=2));assert all(x['exit_code']==0 for x in results)
