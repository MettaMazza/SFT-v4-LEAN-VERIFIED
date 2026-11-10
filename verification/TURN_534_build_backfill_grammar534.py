from pathlib import Path
import subprocess,json,os,concurrent.futures
w=Path('work').resolve();r=w/'constants-recovery';env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'),LEAN_NUM_THREADS='1')
def build(item):
 result=[]
 for tail in ['Grammar','Evidence']:
  m=item['stem']+tail;cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean')),'-c',str(r/'.lake/build/ir/SFT/Physics'/(m+'.c')),'SFT/Physics/'+m+'.lean'];p=subprocess.run(cmd,cwd=r,env=env,text=True,capture_output=True);(w/('build534_'+m+'.log')).write_text(p.stdout+p.stderr);result.append(dict(module=m,exit=p.returncode,command=cmd));assert p.returncode==0,p.stdout+p.stderr
 return result
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:out=list(pool.map(build,json.loads((w/'backfill534_metadata.json').read_text())))
(w/'backfill534_grammar_build_report.json').write_text(json.dumps(out,indent=2));print('All eight grammar/evidence builds passed',flush=True)
