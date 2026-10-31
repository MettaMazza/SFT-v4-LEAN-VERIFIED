from pathlib import Path
import os,time,subprocess
while True:
 try:os.kill(29988,0)
 except ProcessLookupError:break
 time.sleep(5)
assert 'BUILD PASS' in Path('work/mechanics_build482.log').read_text(),Path('work/mechanics_build482.log').read_text()
subprocess.run(['python3','work/run_mechanics482.py'],check=True)
