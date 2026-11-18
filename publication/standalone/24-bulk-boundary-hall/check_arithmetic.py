from pathlib import Path
import ast,json,dataclasses,hashlib,re
from fractions import Fraction
from math import gcd
from html import unescape
root=Path(__file__).resolve().parents[1];dest=root
g={'dataclass':dataclasses.dataclass,'Fraction':Fraction,'gcd':gcd}
def load(path,names):
 t=ast.parse((root/'v3'/path).read_text());nodes=[n for n in t.body if isinstance(n,(ast.ClassDef,ast.FunctionDef)) and n.name in names];assert len(nodes)==len(names);exec(compile(ast.Module(body=nodes,type_ignores=[]),path,'exec'),g)
load('sft/engine/exact.py',['InadmissibleExactValue','PositiveCount','HeldLabel']);load('sft/materials/successor_structural_counts.py',['primary_fractional_hall_classes','topological_edge_count']);P=g['PositiveCount'];H=g['HeldLabel'];hall=[];edge=[]
for m in range(1,34):
 r=g['primary_fractional_hall_classes'](P(m));expected=tuple(Fraction(n,d) for d in range(1,m+1,2) for n in range(1,d+1) if gcd(n,d)==1);assert r==expected;assert all(0<x<=1 and x.denominator%2==1 for x in r);hall.append({'bound':m,'ordered_parts':[str(x) for x in r]})
for a in range(1,34):
 for b in range(1,34):
  try:r=g['topological_edge_count'](P(a),P(b))
  except g['InadmissibleExactValue'] as e:assert a==b and str(e)=='edge count requires distinct adjacent winding classes';edge.append({'first':a,'second':b,'error':str(e)})
  else:
   assert list(r)==['count','orientation'] and r['count']==P(abs(a-b)) and r['orientation']==H('bulk-order','first-to-second' if a<b else 'second-to-first');edge.append({'first':a,'second':b,'result':{k:dataclasses.asdict(v) for k,v in r.items()}})
snap='experiments/external_sources/materials/snapshots/nist-hall-quantization-2026-07-27.html';data=(root/'v3'/snap).read_bytes();assert hashlib.sha256(data).hexdigest()=='4536e34ab401e72216f8b9010bafc9f1cacdbbfc47ca8fc998b781fa9125994c';text=re.sub(r'\s+',' ',unescape(re.sub('<[^>]+>',' ',data.decode())).casefold());frags=['sharp, quantized energy levels','fractional quantum hall effect','even-denominator states','quantum hall edge states','different colored plateaus'];assert all(f in text for f in frags)
r={'status':'PASS','source_sha256':{n:hashlib.sha256((root/'v3'/n).read_bytes()).hexdigest() for n in ['sft/engine/exact.py','sft/materials/successor_structural_counts.py',snap]},'hall':hall,'edge':edge,'source_fragments':frags,'method':'Unchanged original constructors and two source operations. Complete ordered fraction outputs, both edge fields and original equality rejection. Existing general proof bodies retained separately.'};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2)+'\n');print({'status':'PASS','hall_bounds':len(hall),'ordered_parts':sum(len(x['ordered_parts']) for x in hall),'edge_pairs':len(edge),'equal_rejections':sum('error' in x for x in edge),'source_fragments':len(frags)})
