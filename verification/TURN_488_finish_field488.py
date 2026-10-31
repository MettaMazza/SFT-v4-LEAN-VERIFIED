from pathlib import Path
import os,time,subprocess
while True:
 try:os.kill(41536,0)
 except ProcessLookupError:break
 time.sleep(2)
assert 'Build completed successfully' in Path('work/build_field488.log').read_text()
subprocess.run(['python3','-u','work/run_field488.py'],check=True)
print('FIVE FIELD ENTRIES CHECKED AND REGISTERED',flush=True)
