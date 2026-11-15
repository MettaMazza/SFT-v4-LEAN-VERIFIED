from pathlib import Path
from fractions import Fraction
import sys,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import lattice_operator_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expr=[];expected=[]
def run(f,args,e):
 try: v={'ok':canonical_value(f(*args))}
 except ValueError as ex: v={'error':str(ex)}
 expected.append(v);expr.append(e)
def count(n):return '.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')'
for n in [False,True,-2,0,1,2,3,4,7,12]:
 c=count(n)
 run(src.conservative_stencil,[n],f'out stencilValue (conservativeStencil ({c}))')
 run(src.point_source_operator,[n],f'out operatorValue (pointSourceOperator ({c}))')
 run(src.exact_mode_carriers,[n],f'out (fun xs => .array (xs.map modeValue)) (exactModeCarriers ({c}))')
 run(src.axis_positions,[n],f'out (fun xs => .array (xs.map axisValue)) (axisPositions ({c}))')
for d,t in [(d,t) for d in [0,1,2,3,4] for t in [0,1,2,3]]+[(True,2),(2,False),(-1,2),(2,-1)]:
 run(src.causal_ball,[d,t],f'out (fun xs => .array (xs.map coordinateValue)) (causalBall ({count(d)}) ({count(t)}))')
 run(src.causal_ball_count,[d,t],f'out natValue (causalBallCount ({count(d)}) ({count(t)}))')
for state in [(),(Fraction(1),),(Fraction(1),)*2,(Fraction(1,3),)*3,(Fraction(1,4),Fraction(1,2),Fraction(1,4)),tuple(Fraction(i+1,11) for i in range(8)),(Fraction(0),Fraction(1),Fraction(2)),(Fraction(-1),Fraction(1),Fraction(2)),(1,Fraction(1),Fraction(1))]:
 vals=[]
 for q in state:
  vals.append(f'.fraction (SFT.Physics.LeptonIntervals.normalize ({q.numerator}) {q.denominator} (by decide))' if isinstance(q,Fraction) else '.nonFraction')
 run(src.cyclic_update,[state],'out (fun xs => .array (xs.map rational)) (cyclicUpdate ['+','.join(vals)+'])')
run(src.lattice_family_certificate,[],'out certificateValue latticeFamilyCertificate')
s='''import SFT.Physics.LatticeOperator
import SFT.Host.Canonical
open SFT.Physics.LatticeOperator SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def natValue (n : Nat) : Value := .integer (.ofNat n)
def out (f : α → Value) : Except String α → Value
 | .ok x => .object [("ok",f x)]
 | .error e => .object [("error",.text e)]
def stencilValue (s : Stencil) : Value := .object [("dimension",natValue s.dimension),("centre_share",rational s.centreShare),("neighbour_count",natValue s.neighbourCount),("neighbour_share",rational s.neighbourShare),("neighbour_total",rational s.neighbourTotal),("complete_total",rational s.completeTotal)]
def modeValue (m : PhaseModeCarrier) : Value := .object [("index",natValue m.index),("period",natValue m.period),("centre_share",rational m.centreShare),("forward_share",rational m.forwardShare),("reverse_share",rational m.reverseShare),("identity_phase",.boolean m.identityPhase)]
def axisValue : AxisPosition → Value
 | .origin => .array [.text "origin",.null]
 | .lower n => .array [.text "lower",natValue n]
 | .upper n => .array [.text "upper",natValue n]
def coordinateValue (axes : List AxisPosition) : Value := .object [("axes",.array (axes.map axisValue))]
def operatorValue (s : PointSource) : Value := .object [("peak_magnitude",natValue s.peakMagnitude),("peak_orientation",.text s.peakOrientation),("ring",.array (s.ring.map (fun p => .array [.text p.1,rational p.2]))),("ring_count",natValue s.ringCount),("balanced_magnitude",.boolean s.balancedMagnitude)]
def certificateValue (c : Certificate) : Value := .object [("stencils",.array (c.stencils.map stencilValue)),("operators",.array (c.operators.map operatorValue)),("causal_counts",.object (c.causalCounts.map (fun p => (toString p.1,.array (p.2.map natValue))))),("bump_update",.array (c.bumpUpdate.map rational)),("bump_centre",rational c.bumpCentre),("flat_stationary",.boolean c.flatStationary),("presence_conserved",.boolean c.presenceConserved),("mode_count",natValue c.modeCount),("identity_mode_count",natValue c.identityModeCount),("mode_relation",.text c.modeRelation),("irrational_mode_value_evaluated",.boolean c.irrationalModeValueEvaluated)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n'
p=w/'constants-recovery/Lattice998.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'lattice998_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-5000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
code=(r/'SFT/Physics/LatticeOperator.lean').read_text();names=['SFT.Physics.LatticeOperator.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'lattice998_core_audit.lean';p.write_text('import SFT.Physics.LatticeOperator\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'lattice998_core_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'lattice998_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=names,axioms=[],sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'source outputs;',len(names),'empty axioms')
