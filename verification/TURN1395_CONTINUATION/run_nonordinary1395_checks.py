from pathlib import Path
import json,os,time,subprocess,sys,hashlib
w=Path('work');r=w/'turn1064_recovery';jobs=json.loads((w/'nonordinary1395_jobs.json').read_text())
for row in json.loads((w/'nonordinary1395_checks_plan.json').read_text()):
 name=row['name'];audit=w/(name+'1395_audit_report.json');job=next(x for x in jobs if x['name']==name)
 while not audit.exists():
  os.kill(job['pid'],0);time.sleep(10)
 a=json.loads(audit.read_text());assert a['status']=='PASS'
 for rel,h in a['source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h
 subprocess.run([sys.executable,'work/check_nonordinary1395_program.py',name],check=True)
print('All five original programme and independent checks pass',flush=True)
