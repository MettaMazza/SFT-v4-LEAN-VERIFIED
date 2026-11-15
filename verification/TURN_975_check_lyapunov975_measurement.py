from pathlib import Path
import sys,json,subprocess,os,copy,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));from sft.physics import lyapunov_ks_correspondence_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
target=src.authoritative_record(root)['registered_target'];tests=[target]
for key in ['map_piece_count','absolute_branch_slope','preimage_count','output_alphabet_size']:
 for value in ['1','2','3','5']:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for key in ['stationary_distribution','output_symbols','conventional_lyapunov_label','conventional_information_rate_label','entropy_formula_scope','entropy_formula_relation']:
 for value in ['', 'changed']:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
expected=[]
for target in tests:
 try:expected.append(src.exact_measurement_analysis(target))
 except ValueError as ex:expected.append({'error':str(ex)})
s='''import SFT.Physics.LyapunovMeasurement
open SFT.Physics LyapunovMeasurement SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Analysis → Value | .ok a => analysisValue a | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n'
p=w/'constants-recovery/LyapunovMeasurement975.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
(w/'lyapunov975_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all15fields=True,source_sha256=hashlib.sha256((c/'SFT/Physics/LyapunovMeasurement.lean').read_bytes()).hexdigest()),indent=2));print('PASS',len(tests),'complete analysis cases/all15fields')
