from pathlib import Path
import subprocess,time,json,hashlib
w=Path('work');r=w/'turn1064_recovery'
while True:
 p=subprocess.run(['ps','-p','55808','-o','command='],capture_output=True,text=True)
 if p.returncode or 'resume_chemistry1192.py'not in p.stdout:break
 time.sleep(15)
assert json.loads((w/'precision1309_program_report.json').read_text())['status']=='PASS'
for name in ['bondenergy1311_full_audit_report.json','bondenergy1311_core_report.json','bondenergy1311_source_cases_report.json','bondenergy1311_experiment_report.json','bondenergy1311_empirical_report.json']:
 while not (w/name).exists():time.sleep(15)
 assert json.loads((w/name).read_text())['status']=='PASS'
for rel,h in json.loads((w/'bondenergy1311_full_audit_report.json').read_text())['source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h
subprocess.run(['python3','work/check_bondenergy1311_program.py'],check=True)
subprocess.run(['python3','work/register_bondenergy1311.py'],check=True)
