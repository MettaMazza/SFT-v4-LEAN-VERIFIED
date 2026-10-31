from pathlib import Path
import subprocess,json,os
entries=json.load(open('work/limitspeed500_entries.json'));targets=['SFT.Physics.FieldMagneticOrientation:c.o']
for stem,_,component in entries:
 targets.append('SFT.Physics.'+stem+'ValidationProofs')
 targets += ['SFT.Physics.'+m+':c.o' for m in [component]+[stem+t for t in ['Grammar','Evidence','Experiment','Validation','Measured']]]
with Path('work/build_limitspeed500.log').open('w') as f:
 subprocess.run(['/Users/dolltrading/.elan/bin/lake','-d','work/constants-recovery','build',*targets],env=dict(os.environ,LEAN_NUM_THREADS='1'),stdout=f,stderr=subprocess.STDOUT,check=True)
print('BUILD PASS',flush=True)
