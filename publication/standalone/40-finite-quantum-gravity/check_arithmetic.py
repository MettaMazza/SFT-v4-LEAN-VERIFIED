from pathlib import Path
from fractions import Fraction
from dataclasses import dataclass,replace,asdict,is_dataclass
from functools import lru_cache
from itertools import product,permutations,combinations_with_replacement
from collections import Counter
from math import gcd
import ast,json,hashlib,types,sys
root=Path(__file__).resolve().parents[1];p=root;p.mkdir(exist_ok=True)
mods={};trees={};sources={}
for short in ['post_newtonian_fixed_point_terminal_law_v1','symmetric_source_conservation_terminal_law_v1','lattice_operator_terminal_law_v1','finite_quantum_gravity_terminal_law_v1','fold_universe_transport_terminal_law_v1']:
 f=root/'v3/sft/physics'/(short+'.py');t=ast.parse(f.read_text());trees[short]=t;sources[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest();m=types.ModuleType(short);sys.modules[short]=m;g=m.__dict__;g.update(Fraction=Fraction,dataclass=dataclass,replace=replace,lru_cache=lru_cache,product=product,permutations=permutations,combinations_with_replacement=combinations_with_replacement,Counter=Counter,gcd=gcd);mods[short]=g
 for n in t.body:
  if isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:v=ast.literal_eval(n.value)
   except (ValueError,TypeError):
    if isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Name) and n.value.func.id=='Fraction':v=Fraction(*(ast.literal_eval(a) for a in n.value.args))
    elif n.targets[0].id=='COORDINATE_ORDER':v=eval(compile(ast.Expression(n.value),str(f),'eval'),g)
    else:continue
   g[n.targets[0].id]=v
 nodes=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+[n for n in t.body if isinstance(n,ast.FunctionDef) or (isinstance(n,ast.ClassDef) and n.name in ['CandidateForm','OrientedCoordinate','PhaseModeCarrier'])];exec(compile(ast.fix_missing_locations(ast.Module(body=nodes,type_ignores=[])),str(f),'exec'),g)
fixed=mods['post_newtonian_fixed_point_terminal_law_v1'];sym=mods['symmetric_source_conservation_terminal_law_v1'];lat=mods['lattice_operator_terminal_law_v1'];qg=mods['finite_quantum_gravity_terminal_law_v1'];crt=mods['fold_universe_transport_terminal_law_v1'];fc=fixed['convergence_certificate']();sc=sym['conservation_certificate']();lc=lat['lattice_family_certificate']();models=[qg['finite_quantum_gravity_model'](d) for d in range(1,9)]
assert fc['fixed_candidates']==(Fraction(1,4),Fraction(7,4)) and fc['admissible_fixed_points']==(Fraction(1,4),)
assert all(fc[k] for k in ['values_increase_below_fixed','errors_strictly_shrink','corrections_strictly_shrink','all_factors_below_quarter'])
assert sc['slot_count']==10 and sc['source_partition_counts']==(1,3,6) and sc['all_four_balanced'] and not sc['leaking_control_balanced'] and sc['leaking_control_has_one_missing_flow'];assert sc['commutation']['word_count']==64
assert all(row['carried_terms']==row['opposed_terms']==48 for row in sc['divergence_rows']);assert lc['presence_conserved'] and lc['flat_stationary'];assert all(qg['successor_preserves_model'](d) for d in range(1,8));assert all(len(m)==19 and m['horizon_quarter_law'] for m in models)
crts=[{'factors':[m,n],'census':crt['crt_component_census'](m,n),'period':crt['composite_period'](m,n),'no_steering':crt['target_trajectory_independent_of_source'](m,n,1,12)} for m,n in [(3,5),(3,7),(5,7)]];assert all(x['census']['bijection'] and x['census']['fold_commutes'] and x['period']['matches'] and x['no_steering'] for x in crts)
axes={}
for name,t in trees.items():
 if name in ['post_newtonian_fixed_point_terminal_law_v1','symmetric_source_conservation_terminal_law_v1']:
  g=mods[name];forms=g['candidate_forms']();survivors=[f.candidate_id for f in forms if g['form_survives'](f)];assert len(forms)==2916 and len(survivors)==1
  tuples=next(n for n in t.body if isinstance(n,ast.FunctionDef) and n.name=='candidate_forms');call=next(n for n in ast.walk(tuples) if isinstance(n,ast.Call) and isinstance(n.func,ast.Name) and n.func.id=='product');domains={x.id:g[x.id] for x in call.args};axes[name]={'domains':domains,'candidate_count':len(forms),'survivor':survivors[0]}
 else:
  spec=next(n for n in t.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id=='SPEC');out=[]
  for a in next(k.value for k in spec.value.keywords if k.arg=='axes').elts:
   key,question,bad,why,good,reason=[ast.literal_eval(x) for x in a.args];out.append({'key':key,'question':question,'rejected':bad,'rejected_reason':why,'admitted':good,'admitted_reason':reason})
  assert len(out)==10;axes[name]={'axes':out,'candidate_count':1024,'survivor':[x['admitted'] for x in out]}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if is_dataclass(v):return clean(asdict(v))
 if isinstance(v,dict):
  if all(isinstance(k,(str,int)) for k in v):return {str(k):clean(x) for k,x in v.items()}
  return [[clean(k),clean(x)] for k,x in v.items()]
 if isinstance(v,(list,tuple)):return [clean(x) for x in v]
 return v
r={'method':'Execute unchanged pinned original pure functions and declared dataclasses,retaining exact Fraction,Counter and original finite enumeration operations. Reuse existing general Lean proofs and completed source comparisons.','source_sha256':sources,'self_source_certificate':fc,'symmetric_certificate':sc,'lattice_certificate':lc,'quantum_gravity_models_depths1to8':models,'all_seven_model_successors_pass':True,'crt_complete_censuses':crts,'denominator_traces':{str(d):crt['denominator_trace'](1,d,12) for d in [3,5,7,15,21,35]},'grammars':axes};(p/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print(json.dumps(clean({'fixed_values_first4':fc['values'][:4],'error_factors_first3':fc['error_factors'][:3],'lattice_counts':lc['causal_counts'],'bump_update':lc['bump_update'],'CRT_periods':[x['period'] for x in crts],'grammar_counts':{k:v['candidate_count'] for k,v in axes.items()}}),indent=2))
