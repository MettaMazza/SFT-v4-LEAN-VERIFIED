import subprocess
for name in ['check_polarizability1319_prediction_cases.py','check_polarizability1319_empirical.py','register_polarizability1319.py']:
 print('RUN '+name,flush=True)
 subprocess.run(['python3','work/'+name],check=True)
