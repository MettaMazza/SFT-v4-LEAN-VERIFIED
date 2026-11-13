from pathlib import Path
import ast,subprocess,json,dataclasses,sys,types,itertools,math
from fractions import Fraction
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3='/Volumes/One Touch/ernos-labs-sft-platform'
def source(p):return subprocess.check_output(['git','-C',v3,'show',pin+':'+p],text=True)
m=types.ModuleType('original_bounded859');sys.modules[m.__name__]=m;ns=m.__dict__;ns.update(dataclass=dataclasses.dataclass,Fraction=Fraction,product=itertools.product,Sequence=list,gcd=math.gcd,lcm=math.lcm)
generated=ast.parse(source('sft/mathematics/generated_law.py'))
selected=[n for n in generated.body if isinstance(n,(ast.ClassDef,ast.FunctionDef)) and n.name in ['Choice','Dimension','Witness','LawSpec','binary_dimension','candidate_records','survivor_id','decision_reason','completeness_record','closure_record']]
exec(compile(ast.Module(body=selected,type_ignores=[]),'pinned-generated_law.py','exec'),ns)
tree=ast.parse(source('sft/mathematics/lineage_laws.py'));selected=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in ['_dim','_fold_rank','_order_two','_orbit'] or isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id in ['COMMON_BOUNDARY','BOUNDED_N_BODY'] for t in n.targets)]
exec(compile(ast.Module(body=selected,type_ignores=[]),'pinned-lineage_laws.py','exec'),ns)
spec=ns['BOUNDED_N_BODY'];spec.validate();values=dataclasses.asdict(spec);closure=ns['closure_record'](spec);completeness=ns['completeness_record'](spec);q=lambda x:json.dumps(x,ensure_ascii=False)
if __name__=='__main__':Path('work/bounded859_spec.json').write_text(json.dumps(values,indent=2));print(spec.claim_id,len(ns['candidate_records'](spec)))
