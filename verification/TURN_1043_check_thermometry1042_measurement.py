from pathlib import Path
import json,subprocess,os,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');scope={};exec((w/'check_thermometry1042_analysis.py').read_text().split("lines=['")[0],scope);cases=scope['cases'];source=scope['ns']['exact_thermal_analysis']
def cv(x):
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if x is None:return '.null'
 if isinstance(x,str):return '.text '+json.dumps(x)
 if isinstance(x,dict):return '.object ['+','.join('('+json.dumps(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(x)
lines=['import SFT.Physics.ThermometryMeasurement','open SFT.Physics.ThermometryMeasurement SFT.Host.Canonical']
for t in cases:lines.append('#eval (exactThermalAnalysis ('+cv(t)+')).map render')
p=w/'thermometry1042_measurement_cases.lean';p.write_text('\n'.join(lines)+'\n');x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'thermometry1042_measurement_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout
actual=[]
for line in x.stdout.splitlines():
 if line.startswith('Except.ok '):actual.append(json.loads(json.loads(line[len('Except.ok '):])))
assert actual==[json.loads(json.dumps(source(t)))for t in cases],(len(actual),len(cases))
(w/'thermometry1042_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),fields=13,source_sha256=hashlib.sha256((r/'SFT/Physics/ThermometryMeasurement.lean').read_bytes()).hexdigest(),scope='Complete original registered integer analysis and exact boolean identity behavior through canonical target adapter'),indent=2));print('PASS',len(cases),'canonical target13fieldcomparisons')
