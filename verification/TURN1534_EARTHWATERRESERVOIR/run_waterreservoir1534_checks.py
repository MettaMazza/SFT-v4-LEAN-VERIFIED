from pathlib import Path
import subprocess,json,time,hashlib,concurrent.futures
w=Path('work');r=w/'turn1064_recovery';a=w/'earthwaterreservoir1478_full_entry_audit_report.json'
while not a.exists():time.sleep(5)
v=json.load(open(a));assert v['status']=='PASS'
for m,h in v['source_sha256'].items():assert hashlib.sha256((r/'SFT/EarthEnvironment'/f'{m}.lean').read_bytes()).hexdigest()==h
subprocess.run(['python3','work/prepare_waterreservoirresolved1534_programme.py'],check=True)
def task(s):
 with(w/(s+'.log')).open('w')as f:subprocess.run(['python3','work/'+s+'.py'],stdout=f,stderr=subprocess.STDOUT,check=True)
# Native shared objects are already built and hash-bound; do not duplicate builds.
def continuation():
 p=subprocess.run(['python3','work/prepare_waterreservoirresolved1534_programme.py','--execute'],capture_output=True,text=True,check=True);(w/'waterreservoir_resolved1534_execution.log').write_text(p.stdout+p.stderr);actual=json.loads(p.stdout);expected=json.load(open(w/'waterreservoir_resolved1534_expected.json'));assert actual==expected
 (w/'waterreservoir_resolved1534_output.json').write_text(json.dumps(actual,indent=2)+'\n');(w/'waterreservoir_resolved1534_report.json').write_text(json.dumps(dict(status='PASS',scope='original conditional validator continuation; not full external validation',fields=len(actual),measurements=len(actual['measurements']),lean_source_sha256={'SFT/EarthEnvironment/'+m+'.lean':v['source_sha256'][m]for m in ['EarthWaterReservoirExperiment','EarthWaterReservoirValidation']},full_source_guard_unchanged=True),indent=2)+'\n');print('PASS12-field continuation',flush=True)
with concurrent.futures.ThreadPoolExecutor(max_workers=2)as pool:
 jobs=[pool.submit(continuation),pool.submit(task,'check_waterreservoir_guard1534_native')]
 for j in jobs:j.result()
print('PASS all original/native entry checks',flush=True)
