from pathlib import Path
import sys,json,hashlib,importlib,dataclasses
from fractions import Fraction
root=Path(__file__).resolve().parents[1]/'v3';dest=root.parent;dest.mkdir(exist_ok=True)
sys.dont_write_bytecode=True;sys.path.insert(0,str(root))
names=['root_theorem','one','count','part','part_equivalence','fold','fold_assembly','exact_operations','half_one','fold_dynamics','primitive_map_uniqueness'];results={};mods={}
for name in names:
 m=importlib.import_module('sft.foundation.'+name);mods[name]=m;f=Path(m.__file__);sha=hashlib.sha256(f.read_bytes()).hexdigest();records=m.candidate_records();decisions=[m.decision_record(r) if name=='root_theorem' else {'candidate_id':r['candidate_id'],'survives':m.survives(r),'reason':m.decision_reason(r)} for r in records];controls=m.control_records('sha256:'+sha);assert all(c['passed'] for c in controls);assert sum(d['survives'] for d in decisions)==1
 results[name]={'source_sha256':sha,'records':records,'decisions':decisions,'completeness':m.completeness_record(),'closure':m.closure_record(),'controls':controls}
from sft.engine.exact import ExactPart,PositiveCount
op=mods['exact_operations'];dyn=mods['fold_dynamics'];prim=mods['primitive_map_uniqueness'];half=mods['half_one'];third=ExactPart.from_pair(1,3);one=ExactPart.from_pair(1,1)
assert prim.apply_word(('Fold','Fold'),third)==third and prim.primitive('Fold')(third)!=third
assert op.fold_part(half.half_one())==op.fold_part(one)==one
assert half.complement(half.half_one())==half.half_one() and dyn.phase_antipode(half.half_one())==one
uniform=[]
for n in [1,2,3,4,5,6]:
 before=dyn.uniform_division(PositiveCount(2*n));after=dyn.folded_distinct(before);assert after==dyn.uniform_division(PositiveCount(n));uniform.append({'n':n,'input':before,'output':after})
assembly={str(n):mods['fold_assembly'].support_after_extensions(n) for n in range(5)}
for n,rows in assembly.items():assert len(rows)==2**int(n) and len(set(rows))==len(rows)
e=mods['part_equivalence'];left=e.lifted_a(('a',),('u','v','w','z'));right=e.lifted_b(('a','b'),('u','v'));assert e.has_generated_bijection(left,right)
sourcefiles={str(Path(m.__file__).relative_to(root)):hashlib.sha256(Path(m.__file__).read_bytes()).hexdigest() for k,m in sys.modules.items() if k.startswith('sft') and getattr(m,'__file__',None)}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if dataclasses.is_dataclass(v):return clean(dataclasses.asdict(v))
 if isinstance(v,dict):return {str(k):clean(x) for k,x in v.items()}
 if isinstance(v,(list,tuple)):return [clean(x) for x in v]
 if hasattr(v,'value'):return clean(v.value)
 return v
r={'source_sha256':sourcefiles,'entries':results,'uniform_images':uniform,'assembly':assembly,'refinement_example':{'left':left,'right':right},'half':'1/2','cycle':['1/3','2/3','1/3'],'primitive_prefix_count':84,'primitive_survivor':'size-1:Fold'}
(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'entries':len(results),'candidates':sum(len(x['records']) for x in results.values()),'controls':sum(len(x['controls']) for x in results.values()),'imported_source_files':len(sourcefiles),'status':'PASS'})
