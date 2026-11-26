import subprocess
for n in ['prepare_diffusionlimit1357_optimized1471.py', 'check_diffusionlimit1357_optimized1471.py', 'adopt_diffusionlimit1357_optimized1471.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
