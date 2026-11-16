from pathlib import Path
from fractions import Fraction
from math import comb,prod
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'spinstatistics1043_law.py').read_text();env={'Fraction':Fraction,'comb':comb,'prod':prod};exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-source','exec'),env)
ci=lambda n:'.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')'
tests=[]
def add(name,args,lean,wrap):tests.append((name,args,wrap+' ('+lean+')'))
for n,l in [(n,l)for n in range(1,7)for l in range(1,7)]+[(False,2),(0,2),(-1,2),(2,False),(2,0),(2,-1)]:
 inputs=' ('+ci(n)+') ('+ci(l)+')'
 for name,lean,wrap in [('occupation_census','occupationCensus','censusResult'),('minimal_throw_ground_certificate','minimalThrowGroundCertificate','groundResult')]:add(name,(n,l),lean+inputs,wrap)
 for exchange in ['preserving','alternating','invalid']:
  args=inputs+' '+json.dumps(exchange)
  add('occupation_vectors',(n,l,exchange),'occupationVectors'+args,'wordsResult')
  if l<=4 and n<=4:
   for d in [1,3,False,0]:
    tail=args+' ('+ci(d)+')'
    for name,lean,wrap in [('canonical_occupation_weights','canonicalOccupationWeights','weightsResult'),('ground_share','groundShare','ratResult'),('canonical_mean_throw','canonicalMeanThrow','ratResult')]:add(name,(n,l,exchange,d),lean+tail,wrap)
for l in [False,-1,0,1,2,5]:add('_raw_level_weights',(l,),'rawLevelWeights ('+ci(l)+')','natsResult')
for n,l,m in [(n,l,m)for n in range(1,5)for l in range(2,5)for m in range(2,6)]+[(False,2,2),(0,2,2),(2,False,2),(2,1,2),(2,2,False),(2,2,1)]:add('critical_condensation_certificate',(n,l,m),'criticalCondensationCertificate '+' '.join('('+ci(x)+')' for x in (n,l,m)),'condensationResult')
add('exchange_spin_census',(),'exchangeSpinCensus','spinValue');add('spin_return_certificate',(),'spinReturnCertificate','returnValue')
def cv(v):
 if isinstance(v,Fraction):return f'{v.numerator}/{v.denominator}'
 if isinstance(v,(tuple,list)):return list(map(cv,v))
 if isinstance(v,dict):return {k:cv(a)for k,a in v.items()}
 return v
expected=[]
for name,args,_ in tests:
 try:expected.append({'ok':cv(env[name](*args))})
 except ValueError as e:expected.append({'error':str(e)})
header='''import SFT.Physics.SpinStatisticsCondensation
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.SpinStatisticsCondensation LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nn(n:Nat):Value := .integer (.ofNat n)
def rr(q:Rat):Value := .text (toString q.num ++ "/" ++ toString q.den)
def ns(xs:List Nat):Value := .array (xs.map nn)
def ws(xs:List (List Nat)):Value := .array (xs.map ns)
def result {α : Type} (convert : α→Value) : Except String α → Value
 | .ok a => .object [("ok",convert a)]
 | .error e => .object [("error",.text e)]
def wordsResult := result ws
def natsResult := result ns
def ratResult := result rr
def weightsResult := result (fun rows : List (List Nat × Rat) => .array (rows.map (fun (word,weight) => .array [ns word,rr weight])))
def censusResult := result (fun a : Census => .object [("boson_vectors",ws a.bosons),("fermion_vectors",ws a.fermions),("boson_count",nn a.bosonCount),("fermion_count",nn a.fermionCount),("expected_boson_count",nn a.expectedBosons),("expected_fermion_count",nn a.expectedFermions),("complete",.boolean a.complete)])
def groundResult := result (fun a : GroundCertificate => .object [("least_total_throw",nn a.least),("survivors",ws a.survivors),("unique",.boolean a.unique)])
def condensationResult := result (fun a : Condensation => .object [("particle_count",nn a.particles),("level_count",nn a.levels),("fold_factor",nn a.factor),("lock_share",rr a.lockShare),("critical_depth",nn a.criticalDepth),("critical_mean_throw",rr a.criticalMean),("ground_share",rr a.groundShare),("prior_below",.boolean a.priorBelow),("rows",.array (a.rows.map (fun (d,s,m) => .array [nn d,rr s,rr m]))),("minimal_throw_ground_word",ns a.ground)])
def spinValue(a:SpinCensus):Value := .object [("ok",.object [("preserving",.array (a.preserving.map Value.text)),("alternating",.array (a.alternating.map Value.text)),("complete_count",nn a.completeCount),("preserving_share",rr a.preservingShare),("alternating_share",rr a.alternatingShare)])]
def returnValue(a:SpinReturn):Value := .object [("ok",.object [("alternating_turn_orbit",.array (a.alternatingOrbit.map Value.text)),("alternating_first_return_turns",nn a.alternatingFirstReturn),("paired_turn_orbit",.array (a.pairedOrbit.map Value.text)),("paired_first_return_turns",nn a.pairedFirstReturn),("two_alternating_compose_to",.text a.composedClass)])]
'''
p=w/'spinstatistics1043_cases.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(e for _,_,e in tests)+']))\n');ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=ev,capture_output=True,text=True);(w/'spinstatistics1043_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-4000:];actual=json.loads(x.stdout);assert actual==expected,[(i,tests[i][:2],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:2]
body=(r/'SFT/Physics/SpinStatisticsCondensation.lean').read_text();names=re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M);p=w/'spinstatistics1043_audit.lean';p.write_text('import SFT.Physics.SpinStatisticsCondensation\n'+''.join('#print axioms SFT.Physics.SpinStatisticsCondensation.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=ev,capture_output=True,text=True);(w/'spinstatistics1043_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'spinstatistics1043_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all_source_operation_fields=True,declarations=names,axioms=[],source_sha256=hashlib.sha256(body.encode()).hexdigest()),indent=2));print('PASS',len(tests),'whole source outputs;',len(names),'zeroaxiom declarations')
