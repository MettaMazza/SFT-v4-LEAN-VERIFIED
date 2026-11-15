from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()));from sft.physics import symmetric_source_conservation_terminal_validation_v1 as src
rel=src.SOURCE_RECORD_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_RECORD_HASH;(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target,dict(reversed(list(target.items())))];q=json.dumps
def val(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
for key,value in target.items():
 t=copy.deepcopy(target);t[key]=not value if isinstance(value,bool) else 'changed';tests.append(t)
for key in ['regge_exact_discrete_identity','regge_arbitrary_curvature_validity','regge_general_identity_linear_in_curvature','regge_operator_identical_to_v3_commuting_difference_operator','ligo_mixed_mode_tested']:
 for value in [0,1,'false']:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for key in ['v1_source_entry','v1_planar_slots','v1_balanced_source_conserved','v1_leaking_source_rejected','measured_parameter_fitted_into_v3']:
 t=copy.deepcopy(target);t.pop(key);tests.append(t)
t=copy.deepcopy(target);t['extra']='retained';tests.append(t)
expected=[src.exact_measurement_analysis(t) for t in tests]
s='''import SFT.Physics.SymmetricMeasurement
open SFT.Physics.SymmetricMeasurement SFT.Host.Canonical
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/SymmetricMeasurement980.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[i for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/SymmetricMeasurement.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'symmetric980_measurement_audit.lean';p.write_text('import SFT.Physics.SymmetricMeasurement\n'+''.join('#print axioms SFT.Physics.SymmetricMeasurement.'+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);(w/'symmetric980_measurement_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names) and 'depends on axioms:' not in out
(w/'symmetric980_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all18fields=True,axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest()),indent=2));print('PASS',len(tests),'complete18fieldcases;',len(names),'emptydefinitions')
