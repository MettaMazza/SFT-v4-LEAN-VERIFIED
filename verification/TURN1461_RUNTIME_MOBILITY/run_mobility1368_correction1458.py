from pathlib import Path
import subprocess,time
w=Path('work')
for n in ['build_mobility1368_core.py','check_mobility1368_core.py','build_mobility1368_evidence1441.py','check_mobility1368_program.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u',str(w/n)],check=True)
# Preserve any already executing earlier rest batch; rebuild consumers after it finishes.
while True:
 lines=subprocess.check_output(['ps','-axo','pid,command'],text=True).splitlines()
 old=[s for s in lines if 'Python' in s and 'work/run_mobility1368_rest1272.py' in s]
 if not old:break
 time.sleep(15)
print('RUN run_mobility1368_rest1272.py after corrected core/evidence',flush=True)
subprocess.run(['python3','-u','work/run_mobility1368_rest1272.py'],check=True)
