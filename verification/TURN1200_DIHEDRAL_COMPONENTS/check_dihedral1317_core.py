from pathlib import Path
import sys,json,subprocess,os,hashlib,dataclasses,itertools
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1317/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import dihedral_torsion_law_v1 as src
from sft.claim_evidence.fold_language import EMPTY_ONE,EmptyOne,PositiveRatio
from sft.engine.exact import HeldLabel,PositiveCount
q=lambda s:json.dumps(s,ensure_ascii=False);pc=lambda n:'⟨'+str(n)+',by decide⟩';cases=[];expected=[]
def enc(v):
 if v is EMPTY_ONE:return ['emptyOne']
 if isinstance(v,EmptyOne):return ['otherEmptyOne',v.identity]
 if isinstance(v,PositiveRatio):return [v.numerator.value,v.denominator.value]
 if isinstance(v,bool):return v
 raise TypeError(v)
def native(v):
 if v is EMPTY_ONE:return 'Height.emptyOne'
 if isinstance(v,EmptyOne):return '(Height.otherEmptyOne '+q(v.identity)+')'
 if isinstance(v,PositiveRatio):return '(Height.ratio ⟨'+pc(v.numerator.value)+','+pc(v.denominator.value)+'⟩)'
 return 'Height.invalid'
def call(fn,expr,encode=enc):
 try:out=['ok',encode(fn())]
 except Exception as e:out=['error',str(e)]
 expected.append(out);cases.append(expr)
for n in range(1,10):
 for pos in range(1,n+3):call(lambda pos=pos,n=n:src.generated_dihedral_coordinate(PositiveCount(pos),PositiveCount(n)),'heightResult (generatedCoordinate (.count '+pc(pos)+') (.count '+pc(n)+'))')
for p,n in [(0,PositiveCount(6)),(PositiveCount(1),0),(0,0)]:
 a='(.count '+pc(p.value)+')'if isinstance(p,PositiveCount)else '.other';b='(.count '+pc(n.value)+')'if isinstance(n,PositiveCount)else '.other';call(lambda p=p,n=n:src.generated_dihedral_coordinate(p,n),'heightResult (generatedCoordinate '+a+' '+b+')')
heights=[EMPTY_ONE,EmptyOne(),EmptyOne('foreign'),PositiveRatio.from_pair(1,2),PositiveRatio.from_pair(2,4),PositiveRatio.from_pair(2,1),PositiveRatio.from_pair(5,1)]
for high,low in itertools.product(heights,repeat=2):
 call(lambda h=high,l=low:src.ordered_positive_barrier_take(h,l),'ratioResult (barrierTake '+native(high)+' '+native(low)+')')
 call(lambda h=high,l=low:src._less(h,l),'boolResult (less '+native(high)+' '+native(low)+')')
for value in [EMPTY_ONE,None,7]:call(lambda v=value:src.ordered_positive_barrier_take(v,EMPTY_ONE),'ratioResult (barrierTake '+native(value)+' .emptyOne)')
# Cyclic topology includes repeated neighbours, plateau minima and wraparound.
vectors=[[0],[1],[0,2],[2,0],[0,1,1],[2,1,1],[1,1],[0,2,1],[1,2,3],[0,2,5,0,3,6],[1,3,1,4],[0,0,0]]
def make_nodes(values):
 carrier=src._synthetic_carrier();n=PositiveCount(len(values));hs=[EMPTY_ONE if v==0 else PositiveRatio.from_pair(v,1)for v in values];hs.append(hs[0]);return n,[src.TorsionNode(carrier,PositiveCount(i+1),src.generated_dihedral_coordinate(PositiveCount(i+1),n),h,HeldLabel('torsion-record','case-'+str(i+1)))for i,h in enumerate(hs)]
def carrier_expr(c):return '⟨'+','.join(label_expr(x)for x in [c.molecule,c.molecular_state])+',['+','.join(label_expr(x)for x in c.ordered_atoms)+'],'+label_expr(c.rotor_type)+','+label_expr(c.orientation)+'⟩'
def label_expr(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def node_expr(node):return '⟨'+carrier_expr(node.carrier)+','+pc(node.path_position.value)+','+native(node.coordinate)+','+native(node.height)+','+label_expr(node.record)+'⟩'
def cycle_out(n,nodes):
 c=src.TorsionCycle(n,tuple(nodes));return dict(coordinates=[enc(x.coordinate)for x in c.nodes],minima=[x.value for x in c.local_conformer_positions()],barriers=[x.value for x in c.local_barrier_positions()],transitions=[[a.value,b.value,enc(m)]for a,b,m in c.barrier_transitions()])
def cycle_case(n,nodes):
 call(lambda:cycle_out(n,nodes),'cycleResult (do let nodes ← ['+','.join(node_expr(x)for x in nodes)+'].mapM validateNode; validateCycle (.count '+pc(n.value)+') nodes)',lambda x:x)
for values in vectors:
 n,nodes=make_nodes(values);cycle_case(n,nodes)
n,nodes=make_nodes([0,2,5,0,3,6])
for index,field,value in [(1,'coordinate',PositiveRatio.from_pair(1,6)),(2,'coordinate',PositiveRatio.from_pair(1,3)),(0,'coordinate',EmptyOne()),(6,'height',PositiveRatio.from_pair(1,1)),(2,'path_position',PositiveCount(9))]:
 altered=list(nodes);altered[index]=dataclasses.replace(altered[index],**{field:value});cycle_case(n,altered)
cycle_case(n,nodes[:-1])
altered=list(nodes);altered[0]=dataclasses.replace(altered[0],height=PositiveRatio.from_pair(2,4));altered[-1]=dataclasses.replace(altered[-1],height=PositiveRatio.from_pair(1,2));cycle_case(n,altered)
header='''import SFT.Chemistry.DihedralTorsionWitnesses
open SFT.Chemistry.DihedralTorsion SFT.Chemistry.DihedralTorsionCycle
abbrev J := SFT.Host.Canonical.Value
def heightValue : Height → J
 | .emptyOne => .array [.text "emptyOne"]
 | .otherEmptyOne id => .array [.text "otherEmptyOne",.text id]
 | .ratio r => .array [.integer (.ofNat r.numerator.value),.integer (.ofNat r.denominator.value)]
 | .invalid => .text "invalid"
def heightResult : Except String Height → J
 | .error e => .array [.text "error",.text e]
 | .ok v => .array [.text "ok",heightValue v]
def ratioResult : Except String Ratio → J
 | .error e => .array [.text "error",.text e]
 | .ok v => .array [.text "ok",heightValue (.ratio v)]
def boolResult : Except String Bool → J
 | .error e => .array [.text "error",.text e]
 | .ok v => .array [.text "ok",.boolean v]
def cycleValue (c : Cycle) : Except String J := do
 let minima ← localConformerPositions c
 let barriers ← localBarrierPositions c
 let paths ← barrierTransitions c
 pure (.object [("coordinates",.array (c.nodes.map fun n => heightValue n.coordinate)),
 ("minima",.array (minima.map fun p => .integer (.ofNat p.value))),
 ("barriers",.array (barriers.map fun p => .integer (.ofNat p.value))),
 ("transitions",.array (paths.map fun p => .array [.integer (.ofNat p.barrier.value),.integer (.ofNat p.conformer.value),heightValue (.ratio p.magnitude)]))])
def cycleResult (c : Except String Cycle) : J :=
 match c.bind cycleValue with
 | .error e => .array [.text "error",.text e]
 | .ok v => .array [.text "ok",v]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''
p=w/'DihedralTorsionCases1317.lean';p.write_text(header+',\n'.join(cases)+']))\n');(w/'dihedral1317_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
print('Prepared',len(cases),'original raw-coordinate,Take,order and cycle cases',flush=True)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'dihedral1317_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-2000:]+p.stderr[-500:];actual=json.loads(p.stdout);assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:4]
(w/'dihedral1317_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),all_fields=True,source_sha256={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for p in(r/'SFT/Chemistry').glob('DihedralTorsion*.lean')}),indent=2)+'\n');print('PASS',len(cases),'original/native cases',flush=True)
