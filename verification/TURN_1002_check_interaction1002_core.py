from pathlib import Path
import sys,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import interaction_unification_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
from fractions import Fraction
expected=[];expr=[]
def count(n):return '.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')'
def run(f,args,name,out):
 try:v={'ok':canonical_value(f(*args))}
 except ValueError as ex:v={'error':str(ex)}
 expected.append(v);expr.append('out '+out+' ('+name+' '+' '.join('('+count(a)+')' for a in args)+')')
for m in [False,True,-3,0,1,2,3,4,5,6,7,8,11,16]:
 run(src.standing_modes,[m],'standingModes','rats');run(src.base_sector_table,[m],'baseSectorTable','tableValue')
 for support in [False,True,-3,0,1,2,8,16]:
  run(src.running_share,[m,support],'runningShare','rational');run(src.running_shortfall,[m,support],'runningShortfall','rational')
for a,b in [(2,3),(2,7),(3,5),(3,7),(5,7),(7,2),(2,2),(True,3),(4,5)]:
 for support in [False,-1,0,1,4,16]:run(src.running_gap,[a,b,support],'runningGap','rational')
for d in [False,True,-1,0,*range(1,18)]:run(src.all_depth_order_and_noncoincidence,[d],'allDepthOrderAndNoncoincidence','Value.boolean')
run(src.common_half_one_sectors,[],'commonHalfOneSectors','nats')
expected.append({'ok':src.prior_flat_slope_bundle_is_consistent()});expr.append('out Value.boolean (.ok priorFlatSlopeBundleIsConsistent)')
for q in [Fraction(-2,3),Fraction(0),Fraction(1,7),Fraction(1,3),Fraction(1,2),Fraction(3,4),Fraction(1),Fraction(2)]:
 expected.append({'ok':canonical_value(src.fold_part(q))});expr.append(f'out rational (.ok (foldPart (SFT.Physics.LeptonIntervals.normalize ({q.numerator}) {q.denominator} (by decide))))')
s='''import SFT.Physics.InteractionUnification
import SFT.Host.Canonical
open SFT.Physics.InteractionUnification SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def rats (qs : List Rat) : Value := .array (qs.map rational)
def natValue (n : Nat) : Value := .integer (.ofNat n)
def nats (ns : List Nat) : Value := .array (ns.map natValue)
def out (f : α → Value) : Except String α → Value
 | .ok x => .object [("ok",f x)]
 | .error e => .object [("error",.text e)]
def tableValue (t : SectorTable) : Value := .object [("sector",natValue t.sector),("coupling",rational t.coupling),("mixing_share",rational t.mixingShare),("mass_shortfall",rational t.massShortfall),("mediator_count",natValue t.mediatorCount),("standing_modes",rats t.standingModes),("half_One_standing",.boolean t.halfOneStanding)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/Interaction1002.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'interaction1002_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e,expr[i]) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
code=(r/'SFT/Physics/InteractionUnification.lean').read_text();names=['SFT.Physics.InteractionUnification.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'interaction1002_core_audit.lean';p.write_text('import SFT.Physics.InteractionUnification\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'interaction1002_core_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'interaction1002_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest(),scope='Implemented table, standing modes, running operations, fold, depth checks and adverse control; period dictionary not yet implemented'),indent=2));print('PASS',len(expected),'fresh source outputs;',len(names),'empty-axiom declarations')
