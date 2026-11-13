from pathlib import Path
from itertools import product
from fractions import Fraction
import ast,json,subprocess,dataclasses,__future__
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
namespace={'dataclass':dataclasses.dataclass,'product':product,'Fraction':Fraction}
def evaluate(nodes,name):exec(compile(ast.Module(body=nodes,type_ignores=[]),name,'exec',flags=__future__.annotations.compiler_flag),namespace)
for source,names in [('sft/engine/exact.py',{'PositiveCount','InadmissibleExactValue'}),('sft/physics/generated_empirical_law.py',{'LawChoice','LawDimension','dimension'})]:
 evaluate([n for n in ast.parse(raw(source)).body if getattr(n,'name',None) in names],source)
for source in ['sft/materials/obligations.py','sft/materials/structural_counts.py','sft/materials/derivation.py']:
 evaluate([n for n in ast.parse(raw(source)).body if not isinstance(n,(ast.Import,ast.ImportFrom))],source)
spec=namespace['MATERIALS_BLUEPRINTS'][71];spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
if __name__=='__main__':Path('work/sintering842_spec.json').write_text(json.dumps(values,indent=2));print(cid)
