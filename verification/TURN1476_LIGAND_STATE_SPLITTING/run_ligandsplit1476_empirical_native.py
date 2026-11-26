import subprocess
for n in ['prepare_ligandsplit1476_empirical_native.py','check_ligandsplit1476_empirical_native.py']:
 print('RUN',n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
