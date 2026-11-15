from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from sft.physics import proton_radius_terminal_validation_v1 as src
from sft.engine.canonical import canonical_value
rel=src.SOURCE_RECORD_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_RECORD_HASH;(root/rel).parent.mkdir(parents=True,exist_ok=True);(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target]
for key in ['value_fm','standard_uncertainty_fm']:
 for value in ['0','-2','1/3','0.210308910051','0.000000000066',True,8]:
  t=copy.deepcopy(target);t['dimension_scale'][key]=value;tests.append(t)
for i in range(4):
 row=target['current_radius_rows'][i]
 for key in [k for k in row if 'uncertainty_fm' in k or k=='value_fm']:
  for value in ['0','0.8200','0.0010','-1','0.8406']:
   t=copy.deepcopy(target);t['current_radius_rows'][i][key]=value;tests.append(t)
for i in range(4):
 t=copy.deepcopy(target);t['current_radius_rows'].append(copy.deepcopy(t['current_radius_rows'][i]));tests.append(t)
for value in [True,False,0,1,'',[],[1],None]:
 t=copy.deepcopy(target);t['scope_rows'][next(iter(t['scope_rows']))]=value;tests.append(t)
t=copy.deepcopy(target);t['scope_rows'].pop(next(iter(t['scope_rows'])));tests.append(t)
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(val(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
expected=[]
for t in tests:
 try:expected.append(canonical_value(src.exact_measurement_analysis(t)))
 except ValueError as e:expected.append({'error':str(e)})
s='''import SFT.Physics.ProtonRadiusMeasurement
open SFT.Host.Canonical SFT.Physics.ProtonRadiusMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/ProtonRadiusMeasurement1007.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'proton_radius1012_measurement_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/ProtonRadiusMeasurement.lean').read_text();p=w/'proton_radius1012_measurement_audit.lean';p.write_text('import SFT.Physics.ProtonRadiusMeasurement\n#print axioms SFT.Physics.ProtonRadiusMeasurement.exactMeasurementAnalysis\n');x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'proton_radius1012_measurement_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==1,x.stdout
(w/'proton_radius1012_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=['SFT.Physics.ProtonRadiusMeasurement.exactMeasurementAnalysis'],source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Complete13field original radius analysis,all9formula rows,fourcurrentintervals,historicalconflict,positivewidth guards,duplicate-row overwrite andscope truthiness'),indent=2));print('PASS',len(tests),'complete original13-field analyses;empty axiom definition')
