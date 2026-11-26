import subprocess
for n in ['prepare_isotope1358_optimized1471.py', 'check_isotope1358_optimized1471.py', 'adopt_isotope1358_optimized1471.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
