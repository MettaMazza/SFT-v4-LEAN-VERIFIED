import subprocess
for n in ['prepare_coordisomer1474_program_native.py','check_coordisomer1474_program_native.py']:
 print('RUN',n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
