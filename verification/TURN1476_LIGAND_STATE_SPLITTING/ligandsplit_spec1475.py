from pathlib import Path
import sys,json,dataclasses,ast
runtime=Path('work/v3-runtime500');sys.path.insert(0,str(runtime.resolve()))
import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_ligandsplit1474/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.ligand_state_splitting_batch_v1 import LIGAND_STATE_SPLITTING_SPEC as STATE_SYMMETRY_SPEC
spec=STATE_SYMMETRY_SPEC;spec.validate();values=dataclasses.asdict(spec);q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
Path('work/ligandsplit1475_spec.json').write_text(json.dumps(values,indent=2))
cid=spec.claim_id
