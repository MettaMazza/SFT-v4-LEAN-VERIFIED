import subprocess
for n in ['prepare_catalytic1356_streaming1468.py','check_catalytic1356_streaming1468.py','adopt_catalytic_streaming1468.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
