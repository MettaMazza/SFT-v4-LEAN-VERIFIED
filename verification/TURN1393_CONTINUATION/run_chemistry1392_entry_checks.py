from pathlib import Path
import subprocess,json,sys,hashlib
w=Path('work');r=w/'turn1064_recovery';tag=sys.argv[1]
for kind,suffix in [('prediction_cases','prediction'),('experiment','experiment'),('empirical','empirical')]:
 p=w/(tag+'_'+suffix+'_report.json');reuse=False
 if p.exists():
  a=json.loads(p.read_text());reuse=a.get('status')=='PASS'
  for k,h in a.get('source_sha256',{}).items():
   q=r/(k if k.startswith('SFT/')else 'SFT/Chemistry/'+k+'.lean')
   reuse=reuse and q.exists()and hashlib.sha256(q.read_bytes()).hexdigest()==h
 if reuse:print('REUSE',tag,suffix,flush=True);continue
 print('RUN ORIGINAL',tag,kind,flush=True);subprocess.run([sys.executable,str(w/('check_'+tag+'_'+kind+'.py'))],check=True)
print('Original source checks complete',tag,flush=True)
