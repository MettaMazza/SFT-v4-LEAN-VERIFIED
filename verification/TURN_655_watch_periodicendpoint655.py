from pathlib import Path
import time,subprocess,json,os
w=Path('work');report=w/'periodicendpoint_native655_report.json';pid=31177
while not report.exists():
 try:os.kill(pid,0)
 except ProcessLookupError:raise RuntimeError('Endpoint native process ended without report; inspect original log. No automatic restart.')
 time.sleep(2)
assert json.load(open(report))['status']=='PASS'
assert json.load(open(w/'periodicendpoint_validation655_report.json'))['status']=='PASS'
assert json.load(open(w/'smithium655_registration_status.json'))['completed_entries']==439
subprocess.run(['python3','work/check_independent645.py','periodicendpoint','SFT-CHEM-PRED-PERIODIC-ENDPOINT-001','work/periodicendpoint_native655_output.json'],check=True)
subprocess.run(['python3','work/register_periodicendpoint655.py'],check=True)
(w/'periodicendpoint655_registration_status.json').write_text(json.dumps({'status':'complete','completed_entries':440}))
