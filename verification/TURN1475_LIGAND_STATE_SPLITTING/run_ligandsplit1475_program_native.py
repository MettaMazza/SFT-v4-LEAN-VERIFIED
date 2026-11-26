from pathlib import Path
import subprocess,time,json
w=Path('work')
while not (w/'ligandsplit_grammar1475_entry_audit_report.json').exists():time.sleep(5)
assert json.loads((w/'ligandsplit_grammar1475_entry_audit_report.json').read_text())['status']=='PASS'
for n in ['prepare_ligandsplit1475_program_native.py','check_ligandsplit1475_program_native.py']:
 print('RUN',n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
