from pathlib import Path
import subprocess,os,time,json
while True:
 try:os.kill(28218,0)
 except ProcessLookupError:break
 time.sleep(5)
s=Path('work/build_measurement481.log').read_text();assert 'Build completed successfully' in s,s[-3000:]
entries=json.load(open('work/measurement481_entries.json'));targets=['SFT.Physics.ConsistencyValidationProofs']
for stem,key,component in entries:
 targets += ['SFT.Physics.'+m+':c.o' for m in [component]+[stem+x for x in ['Grammar','Evidence','Experiment','Validation']]]
with Path('work/build_measurement_runtime481.log').open('w') as f:
 subprocess.run(['/Users/dolltrading/.elan/bin/lake','-d','work/constants-recovery','build',*targets],env=dict(os.environ,LEAN_NUM_THREADS='1'),stdout=f,stderr=subprocess.STDOUT,check=True)
subprocess.run(['python3','work/run_measurement481.py'],check=True)
