from pathlib import Path
import sys,json,subprocess,os,copy,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));from sft.engine.canonical import canonical_value
from sft.physics import orbital_dimension_stability_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
target=src.authoritative_record(root)['registered_target'];tests=[target]
for value in [[],['2'],['3','2'],['2','4'],['2','3','4'],[2,3],[True,False]]:
 t=copy.deepcopy(target);t['stable_dimensions']=value;tests.append(t)
for value in ['3','4','5','+4','04','-4',3,4,True,False]:
 t=copy.deepcopy(target);t['marginal_dimension']=value;tests.append(t)
for value in ['', 'changed','every-positive-whole-N-at-least-five']:
 t=copy.deepcopy(target);t['unstable_dimension_family']=value;tests.append(t)
for key in target:
 if key not in ['stable_dimensions','marginal_dimension','unstable_dimension_family']:
  t=copy.deepcopy(target);t.pop(key);tests.append(t)
t=copy.deepcopy(target);t['additional']='retained';tests.append(t)
expected=[]
for target in tests:
 try:expected.append(canonical_value(src.exact_measurement_analysis(target)))
 except ValueError as ex:expected.append({'error':str(ex)})
s='''import SFT.Physics.OrbitalMeasurement
open SFT.Physics OrbitalMeasurement SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Analysis → Value | .ok a => analysisValue a | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n'
p=w/'constants-recovery/OrbitalMeasurement977.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
(w/'orbital977_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all10fields=True,source_sha256=hashlib.sha256((c/'SFT/Physics/OrbitalMeasurement.lean').read_bytes()).hexdigest()),indent=2));print('PASS',len(tests),'complete analysis cases/all10fields')
