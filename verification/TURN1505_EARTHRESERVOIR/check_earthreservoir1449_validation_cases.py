from pathlib import Path
import os,subprocess,json,hashlib
w=Path('work');r=w/'turn1064_recovery'
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/EarthReservoirValidationCases1449.lean'],env=env,capture_output=True,text=True)
(w/'earthreservoir1449_validation_cases_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:]
actual=json.loads(p.stdout);expected=json.loads((w/'earthreservoir1449_validation_expected.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'earthreservoir1449_validation_cases_report.json').write_text(json.dumps(dict(status='PASS',instructions=len(expected['program']['instructions']),registration_fields=len(expected['registration']),source_sha256={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for p in [(r/'SFT/EarthEnvironment'/(m+'.lean'))for m in ['EarthReservoirExperiment','EarthReservoirValidation']]}),indent=2)+'\n')
print('PASS original Earth constructor and guarded outcome',len(expected['registration']),flush=True)
