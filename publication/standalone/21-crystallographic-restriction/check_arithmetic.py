from pathlib import Path
import ast,types,sys,json,math,itertools
root=Path(__file__).resolve().parents[1];dest=root
sys.dont_write_bytecode=True
def module(name,relative,bindings=None):
 p=root/'v3'/relative;tree=ast.parse(p.read_text(),filename=relative)
 tree.body=[n for n in tree.body if not (isinstance(n,ast.ImportFrom) and (n.module or '').startswith('sft.'))]
 m=types.ModuleType(name);sys.modules[name]=m;m.__dict__.update(bindings or {});exec(compile(tree,relative,'exec'),m.__dict__);return m
exact=module('paper21_exact','sft/engine/exact.py')
bindings={n:getattr(exact,n) for n in ['PositiveCount','HeldLabel','InadmissibleExactValue']}
s=module('paper21_counts','sft/materials/structural_counts.py',bindings);u=module('paper21_successor','sft/materials/successor_structural_counts.py',bindings);P=exact.PositiveCount
orders=[]
for n in range(1,513):
 actual=s.totient_count(P(n)).value;assert actual==sum(math.gcd(n,k)==1 for k in range(1,n+1))
 if s.crystallographic_rotation_admitted(P(n)):orders.append(n)
assert orders==[1,2,3,4,6]==[x.value for x in s.allowed_crystallographic_orders()]
metrics=list(itertools.product(s.LENGTH_CLASSES,s.ANGLE_CLASSES));systems=s.crystal_system_census();assert len(metrics)==12 and len(systems)==7 and len({x.name for x in systems})==7
assert sum(s._system_name(l,a) is None for l,a in metrics)==5
bravais=s.bravais_census();assert len(bravais)==len(set(bravais))==14
assert sum(not s._centering_preserves_system(x.name,c) for x in systems for c in s.CENTERING_CLASSES)==21
for depth in range(1,129):
 rows=u.substitution_populations(P(depth));assert len(rows)==depth
 for a,b in zip(rows,rows[1:]):assert (b.first.value,b.second.value)==(a.first.value+a.second.value,a.first.value)
assert [(x.first.value,x.second.value) for x in u.substitution_populations(P(6))]==[(1,1),(2,1),(3,2),(5,3),(8,5),(13,8)]
pairs=0
for p in range(1,129):
 for q in range(1,129):
  if math.gcd(p,q)==1:assert p*p!=p*q+q*q;pairs+=1
assert u.rational_inflation_fixed_point_certificate()['least_candidate_rejected'] is True
result={'status':'PASS','original_source_functions_executed_without_package_initializers':True,'rotation_orders_checked':512,'metric_forms':12,'retained_systems':7,'centering_forms':35,'bravais_classes':14,'population_depths':128,'coprime_rational_examples':pairs,'general_rotation_and_rational_exclusion_proofs':'retained native Lean proof bodies; finite checks are reproduction examples','new_lean_builds':0}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
