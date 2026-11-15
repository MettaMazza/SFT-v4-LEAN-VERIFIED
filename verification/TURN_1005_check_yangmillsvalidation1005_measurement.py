from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from sft.physics import yang_mills_singlet_gap_empirical_validation_v1 as src
from sft.engine.canonical import canonical_value
rel=src.SOURCE_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_HASH
(root/rel).parent.mkdir(parents=True,exist_ok=True);(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target]
for key in ['quenched_approximation_neglects_quark_loops','glue_and_quark_antiquark_states_can_mix','full_qcd_requires_dynamical_light_quarks_mixing_control_and_high_statistics','pdg_reports_no_scalar_below_2_gev_as_predominantly_glueball','unambiguous_experimental_glueball_identification','dimensionful_mass_selected_formal_fold_gap']:
 for value in [False,True,0,1,'',[],[1],None]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for i in range(3):
 for key in ['mass_mev','standard_uncertainty_mev']:
  for value in ['0','-2','1/3','2400',True,8]:
   t=copy.deepcopy(target);t['precise_lattice_rows'][i][key]=value;tests.append(t)
for order in [[2,1,0],[0,2,1],[0,1,2,2]]:
 t=copy.deepcopy(target);t['precise_lattice_rows']=[target['precise_lattice_rows'][i] for i in order];tests.append(t)
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(val(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
expected=[canonical_value(src.exact_spectrum_analysis(t)) for t in tests]
s='''import SFT.Physics.YangMillsSpectrumMeasurement
open SFT.Host.Canonical SFT.Physics.YangMillsSpectrumMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactSpectrumAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/YangMillsMeasurement1005.lean';p.write_text(s)
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'yangmillsvalidation1005_measurement_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/YangMillsSpectrumMeasurement.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'yangmillsvalidation1005_measurement_audit.lean';p.write_text('import SFT.Physics.YangMillsSpectrumMeasurement\n'+''.join('#print axioms SFT.Physics.YangMillsSpectrumMeasurement.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'yangmillsvalidation1005_measurement_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'yangmillsvalidation1005_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original exact_spectrum_analysis all nine returned fields, complete six-field rows, ordered intervals, original truthiness and identity scope checks'),indent=2));print('PASS',len(tests),'full original spectrum analyses;',len(names),'empty-axiom definitions')
