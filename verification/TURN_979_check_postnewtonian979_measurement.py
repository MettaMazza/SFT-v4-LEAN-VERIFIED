from pathlib import Path
import sys,json,subprocess,os,copy,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));from sft.engine.canonical import canonical_value
from sft.physics import post_newtonian_fixed_point_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
target=src.authoritative_record(root)['registered_target'];tests=[target]
for value in [[],['7/50'],['7/150','7/50'],['1/2','1/2'],['-1/2','-2/3'],[1,0],[True,False],['0','-1/4'],['1e-2','1e-3']]:
 t=copy.deepcopy(target);t['v1_corrections']=value;tests.append(t)
for key in ['v2_matter_source','v2_coupling','v2_fixed_point']:
 for value in ['',0,'changed']:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for value in [True,False,'false',0]:
 t=copy.deepcopy(target);t['external_universal_numeric_convergence_claimed']=value;tests.append(t)
for key in ['external_scheme','external_nonlinearity','external_1PN_scalar_structure','external_domain','external_formal_order']:
 t=copy.deepcopy(target);t[key]='changed-but-retained';tests.append(t)
for key in ['v1_source_entry','v1_relation','v2_source_step','v2_map','measured_parameter_fitted']:
 t=copy.deepcopy(target);t.pop(key);tests.append(t)
t=copy.deepcopy(target);t['additional']='retained';tests.append(t)
expected=[canonical_value(src.exact_measurement_analysis(t)) for t in tests]
s='''import SFT.Physics.PostNewtonianMeasurement
open SFT.Physics PostNewtonianMeasurement SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Analysis → Value | .ok a => analysisValue a | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n'
p=w/'constants-recovery/PostNewtonianMeasurement979.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[i for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
(w/'postnewtonian979_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all17fields=True,source_sha256=hashlib.sha256((c/'SFT/Physics/PostNewtonianMeasurement.lean').read_bytes()).hexdigest()),indent=2));print('PASS',len(tests),'complete analysis cases/all17fields')
