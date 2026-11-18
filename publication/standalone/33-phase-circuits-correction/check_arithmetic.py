from pathlib import Path
from dataclasses import dataclass
from itertools import product,combinations,permutations
import ast,json,hashlib
root=Path(__file__).resolve().parents[1];dest=root
def load(n):
 g={'dataclass':dataclass,'product':product,'combinations':combinations,'Word':tuple[str,...],'__name__':'__main__'};tree=ast.parse((root/'v3'/n).read_text());nodes=[x for x in tree.body if isinstance(x,(ast.FunctionDef,ast.ClassDef)) or isinstance(x,ast.ImportFrom) and x.module=='__future__'];exec(compile(ast.Module(body=nodes,type_ignores=[]),n,'exec'),g);return g
ops=load('sft/quantum_computation/operations.py');lin=load('sft/quantum_computation/lineage_laws.py');info=load('sft/information_science/quantum_information_correspondence/law.py');info['EMPTY_ONE']=('empty-One',)
phase=0;gates=0;observations=0
for m in range(2,8):
 cycle=tuple('phase'+str(i) for i in range(m));words=(('a',),('b',),('c',))
 for phases in product(cycle,repeat=3):
  state=ops['FoldQuantumState'](tuple(zip(words,phases)),cycle)
  for k in range(1,2*m+1):
   steps=tuple('s'+str(i) for i in range(k));out=ops['phase_action'](state,steps);assert out.branches==tuple((w,cycle[(cycle.index(p)+k)%m]) for w,p in state.branches)
   rev=m-k%m;assert ops['phase_action'](out,tuple('r'+str(i) for i in range(rev)))==state;phase+=1
  assert ops['phase_action'](state,tuple('s'+str(i) for i in range(m)))==state
  mapping=((words[2],'z'),(words[0],'x'),(words[1],'x'));groups=ops['predecessor_merge'](state,mapping);assert groups==(('x',state.branches[:2]),('z',state.branches[2:]));selected,record=ops['observe'](state,mapping,'x');assert selected.branches==state.branches[:2] and record==tuple((w,p,dict(mapping)[w]) for w,p in state.branches);observations+=1
 for perm in permutations(words):
  gate=ops['ReversibleGate'](tuple(zip(words,perm)),('one','two','three'));state=ops['FoldQuantumState'](tuple((w,cycle[i%m]) for i,w in enumerate(words)),cycle);out=ops['apply_gate'](state,gate);assert ops['apply_gate'](out,gate.inverse(),True)==state;gates+=1
faults=[]
for t in range(1,7):
 trace=tuple('fault'+str(i) for i in range(t));assert lin['forced_width'](trace)==2*t+1 and lin['shorter_widths_fail'](trace)
 for label in ['held','returned']:
  rows=ops['exhaustive_fault_census'](label,trace);width=2*t+1;opp='returned' if label=='held' else 'held';expected=tuple((tuple(opp if i in mask else label for i in range(width)),label) for k in range(t+1) for mask in combinations(range(width),k));assert rows==expected and lin['exhaustive_small_fault_census'](label,trace);faults.append({'t':t,'label':label,'all_masks':len(rows)})
for t in range(1,15):
 trace=tuple(str(i) for i in range(t));assert lin['shorter_widths_fail'](trace);assert lin['depth_seven_round_trip'](trace)
assert lin['decode'](('held','returned'))=='no-strict-majority'
try:ops['repetition_decode'](('held','returned'))
except ValueError as e:assert str(e)=='decoder requires an odd generated width'
else:raise AssertionError('tie must reject in original decoder')
supports=0
for n in range(1,7):
 labels=('held-a','held-b');positions=tuple(str(i) for i in range(n));sup=info['complete_fold_support'](labels,positions);assert sup==tuple(product(labels,repeat=n));basis=info['basis_correspondence'](sup);assert tuple(x for x,_ in basis)==sup and len(set(y for _,y in basis))==len(sup)
 trace=info['information_unit_trace'](labels,positions);assert len(trace)==n and all(a in sup and b in sup and a!=b for _,_,a,b in trace)
 rows=tuple((w,w[0]) for w in sup);obs=info['observe_support'](sup,rows,'held-a');assert info['reconstruct_support'](obs['reconstruction_record'])==sup;supports+=1
collision=info['basis_correspondence']((('a','a:a'),('a:a','a')));assert collision[0][0]!=collision[1][0] and collision[0][1]==collision[1][1]
r={'status':'PASS','phase_actions':phase,'complete_predecessor_and_observation_records':observations,'reversible_gate_cases':gates,'fault_census':faults,'predecessor_width_orders':14,'depth_seven_round_trip_orders':14,'canonical_support_depths':supports,'both_decoder_tie_outcomes_preserved':True,'raw_name_collision_retained':True,'method':'Unchanged pinned V3 operation bodies; exact full phase/support/predecessor/observation outputs, gate inverses, all fault-mask rows through order6, original predecessor counterexamples and all depth7words through order14. Native universal proofs retained separately.','source_sha256':{str(p.relative_to(root/'v3')):hashlib.sha256(p.read_bytes()).hexdigest() for p in (root/'v3').rglob('*') if p.is_file() and not p.name.startswith('._')}}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2)+'\n');print({k:v for k,v in r.items() if k not in ['source_sha256','method','fault_census']});print('fault rows',sum(x['all_masks'] for x in faults))
