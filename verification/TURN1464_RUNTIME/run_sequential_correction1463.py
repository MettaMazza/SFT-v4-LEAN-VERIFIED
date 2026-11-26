import subprocess
for n in ['build_sequential1353_correction1463.py','prepare_sequential1353_chunked1463.py','check_sequential1353_chunked1463.py','adopt_sequential_chunked1463.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
