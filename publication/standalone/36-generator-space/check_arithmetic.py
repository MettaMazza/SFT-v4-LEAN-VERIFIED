from pathlib import Path
from fractions import Fraction
from itertools import product
import ast,json,hashlib
root=Path(__file__).resolve().parents[1];p=root;p.mkdir(exist_ok=True)
f=root/'v3/sft/physics/structural_constants.py';t=ast.parse(f.read_text());wanted=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three','stable_spatial_counts','spatial_dimension_three','boundary_rank_two','repeated_positive_product','boundary_growth'];g={'Fraction':Fraction};nodes=[n for n in t.body if isinstance(n,ast.FunctionDef) and n.name in wanted];assert len(nodes)==len(wanted);exec(compile(ast.Module(body=nodes,type_ignores=[]),str(f),'exec'),g)
assert g['first_return_trace'](g['generator_unit_part'](2))==(Fraction(2,3),Fraction(1,3));assert g['first_return_trace'](g['generator_unit_part'](3))==(Fraction(2,7),Fraction(4,7),Fraction(1,7));assert g['generator_period_three']()==g['spatial_dimension_three']()==3 and g['boundary_rank_two']()==2
axes={}
for n in t.body:
 if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id in ['GENERATOR_THREE_SPEC','SPATIAL_THREE_SPEC','BOUNDARY_RANK_SPEC']:
  out=[]
  for a in next(k.value for k in n.value.keywords if k.arg=='axes').elts:
   args=[ast.literal_eval(x) for x in a.args]
   if a.func.id=='binary_axis':key,q,bad,why,good,reason=args;choices=[{'name':bad,'admitted':False,'reason':why},{'name':good,'admitted':True,'reason':reason}]
   else:key,q,alternatives,good,reason=args;choices=[{'name':v,'admitted':v==good,'reason':reason if v==good else why} for v,why in alternatives]
   out.append({'key':key,'question':q,'choices':choices})
  count=1
  for a in out:count*=len(a['choices'])
  tuples=list(product(*(a['choices'] for a in out)));survivors=[x for x in tuples if all(y['admitted'] for y in x)];assert len(survivors)==1
  axes[n.targets[0].id]={'axes':out,'candidate_count':count,'surviving_tuple':[x['name'] for x in survivors[0]]}
assert [axes[k]['candidate_count'] for k in ['GENERATOR_THREE_SPEC','SPATIAL_THREE_SPEC','BOUNDARY_RANK_SPEC']]==[1024,1024,2048]
invalid=[]
for name,args in [('fold_part',(Fraction(0),)),('fold_part',(Fraction(3,2),)),('first_return_trace',(Fraction(1,2),)),('fold_word_support_count',(True,)),('fold_word_support_count',(0,)),('positive_predecessor',(1,)),('stable_spatial_counts',(1,)),('stable_spatial_counts',(True,)),('boundary_growth',(Fraction(1),)),('boundary_growth',(Fraction(0),))]:
 try:g[name](*args)
 except ValueError as e:invalid.append({'operation':name,'input':[str(x) for x in args],'outcome':str(e)})
 else:raise AssertionError((name,args))
r={'source_sha256':hashlib.sha256(f.read_bytes()).hexdigest(),'method':'Execute unchanged original pure function ASTs and enumerate every original grammar constructor product. Preserve general native proofs and retained full program comparisons.','binary_trace':['2/3','1/3'],'ternary_trace':['2/7','4/7','1/7'],'generator':3,'stable_counts':g['stable_spatial_counts'](2),'spatial_dimension':3,'boundary_rank':2,'growth_examples':{str(x):str(g['boundary_growth'](x)) for x in [Fraction(3,2),Fraction(2),Fraction(3),Fraction(7,3)]},'grammars':axes,'original_error_cases':invalid};(p/'arithmetic_check.json').write_text(json.dumps(r,indent=2)+'\n');print('PASS:3ranks,3completegrammars,10originalerrorcases,growthratios')
