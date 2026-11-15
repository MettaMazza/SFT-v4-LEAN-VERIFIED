from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()));from sft.physics import strong_carrier_massless_confined_terminal_validation_v1 as src
rel=src.SOURCE_RECORD_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_RECORD_HASH;(root/rel).parent.mkdir(parents=True,exist_ok=True);(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target,dict(reversed(list(target.items())))];q=json.dumps
def val(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
for key,value in target.items():
 t=copy.deepcopy(target);t[key]=not value if isinstance(value,bool) else 'changed';tests.append(t)
for key in ['pdg_qcd_nonlinear_field_term_present','pdg_qcd_three_gluon_vertex_present','pdg_qcd_four_gluon_vertex_present','pdg_qcd_free_quarks_or_gluons_observed','pdg_qcd_hadrons_are_colour_singlets','direct_free_gluon_time_of_flight_measurement_available','external_values_select_formal_survivor','external_mass_value_used_as_formal_proof_scalar','measured_parameter_fitted_into_v3','free_carrier_correction_added_to_v3']:
 for value in [0,1,'false','',[],{}]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
t=copy.deepcopy(target);t['extra']='retained';tests.append(t)
from sft.engine.canonical import canonical_value
expected=[canonical_value(src.exact_measurement_analysis(t)) for t in tests]
s='''import SFT.Physics.StrongCarrierMeasurement
open SFT.Physics.StrongCarrierMeasurement SFT.Host.Canonical
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/StrongCarrierMeasurement986.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[i for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/StrongCarrierMeasurement.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'strongcarrier986_measurement_audit.lean';p.write_text('import SFT.Physics.StrongCarrierMeasurement\n'+''.join('#print axioms SFT.Physics.StrongCarrierMeasurement.'+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);(w/'strongcarrier986_measurement_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names) and 'depends on axioms:' not in out
(w/'strongcarrier986_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all36fields=True,axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest()),indent=2));print('PASS',len(tests),'complete36fieldcases;',len(names),'emptydefinitions')
