from pathlib import Path
import os,time,subprocess
# Observe the original live batch build; never duplicate it while it is alive.
while True:
 try:os.kill(36038,0)
 except ProcessLookupError:break
 time.sleep(2)
assert 'Build completed successfully' in Path('work/build_mechanics486.log').read_text()
subprocess.run(['python3','-u','work/run_mechanics486.py'],check=True)
print('ALL FIVE MECHANICS ENTRIES CHECKED AND REGISTERED',flush=True)
