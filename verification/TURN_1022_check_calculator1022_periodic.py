from pathlib import Path
import sys,json,subprocess,os,re,hashlib,concurrent.futures
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator import values as v
from sft.mathematics.calculator_complete import operations as o
rel='sft/mathematics/calculator_complete/operations.py';pinned=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert (w/'v3-runtime500'/rel).read_bytes()==pinned
helpers=Path('work/check_calculator1014_functions.py').read_text();exec(helpers[helpers.index('def rs'):helpers.index('expected=[]')]);expected=[];expr=[]
def addcase(f,expression,*args):
 try:expected.append({'ok':canon(f(*args))})
 except (v.CalculatorHalt,TypeError) as e:expected.append({'error':str(e)})
 expr.append('result (do '+expression+')')
values=[v.scalar_from_projection(Fraction(x)) for x in [-100,-7,0,1,7,100]]
values += [v.CertifiedInterval(v.scalar_from_projection(Fraction(-8)),v.scalar_from_projection(Fraction(9)),('crossing',)),v.ComplexFibre(v.forward(1),v.forward(2))]
for x in values:
 for places in [1,3]:
  addcase(o.periodic_reduce,'pure (.interval (← periodicReduce ('+vv(x)+') '+str(places)+'))',x,places)
  for py,ln in [('sin_value','sinValue'),('cos_value','cosValue'),('tan_value','tanValue')]:addcase(getattr(o,py),ln+' ('+vv(x)+') '+str(places),x,places)
for turns,places in [(0,-7),(0,-6),(1,18),(-1,3),(10**30,18),(1,505)]:addcase(o._circle_for_turns,'pure (.interval (← circleForTurns ('+str(turns)+') ('+str(places)+')))',turns,places)
head=helpers[helpers.index("s='''")+5:helpers.index("#eval IO.println")].replace('CalculatorFunctionsV3','CalculatorCompleteOperations')
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def run(i):
 p=w/f'constants-recovery/CalculatorPeriodic1022_{i}.lean';p.write_text(head+'#eval IO.println (SFT.Host.Canonical.render (.array ['+',\n'.join(expr[i:i+10])+']))\n');x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1022_periodic_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1500:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:actual=[x for rows in pool.map(run,range(0,len(expr),10)) for x in rows]
assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:1]
# Exact nearest-whole boundary cases, including negative and half-way ties.
fractions=[Fraction(n,d) for n in range(-35,36) for d in [1,2,3,7]];p=w/'calculator1022_nearest.lean';p.write_text(head+'#eval IO.println (SFT.Host.Canonical.render (.array ['+','.join('.integer (nearestWhole '+rs(x)+')' for x in fractions)+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,text=True,capture_output=True);assert x.returncode==0,x.stdout;assert json.loads(x.stdout)==[o._nearest_whole(x) for x in fractions]
p=r/'SFT/Mathematics/CalculatorCompleteOperations.lean';s=p.read_text();names=['SFT.Mathematics.CalculatorCompleteOperations.'+n for n in re.findall(r'^def (\w+)',s,re.M)];a=w/'calculator1022_periodic_audit.lean';a.write_text('import SFT.Mathematics.CalculatorCompleteOperations\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(a)],env=env,capture_output=True,text=True);(w/'calculator1022_periodic_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1022_periodic_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),nearest_whole_cases=len(fractions),declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),original_sha256=hashlib.sha256(pinned).hexdigest()),indent=2));print('PASS',len(expected),'full interval/certificate/error outputs and',len(fractions),'nearest count outputs;',len(names),'zeroaxiom definitions')
