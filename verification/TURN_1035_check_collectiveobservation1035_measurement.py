from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from fractions import Fraction
import ast,types
from sft.engine.canonical import canonical_value
body=(w/'collective_radiation_validation_v11035.py').read_text();env={'Fraction':Fraction};exec(compile(ast.Module(body=[n for n in ast.parse(body).body if isinstance(n,ast.FunctionDef) and n.name=='exact_collective_analysis'],type_ignores=[]),'pinned-collective-analysis','exec'),env);src=types.SimpleNamespace(**env)
target=json.load(open(w/'collectiveobservation1035_target.json'))['registered_target'];tests=[target]
for key in ['blackbody_spectrum_shape_agreement_reported','plasma_frequency_direct_density_function_reported','all_registered_rows_retained']:
 for value in [False,True,0,1,'',[],[1],None]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for key in ['blackbody_exponent','plasma_probe_flight_count','alfven_observation_year_first','alfven_observation_year_last']:
 for value in [False,True,0,1,3,4,-2,2007,2014]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for key in ['laser_unmodified_linewidth_lower_hz','laser_extended_cavity_linewidth_upper_hz','blackbody_historical_stefan_constant_relative_agreement_upper']:
 for value in ['1/7','-2','1/3','0.6000',True,8]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for value in ['',None,'part-per-million','other']:
 t=copy.deepcopy(target);t['acoustic_resonance_measurement_precision_label']=value;tests.append(t)
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(val(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
expected=[canonical_value(src.exact_collective_analysis(t)) for t in tests]
s='''import SFT.Physics.CollectiveObservationMeasurement
open SFT.Host.Canonical SFT.Physics.CollectiveObservationMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactCollectiveAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/CollectiveObservationMeasurement1031.lean';p.write_text(s)
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'collectiveobservation1035_measurement_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/CollectiveObservationMeasurement.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'collectiveobservation1035_measurement_audit.lean';p.write_text('import SFT.Physics.CollectiveObservationMeasurement\n'+''.join('#print axioms SFT.Physics.CollectiveObservationMeasurement.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'collectiveobservation1035_measurement_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'collectiveobservation1035_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original exact_collective_analysis all twelve fields, exact rational conversion, integer exponent and year arithmetic, retained raw flags and Python and behavior'),indent=2));print('PASS',len(tests),'full original CollectiveObservation analyses;',len(names),'empty-axiom definitions')
