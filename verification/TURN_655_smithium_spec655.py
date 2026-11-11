from pathlib import Path
from fractions import Fraction
import ast,json,subprocess,dataclasses,__future__
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
namespace={'dataclass':dataclasses.dataclass,'Fraction':Fraction}
def evaluate(nodes,source):exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec',flags=__future__.annotations.compiler_flag),namespace)
for source,names in [('sft/physics/generated_empirical_law.py',{'LawChoice','LawDimension','dimension'}),('sft/chemistry/generated_law.py',{'ChemistryTargetReference','EmpiricalChemistrySpec'})]:evaluate([n for n in ast.parse(raw(source)).body if getattr(n,'name',None) in names],source)
for source,limit in [('sft/physics/structural_constants.py',180),('sft/physics/atomic_constants.py',209)]:evaluate([n for n in ast.parse(raw(source)).body if isinstance(n,ast.FunctionDef) and n.lineno<limit],source)
source='sft/chemistry/gblock_predictions.py';evaluate([n for n in ast.parse(raw(source)).body if isinstance(n,(ast.FunctionDef,ast.ClassDef,ast.Assign)) and n.lineno<217],source)
spec=namespace['SMITHIUM_SPEC'];spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions];kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
