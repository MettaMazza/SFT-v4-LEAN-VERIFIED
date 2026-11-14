from pathlib import Path
import concurrent.futures,subprocess,os,json,time
r=Path('work/constants-recovery');env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()));compiler='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
def run(i):
 m=f'CollatzBlock{i}';st=time.time();p=subprocess.run([compiler,'-j1','-M12288',str(r/'SFT/Mathematics'/(m+'.lean')),'-o',str(r/'.lake/build/lib/lean/SFT/Mathematics'/(m+'.olean'))],capture_output=True,text=True,env=env);Path('work',m+'_863_pinned_retry.log').write_text(p.stdout+p.stderr);v=dict(module=m,exit_code=p.returncode,seconds=round(time.time()-st,2),compiler=compiler,reason='Elan launcher blocked in online release lookup before compiler start');print(json.dumps(v),flush=True);return v
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:results=list(pool.map(run,[78,79,80]))
Path('work/collatz863_launcher_recovery.json').write_text(json.dumps(results,indent=2));assert all(x['exit_code']==0 for x in results)
prior=json.loads(Path('work/collatz863_blocks_report.json').read_text());by={x['module']:x for x in prior};by.update({x['module']:x for x in results});assert len(by)==100 and all(x['exit_code']==0 for x in by.values());Path('work/collatz863_all_blocks_verified.json').write_text(json.dumps(list(by.values()),indent=2));print('PASS all100 blocks;97 reused,3 completed with installed pinned compiler')
