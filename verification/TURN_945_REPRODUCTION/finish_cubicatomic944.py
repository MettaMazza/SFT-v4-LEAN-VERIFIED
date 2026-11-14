from pathlib import Path
import time,subprocess
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
while True:
 s=(w/'cubicatomic944_canonical_build.log').read_text()
 if 'Build completed successfully' in s:break
 if 'error: build failed' in s:raise RuntimeError('cubic build failed')
 time.sleep(10)
subprocess.run(['python3','work/check_cubicatomic_entry944.py'],check=True)
while not (c/'verification/TURN_943_TERMINAL_MUON_COMPLETION.json').exists():time.sleep(10)
subprocess.run(['python3','work/register_cubicatomic944.py','CubicAtomicSupportEntry','cubicatomic','944','SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004','CUBIC_ATOMIC','816'],check=True)
print('COMPLETE registered612',flush=True)
