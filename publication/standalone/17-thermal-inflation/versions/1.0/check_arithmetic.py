from pathlib import Path
from fractions import Fraction
import ast,json,hashlib,copy
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(exist_ok=True)
hashes={}
def load(name,extra=None,only=None):
 f=root/'v3/sft/physics'/(name+'.py');g={'Fraction':Fraction};g.update(extra or {});hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest()
 for n in ast.parse(f.read_text()).body:
  if isinstance(n,ast.FunctionDef) and (only is None or n.name in only):exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n],type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:g[n.targets[0].id]=ast.literal_eval(n.value)
   except (ValueError,TypeError):
    if isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Name) and n.value.func.id=='Fraction':g[n.targets[0].id]=Fraction(*(ast.literal_eval(x) for x in n.value.args))
 return g
s=load('structural_constants',only=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three']);atomic=load('atomic_constants',s);budget=load('cosmic_budget_law',{**s,**atomic});thermal=load('thermal_history_recombination_terminal_law_v1');inflation=load('inflation_growth_terminal_law_v1');isotope=load('helium_isotope_closure_terminal_law_v1',thermal);cosmic=load('cosmic_component_transport_terminal_law_v1');oldtv=load('thermal_history_validation_v1',only=['exact_thermal_analysis']);tv=load('thermal_history_measured_value_successor_validation_v1',isotope,only=['interval','exact_thermal_analysis']);iv=load('inflation_growth_validation_v1',only=['exact_inflation_analysis']);cv=load('cosmic_transport_measured_value_successor_validation_v1',cosmic,only=['decimal','interval','initial_root_bracket','refine_root_bracket','normalized_squared_residual_bounds','complete_residual_certificate','exact_cosmic_analysis'])
recroot=root/'v3/experiments/external_sources/physics/snapshots'
def record(n):return json.loads((recroot/(n+'.json')).read_text())
toriginal=record('thermal-history-postseal-source-record');ttarget={'record':record('thermal-history-measured-value-successor-source-record'),'original':toriginal};itarget=record('inflation-growth-postseal-source-record')['registered_target'];coriginal=record('cosmic_transport_terminal-source-record');ctarget={'record':record('cosmic-transport-measured-value-successor-source-record'),'original':coriginal};oldta=oldtv['exact_thermal_analysis'](toriginal['registered_target']);ta=tv['exact_thermal_analysis'](ttarget);ia=iv['exact_inflation_analysis'](itarget);ca=cv['exact_cosmic_analysis'](ctarget)
assert len(oldta)==18 and len(ta)==14 and len(ia)==10 and len(ca)==16
assert all(v for v in ta.values() if isinstance(v,bool)) and all(v for v in ia.values() if isinstance(v,bool)) and all(v for v in ca.values() if isinstance(v,bool));assert oldta['exact_quarter_excluded'] and oldta['angular_integer_multiple_claim_rejected']
assert ca['residual_certificate']['refinements']==3 and ca['residual_certificate']['row_count']==32
controls={}
t=copy.deepcopy(toriginal['registered_target']);t['cmb_temperature_exponent_central']='1.100';controls['temperature']=oldtv['exact_thermal_analysis'](t);assert not controls['temperature']['exact_one_inside_temperature_interval']
t=copy.deepcopy(ttarget);t['original']['registered_target']['primordial_helium_mass_fraction_central']='0.2300';t['original']['registered_target']['primordial_helium_mass_fraction_standard_uncertainty']='0.0001';controls['helium']=tv['exact_thermal_analysis'](t);assert not controls['helium']['physical_helium_59_over_240_passed']
t=copy.deepcopy(ttarget);t['original']['registered_target']['planck_detected_peak_count']=17;controls['peaks']=tv['exact_thermal_analysis'](t);assert not controls['peaks']['complete_peak_census_retained']
t=copy.deepcopy(itarget);t['planck_scalar_index_central']='0.9';controls['inflation']=iv['exact_inflation_analysis'](t);assert not controls['inflation']['scalar_inside_interval']
t=copy.deepcopy(ctarget);t['original']['cosmic_chronometers']['rows'][0]['central']='1000';controls['chronometer']=cv['exact_cosmic_analysis'](t);assert not controls['chronometer']['chronometer_unit_residual_passed']
t=copy.deepcopy(ctarget);t['record']['corrected_acceleration_target'].update(transition_redshift_center='1.50',transition_redshift_lower_uncertainty='0.01',transition_redshift_upper_uncertainty='0.01');controls['transition']=cv['exact_cosmic_analysis'](t);assert not controls['transition']['onset_inside_Haridasu_transition_interval']
rows=[]
for pos,row in enumerate(coriginal['cosmic_chronometers']['rows'],1):
 z=Fraction(row['redshift']);e=cosmic['late_squared_expansion'](1+z);bracket=cv['initial_root_bracket'](e);rows.append({'position':pos,'redshift':z,'observed':Fraction(row['central']),'uncertainty':Fraction(row['standard_uncertainty']),'e2':e,'root_bracket':bracket})
h0=Fraction(coriginal['hubble_reference']['central']);u0=Fraction(coriginal['hubble_reference']['standard_uncertainty']);history=[]
for round in range(4):
 bounds=[cv['normalized_squared_residual_bounds'](row['observed'],row['uncertainty'],h0,u0,row['e2'],row['root_bracket']) for row in rows];history.append({'refinements':round,'mean_lower':sum(x[0] for x in bounds)/32,'mean_upper':sum(x[1] for x in bounds)/32})
 if round<3:
  for row in rows:row['root_bracket']=cv['refine_root_bracket'](row['e2'],row['root_bracket'])
assert history[-1]['mean_upper']==ca['residual_certificate']['mean_squared_residual_upper']
r={'method':'Unchanged original pure functions and actual source imports; complete records and controls; general native proof/build evidence reused.','source_sha256':hashes,'thermal_certificate':thermal['theorem_certificate'](),'capture':thermal['freezeout_capture_ledger'](),'visibility':{str(k):thermal['visibility_ledger'](k) for k in range(1,9)},'modes':thermal['acoustic_mode_ledger'](8),'inflation_certificate':inflation['theorem_certificate'](),'transfers':{str(g):inflation['forward_component_transfer'](g) for g in [Fraction(1,2),Fraction(1),Fraction(3,2),Fraction(2),Fraction(3)]},'isotope':isotope['isotope_closure_ledger'](),'budget':budget['cosmic_budget_structure'](),'old_thermal_analysis':oldta,'thermal_analysis':ta,'inflation_analysis':ia,'cosmic_analysis':ca,'thermal_target':ttarget,'inflation_target':itarget,'cosmic_target':ctarget,'chronometer_rows':rows,'residual_history':history,'controls':controls}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if isinstance(v,dict):return {k:clean(x) for k,x in v.items()}
 if isinstance(v,(tuple,list)):return [clean(x) for x in v]
 return v
(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'analyses':[len(oldta),len(ta),len(ia),len(ca)],'rows':len(rows),'refinements':3,'mean_upper':float(history[-1]['mean_upper']),'controls':list(controls),'helium':str(r['isotope']['physical_helium_isotope_share'])})
