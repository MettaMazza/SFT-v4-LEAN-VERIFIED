from pathlib import Path
import time,subprocess,json,os
w=Path('work');report=w/'gblock_native655_report.json';pid=30863
while not report.exists():
 try:os.kill(pid,0)
 except ProcessLookupError:raise RuntimeError('Original native process ended without passing report; inspect gblock655_native_link.log. Do not restart automatically.')
 time.sleep(2)
assert json.load(open(report))['status']=='PASS'
subprocess.run(['python3','work/check_independent645.py','gblock','SFT-CHEM-PRED-G-BLOCK-001','work/gblock_native655_output.json'],check=True)
subprocess.run(['python3','work/register_gblock655.py'],check=True)
(w/'gblock655_registration_status.json').write_text(json.dumps({'status':'complete','completed_entries':438}))
