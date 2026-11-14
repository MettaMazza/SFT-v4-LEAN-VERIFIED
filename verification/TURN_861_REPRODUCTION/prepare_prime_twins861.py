from pathlib import Path
import subprocess,ast,types,sys,json,concurrent.futures,os,time
r=Path('work/constants-recovery');src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:sft/mathematics/lineage_laws.py'],text=True);tree=ast.parse(src);ns={};exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='_is_prime'],type_ignores=[]),'pinned_source','exec'),ns)
jobs=[];counts=[]
for i,start in enumerate(range(0,9996,1000)):
 count=min(1000,9996-start);expected=sum(ns['_is_prime'](p) and ns['_is_prime'](p+2) for p in range(3+start,3+start+count));counts.append(expected);m=f'PrimeTwinBlock{i}'
 (r/'SFT/Mathematics'/(m+'.lean')).write_text(f'import SFT.Mathematics.PrimePairCensus\nnamespace SFT.Mathematics.PrimePairCensus\nset_option maxRecDepth 200000\nset_option maxHeartbeats 100000000\ndef twinBlock{i} := ((List.range {count}).map (fun n => n+{start+3})).filter (fun p => isPrime p && isPrime (p+2))\ntheorem twinCount{i} : twinBlock{i}.length={expected} := by decide\nend SFT.Mathematics.PrimePairCensus\n');jobs.append(m)
env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()))
def build(m):
 st=time.time();p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',str(r/'SFT/Mathematics'/(m+'.lean')),'-o',str(r/'.lake/build/lib/lean/SFT/Mathematics'/(m+'.olean'))],env=env,capture_output=True,text=True);Path('work',m+'_861.log').write_text(p.stdout+p.stderr);v=dict(module=m,exit_code=p.returncode,seconds=round(time.time()-st,2));print(json.dumps(v),flush=True);return v
with concurrent.futures.ThreadPoolExecutor(max_workers=10) as pool:result=list(pool.map(build,jobs))
Path('work/prime861_twins_report.json').write_text(json.dumps(dict(jobs=result,counts=counts,total=sum(counts)),indent=2));assert all(x['exit_code']==0 for x in result)
