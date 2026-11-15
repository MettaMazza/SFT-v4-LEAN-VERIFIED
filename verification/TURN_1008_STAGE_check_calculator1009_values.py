from pathlib import Path
import sys,json,os,subprocess,re,hashlib
from fractions import Fraction
w=Path('work');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from sft.mathematics.calculator import values as v
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');parts=[Fraction(n,d) for n in range(-3,4) for d in [1,2,5]]
def rat(q):return '(SFT.Physics.LeptonIntervals.normalize ('+str(q.numerator)+') '+str(q.denominator)+' (by decide))'
def scalar(q):return '(scalarFromProjection '+rat(q)+')'
def run(f,*args):
 try:return {'ok':f(*args)}
 except v.CalculatorHalt as e:return {'error':str(e)}
def text(x):return v.exact_text(x)
expected=[];expr=[]
for a in parts:
 for name,ln in [('forward','forward'),('counter','counter'),('scalar_from_projection','scalarFromProjection')]:
  expected.append(run(lambda: text(getattr(v,name)(a))));expr.append('resultText ('+ln+' '+rat(a)+')')
 aa=v.scalar_from_projection(a)
 expected.append(run(lambda:text(v.reciprocal_scalar(aa))));expr.append('resultText (do reciprocalScalar (← '+scalar(a)+'))')
 for b in parts:
  bb=v.scalar_from_projection(b)
  expected.append({'ok':v.compare_scalar(aa,bb)});expr.append('resultInt (do pure (compareScalar (← '+scalar(a)+') (← '+scalar(b)+')))')
  for fn,lean in [(v.add_scalar,'FoldScalar.add'),(v.subtract_scalar,'FoldScalar.subtract'),(v.multiply_scalar,'FoldScalar.multiply')]:
   expected.append({'ok':text(fn(aa,bb))});expr.append('resultText (do pure ('+lean+' (← '+scalar(a)+') (← '+scalar(b)+')))')
  expected.append(run(lambda:text(v.divide_scalar(aa,bb))));expr.append('resultText (do divideScalar (← '+scalar(a)+') (← '+scalar(b)+'))')
  for cert in [[],['source']]:
   expected.append(run(lambda: (lambda z:[text(z.lower),text(z.upper),list(z.certificate)])(v.CertifiedInterval(aa,bb,tuple(cert)))))
   expr.append('resultInterval (do certifiedInterval (← '+scalar(a)+') (← '+scalar(b)+') '+json.dumps(cert)+')')
s='''import SFT.Mathematics.CalculatorValues
open SFT.Mathematics SFT.Mathematics.CalculatorValues SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def resultText : Except String FoldScalar.Scalar → SFT.Host.Canonical.Value | .ok x => .object [("ok",.text (exactText x))] | .error e => .object [("error",.text e)]
def resultInt : Except String Int → SFT.Host.Canonical.Value | .ok x => .object [("ok",.integer x)] | .error e => .object [("error",.text e)]
def resultInterval : Except String CertifiedInterval → SFT.Host.Canonical.Value | .ok x => .object [("ok",.array [.text (exactText x.lower),.text (exactText x.upper),.array (x.certificate.map SFT.Host.Canonical.Value.text)])] | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n'
p=w/'constants-recovery/CalculatorValues1009.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1009_values_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
s=(r/'SFT/Mathematics/CalculatorValues.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1009_values_audit.lean';p.write_text('import SFT.Mathematics.CalculatorValues\n'+''.join('#print axioms SFT.Mathematics.CalculatorValues.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1009_values_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1009_values_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original scalar operations, exact_text and interval construction; reused existing FoldScalar arithmetic/proofs. Parser, decimal projection, operations and machine not certified by this component test.'),indent=2));print('PASS',len(expected),'original scalar/interval outputs;',len(names),'empty axioms')
