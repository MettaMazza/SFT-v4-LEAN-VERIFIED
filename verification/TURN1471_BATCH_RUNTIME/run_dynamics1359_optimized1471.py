import subprocess
for n in ['prepare_dynamics1359_optimized1471.py', 'check_dynamics1359_optimized1471.py', 'adopt_dynamics1359_optimized1471.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
