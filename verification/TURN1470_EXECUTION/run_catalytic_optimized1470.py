import subprocess
for n in ['prepare_catalytic1356_optimized1470.py','check_catalytic1356_optimized1470.py','adopt_catalytic_optimized1470.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
