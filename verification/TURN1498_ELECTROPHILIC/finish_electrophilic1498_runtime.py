from pathlib import Path
import os,time,json,subprocess,sys
w=Path('work');p=w/'electrophilic1498_program_native_build.json'
while not p.exists():
 try:os.kill(98471,0)
 except ProcessLookupError:raise RuntimeError('Primary builder terminal without receipt; inspect retained log; do not duplicate it')
 time.sleep(5)
assert json.load(open(p))['status']=='PASS'
source=json.load(open(w/'electrophilic1498_original_program.json'))['registration']['source_hash']
with(w/'electrophilic1498_program_output.log').open('w')as f:subprocess.run([sys.executable,str(w/'prepare_electrophilic1498_program_native.py'),'--execute',source],stdout=f,stderr=subprocess.STDOUT,check=True)
with(w/'electrophilic1498_validation_native_reused.log').open('w')as f:subprocess.run([sys.executable,str(w/'prepare_electrophilic1498_validation_native.py')],stdout=f,stderr=subprocess.STDOUT,check=True)
with(w/'electrophilic1498_validation_output.log').open('w')as f:subprocess.run([sys.executable,str(w/'prepare_electrophilic1498_validation_native.py'),'--execute'],stdout=f,stderr=subprocess.STDOUT,check=True)
subprocess.run([sys.executable,str(w/'finish_electrophilic1498_comparisons.py')],check=True)
print('Both fresh comparisons PASS',flush=True)
