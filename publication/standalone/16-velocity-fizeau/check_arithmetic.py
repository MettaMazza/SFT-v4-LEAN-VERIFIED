from pathlib import Path
from fractions import Fraction
import ast,json,hashlib,copy
from enum import Enum
from itertools import product
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(exist_ok=True)
hashes={}
def load(name,extra=None,only=None):
 f=root/'v3/sft/physics'/(name+'.py');g={'Fraction':Fraction,'Enum':Enum,'product':product};g.update(extra or {});hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest()
 for n in ast.parse(f.read_text()).body:
  if isinstance(n,ast.ClassDef) and n.name in ['TypedRest','TypedEmpty']:
   exec(compile(ast.fix_missing_locations(ast.Module(body=[n],type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.FunctionDef) and (only is None or n.name in only):exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n],type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:g[n.targets[0].id]=ast.literal_eval(n.value)
   except (ValueError,TypeError):
    if isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Name) and n.value.func.id=='Fraction':g[n.targets[0].id]=Fraction(*(ast.literal_eval(x) for x in n.value.args))
 return g


g=load('velocity_composition_terminal_law_v1');g['REST']=g['TypedRest'].REST;g['EMPTY']=g['TypedEmpty'].EMPTY
rows=g['bilinear_candidates']();certificate=g['theorem_certificate']();assert len(rows)==4 and certificate['candidate_count']==4 and all(v is True for k,v in certificate.items() if k not in ['candidate_count','survivor'])
constants=load('velocity_composition_fizeau_empirical_v1',only=[])
def hash_file(p):return 'sha256:'+hashlib.sha256(Path(p).read_bytes()).hexdigest()
v=load('velocity_composition_fizeau_validation_v1',{**constants,'hash_file':hash_file,'json':json})
record=v['authoritative_record'](root/'v3');analysis=v['exact_fizeau_analysis'](record['registered_target']);assert len(analysis)==15
assert all(analysis[k] for k in ['measurement_inside_complete_relativistic_systematics_bracket','relativistic_more_than_ten_times_closer','ordinary_outside_measurement_interval','air_control_retained','all_limitations_retained'])
tampered=copy.deepcopy(record['registered_target']);tampered['ordinary_addition_prediction_rad_s_per_m']=tampered['water_measured_slope_rad_s_per_m'];adverse=v['exact_fizeau_analysis'](tampered);assert not adverse['relativistic_more_than_ten_times_closer'] and not adverse['ordinary_outside_measurement_interval']
grid=g['exact_closure_grid']();pairs=[]
for u in grid:
 for w in grid:
  c=g['compose_same_direction'](u,w);p=g['compose_held_pairs'](u,w);back=g['recover_speed'](p);assert back==c;pairs.append({'left':u,'right':w,'result':c,'pair':p,'recovered':back})
rest=[{'value':str(x),'left':g['compose_same_direction'](g['REST'],x),'right':g['compose_same_direction'](x,g['REST'])} for x in [g['REST'],Fraction(0),Fraction(2),Fraction(1,2)]]
guards=[]
for x in [Fraction(0),Fraction(-1),Fraction(5,4)]:
 try:g['compose_same_direction'](x,Fraction(1,2))
 except ValueError as e:guards.append({'input':str(x),'error':str(e)})
 else:raise AssertionError(x)
def clean(x):
 if isinstance(x,Fraction):return str(x)
 if isinstance(x,Enum):return x.value
 if isinstance(x,dict):return {k:clean(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return [clean(v) for v in x]
 return x
out={'source_sha256':hashes,'bilinear_census':rows,'certificate':certificate,'grid':grid,'complete_pair_records':pairs,'typed_rest_branch_order':rest,'guard_checks':guards,'fizeau_source_record':record,'fizeau_analysis':analysis,'adverse_analysis':adverse,'method':'Unchanged original functions and exact typed enum definitions; both source-byte bindings and full original15field numerical comparison retained. General native operation proofs and full-program audits reused.'};(dest/'arithmetic_check.json').write_text(json.dumps(clean(out),indent=2)+'\n');print({'status':'PASS','census':len(rows),'grid_pairs':len(pairs),'certificate_fields':len(certificate),'fizeau_fields':len(analysis),'tampered_control':'rejected'})
