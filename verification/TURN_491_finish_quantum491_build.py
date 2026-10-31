from pathlib import Path
import os,time,subprocess
while True:
 try:os.kill(47386,0)
 except ProcessLookupError:break
 time.sleep(2)
assert 'Build completed successfully' in Path('work/build_quantum491.log').read_text(),Path('work/build_quantum491.log').read_text()[-3000:]
subprocess.run(['python3','work/build_quantum491_tail.py'],check=True)
print('ALL SIX BUILD TARGETS PASS',flush=True)
