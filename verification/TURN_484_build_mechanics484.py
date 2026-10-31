from pathlib import Path
import subprocess,json,os
entries=json.load(open('work/mechanics484_entries.json'));targets=['SFT.Mathematics.FoldScalar:c.o']
for stem,_,component in entries:
 targets.append('SFT.Physics.'+stem+'ValidationProofs')
 targets += ['SFT.Physics.'+m+':c.o' for m in [component]+[stem+t for t in ['Grammar','Evidence','Experiment','Validation']]]
with Path('work/build_mechanics484.log').open('w') as f:
 subprocess.run(['/Users/dolltrading/.elan/bin/lake','-d','work/constants-recovery','build',*targets],env=dict(os.environ,LEAN_NUM_THREADS='1'),stdout=f,stderr=subprocess.STDOUT,check=True)
print('BUILD PASS',flush=True)
