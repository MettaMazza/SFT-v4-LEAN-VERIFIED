from pathlib import Path
import json,subprocess,sys,time
w=Path('work');r=w/'turn1064_recovery'
for row in json.loads((w/'nonordinary1394_plan.json').read_text()):
 name=row['name'];cid=row['claim_id'];reports=['core1395_audit_report.json','nonordinary1395_records_report.json',name+'1395_audit_report.json',name+'1395_original_report.json',name+'1395_program_report.json']
 if name=='NonordinaryFamily':reports+=['external1395_audit_report.json','nonordinary1395_empirical_report.json']
 while True:
  c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']}
  if c['summary']['fully_reconstructed_claims']>=1000:raise SystemExit(0)
  if by[cid]['lean_status']=='complete':break
  if all((w/n).exists()and json.loads((w/n).read_text()).get('status')=='PASS'for n in reports)and all(by[d]['lean_status']=='complete'for d in row['dependencies']):
   subprocess.run([sys.executable,'work/register_nonordinary1395.py',name],check=True);break
  time.sleep(10)
print('All five original nonordinary entries registered',flush=True)
