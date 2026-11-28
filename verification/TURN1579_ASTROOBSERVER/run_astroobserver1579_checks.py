from pathlib import Path
import json,subprocess,concurrent.futures,hashlib
w=Path('work');r=w/'turn1064_recovery'
a=json.loads((w/'astroobserver1579_full_entry_audit_report.json').read_text());assert a['status']=='PASS'
for m,h in a['source_sha256'].items():assert hashlib.sha256((r/'SFT/AstronomyCosmology'/f'{m}.lean').read_bytes()).hexdigest()==h
def empirical():
 p=subprocess.run(['python3','work/build_astroobserver1579_native.py','--execute'],capture_output=True,text=True,check=True);(w/'astroobserver1579_empirical_execution.log').write_text(p.stdout+p.stderr);actual=json.loads(p.stdout)
 expected={'registration':json.loads((w/'astroobserver1579_registration_expected.json').read_text()),'validation':json.loads((w/'astroobserver1579_empirical_expected.json').read_text())}
 assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
 (w/'astroobserver1579_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n')
 (w/'astroobserver1579_empirical_report.json').write_text(json.dumps(dict(status='PASS',full_empirical_replay_passed=actual['validation']['passed'],registration_fields=len(actual['registration']),validation_fields=len(actual['validation']),measurements=len(actual['validation']['measurements']),native_build_specs=True,source_sha256=a['source_sha256']),indent=2)+'\n');print('PASS original full empirical validator and native source assembly',flush=True)
def programme():
 for script in ['build_astroobserver_programme1579_native','check_astroobserver_programme1579_native']:
  with(w/(script+'.log')).open('w')as f:subprocess.run(['python3','work/'+script+'.py'],stdout=f,stderr=subprocess.STDOUT,check=True)
 print('PASS fresh256 programme and independent controls',flush=True)
with concurrent.futures.ThreadPoolExecutor(max_workers=2)as pool:
 jobs=[pool.submit(empirical),pool.submit(programme)]
 for j in jobs:j.result()
