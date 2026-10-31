from pathlib import Path
import os,time,subprocess
while True:
 try:os.kill(38081,0)
 except ProcessLookupError:break
 time.sleep(2)
assert 'Build completed successfully' in Path('work/build_field487.log').read_text()
subprocess.run(['python3','-u','work/run_field487.py'],check=True)
print('ALL FIVE FIELD ENTRIES CHECKED AND REGISTERED',flush=True)
