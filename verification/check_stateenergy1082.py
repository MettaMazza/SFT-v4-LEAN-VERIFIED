from pathlib import Path
import sys,json,hashlib,os,subprocess,itertools,re
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry import state_energy_order_law_v1 as s
source=w/'v3-runtime500/sft/chemistry/state_energy_order_law_v1.py';b=source.read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()=='230ebc339fbddec69898544beee70a776916950d'
q=lambda x:json.dumps(x,ensure_ascii=False)
def norm(v):
 if isinstance(v,s.HeldLabel):return[v.family,v.label]
 if isinstance(v,s.EmptyOne):return['empty',v.identity]
 if isinstance(v,s.PositiveCount):return['count',v.value]
 if isinstance(v,s.OrderedMolecularState):return[norm(v.molecular_carrier),norm(v.state_identity),norm(v.order_position),norm(v.support_identity)]
 if isinstance(v,s.ExactFiniteStateOrder):return[norm(v.molecular_carrier),[norm(x)for x in v.states]]
 return v
expected=[];expressions=[]
def add(name,expr,fn):
 try:out={'ok':norm(fn())}
 except (ValueError,AttributeError,StopIteration) as e:out={'error':str(e) if not isinstance(e,StopIteration)else'StopIteration'}
 expected.append([name,out]);expressions.append('('+q(name)+','+expr+')')
def labels(xs):return '['+','.join(q(x)for x in xs)+']'
def held(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def pos(x):return '.emptyOne '+q(x.identity) if isinstance(x,s.EmptyOne)else '.count ⟨'+str(x.value)+',by decide⟩'
def row(x):return '⟨'+','.join([held(x.molecular_carrier),held(x.state_identity),pos(x.order_position),held(x.support_identity)])+'⟩'
def order(x):return '⟨'+held(x.molecular_carrier)+',['+','.join(row(y)for y in x.states)+']⟩'
for n in range(9):
 xs=[f'state-{i}'for i in range(n)];call='buildExactStateOrder "molecule" '+labels(xs)
 add(f'build-{n}','result orderValue ('+call+')',lambda xs=xs:s.build_exact_state_order('molecule',tuple(xs)))
 if not n:continue
 o=s.build_exact_state_order('molecule',tuple(xs));add(f'ground-{n}','result rowValue (groundState '+order(o)+')',lambda o=o:o.ground_state)
 for i,j in itertools.product(range(n),repeat=2):add(f'compare-{n}-{i}-{j}','result Canonical.Value.boolean (precedes '+row(o.states[i])+' '+row(o.states[j])+')',lambda o=o,i=i,j=j:s.precedes(o.states[i],o.states[j]))
for carrier,xs in [('', ['a']),(' ',['a']),('m',['a','a']),('m',['']),('m',['a',' '])]:add('build-guard-'+repr((carrier,xs)),'result orderValue (buildExactStateOrder '+q(carrier)+' '+labels(xs)+')',lambda carrier=carrier,xs=xs:s.build_exact_state_order(carrier,tuple(xs)))
c=s.HeldLabel('molecular-carrier','m')
def mk(i,p):return s.OrderedMolecularState(c,s.HeldLabel('molecular-electronic-state',str(i)),p,s.HeldLabel('molecular-support',str(i)))
positions=[s.EMPTY_ONE,s.PositiveCount(1),s.PositiveCount(2),s.PositiveCount(3),s.EmptyOne('other')]
for n in range(1,4):
 for k,ps in enumerate(itertools.product(positions,repeat=n)):
  rows=tuple(mk(i,p)for i,p in enumerate(ps));encoded='⟨'+held(c)+',['+','.join(row(x)for x in rows)+']⟩'
  add(f'order-{n}-{k}','result orderValue (validOrder '+encoded+')',lambda rows=rows:s.ExactFiniteStateOrder(c,rows))
for a,b in itertools.product(positions,repeat=2):
 l,rr=mk(0,a),mk(1,b);add('position-pair-'+repr((norm(a),norm(b))),'result Canonical.Value.boolean (precedes '+row(l)+' '+row(rr)+')',lambda l=l,rr=rr:s.precedes(l,rr))
base=mk(0,s.EMPTY_ONE)
for field,family in [('molecular_carrier','bad-carrier'),('state_identity','bad-state'),('support_identity','bad-support')]:
 args=dict(molecular_carrier=base.molecular_carrier,state_identity=base.state_identity,order_position=base.order_position,support_identity=base.support_identity);args[field]=s.HeldLabel(family,'x');raw=object.__new__(s.OrderedMolecularState)
 for k,v in args.items():object.__setattr__(raw,k,v)
 add('state-guard-'+field,'result rowValue (validState '+row(raw)+')',lambda args=args:s.OrderedMolecularState(**args))
other=s.OrderedMolecularState(s.HeldLabel('molecular-carrier','other'),base.state_identity,s.EMPTY_ONE,base.support_identity)
add('cross-carrier','result Canonical.Value.boolean (precedes '+row(base)+' '+row(other)+')',lambda:s.precedes(base,other))
h='''import SFT.Chemistry.StateEnergyOrder
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.StateEnergyOrder
set_option maxHeartbeats 20000000
abbrev V := Canonical.Value
def labelValue (x : HeldLabel) : V := .array [.text x.family,.text x.label]
def positionJson : OrderPosition → V
 | .emptyOne identity => .array [.text "empty",.text identity]
 | .count n => .array [.text "count",.integer (.ofNat n.value)]
def rowValue (x : OrderedMolecularState) : V := .array [labelValue x.molecularCarrier,labelValue x.stateIdentity,positionJson x.orderPosition,labelValue x.supportIdentity]
def orderValue (x : ExactFiniteStateOrder) : V := .array [labelValue x.molecularCarrier,.array (x.states.map rowValue)]
def result {α : Type} (f : α → V) : Except String α → V
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",f x)]
'''
h+='def rows : List (String × V) := [\n'+',\n'.join(expressions)+'\n]\ndef main : IO Unit := IO.println (Canonical.render (.array (rows.map (fun (name,value) => .array [.text name,value]))))\n';hp=w/'StateEnergyProgram1082.lean';hp.write_text(h)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(hp)]
with(w/'stateenergy1082_output.json').open('w')as out,(w/'stateenergy1082_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0,run.returncode
actual=json.loads((w/'stateenergy1082_output.json').read_text());assert actual==expected,[(a,b)for a,b in zip(actual,expected)if a!=b][:3]
log=(w/'stateenergy1082_build.log').read_text();decls=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(decls)==11 and 'depends on axioms:'not in log
report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_git_blob='230ebc339fbddec69898544beee70a776916950d',cases=len(expected),declarations=decls,axioms=[],source_sha256=hashlib.sha256((r/'SFT/Chemistry/StateEnergyOrder.lean').read_bytes()).hexdigest());(w/'stateenergy1082_core_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(expected),'fresh V3 operation comparisons;11 empty axiom dependencies')
