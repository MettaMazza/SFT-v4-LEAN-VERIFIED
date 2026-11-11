from pathlib import Path
from fractions import Fraction
from collections import namedtuple
import ast,json,subprocess,dataclasses,__future__
r=Path('work/constants-recovery')
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
namespace={'dataclass':dataclasses.dataclass,'Fraction':Fraction,'PositiveCount':namedtuple('PositiveCount','value'),'Path':Path,'json':json,'__file__':repo+'/sft/physics/atomic_constants_validation.py'}
def evaluate(nodes,name):exec(compile(ast.Module(body=nodes,type_ignores=[]),name,'exec',flags=__future__.annotations.compiler_flag),namespace)
source='sft/physics/generated_empirical_law.py';names={'LawChoice','LawDimension','ExternalTargetRow','EmpiricalPhysicsSpec','dimension','empirical_dimensions'}
evaluate([n for n in ast.parse(raw(source)).body if getattr(n,'name',None) in names],source)
for source,limit in [('sft/physics/structural_constants.py',180),('sft/physics/atomic_constants.py',209)]:
 evaluate([n for n in ast.parse(raw(source)).body if isinstance(n,ast.FunctionDef) and n.lineno<limit],source)
source='sft/physics/measured_value.py';evaluate([n for n in ast.parse(raw(source)).body if getattr(n,'name',None)=='exact_decimal'],source)
source='sft/physics/atomic_constants_validation.py';tree=ast.parse(raw(source))
for rel in ['experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt','experiments/external_sources/physics/snapshots/iaea-magic-numbers-source-record.json']:
 assert (Path(repo)/rel).read_bytes()==subprocess.check_output(['git','-C',repo,'show',pin+':'+rel])
evaluate([n for n in tree.body if (isinstance(n,(ast.Assign,ast.FunctionDef)) and n.lineno<161)],source)
spec=namespace['NUCLEAR_SPEC'];spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
if __name__=='__main__':Path('work/nuclear_sequence650_spec.json').write_text(json.dumps(values,indent=2));print(cid)
