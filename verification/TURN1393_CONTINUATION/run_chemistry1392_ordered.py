from pathlib import Path
import json,subprocess,sys,hashlib
w=Path('work');r=w/'turn1064_recovery';rows=json.loads((w/'chemistry1392_native_preparation.json').read_text())
for row in rows:
 tag=row['tag'];p=w/(tag+'_full_audit_report.json');reuse=False
 if p.exists():
  a=json.loads(p.read_text());reuse=a.get('status')=='PASS'and row['module'].replace('.','/')+'.lean'in a.get('source_sha256',{})
  for k,h in a.get('source_sha256',{}).items():
   q=r/(k if k.startswith('SFT/')else 'SFT/Chemistry/'+k+'.lean');reuse=reuse and q.exists()and hashlib.sha256(q.read_bytes()).hexdigest()==h
 if not reuse:print('BUILD ORIGINAL REST',tag,flush=True);subprocess.run([sys.executable,row['builder']],check=True)
 else:print('REUSE complete current-source build/audit',tag,flush=True)
 ps=subprocess.check_output(['ps','-axo','command'],text=True)
 cmd='work/run_chemistry1392_entry_checks.py '+tag
 if any(l.endswith(' '+cmd)for l in ps.splitlines()):print('RETAIN live checks',tag,flush=True);continue
 log=w/(tag+'_entry1392.log');out=log.open('w');p=subprocess.Popen([sys.executable,'work/run_chemistry1392_entry_checks.py',tag],stdout=out,stderr=subprocess.STDOUT,start_new_session=True)
 path=w/'chemistry1392_entry_jobs.json';jobs=json.loads(path.read_text())if path.exists()else[];jobs.append({'tag':tag,'pid':p.pid,'log':str(log)});path.write_text(json.dumps(jobs,indent=2)+'\n');print('CHECKS STARTED',tag,p.pid,flush=True)
print('All original rest modules built in source import order',flush=True)
