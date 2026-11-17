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
s=load('structural_constants',only=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three']);a=load('atomic_constants',s);l=load('lineage_particle_laws',{**s,**a});energy=load('parker_proton_energy_terminal_law_v1',{**a,**l});radius=load('proton_radius_terminal_law_v1',{**s,**a});ev=load('parker_proton_energy_terminal_validation_v1',energy,only=['exact_measurement_analysis']);rv=load('proton_radius_terminal_validation_v1',radius,only=['exact_interval','interval_contains','exact_measurement_analysis']);er=json.load(open(root/'v3/experiments/external_sources/physics/snapshots/parker-proton-energy-source-record.json'));rr=json.load(open(root/'v3/experiments/external_sources/physics/snapshots/proton-radius-terminal-source-record.json'));ea=ev['exact_measurement_analysis'](er['registered_target']);ra=rv['exact_measurement_analysis'](rr['registered_target']);assert len(ea)==14 and len(ra)==13;assert ea['adverse_inside_range']==((2,2),(3,2));assert ra['adverse_inside_muonic_interval']==((8,'linear'),(9,'linear'),(10,'linear'));assert ea['terminal_inside_complete_range'] and ea['leading_inside_complete_range'];assert ra['all_current_intervals_contain_prediction'] and ra['historical_conflict_retained'] and ra['scope_rows_retained']
et=copy.deepcopy(er['registered_target']);et['parker_event']['spectral_analysis_upper_keV']='300';rt=copy.deepcopy(rr['registered_target']);rt['current_radius_rows'][0]['value_fm']='0.8200';rt['current_radius_rows'][0]['standard_uncertainty_fm']='0.0010';ec=ev['exact_measurement_analysis'](et);rc=rv['exact_measurement_analysis'](rt);assert not ec['terminal_inside_complete_range'] and not rc['all_current_intervals_contain_prediction']
r={'method':'Unchanged original pure function bodies and actual structural/atomic/lineage imports; exact Fraction arithmetic; complete original output vectors and controls. Native proof/build/full-program evidence reused.','source_sha256':hashes,'energy_fraction':energy['proton_energy_fraction'](),'leading_energy_fraction':energy['historical_leading_fraction'](),'radius_coefficient':radius['terminal_radius_coefficient'](),'energy_analysis':ea,'radius_analysis':ra,'energy_target':er['registered_target'],'radius_target':rr['registered_target'],'energy_control':ec,'radius_control':rc}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if isinstance(v,dict):return {k:clean(x) for k,x in v.items()}
 if isinstance(v,(tuple,list)):return [clean(x) for x in v]
 return v
(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'fields':[len(ea),len(ra)],'censuses':[len(ea['adverse_formula_rows']),len(ra['adverse_formula_rows'])],'energy':float(ea['terminal_prediction_centre_keV']),'radius':float(ra['terminal_prediction_centre_fm']),'controls':'PASS'})
