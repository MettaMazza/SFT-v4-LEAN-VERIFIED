from pathlib import Path
import subprocess,os,json,concurrent.futures
r=Path('work/constants-recovery').resolve();out=Path('work/limit_native543').resolve();out.mkdir(exist_ok=True);env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'),LEAN_NUM_THREADS='1')
mods=['LimitContinuumWitnesses','LimitContinuumGrammarBase']+[f'LimitContinuumCensus{i}' for i in range(16)]+['LimitContinuumGrammar']
def build(m):
 cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-c',str(out/(m+'.c')),'SFT/Mathematics/'+m+'.lean'];p=subprocess.run(cmd,cwd=r,env=env,text=True,capture_output=True);(out/(m+'.log')).write_text(p.stdout+p.stderr);assert p.returncode==0,m
 subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(out/(m+'.c')),'-o',str(out/(m+'.o'))],check=True);return {'module':m,'command':cmd,'exit':0}
with concurrent.futures.ThreadPoolExecutor(max_workers=19) as pool:results=list(pool.map(build,mods))
(out/'report.json').write_text(json.dumps(results,indent=2));print('Built',len(results),'missing native dependency objects; no source edits')
