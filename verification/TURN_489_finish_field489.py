from pathlib import Path
import os,time,subprocess
while True:
 try:os.kill(43241,0)
 except ProcessLookupError:break
 time.sleep(2)
assert 'Build completed successfully' in Path('work/build_field489.log').read_text()
subprocess.run(['python3','-u','work/run_field489.py'],check=True)
print('FOUR FIELD ENTRIES CHECKED AND REGISTERED',flush=True)
