from pathlib import Path
import subprocess,time,concurrent.futures
w=Path('work')
while True:
 s=(w/'precision954_wrapper_correction_build.log').read_text()
 if 'Build completed successfully' in s:break
 if 'error:' in s:raise RuntimeError(s[-4000:])
 time.sleep(2)
def run(item):
 low,n=item
 with (w/f'{low}{n}_wrapper_recheck.log').open('w') as f:
  for name in [f'audit_{low}{n}_all.py',f'prepare_{low}empirical_empirical_native{n}.py',f'check_{low}empirical_empirical{n}.py']:
   subprocess.run(['python3',str(w/name)],stdout=f,stderr=subprocess.STDOUT,check=True)
 print('PASS corrected original validator order and passed guard',low,n,flush=True)
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:list(pool.map(run,[('terminallamb',951),('terminalfine',952),('terminalhyperfine',953)]))
