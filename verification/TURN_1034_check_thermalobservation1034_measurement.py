from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from sft.physics import thermal_history_validation_v1 as src
from sft.engine.canonical import canonical_value
rel=src.SOURCE_PATH;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(b).hexdigest()==src.SOURCE_HASH
(root/rel).parent.mkdir(parents=True,exist_ok=True);(root/rel).write_bytes(b);target=json.loads(b)['registered_target'];tests=[target]
for key in ['all_registered_rows_retained','planck_detected_peak_count','pdg_freezeout_neutron_proton_label','pdg_capture_entry_neutron_proton_label','pdg_analytic_helium_partition_label']:
 for value in [False,True,0,1,'',[],[1],None]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
for key in ['cmb_temperature_exponent_central', 'cmb_temperature_exponent_standard_uncertainty', 'primordial_helium_mass_fraction_central', 'primordial_helium_mass_fraction_standard_uncertainty', 'primordial_deuterium_times_100000_central', 'primordial_deuterium_times_100000_standard_uncertainty', 'planck_recombination_redshift_central', 'planck_recombination_redshift_standard_uncertainty']:
 for value in ['1/7','-2','1/3','0.6000',True,8]:
  t=copy.deepcopy(target);t[key]=value;tests.append(t)
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(val(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
expected=[canonical_value(src.exact_thermal_analysis(t)) for t in tests]
s='''import SFT.Physics.ThermalObservationMeasurement
open SFT.Host.Canonical SFT.Physics.ThermalObservationMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (exactThermalAnalysis ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/ThermalObservationMeasurement1031.lean';p.write_text(s)
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'thermalobservation1034_measurement_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/ThermalObservationMeasurement.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'thermalobservation1034_measurement_audit.lean';p.write_text('import SFT.Physics.ThermalObservationMeasurement\n'+''.join('#print axioms SFT.Physics.ThermalObservationMeasurement.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'thermalobservation1034_measurement_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'thermalobservation1034_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original exact_thermal_analysis all eighteen returned fields, exact rational input conversions, complete interval/distance comparisons, original Python and result and limitation length behavior'),indent=2));print('PASS',len(tests),'full original ThermalObservation analyses;',len(names),'empty-axiom definitions')
