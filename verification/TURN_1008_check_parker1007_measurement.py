from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from sft.physics import parker_proton_energy_terminal_validation_v1 as src
from sft.engine.canonical import canonical_value
rel=src.SOURCE_RECORD_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_RECORD_HASH;(root/rel).parent.mkdir(parents=True,exist_ok=True);(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target]
for group,keys in [('proton_rest_energy',['value_MeV','standard_uncertainty_MeV']),('parker_event',['spectral_analysis_lower_keV','spectral_analysis_upper_keV'])]:
 for key in keys:
  for value in ['0','-2','1/3','300','1000','938.27208943',True,8]:
   t=copy.deepcopy(target);t[group][key]=value;tests.append(t)
for key in ['approximately_400_has_reported_standard_uncertainty','approximately_400_is_exact_cutoff_measurement']:
 for v in [False,True,0,1,'',[],[1],None]:
  t=copy.deepcopy(target);t['parker_event'][key]=v;tests.append(t)
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(val(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
expected=[canonical_value(src.exact_measurement_analysis(t)) for t in tests]
s='''import SFT.Physics.ParkerMeasurement
open SFT.Host.Canonical SFT.Physics.ParkerMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/ParkerMeasurement1007.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'parker1007_measurement_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/ParkerMeasurement.lean').read_text();p=w/'parker1007_measurement_audit.lean';p.write_text('import SFT.Physics.ParkerMeasurement\n#print axioms SFT.Physics.ParkerMeasurement.exactMeasurementAnalysis\n');x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'parker1007_measurement_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==1,x.stdout
(w/'parker1007_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=['SFT.Physics.ParkerMeasurement.exactMeasurementAnalysis'],source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Complete14field original analysis,all12adverseformula rows,exact intervals,absolute/relative differences and raw precision flags'),indent=2));print('PASS',len(tests),'complete original14-field analyses;empty axiom definition')
