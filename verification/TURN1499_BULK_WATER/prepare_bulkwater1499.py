from pathlib import Path
import sys,json,subprocess,hashlib,ast,importlib.util,copy
from types import SimpleNamespace
w=Path('work');stage=w/'pinned_bulkwater1499';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-MAT-BULK-WATER-RESPONSE-002'
def read(rel):return subprocess.check_output(['git','-C',repo,'show',pin+':'+rel])
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.materials;sft.materials.__path__.insert(0,str((stage/'sft/materials').resolve()))
from sft.materials import successor_evidence as v
spec=next(x for x in v.SPECS if x.claim_id==cid)
seal=json.loads(read(v.PRE_SOURCE_SEAL_PATH));execution=ast.parse((stage/'claims'/cid/'execution.py').read_text())
fixed=next(n for n in ast.walk(execution)if isinstance(n,ast.Tuple)and len(n.elts)==12)
paths=list(dict.fromkeys([ast.literal_eval(n)for n in fixed.elts]+[v.PRE_SOURCE_SEAL_PATH]+list(seal['source_files'])+[v.SOURCE_BY_ID[x.source_id].path for x in v.BINDINGS[cid]]))
for rel in paths:
 p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(read(rel))
for d in ['census','receipts']:
 p=stage/d
 if not p.exists():p.symlink_to((w/'v3-runtime500'/d).resolve(),target_is_directory=True)
allfiles=[dict(path=str(p.relative_to(stage)),sha256=hashlib.sha256(p.read_bytes()).hexdigest())for p in stage.rglob('*')if p.is_file()and '__pycache__'not in str(p)]
(w/'bulkwater1499_source_pin.json').write_text(json.dumps(dict(commit=pin,files=allfiles),indent=2)+'\n')
modspec=importlib.util.spec_from_file_location('bulkwater_original',stage/'claims'/cid/'execution.py');m=importlib.util.module_from_spec(modspec);modspec.loader.exec_module(m);e=m.build_execution(stage)
from sft.engine.canonical import canonical_value
p=e.program;c=p.generate_candidates();ds=tuple(p.decide_candidate(x)for x in c.candidates);out=canonical_value(dict(registration=p.registration,census=c,decisions=ds,closure=p.closure_evidence(ds),controls=p.run_controls(),unknown_id='StopIteration'));(w/'bulkwater1499_original_program.json').write_text(json.dumps(out,indent=2)+'\n')
try:emp=canonical_value(e.empirical_validator.validate(SimpleNamespace(seal_hash='native-bulkwater1499')))
except Exception as err:emp={'error':str(err),'exception_type':type(err).__name__}
(w/'bulkwater1499_original_empirical.json').write_text(json.dumps(emp,indent=2)+'\n')
files=list(seal['source_files'])+[v.SOURCE_BY_ID[x].path for x in spec.source_ids]
data={'seal_path':str((stage/v.PRE_SOURCE_SEAL_PATH).resolve()),'files':[{'path':p,'local':str((stage/p).resolve())}for p in dict.fromkeys(files)]};(w/'bulkwater1499_source_input.json').write_text(json.dumps(data,indent=2)+'\n')
print('Original256programme; empirical',emp.get('passed',emp.get('error')),'pinnedfiles',len(allfiles))
