from pathlib import Path
import sys,os,json,re,subprocess,hashlib,random,concurrent.futures
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator import values as v
parts=[Fraction(n,d) for n in [-9999999,-125,-1,0,1,5,999,1000,12340,9999999] for d in [1,2,3,7,100,10**7]]
parts += [Fraction(10**k+d,10**j) for k in [8,18,30] for d in [-1,0,1,5] for j in [0,7,20,40]]
rng=random.Random(1010);parts += [Fraction(rng.randrange(-10**30,10**30),rng.randrange(1,10**30)) for _ in range(40)]
def rs(q):return '(SFT.Physics.LeptonIntervals.normalize ('+str(q.numerator)+') '+str(q.denominator)+' (by decide))'
def ss(q):return '(← CalculatorValues.scalarFromProjection '+rs(q)+')'
expected=[];expr=[]
for q in parts:
 a=v.scalar_from_projection(q)
 for places in [-8,-1,0,1,3,12,18,60]:
  for f,lean in [(v.decimal_projection,'decimalProjection'),(v.value_text,'valueText')]:
   try:expected.append({'ok':f(a,places)})
   except ValueError:expected.append({'error':'ValueError'})
   arg=ss(q) if lean=='decimalProjection' else '(CalculatorValues.Value.scalar '+ss(q)+')'
   expr.append('result (do '+lean+' '+arg+' ('+str(places)+'))')
for lower,upper in [(Fraction(-1,3),Fraction(1,7)),(Fraction(1,3),Fraction(2,3)),(Fraction(2),Fraction(2))]:
 for places in [0,3,18]:
  interval=v.CertifiedInterval(v.scalar_from_projection(lower),v.scalar_from_projection(upper),('test',));expected.append({'ok':v.value_text(interval,places)});expr.append('result (do valueText (.interval (← CalculatorValues.certifiedInterval '+ss(lower)+' '+ss(upper)+' ["test"])) '+str(places)+')')
header='''import SFT.Mathematics.CalculatorProjection
open SFT.Mathematics SFT.Mathematics.CalculatorProjection SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String String → Value | .ok v => .object [("ok",.text v)] | .error e => .object [("error",.text e)]
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'constants-recovery/CalculatorProjection1010_{i}.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(expr[i:i+150])+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1010_projection_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=28) as pool:actual=[a for rows in pool.map(batch,range(0,len(expr),150)) for a in rows]
assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:15]
s=(r/'SFT/Mathematics/CalculatorProjection.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1010_projection_audit.lean';p.write_text('import SFT.Mathematics.CalculatorProjection\n'+''.join('#print axioms SFT.Mathematics.CalculatorProjection.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1010_projection_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1010_projection_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expr),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original two-stage Decimal rounding/general format and value_text, including exact terminating and repeating rationals, ties/carry,small/large exponents,negative orientations,precision guards and intervaldisplay; host failures retain exception type.'),indent=2));print('PASS',len(expr),'original display cases;',len(names),'emptyaxioms')
