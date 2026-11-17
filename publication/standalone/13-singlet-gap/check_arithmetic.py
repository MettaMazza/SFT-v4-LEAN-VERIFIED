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
s=load('structural_constants',only=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three']);a=load('atomic_constants',s);l=load('lineage_particle_laws',{**s,**a});inventory=load('sector_inventory_law_v1',l);interaction=load('interaction_unification_terminal_law_v1');carrier=load('strong_carrier_massless_confined_terminal_law_v1',only=['strong_sector_structure','massless_causal_trace','confining_tube_trace','work_exceeds_positive_bound','simultaneous_carrier_certificate']);gap=load('yang_mills_singlet_gap_terminal_law_v1',{**inventory,**interaction,**carrier});v=load('yang_mills_singlet_gap_empirical_validation_v1',only=['exact_spectrum_analysis']);record=json.load(open(root/'v3/experiments/external_sources/physics/snapshots/yang-mills-singlet-gap-source-record.json'));analysis=v['exact_spectrum_analysis'](record['registered_target']);assert len(analysis)==9 and analysis['row_count']==3;assert all(analysis[k] for k in ['all_central_masses_positive','all_lower_edges_positive','intervals_strictly_ordered_and_disjoint','ground_state_scalar','first_excitation_tensor','scope_rows_retained']);target=copy.deepcopy(record['registered_target']);target['precise_lattice_rows'][0]['mass_mev']='2400';control=v['exact_spectrum_analysis'](target);assert not control['intervals_strictly_ordered_and_disjoint']
partition=gap['strong_gap_partition']();support=gap['physical_singlet_support']();assert partition['gap']==Fraction(1,3) and partition['coupling']==Fraction(2,3);assert support['singlet_supports']==(2,3)
traces={str(d):gap['singlet_gap_trace'](d) for d in [1,2,16,20,24]}
for d,t in traces.items():
 assert len(t['rows'])==int(d)
 for j,row in enumerate(t['rows'],1):assert row=={'depth':j,'normalized_singlet_gap':Fraction(1,3),'confinement_work':Fraction(2*j,3),'physical_support':2}
 assert all(t[k] for k in ['all_gaps_positive','gap_depth_invariant','work_positive_and_increasing','least_physical_state_is_singlet','local_carrier_One_speed','local_carrier_confined','local_masslessness_not_physical_gaplessness'])
assert gap['fold_part'](Fraction(1,3))==Fraction(2,3) and gap['fold_part'](Fraction(2,3))==Fraction(1,3)
certificate=carrier['simultaneous_carrier_certificate'](16)
assert certificate['all_registered_bounds_exceeded'] and certificate['simultaneously_massless_and_One_speed'] and certificate['simultaneously_confined']
guards=[]
for fn,inputs in [(gap['singlet_gap_trace'],[True,0,-1,Fraction(3,2)]),(gap['fold_part'],[0,Fraction(0),Fraction(4,3)]),(carrier['work_exceeds_positive_bound'],[0,Fraction(0),Fraction(-1)])]:
 for x in inputs:
  try:fn(x)
  except ValueError:guards.append((fn.__name__,str(x),'rejected'))
  else:raise AssertionError((fn.__name__,x))
r={'method':'Unchanged original pure functions and actual imported operations; all original returned fields retained. General native proofs and existing complete-program/build audits reused.','source_sha256':hashes,'partition':partition,'support':support,'traces':traces,'carrier_certificate':certificate,'spectrum_record':record,'spectrum_analysis':analysis,'altered_mass_control':control,'guards':guards}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if isinstance(v,dict):return {k:clean(x) for k,x in v.items()}
 if isinstance(v,(tuple,list)):return [clean(x) for x in v]
 return v
(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'gap':str(partition['gap']),'support':support['singlet_supports'],'trace_depths':list(traces),'spectrum_rows':len(analysis['rows']),'output_fields':len(analysis),'guards':len(guards),'control':'PASS'})
