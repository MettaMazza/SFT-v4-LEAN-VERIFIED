from pathlib import Path
import sys,json,subprocess,os,re,hashlib
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator import values as v,operations as o
parts=[Fraction(-2),Fraction(-1,2),Fraction(0),Fraction(1,2),Fraction(2)]
sc=[v.scalar_from_projection(x) for x in parts];values=sc+[v.CertifiedInterval(sc[0],sc[1],('negative',)),v.CertifiedInterval(sc[1],sc[3],('crossing',)),v.CertifiedInterval(sc[3],sc[4],('positive',)),v.ComplexFibre(sc[3],sc[4]),v.ComplexFibre(sc[2],sc[2])]
def rs(q):return '(SFT.Physics.LeptonIntervals.normalize ('+str(q.numerator)+') '+str(q.denominator)+' (by decide))'
def ss(x):return '(← scalarFromProjection '+rs(v.scalar_to_fraction_for_projection(x))+')'
def vv(x):
 if isinstance(x,v.CertifiedInterval):return 'Value.interval (← certifiedInterval '+ss(x.lower)+' '+ss(x.upper)+' '+json.dumps(list(x.certificate))+')'
 if isinstance(x,v.ComplexFibre):return 'Value.complex ⟨'+ss(x.real)+','+ss(x.orthogonal)+'⟩'
 return 'Value.scalar '+ss(x)
def canon(x):
 if isinstance(x,v.CertifiedInterval):return {'interval':[v.exact_text(x.lower),v.exact_text(x.upper),list(x.certificate)]}
 if isinstance(x,v.ComplexFibre):return {'complex':[v.exact_text(x.real),v.exact_text(x.orthogonal)]}
 return {'scalar':v.exact_text(x)}
expected=[];expr=[]
def addcase(f,expression,*args):
 try:expected.append({'ok':canon(f(*args))})
 except v.CalculatorHalt as e:expected.append({'error':str(e)})
 expr.append('result (do '+expression+')')
for a in values:
 addcase(o.absolute,'absolute ('+vv(a)+')',a)
for a in sc+[v.forward(Fraction(1,27)),v.counter(8),v.forward(16)]:
 for degree in [-1,0,1,2,3,4]:
  for depth in [-2,0,5]:
   addcase(o.nth_root,'nthRoot ('+vv(a)+') ('+str(degree)+') ('+str(depth)+')',a,degree,depth)
s='''import SFT.Mathematics.CalculatorRoots
open SFT.Mathematics SFT.Mathematics.CalculatorValues SFT.Mathematics.CalculatorRoots
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def canonical : Value → SFT.Host.Canonical.Value
 | .scalar v => .object [("scalar",.text (exactText v))]
 | .complex v => .object [("complex",.array [.text (exactText v.real),.text (exactText v.orthogonal)])]
 | .interval v => .object [("interval",.array [.text (exactText v.lower),.text (exactText v.upper),.array (v.certificate.map SFT.Host.Canonical.Value.text)])]
def result : Except String Value → SFT.Host.Canonical.Value | .ok x => .object [("ok",canonical x)] | .error e => .object [("error",.text e)]
#eval IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(expr)+']))\n'
p=w/'constants-recovery/CalculatorRoots1009.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1009_roots_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
s=(r/'SFT/Mathematics/CalculatorRoots.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1009_roots_audit.lean';p.write_text('import SFT.Mathematics.CalculatorRoots\n'+''.join('#print axioms SFT.Mathematics.CalculatorRoots.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1009_roots_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1009_roots_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original nth_root and absolute complete value/certificate/error outputs; degree guards,negative/zero depth,exact roots,odd orientation and orthogonal rejection.'),indent=2));print('PASS',len(expected),'full original outputs;',len(names),'empty axioms')
