from pathlib import Path
import subprocess,time,json,datetime,hashlib
w=Path('work');r=w/'turn1064_recovery'
while not (w/'xray1163_empirical_report.json').exists():time.sleep(20)
assert json.loads((w/'xray1163_empirical_report.json').read_text())['status']=='PASS'
for f in ['massvector1310_full_audit_report.json','massvector1310_jcamp_report.json','massvector1310_surface_report.json']:
 a=json.loads((w/f).read_text());assert a['status']=='PASS'
for rel,h in json.loads((w/'massvector1310_full_audit_report.json').read_text())['source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h
for name in ['prepare_massvector1310_reuse.py','check_massvector1310_empirical.py','check_massvector1310_program.py']:
 print('START '+name,flush=True)
 (w/'massvector1310_queue_cursor.json').write_text(json.dumps(dict(command=name,started=datetime.datetime.now(datetime.timezone.utc).isoformat())))
 subprocess.run(['python3','work/'+name],check=True)
 print('PASS '+name,flush=True)
subprocess.run(['python3','work/register_massvector1310.py'],check=True)
