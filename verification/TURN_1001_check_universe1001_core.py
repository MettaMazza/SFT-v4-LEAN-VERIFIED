from pathlib import Path
import sys,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import fold_universe_transport_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expected=[];expr=[]
def count(n):return '.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')'
def run(f,args,out):
 try:v={'ok':canonical_value(f(*args))}
 except (ValueError,ZeroDivisionError) as ex:v={'error':str(ex)}
 expected.append(v);expr.append('out '+out+' ('+{'unit_residues':'unitResidues','fold_residue':'foldResidue','orbit_trace':'orbitTrace','crt_component_map':'crtComponentMap','crt_component_census':'crtComponentCensus','least_common_multiple':'leastCommonMultiple','composite_period':'compositePeriod','denominator_trace':'denominatorTrace','target_trajectory_independent_of_source':'targetTrajectoryIndependentOfSource'}[f.__name__]+' '+' '.join('('+count(a)+')' for a in args)+')')
for d in [False,True,-7,0,1,2,3,5,7,9,15,21,35]:
 run(src.unit_residues,[d],'nats')
 for x in [False,True,-1,0,1,2,3,4,7]:
  run(src.fold_residue,[x,d],'natValue');run(src.orbit_trace,[x,d],'nats')
for l,rr in [(3,5),(3,7),(5,7),(3,3),(9,5),(True,5),(-3,-5),(1,5),(0,3),(2,3)]:
 run(src.crt_component_census,[l,rr],'censusValue');run(src.composite_period,[l,rr],'periodValue')
 for x in [False,True,-1,0,1,2,7,14,34]:run(src.crt_component_map,[x,l,rr],'pairValue')
for l in [-3,0,True,2,6]:
 for rr in [-5,0,True,4,9]:run(src.least_common_multiple,[l,rr],'Value.integer')
for d in [3,5,7,15,21,35]:
 for n in [False,True,-2,0,1,2,12]:run(src.denominator_trace,[1,d,n],'ints')
for l,rr in [(3,5),(3,7),(5,7),(True,5),(3,2)]:
 for t in [False,True,1,2,5]:
  for n in [-2,0,True,1,12]:run(src.target_trajectory_independent_of_source,[l,rr,t,n],'Value.boolean')
s='''import SFT.Physics.FoldUniverseTransport
import SFT.Host.Canonical
open SFT.Physics.FoldUniverseTransport SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def natValue (n : Nat) : Value := .integer (.ofNat n)
def nats (ns : List Nat) : Value := .array (ns.map natValue)
def ints (ns : List Int) : Value := .array (ns.map Value.integer)
def pairValue (p : Int × Int) : Value := .array [.integer p.1,.integer p.2]
def out (f : α → Value) : Except String α → Value
 | .ok x => .object [("ok",f x)]
 | .error e => .object [("error",.text e)]
def censusValue (c : ComponentCensus) : Value := .object [("composite",.integer c.composite),("source",nats c.source),("pairs",.array (c.pairs.map pairValue)),("target",.array (c.target.map pairValue)),("bijection",.boolean c.bijection),("fold_commutes",.boolean c.foldCommutes)]
def periodValue (p : CompositePeriod) : Value := .object [("left",natValue p.left),("right",natValue p.right),("composite",natValue p.composite),("lcm",.integer p.lcm),("matches",.boolean p.matchesSource)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n'
p=w/'constants-recovery/Universe1001.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'universe1001_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e,expr[i]) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
code=(r/'SFT/Physics/FoldUniverseTransport.lean').read_text();names=['SFT.Physics.FoldUniverseTransport.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'universe1001_core_audit.lean';p.write_text('import SFT.Physics.FoldUniverseTransport\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'universe1001_core_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'universe1001_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'fresh source outputs;',len(names),'empty-axiom declarations')
