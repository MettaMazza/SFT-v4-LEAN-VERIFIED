from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import yang_mills_singlet_gap_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
from fractions import Fraction
expected=[];expr=[]
def add(f,args,expression):
 try:v={'ok':canonical_value(f(*args))}
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(expression)
add(src.strong_gap_partition,[],'out partitionValue strongGapPartition');add(src.physical_singlet_support,[],'out supportValue physicalSingletSupport')
for n in [False,True,-4,0,*range(1,33),64]:
 c='.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')'
 add(src.singlet_gap_trace,[n],'out traceValue (singletGapTrace ('+c+'))')
for q in [False,1,Fraction(-1,3),Fraction(0),Fraction(1,7),Fraction(1,3),Fraction(1,2),Fraction(2,3),Fraction(1),Fraction(2)]:
 c='.fraction (SFT.Physics.LeptonIntervals.normalize ('+str(q.numerator)+') '+str(q.denominator)+' (by decide))' if isinstance(q,Fraction) else '.nonFraction'
 add(src.fold_part,[q],'out rational (foldPart ('+c+'))')
fields={
'partitionValue':('Partition',[('coupling','coupling','rational'),('gap','gap','rational'),('complete','complete','.boolean'),('gap_to_coupling','gapToCoupling','.boolean'),('coupling_to_gap','couplingToGap','.boolean'),('first_return_period','firstReturnPeriod','natValue')]),
'supportValue':('SingletSupport',[('least_singlet_constituents','leastSingletConstituents','natValue'),('complete_fibre_constituents','completeFibreConstituents','natValue'),('singlet_supports','singletSupports','nats'),('least_singlet_is_nonempty_composite','leastSingletIsNonemptyComposite','.boolean'),('isolated_colour_observation_record','isolatedColourObservationRecord','rats'),('vacuum_excitation_record','vacuumExcitationRecord','rats')]),
'rowValue':('Row',[('depth','depth','natValue'),('normalized_singlet_gap','normalizedSingletGap','rational'),('confinement_work','confinementWork','rational'),('physical_support','physicalSupport','natValue')]),
}
trace=[('rows','rows','rowsValue'),('gap','gap','rational'),('coupling','coupling','rational')]
for a,b in [('all_gaps_positive','allGapsPositive'),('gap_depth_invariant','gapDepthInvariant'),('work_positive_and_increasing','workPositiveAndIncreasing'),('least_physical_state_is_singlet','leastPhysicalStateIsSinglet')]:trace.append((a,b,'.boolean'))
for a,b in [('isolated_colour_observation_record','isolatedColourObservationRecord'),('vacuum_excitation_record','vacuumExcitationRecord'),('local_carrier_mass_label','localCarrierMassLabel')]:trace.append((a,b,'rats'))
for a,b in [('local_carrier_One_speed','localCarrierOneSpeed'),('local_carrier_confined','localCarrierConfined'),('local_masslessness_not_physical_gaplessness','localMasslessnessNotPhysicalGaplessness'),('completed_infinity_used','completedInfinityUsed'),('fitted_or_measured_value_used','fittedOrMeasuredValueUsed')]:trace.append((a,b,'.boolean'))
s='''import SFT.Physics.YangMillsSingletGap
import SFT.Host.Canonical
open SFT.Physics.YangMillsSingletGap SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def rats (qs : List Rat) : Value := .array (qs.map rational)
def natValue (n : Nat) : Value := .integer (.ofNat n)
def nats (ns : List Nat) : Value := .array (ns.map natValue)
def out (f : α → Value) : Except String α → Value
 | .ok x => .object [("ok",f x)]
 | .error e => .object [("error",.text e)]
'''
def decl(name,ty,fs):return 'def '+name+' (r : '+ty+') : Value := .object ['+','.join('("'+a+'",'+c+' r.'+b+')' for a,b,c in fs)+']\n'
for name,(ty,fs) in fields.items():s+=decl(name,ty,fs)
s+='def rowsValue (rs : List Row) : Value := .array (rs.map rowValue)\n'+decl('traceValue','Trace',trace)
s+='#eval IO.println (render (.array ['+',\n'.join(expr)+']))\n';p=w/'constants-recovery/YangMills1004.lean';p.write_text(s)
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'yangmills1004_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
code=(r/'SFT/Physics/YangMillsSingletGap.lean').read_text();names=['SFT.Physics.YangMillsSingletGap.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'yangmills1004_core_audit.lean';p.write_text('import SFT.Physics.YangMillsSingletGap\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'yangmills1004_core_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'yangmills1004_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest(),scope='All original partition,physical support,15-field singlet trace, guarded Fold and exact inherited local/tube outputs'),indent=2));print('PASS',len(expected),'fresh outputs;',len(names),'empty declarations')
