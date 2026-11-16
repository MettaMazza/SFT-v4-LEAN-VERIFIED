from pathlib import Path
from fractions import Fraction
from math import comb,factorial
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'equilibrium1035_law.py').read_text();env={'Fraction':Fraction,'comb':comb,'factorial':factorial};exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-equilibrium-functions','exec'),env)
ci=lambda n:'.boolean '+str(n).lower() if isinstance(n,bool)else'.integer ('+str(n)+')'
def rat(q):
 q=Fraction(q);return f'(normalize ({q.numerator} : Int) {q.denominator} (by decide))'
tests=[]
def add(name,args,expression,wrapper):tests.append((name,args,wrapper+' ('+expression+')'))
for xs in [[],[Fraction(1,4),Fraction(3,4)],[Fraction(1,3),Fraction(1,2),Fraction(2,3)],[2],[0,1],[-1,1],[Fraction(2,7)]*5]:
 for name,lean,wrapper in [('exact_temperature','exactTemperature','ratResult'),('total_throw_identity','totalThrowIdentity','boolResult')]:add(name,(tuple(xs),),lean+' ['+','.join(map(rat,xs))+']',wrapper)
for n in [False,True,-1,0,*range(1,12)]:
 add('paired_equilibrium_census',(n,),'pairedEquilibriumCensus ('+ci(n)+')','pairedResult')
 add('deterministic_noise_cycle',(n,),'deterministicNoiseCycle ('+ci(n)+')','noiseResult')
for n in [False,True,-1,0,1,*range(2,10)]:
 add('dyadic_canonical_counts',(n,),'dyadicCanonicalCounts ('+ci(n)+')','natListResult')
 add('dyadic_canonical_weights',(n,),'dyadicCanonicalWeights ('+ci(n)+')','ratListResult')
for n in [False,True,-1,0,1,2,3,4,5]:
 add('fixed_count_throw_forms',(n,),'fixedCountThrowForms ('+ci(n)+')','wordsResult')
 add('canonical_maximum_certificate',(n,),'canonicalMaximumCertificate ('+ci(n)+')','maximumResult')
add('fluctuation_response_ledger',(),'Except.ok fluctuationResponseLedger','fluctuationResult')
def cv(v):
 if isinstance(v,Fraction):return f'{v.numerator}/{v.denominator}'
 if isinstance(v,(list,tuple)):return [cv(a)for a in v]
 if isinstance(v,dict):return {k:cv(a)for k,a in v.items()}
 return v
expected=[]
for name,args,_ in tests:
 try:expected.append({'ok':cv(env[name](*args))})
 except ValueError as e:expected.append({'error':str(e)})
header='''import SFT.Physics.ThermalEquilibriumResponse
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.ThermalEquilibriumResponse LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rr(q:Rat):Value := .text (toString q.num ++ "/" ++ toString q.den)
def ns(xs:List Nat):Value := .array (xs.map (fun n => .integer (.ofNat n)))
def ws(xs:List (List Nat)):Value := .array (xs.map ns)
def result {α : Type} (convert : α→Value) : Except String α → Value
 | .ok a => .object [("ok",convert a)]
 | .error e => .object [("error",.text e)]
def wordsResult := result ws
def natListResult := result ns
def ratListResult := result (fun xs : List Rat => .array (xs.map rr))
def ratResult := result rr
def boolResult := result Value.boolean
def pairedResult := result (fun a : PairedCensus => .object [("population",.integer (.ofNat a.population)),("rows",.array (a.rows.map (fun p => ns [p.1,p.2]))),("survivors",ns a.survivors),("share",rr a.share)])
def noiseResult := result (fun a : NoiseCycle => .object [("cycle",.array (a.cycle.map rr)),("mean",rr a.mean),("period",.integer (.ofNat a.period))])
def maximumResult := result (fun a : MaximumCertificate => .object [("target",ns a.target),("forms",.integer (.ofNat a.forms)),("survivors",ws a.survivors),("unique",.boolean a.unique)])
def fluctuationResult := result (fun a : FluctuationResponse => .object [("equilibrium",rr a.equilibrium),("fluctuation",rr a.fluctuation),("response",rr a.response),("complete",.boolean a.complete),("equal_departure",.boolean a.equalDeparture)])
'''
p=w/'equilibrium1035_cases.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(e for _,_,e in tests)+']))\n');envlean={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=envlean,capture_output=True,text=True);(w/'equilibrium1035_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,tests[i][0],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:2]
body=(r/'SFT/Physics/ThermalEquilibriumResponse.lean').read_text();names=re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M);p=w/'equilibrium1035_audit.lean';p.write_text('import SFT.Physics.ThermalEquilibriumResponse\n'+''.join('#print axioms SFT.Physics.ThermalEquilibriumResponse.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=envlean,capture_output=True,text=True);(w/'equilibrium1035_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'equilibrium1035_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all_source_operation_fields=True,complete_forms_through_levels=5,declarations=names,axioms=[],source_sha256=hashlib.sha256(body.encode()).hexdigest()),indent=2));print('PASS',len(tests),'whole source operation outputs;',len(names),'zeroaxiom declarations')
