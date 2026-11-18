from pathlib import Path
import ast,json,dataclasses,hashlib,re
from html import unescape
root=Path(__file__).resolve().parents[1];dest=root
source='sft/quantum_computation/operations.py';tree=ast.parse((root/'v3'/source).read_text());names=['FoldQuantumState','phase_action'];nodes=[n for n in tree.body if isinstance(n,(ast.ClassDef,ast.FunctionDef)) and n.name in names];assert len(nodes)==2
g={'dataclass':dataclasses.dataclass,'Word':tuple[str,...]};exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),g);State=g['FoldQuantumState'];action=g['phase_action'];rows=[]
for d in range(2,34):
 cycle=tuple('phase-'+str(i) for i in range(d));state=State(tuple(((str(i),),phase) for i,phase in enumerate(cycle)),cycle)
 for m in range(1,3*d+1):
  result=action(state,('step',)*m);assert result.phase_cycle==cycle and result.support==state.support
  assert result.branches==tuple((word,cycle[(i+m)%d]) for i,(word,phase) in enumerate(state.branches))
  assert (result==state)==(m%d==0)
  inverse=d-m%d if m%d else d;assert action(result,('return',)*inverse)==state
  assert action(state,('step',)*(m+d))==result
  rows.append({'cycle_length':d,'trace_length':m,'phase_indices':[(i+m)%d for i in range(d)],'returns':result==state,'whole_winding':m//d if result==state else None})
try:action(State(((('a',),'p'),),('p','q')),())
except ValueError as e:assert str(e)=='phase action requires a generated nonempty successor trace';empty_error=str(e)
else:raise AssertionError('empty source trace accepted')
entries=json.loads((root/'entry_index.json').read_text());sources={};fragments=[]
for e in entries:
 s=(root/'v4'/e['lean_modules'][0].replace('Source.lean','Experiment.lean')).read_text()
 ref=re.search(r'\("source_references",(.+?)\),\("required_fragments"',s)[1];path=re.search(r'\.text "(experiments/[^\"]+)"',ref)[1];sha=re.search(r'sha256:([0-9a-f]{64})',ref)[1]
 data=(root/'v3'/path).read_bytes();assert hashlib.sha256(data).hexdigest()==sha;sources[path]=sha
 text=re.sub(r'\s+',' ',unescape(re.sub('<[^>]+>',' ',data.decode())).casefold());req=re.search(r'\("required_fragments",(.+?)\),\("pre_source_seal_path"',s)[1]
 fs=re.findall(r'\.array \[\.text "[^"]+",\.text "([^"]+)"\]',req);assert len(fs)==2
 for fragment in fs:assert fragment.casefold() in text;fragments.append({'claim':e['claim_id'],'fragment':fragment,'snapshot':path})
sources[source]=hashlib.sha256((root/'v3'/source).read_bytes()).hexdigest()
result={'status':'PASS','method':'Unchanged pinned V3 FoldQuantumState and phase_action bodies; all phases for cycle lengths2..33 and nonempty traces1..3d, complete ordered outputs, inverse return, same-residue equality and exact original empty-trace rejection. Fresh extraction of14 registered source fragments from4 digest-verified snapshots. General native proofs and original full-program comparisons retained separately.','source_sha256':sources,'phase_cases':rows,'empty_trace_error':empty_error,'source_fragments':fragments}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(result,indent=2)+'\n');print({'status':'PASS','phase_cases':len(rows),'phase_rows':sum(len(x['phase_indices']) for x in rows),'fragments':len(fragments),'snapshots':len(sources)-1})
