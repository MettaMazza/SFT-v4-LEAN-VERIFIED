from pathlib import Path
import subprocess,json,os
entries=json.load(open('work/quantum491_entries.json'))[4:];targets=[p[:-5].replace('/','.')+':c.o' for p in json.load(open('work/quantum491_recovery_sources.json'))]
for stem,_,component in entries:
 targets.append('SFT.Physics.'+stem+'ValidationProofs')
 targets += ['SFT.Physics.'+m+':c.o' for m in [component]+[stem+t for t in ['Grammar','Evidence','Experiment','Validation']]]
with Path('work/build_quantum491_tail.log').open('w') as f:
 subprocess.run(['/Users/dolltrading/.elan/bin/lake','-d','work/constants-recovery','build',*targets],env=dict(os.environ,LEAN_NUM_THREADS='1'),stdout=f,stderr=subprocess.STDOUT,check=True)
print('BUILD PASS',flush=True)
