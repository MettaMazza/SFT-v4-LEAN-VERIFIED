from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()));from sft.physics import strong_field_nonlinear_fixed_point_terminal_validation_v1 as src
rel=src.SOURCE_RECORD_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_RECORD_HASH;(root/rel).parent.mkdir(parents=True,exist_ok=True);(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target,dict(reversed(list(target.items())))];q=json.dumps
def val(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
for key,value in target.items():
 t=copy.deepcopy(target);t[key]=not value if isinstance(value,bool) else 'changed';tests.append(t)
for key in ['pdg_qcd_nonabelian_gauge_theory', 'pdg_qcd_gluon_carries_colour_charge', 'pdg_qcd_three_and_four_gluon_self_interactions', 'pdg_qcd_free_quarks_observed', 'lattice_full_QCD_pair_creation', 'lattice_full_QCD_ground_state_saturates', 'lattice_string_and_broken_string_mixing_required', 'lattice_single_ensemble', 'lattice_quark_masses_are_not_physical', 'lattice_distances_are_not_universal_physical_thresholds', 'external_values_select_formal_survivor', 'external_distances_used_as_formal_proof_scalars', 'measured_parameter_fitted_into_v3', 'free_strong_field_correction_added_to_v3']:
 for value in [0,1,'false','',[],{}]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
t=copy.deepcopy(target);t['extra']='retained';tests.append(t)
from sft.engine.canonical import canonical_value
expected=[canonical_value(src.exact_measurement_analysis(t)) for t in tests]
s='''import SFT.Physics.StrongFieldMeasurement
open SFT.Physics.StrongFieldMeasurement SFT.Host.Canonical
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
#eval IO.println (render (.array [
'''+',\n'.join('result (exactMeasurementAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/StrongFieldMeasurement987.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[i for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/StrongFieldMeasurement.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'strongfield987_measurement_audit.lean';p.write_text('import SFT.Physics.StrongFieldMeasurement\n'+''.join('#print axioms SFT.Physics.StrongFieldMeasurement.'+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);(w/'strongfield987_measurement_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names) and 'depends on axioms:' not in out
(w/'strongfield987_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all23fields=True,axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest()),indent=2));print('PASS',len(tests),'complete23fieldcases;',len(names),'emptydefinitions')
