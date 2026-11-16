from pathlib import Path
from fractions import Fraction
from itertools import product
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'collective1035_law.py').read_text();env={'Fraction':Fraction,'product':product,'SPACE_RANK':3,'BINARY':2};exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-collective-functions','exec'),env)
ci=lambda n:'.boolean '+str(n).lower() if isinstance(n,bool)else'.integer ('+str(n)+')'
cs=lambda ns:'['+','.join('('+ci(n)+')'for n in ns)+']'
def rat(q):
 q=Fraction(q);return f'(normalize ({q.numerator} : Int) {q.denominator} (by decide))'
tests=[]
def add(name,args,expression,wrapper):tests.append((name,args,wrapper+' ('+expression+')'))
for costs in [[],[1],[1,2],[1,2,3,5,8],[2,4],[3,8],[0,1],[True],[-1,2]]:
 for total in [True,0,1,4,7]:
  for name,lean,wrap in [('finite_boson_occupations','finiteBosonOccupations','wordsResult'),('exact_mode_occupation','exactModeOccupation','ratListResult'),('ultraviolet_closed','ultravioletClosed','boolResult')]:add(name,(tuple(costs),total),lean+' '+cs(costs)+' ('+ci(total)+')',wrap)
  for scale in [False,1,3]:add('occupation_scale_covariant',(tuple(costs),total,scale),'occupationScaleCovariant '+cs(costs)+' ('+ci(total)+') ('+ci(scale)+')','boolResult')
for q in [Fraction(-1),Fraction(0),Fraction(1,2),Fraction(3,2),Fraction(2)]:
 add('radiation_power_ratio',(q,),'radiationPowerRatio '+rat(q),'ratResult')
 for count in [False,0,1,4]:add('acoustic_ladder',(q,count),'acousticLadder '+rat(q)+' ('+ci(count)+')','ratListResult')
for counts in [(3,2,7),(2,3,1),(1,1,2),(False,2,7),(3,0,7),(3,2,-1)]:
 for gain,loss in [(Fraction(4,3),Fraction(5,4)),(Fraction(1),Fraction(1)),(Fraction(0),Fraction(1))]:
  a,b,c=counts;add('laser_ledger',(a,b,gain,loss,c),'laserLedger ('+ci(a)+') ('+ci(b)+') '+rat(gain)+' '+rat(loss)+' ('+ci(c)+')','laserResult')
for name,lean,base,wrap in [('plasma_squared_carriers','plasmaSquaredCarriers',[3,2,5,7,11],'plasmaResult'),('alfven_squared_carrier','alfvenSquaredCarrier',[3,5,7],'ratResult')]:
 add(name,tuple(base),lean+' '+' '.join(map(rat,base)),wrap)
 for i in range(len(base)):
  for v in [-1,0,Fraction(2,3)]:
   args=base.copy();args[i]=v;add(name,tuple(args),lean+' '+' '.join(map(rat,args)),wrap)
def cv(v):
 if isinstance(v,Fraction):return f'{v.numerator}/{v.denominator}'
 if isinstance(v,(list,tuple)):return [cv(a)for a in v]
 if isinstance(v,dict):return {k:cv(a)for k,a in v.items()}
 return v
expected=[]
for name,args,_ in tests:
 try:expected.append({'ok':cv(env[name](*args))})
 except ValueError as e:expected.append({'error':str(e)})
header='''import SFT.Physics.CollectiveRadiation
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.CollectiveRadiation LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rr(q:Rat):Value := .text (toString q.num ++ "/" ++ toString q.den)
def result {α : Type} (convert : α→Value) : Except String α → Value
 | .ok a => .object [("ok",convert a)]
 | .error e => .object [("error",.text e)]
def wordsResult := result (fun words : List (List Nat) => .array (words.map (fun w => .array (w.map (fun n => .integer (.ofNat n))))))
def ratListResult := result (fun xs : List Rat => .array (xs.map rr))
def ratResult := result rr
def boolResult := result Value.boolean
def laserResult := result (fun a : LaserLedger => .object [("inversion",rr a.inversion),("population_inverted",.boolean a.populationInverted),("at_threshold",.boolean a.atThreshold),("above_threshold",.boolean a.aboveThreshold),("linewidth",rr a.linewidth),("linewidth_time_product",rr a.linewidthTimeProduct)])
def plasmaResult := result (fun a : PlasmaCarriers => .object [("plasma_frequency_squared",rr a.frequencySquared),("debye_length_squared",rr a.debyeLengthSquared)])
'''
p=w/'collective1035_cases.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(e for _,_,e in tests)+']))\n');envlean={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=envlean,capture_output=True,text=True);(w/'collective1035_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,tests[i][0],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:2]
body=(r/'SFT/Physics/CollectiveRadiation.lean').read_text();names=re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M);p=w/'collective1035_audit.lean';p.write_text('import SFT.Physics.CollectiveRadiation\n'+''.join('#print axioms SFT.Physics.CollectiveRadiation.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=envlean,capture_output=True,text=True);(w/'collective1035_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'collective1035_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all_source_operation_fields=True,declarations=names,axioms=[],source_sha256=hashlib.sha256(body.encode()).hexdigest()),indent=2));print('PASS',len(tests),'whole source operation outputs;',len(names),'zeroaxiom declarations')
