import subprocess
for name in ['prepare_search1360_optimized1472.py','check_search1360_optimized1472.py']:
 print('RUN',name,flush=True);subprocess.run(['python3','-u','work/'+name],check=True)
