from pathlib import Path
from fractions import Fraction
from math import comb,factorial
from itertools import combinations
import ast,json,hashlib,copy
root=Path(__file__).resolve().parents[1];dest=root;g={'Fraction':Fraction,'comb':comb,'factorial':factorial}
def load(path,names=None):
 t=ast.parse((root/'v3'/path).read_text());nodes=[n for n in t.body if isinstance(n,ast.FunctionDef) and (names is None or n.name in names)];exec(compile(ast.Module(body=nodes,type_ignores=[]),path,'exec'),g)
source='sft/physics/thermal_equilibrium_response_terminal_law_v1.py';load(source);cert=g['theorem_certificate']();assert len(cert)==6 and all(cert.values())
paired=[g['paired_equilibrium_census'](n) for n in range(1,33)]
for n,c in enumerate(paired,1):assert c['rows']==tuple((k,comb(2*n,k)) for k in range(2*n+1)) and c['survivors']==(n,) and c['share']==Fraction(1,2)
canonical=[]
for l in range(2,6):
 target=g['dyadic_canonical_counts'](l);N=sum(target);E=sum(i*c for i,c in enumerate(target));forms=g['fixed_count_throw_forms'](l);independent=[]
 for bars in combinations(range(N+l-1),l-1):
  bounds=(-1,)+bars+(N+l-1,);w=tuple(bounds[i+1]-bounds[i]-1 for i in range(l))
  if sum(i*c for i,c in enumerate(w))==E:independent.append(w)
 assert forms==tuple(independent);assert len(set(forms))==len(forms);values=[g['multinomial_count'](w) for w in forms];top=g['multinomial_count'](target)
 assert all((v==top)==(w==target) and v<=top for w,v in zip(forms,values));c=g['canonical_maximum_certificate'](l);assert c==dict(target=target,forms=len(forms),survivors=(target,),unique=True);canonical.append({'L':l,'N':N,'E':E,'certificate':c,'rows':list(zip(forms,values))})
weights=[]
for l in range(2,34):
 c=g['dyadic_canonical_counts'](l);w=g['dyadic_canonical_weights'](l);assert sum(c)==2**l-1 and sum(w)==1 and all(a>b>0 for a,b in zip(w,w[1:]));assert g['dyadic_canonical_counts'](l+1)==tuple(2*x for x in c)+(1,);weights.append({'L':l,'counts':c,'weights':w})
noise=[]
for n in range(1,33):
 c=g['deterministic_noise_cycle'](n);assert c['mean']==Fraction(1,2) and c['period']==4 and len(c['cycle'])==4*n;noise.append(c)
throws=[(Fraction(1,4),Fraction(3,4)),(Fraction(1,3),Fraction(1,2),Fraction(2,3)),(Fraction(7,11),),(Fraction(1,7),Fraction(2,9),Fraction(3,11),Fraction(5,13))];temperatures=[{'throws':t,'mean':g['exact_temperature'](t),'total_identity':g['total_throw_identity'](t)} for t in throws];assert all(x['total_identity'] for x in temperatures)
validation='sft/physics/thermal_equilibrium_validation_v1.py';load(validation,['exact_thermal_analysis']);recordpath='experiments/external_sources/physics/snapshots/thermal-equilibrium-postseal-source-record.json';record=json.loads((root/'v3'/recordpath).read_text());target=record['registered_target'];a=g['exact_thermal_analysis'](target);assert len(a)==13 and all(a.values());assert a['acoustic_interval']==(13806456,13806512) and a['electronic_interval']==(13806340,13806680)
bad=copy.deepcopy(target);bad['acoustic_kb_scaled_center']=13000000;control=g['exact_thermal_analysis'](bad);assert control['acoustic_interval']==(12999972,13000028) and not control['acoustic_contains_exact']
boolean_checks=[]
for key,value in target.items():
 if type(value) is bool:
  bad=copy.deepcopy(target);bad[key]=int(value);result=g['exact_thermal_analysis'](bad);assert result!=a;boolean_checks.append(key)
tree=ast.parse((root/'v3/sft/physics/thermal_equilibrium_empirical_v1.py').read_text());files=next(ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='SOURCE_FILES' for x in n.targets));hashes={}
for path,h in files:
 actual=hashlib.sha256((root/'v3'/path).read_bytes()).hexdigest();assert 'sha256:'+actual==h;hashes[path]=actual
for path in [source,validation,recordpath]:hashes[path]=hashlib.sha256((root/'v3'/path).read_bytes()).hexdigest()
assert hashes[recordpath]=='8048a2397c064290a0b948b4238b4133c1a2e5c76a72ecf0c47222c9a951d7b5'
guards=[]
for fn,args in [('exact_temperature',[()]),('exact_temperature',[(0,)]),('paired_equilibrium_census',[True]),('paired_equilibrium_census',[0]),('dyadic_canonical_counts',[1]),('dyadic_canonical_counts',[True]),('deterministic_noise_cycle',[0]),('deterministic_noise_cycle',[True])]:
 try:g[fn](*args)
 except ValueError as e:guards.append({'operation':fn,'input':args,'error':str(e)})
 else:raise AssertionError('guard accepted')
r={'status':'PASS','method':'Unchanged pinned source function bodies; complete original six-field certificate, all ordered fixed-count/throw outputs for L2..5 against independent separator enumeration, full multiplicities and maximum records, general-proof examples for32paired populations/32ladders/32complete cycle repetitions, exact means, full13field measured analysis and original adverse control, strict Boolean identity and source digests. Native general proof bodies retained separately.','source_sha256':hashes,'certificate':cert,'paired':paired,'canonical':canonical,'weights':weights,'noise':noise,'temperatures':temperatures,'response':g['fluctuation_response_ledger'](),'analysis':a,'tampered_analysis':control,'literal_boolean_checks':boolean_checks,'guards':guards};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2,default=lambda x:str(x) if isinstance(x,Fraction) else None)+'\n');print({'status':'PASS','paired':len(paired),'canonical_rows':[len(x['rows']) for x in canonical],'weights':len(weights),'noise':len(noise),'analysis_fields':len(a),'guards':len(guards),'bool_checks':len(boolean_checks)})
