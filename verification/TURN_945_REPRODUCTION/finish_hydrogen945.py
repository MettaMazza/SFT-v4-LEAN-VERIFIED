from pathlib import Path
import time,subprocess
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
while True:
 s=(w/'hydrogen945_canonical_build.log').read_text()
 if 'Build completed successfully' in s:break
 if 'error: build failed' in s:raise RuntimeError('hydrogen build failed')
 time.sleep(10)
subprocess.run(['python3','work/check_hydrogen_entry945.py'],check=True)
while not (c/'verification/TURN_944_CUBIC_ATOMIC_COMPLETION.json').exists():time.sleep(10)
subprocess.run(['python3','work/register_hydrogen945.py','HydrogenSpectrumEntry','hydrogen','945','SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004','HYDROGEN_SPECTRUM','817'],check=True)
print('COMPLETE registered613',flush=True)
