from pathlib import Path
import sys,subprocess,json,os,hashlib,re
from fractions import Fraction as F
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import strong_carrier_massless_confined_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
q=json.dumps;rat=lambda x:'(normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))';inp=lambda x:'.fraction '+rat(x) if isinstance(x,F) else '.nonFraction';count=lambda x:'.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
s='''import SFT.Physics.StrongCarrierMasslessConfined
import SFT.Host.Canonical
open SFT.Physics.StrongCarrierMasslessConfined SFT.Physics.LeptonIntervals SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def rs (xs : List Rat) : Value := .array (xs.map frac)
def sectorValue (x : Sector) : Value := .object [("sector",nv x.sector),("charge_labels",nv x.chargeLabels),("pair_cells",nv x.pairCells),("colourless_return_cells",frac x.colourlessReturnCells),("mediator_count",nv x.mediatorCount),("coupling",frac x.coupling),("mass_label",rs x.massLabel),("mass_class",.text x.massClass),("carrier_charge",.text x.carrierCharge)]
def causalValue (x : Causal) : Value := .object [("mass_label",rs x.massLabel),("positions",rs x.positions),("increments",rs x.increments),("all_increments_One",.boolean x.allIncrementsOne),("phase_trace",rs x.phaseTrace),("phase_retained",.boolean x.phaseRetained),("rest_capture_record",rs x.restCaptureRecord),("causal_speed",frac x.causalSpeed)]
def rowValue (x : TubeRow) : Value := .object [("separation",frac x.separation),("tube_width",frac x.tubeWidth),("field_carrier",frac x.fieldCarrier),("separation_work",frac x.separationWork)]
def tubeValue (x : Tube) : Value := .object [("rows",.array (x.rows.map rowValue)),("tube_width",frac x.tubeWidth),("field_carrier",frac x.fieldCarrier),("width_fixed",.boolean x.widthFixed),("field_fixed",.boolean x.fieldFixed),("work_strictly_increases",.boolean x.workStrictlyIncreases),("work_increment",frac x.workIncrement),("all_work_increments_equal_coupling",.boolean x.allWorkIncrementsEqualCoupling),("isolated_colour_carrier_record",rs x.isolatedColourCarrierRecord),("completed_infinity_used",.boolean x.completedInfinityUsed)]
def boundValue (x : BoundWitness) : Value := .object [("bound",frac x.bound),("witness_separation",nv x.witnessSeparation),("witness_work",frac x.witnessWork),("exceeds_bound",.boolean x.exceedsBound),("finite_witness",.boolean x.finiteWitness)]
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
(w/'strongcarrier986_serializers.txt').write_text(s[s.index('def nv'):s.index('def result')]);expected=[];expr=[]
def case(call,code):
 try:v=canonical_value(call())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(code)
case(src.strong_sector_structure,'result sectorValue strongSectorStructure')
for n in [False,True,-5,-1,0,1,2,3,4,8,12,16,20,33]:
 case(lambda:src.massless_causal_trace(n),'result causalValue (masslessCausalTrace ('+count(n)+'))');case(lambda:src.confining_tube_trace(n),'result tubeValue (confiningTubeTrace ('+count(n)+'))')
for b in [False,True,1,F(0),F(-1),F(-2,3)]+[F(n,d) for n in [1,2,3,7,16,32,99] for d in [1,2,3,8,17]]:
 case(lambda:src.work_exceeds_positive_bound(b),'result boundValue (workExceedsPositiveBound ('+inp(b)+'))')
s+='#eval IO.println (render (.array [\n'+',\n'.join(expr)+']))\n';p=w/'constants-recovery/StrongCarrierCore986.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True,capture_output=True);(w/'strongcarrier986_core_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[:2000];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:2]
p=r/'SFT/Physics/StrongCarrierMasslessConfined.lean';code=p.read_text();names=re.findall(r'^(?:def|theorem) (\w+)',code,re.M);audit=w/'strongcarrier986_core_audit.lean';audit.write_text('import SFT.Physics.StrongCarrierMasslessConfined\n'+''.join('#print axioms SFT.Physics.StrongCarrierMasslessConfined.'+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(audit)],env=env,text=True);(w/'strongcarrier986_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names) and 'depends on axioms:' not in out
(w/'strongcarrier986_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=names,axioms=[],source_sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'complete operation and domain cases;',len(names),'empty declarations')
