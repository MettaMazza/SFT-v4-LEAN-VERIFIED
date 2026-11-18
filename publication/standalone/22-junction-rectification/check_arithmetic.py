from pathlib import Path
import ast,json,dataclasses,hashlib
root=Path(__file__).resolve().parents[1];dest=root
g={'dataclass':dataclasses.dataclass}
def load(path,names):
 t=ast.parse((root/'v3'/path).read_text());nodes=[n for n in t.body if isinstance(n,(ast.ClassDef,ast.FunctionDef)) and n.name in names];assert len(nodes)==len(names);exec(compile(ast.Module(body=nodes,type_ignores=[]),path,'exec'),g)
load('sft/engine/exact.py',['InadmissibleExactValue','PositiveCount','HeldLabel']);load('sft/materials/successor_structural_counts.py',['rectification_certificate'])
P=g['PositiveCount'];H=g['HeldLabel'];rows=[]
for b in range(1,21):
 for a in range(1,21):
  out=g['rectification_certificate'](P(b),P(a));assert list(out)==['forward_orientation','reverse_orientation','orientations_distinct'];assert out['reverse_orientation']==P(b+a) and out['orientations_distinct'] is True
  assert out['forward_orientation']==(P(b-a) if a<b else H('junction-access','open'));rows.append({'barrier':b,'applied':a,'certificate':{k:dataclasses.asdict(v) if dataclasses.is_dataclass(v) else v for k,v in out.items()}})
rejected=[]
for v in [0,-1,True,False,1.0,'1']:
 try:P(v)
 except g['InadmissibleExactValue'] as e:rejected.append({'input':repr(v),'error':str(e)})
 else:raise AssertionError(v)
snap='experiments/external_sources/materials/snapshots/nist-pn-rectification-2026-07-27.txt';b=(root/'v3'/snap).read_bytes();assert hashlib.sha256(b).hexdigest()=='ca301b8fc47ba509909982ca2b077c238b92f3ff4978ed7377d086071c519ba4'
t=b.decode().casefold();fragments=['thisdirectionofpolarityiscalledforwardbias','obstructscurrentintheoppositedirection'];assert all(x in t for x in fragments)
r={'status':'PASS','source_sha256':{n:hashlib.sha256((root/'v3'/n).read_bytes()).hexdigest() for n in ['sft/engine/exact.py','sft/materials/successor_structural_counts.py',snap]},'positive_pair_cases':rows,'rejected_inputs':rejected,'required_source_fragments':fragments,'method':'Unchanged original dataclasses and certificate function; complete three-field output and original input guards. General native branch proofs and junction preservation proofs retained separately.'};dest.mkdir(exist_ok=True,parents=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2)+'\n');print({'status':'PASS','positive_pairs':len(rows),'guards':len(rejected),'source_fragments':len(fragments)})
