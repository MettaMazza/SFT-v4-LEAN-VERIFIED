from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from sft.physics import velocity_composition_fizeau_validation_v1 as src
from sft.engine.canonical import canonical_value
rel=src.SOURCE_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_HASH
(root/rel).parent.mkdir(parents=True,exist_ok=True);(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target]
for key in ['air_nonrelativistic_prediction_ruled_out','air_measurements_compatible_with_relativistic_calculation']:
 for value in [False,True,0,1,'',[],[1],None]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for key in ['water_measured_slope_rad_s_per_m','water_measured_standard_uncertainty_rad_s_per_m','relativistic_raw_prediction_rad_s_per_m','relativistic_profile_and_dispersion_corrected_prediction_rad_s_per_m','ordinary_addition_prediction_rad_s_per_m']:
 for value in ['0','-2','1/3','274/1000',True,8]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for value in [[],['a']*3,['a']*4,['a']*5,'abcd',{'a':1,'b':2,'c':3,'d':4}]:
 t=copy.deepcopy(target);t['systematic_limitations_retained']=value;tests.append(t)
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(val(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
expected=[canonical_value(src.exact_fizeau_analysis(t)) for t in tests]
s='''import SFT.Physics.FizeauMeasurement
open SFT.Host.Canonical SFT.Physics.FizeauMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactFizeauAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/FizeauMeasurement1031.lean';p.write_text(s)
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'fizeau1031_measurement_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/FizeauMeasurement.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'fizeau1031_measurement_audit.lean';p.write_text('import SFT.Physics.FizeauMeasurement\n'+''.join('#print axioms SFT.Physics.FizeauMeasurement.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'fizeau1031_measurement_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'fizeau1031_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original exact_fizeau_analysis all fifteen returned fields, exact rational input conversions, complete interval/distance comparisons, original Python and result and limitation length behavior'),indent=2));print('PASS',len(tests),'full original Fizeau analyses;',len(names),'empty-axiom definitions')
