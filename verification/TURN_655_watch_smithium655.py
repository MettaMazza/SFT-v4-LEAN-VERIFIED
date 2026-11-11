from pathlib import Path
import time,subprocess,json,os
w=Path('work');report=w/'smithium_native655_report.json';pid=30904
while not report.exists():
 try:os.kill(pid,0)
 except ProcessLookupError:raise RuntimeError('Smithium native process ended without report; inspect its log. No automatic restart.')
 time.sleep(2)
assert json.load(open(report))['status']=='PASS'
assert json.load(open(w/'smithium_validation655_report.json'))['status']=='PASS'
assert json.load(open(w/'gblock655_registration_status.json'))['completed_entries']==438
subprocess.run(['python3','work/check_independent645.py','smithium','SFT-CHEM-PRED-SMITHIUM-001','work/smithium_native655_output.json'],check=True)
subprocess.run(['python3','work/register_smithium655.py'],check=True)
(w/'smithium655_registration_status.json').write_text(json.dumps({'status':'complete','completed_entries':439}))
