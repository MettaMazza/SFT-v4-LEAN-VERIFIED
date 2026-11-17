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

from functools import lru_cache
from itertools import product, combinations
q=load('quantum_support_uncertainty_terminal_law_v1',{'lru_cache':lru_cache,'product':product,'combinations':combinations})
v=load('quantum_support_uncertainty_validation_v1',only=['exact_quantum_support_bell_analysis'])
record=json.loads((root/'v3/experiments/external_sources/physics/snapshots/quantum-support-bell-postseal-source-record.json').read_text())
analysis=v['exact_quantum_support_bell_analysis'](record['registered_target']);assert len(analysis)==14 and all(x for k,x in analysis.items() if k!='bell_interval')
controls={}
for key,value,field in [('bell_parameter_center',19900,'complete_interval_above_local_bound'),('trial_duration_nanoseconds_center_hundredths',11100,'space_like_interval_separation')]:
 target=copy.deepcopy(record['registered_target']);target[key]=value;controls[key]=v['exact_quantum_support_bell_analysis'](target);assert controls[key][field] is False
census=q['complete_walsh_census'](4);certificate=q['theorem_certificate']();assert all(certificate.values())
joints={str((m,n)):q['joint_subset_census'](m,n) for m,n in [(2,3),(3,5)]}
bell=q['bell_local_record_census']();inclusive=q['setting_inclusive_no_signal_support']()
guards=[]
for name,values in [('binary_words',[True,0,-1]),('preparation_depth',[True,0,1,3,6]),('complete_walsh_census',[False,0,-1])]:
 for value in values:
  try:q[name](value)
  except ValueError:guards.append((name,str(value),'rejected'))
  else:raise AssertionError((name,value))
r={'source_sha256':hashes,'census':census,'certificate':certificate,'joint_censuses':joints,'bell':bell,'inclusive':inclusive,'record':record,'analysis':analysis,'controls':controls,'guards':guards}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if isinstance(v,dict):return {k:clean(x) for k,x in v.items()}
 if isinstance(v,(tuple,list)):return [clean(x) for x in v]
 return v
(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'census':census,'certificate':certificate,'analysis_fields':len(analysis),'controls':len(controls),'guards':len(guards)})
