from pathlib import Path
from fractions import Fraction
from collections import namedtuple
from math import isqrt
import ast,json,subprocess,dataclasses,__future__
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
namespace={'dataclass':dataclasses.dataclass,'Fraction':Fraction,'Path':Path,'json':json,'isqrt':isqrt}
def evaluate(nodes,name):exec(compile(ast.Module(body=nodes,type_ignores=[]),name,'exec',flags=__future__.annotations.compiler_flag),namespace)
source='sft/physics/generated_empirical_law.py';names={'LawChoice','LawDimension','ExternalTargetRow','EmpiricalPhysicsSpec','dimension','empirical_dimensions'}
evaluate([n for n in ast.parse(raw(source)).body if getattr(n,'name',None) in names],source)
source='sft/physics/measured_value.py';evaluate([n for n in ast.parse(raw(source)).body if getattr(n,'name',None)=='exact_decimal'],source)
source='sft/physics/charged_lepton_validation.py';tree=ast.parse(raw(source));names={'source_interval','positive_sqrt_interval','koide_source_interval'};constants={'CLAIM_ID','KOIDE_CLAIM_ID','SOURCE_ID','SOURCE_PATH','SOURCE_HASH','KOIDE_LABEL','KOIDE_SPEC'}
evaluate([n for n in tree.body if getattr(n,'name',None) in names or isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id in constants for t in n.targets)],source)
spec=namespace['KOIDE_SPEC'];spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions];kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
if __name__=='__main__':Path('work/koide_interval856_spec.json').write_text(json.dumps(values,indent=2));print(cid)
