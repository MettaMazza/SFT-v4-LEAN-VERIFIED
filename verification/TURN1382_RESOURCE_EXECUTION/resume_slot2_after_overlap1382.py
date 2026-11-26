import os,time,subprocess
while True:
 try:os.kill(29446,0)
 except ProcessLookupError:break
 time.sleep(2)
subprocess.run(['python3','work/resume_consciousness1364.py','2'],check=True)
