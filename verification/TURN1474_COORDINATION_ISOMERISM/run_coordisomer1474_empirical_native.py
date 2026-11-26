import time,subprocess,json
from pathlib import Path
w=Path('work')
while not (w/'coordisomer1474_program_optimized_build1474.json').exists():time.sleep(10)
for n in ['prepare_coordisomer1474_empirical_native.py','check_coordisomer1474_empirical_native.py']:
 print('RUN',n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
