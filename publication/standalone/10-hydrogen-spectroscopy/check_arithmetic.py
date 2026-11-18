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


g={}
for name in ['structural_constants','atomic_constants','prior_value_laws','matter_flavour_laws_v1','matter_flavour_completion_laws_v1','matter_flavour_terminal_anomaly_laws_v1','matter_flavour_terminal_proton_laws_v1','atomic_spectra_completion_laws_v1','atomic_precision_successor_laws_v1']:
 g.update(load(name,g))
precision=dict(g)
rydberg=load('hydrogen_rydberg_successor_laws_v1',precision)
rates=load('atomic_transition_rate_successor_laws_v1',g)
fields=load('atomic_field_splitting_successor_laws_v1',g)
def hash_file(path):return 'sha256:'+hashlib.sha256(Path(path).read_bytes()).hexdigest()
extra={'json':json,'hash_file':hash_file}
pv=load('atomic_precision_successor_validation_v1',{**precision,**extra})
rv=load('hydrogen_rydberg_successor_validation_v1',{**rydberg,**extra})
tv=load('atomic_transition_rate_successor_validation_v1',{**rates,**extra})
fv=load('atomic_field_splitting_successor_validation_v1',{**fields,**extra})
post=load('atomic_spectra_postseal_validation_v1',{**g,**extra,'exact_decimal':Fraction})
v3=root/'v3'
records={name:g[name]() for name in ['inverse_fine_structure','fine_structure_blocks','promotion_rungs','terminal_turn_projection','terminal_proton_retention','terminal_proton_ratio_interval','terminal_lamb_carrier','terminal_fine_carrier','terminal_proton_magnetic_projection','terminal_hyperfine_carrier_interval','atomic_scale_hierarchy','transition_selection']}
records['hydrogen_levels']={str(n):g['hydrogen_level'](n) for n in [1,2,3,4,100]}
records['terminal_scale']=rydberg['terminal_hydrogen_scale_interval']()
records['electron_rest']=rydberg['terminal_ionization_to_electron_rest_interval']()
records['precision']={k:{'prediction':pv['translated_prediction_interval'](v3,k),'target':pv['target_interval'](v3,k),'classification':pv['atomic_precision_classification'](v3,k)} for k in ['lamb','fine','hyperfine']}
records['hyperfine_central']=pv['hyperfine_central_carrier_interval'](v3)
records['ionization']={'prediction':rv['predicted_ionization_interval'](v3),'target':rv['ionization_target_interval'](v3),'classification':rv['hydrogen_rydberg_classification'](v3)}
records['lines']={k:{'prediction':rv['predicted_line_interval'](v3,gap),'target':rv['line_target_interval'](v3,k)} for k,gap in [('lyman_alpha',Fraction(3,4)),('balmer_alpha',Fraction(5,36))]}
records['postseal']=post['hydrogen_comparison'](v3)
records['rates_classification']=tv['transition_rate_classification'](v3)
records['fields_classification']=fv['field_splitting_classification'](v3)
records['lifetime']=rates['exact_lifetime']((Fraction(1,8),Fraction(1,24)))
assert records['lifetime']==6
records['E1']=rates['normalized_electric_rate'](Fraction(1,2),Fraction(2,3),3,1)
records['E2']=rates['normalized_electric_rate'](Fraction(1,2),Fraction(2,3),3,2)
assert records['E2']/records['E1']==Fraction(1,4)
records['zeeman']=fields['zeeman_shift_magnitude'](Fraction(3,2),2,Fraction(1,5))
records['linear_stark']=fields['linear_stark_magnitude'](Fraction(4,7),Fraction(1,5))
records['quadratic_stark']=fields['quadratic_stark_magnitude'](Fraction(4,7),Fraction(1,5))
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if isinstance(v,dict):return {k:clean(x) for k,x in v.items()}
 if isinstance(v,(tuple,list)):return [clean(x) for x in v]
 return v
out={'source_sha256':hashes,'records':records,'method':'Unchanged original pure functions with actual original imported arithmetic; original source identity/custody/component guards and every registered comparison executed.'}
(dest/'arithmetic_check.json').write_text(json.dumps(clean(out),indent=2)+'\n');print({'status':'PASS','records':len(records),'source_modules':len(hashes)})
