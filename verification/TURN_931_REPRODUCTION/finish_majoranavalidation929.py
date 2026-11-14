from pathlib import Path
import subprocess,json,os,concurrent.futures
w=Path('work');items=json.load(open(w/'majoranavalidation929_items.json'));jobs=[]
# Preparation is serial to preserve the shared native-object cache. Executions then overlap.
for key,tag,n,cid in items:
 low=tag.lower();build=low+'_build929.log';assert 'Build completed successfully' in (w/build).read_text()
 for script,args in [('audit_majoranavalidation929.py',[tag,low,str(n),build]),(f'prepare_{low}_native{n}.py',[]),(f'prepare_{low}_empirical_native{n}.py',[])]:
  with (w/(script+'.log')).open('w') as f:subprocess.run(['python3',str(w/script),*args],stdout=f,stderr=subprocess.STDOUT,check=True)
 def run_item(tag=tag,low=low,n=n):
  for script,args in [(f'check_{low}_program{n}.py',[str((w/'circuit866_native_objects'/f'{tag}Program{n}').resolve())]),(f'check_{low}_independent{n}.py',[]),(f'check_{low}_empirical{n}.py',[])]:
   with (w/(script+'.log')).open('w') as f:subprocess.run(['python3',str(w/script),*args],stdout=f,stderr=subprocess.STDOUT,check=True)
  actual=json.load(open(w/f'{low}_program{n}_output.json'));original=json.load(open(w/f'{low}{n}_original_program.json'));assert actual==original
  p=w/f'{low}_program{n}_report.json';report=json.load(open(p));report['fresh_original_package_output_also_matches']=True;p.write_text(json.dumps(report,indent=2));print(tag,'ALL CHECKS PASS',flush=True)
 if not jobs:pool=concurrent.futures.ThreadPoolExecutor(max_workers=4)
 jobs.append(pool.submit(run_item))
for job in jobs:job.result()
pool.shutdown()
