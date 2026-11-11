from pathlib import Path
import ast,json,subprocess,dataclasses
from fractions import Fraction
from collections import namedtuple
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
namespace={'dataclass':dataclasses.dataclass,'Fraction':Fraction,'PositiveCount':namedtuple('PositiveCount','value')}
source='sft/physics/generated_empirical_law.py';names={'LawChoice','LawDimension','ExternalTargetRow','EmpiricalPhysicsSpec','dimension','empirical_dimensions'}
tree=ast.parse(raw(source));nodes=[n for n in tree.body if getattr(n,'name',None) in names];exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),namespace)
source='sft/physics/inverse_square_validation.py';tree=ast.parse(raw(source));nodes=[n for n in tree.body if isinstance(n,ast.Assign) or isinstance(n,ast.FunctionDef) and n.name=='positive_integer_exponents_in_interval'];exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),namespace)
spec=namespace['SPEC'];spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions];kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
