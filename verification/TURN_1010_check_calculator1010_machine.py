from pathlib import Path
import sys,os,json,re,subprocess,hashlib,random,concurrent.futures
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator.machine import Calculator
from sft.mathematics.calculator import values as v
expressions=['0.1+0.2','1-1','1-3','1.25e-2','-2^2','2^-2','2^3^2','--2','+2','2+3*4','(2+3)*4','5!','5!%','100%','sqrt(2)','root(8,3)','root(-8,3)','sqrt(-4)','sqrt(-2)','exp(1)','ln(2)','log10(10)','log(8,2)','sin(1)','cos(1)','tan(1)','pi','e','empty','EMPTY_ONE','complex(1,2)^2','conj(complex(1,2))','recip(complex(1,2))','abs(complex(3,4))','pow(2,3)','ncr(10,3)','npr(5,2)','root(2,0)','ncr(2,3)','ln(0)','1/0','1!%','abs(-2)','2^^3','sqrt()','sqrt(1,2)','root(2)','unknown(2)','Unknown','1 2','(1+2','1+2)','1+','*2','1e','1e+','sqrt(1,)','complex(sqrt(2),1)','١.٥+٢.٥','', ' . ','(((1)))','1,2']
expressions += ['('*depth+'1'+')'*depth for depth in [5,15,30]]
expressions += [f'({i}+{j})*({j}-{i})/{i}' for i in range(1,7) for j in [1,3,5]]
cases=[(s,p,10000) for s in expressions for p in [3,18]] + [('1+2+3',p,limit) for p in [0,1,60,61] for limit in [-1,0,1,2]]
def canon(x):
 if isinstance(x,v.CertifiedInterval):return {'interval':[v.exact_text(x.lower),v.exact_text(x.upper),list(x.certificate)]}
 if isinstance(x,v.ComplexFibre):return {'complex':[v.exact_text(x.real),v.exact_text(x.orthogonal)]}
 return {'scalar':v.exact_text(x)}
expected=[]
for s,p,limit in cases:
 try:
  x=Calculator(places=p,operation_limit=limit).calculate(s);expected.append({'ok':{'expression':x.expression,'value':canon(x.value),'trace':list(x.trace),'tokens_read':x.tokens_read,'operations_executed':x.operations_executed,'render':x.render(p)}})
 except v.CalculatorHalt as e:expected.append({'error':str(e)})
 except ValueError:expected.append({'error':'ValueError'})
header='''import SFT.Mathematics.CalculatorMachine
open SFT.Mathematics SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def canonical : CalculatorValues.Value → Value
 | .scalar v => .object [("scalar",.text (CalculatorValues.exactText v))]
 | .complex v => .object [("complex",.array [.text (CalculatorValues.exactText v.real),.text (CalculatorValues.exactText v.orthogonal)])]
 | .interval v => .object [("interval",.array [.text (CalculatorValues.exactText v.lower),.text (CalculatorValues.exactText v.upper),.array (v.certificate.map Value.text)])]
def evaluate (s : String) (p limit : Int) : Except String Value := do
 let x ← CalculatorMachine.calculate s p limit
 let display ← CalculatorMachine.render x p
 pure (.object [("expression",.text x.expression),("value",canonical x.value),("trace",.array (x.trace.map Value.text)),("tokens_read",.integer (Int.ofNat x.tokensRead)),("operations_executed",.integer (Int.ofNat x.operationsExecuted)),("render",.text display)])
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'constants-recovery/CalculatorMachine1010_{i}.lean';p.write_text(header+'#eval IO.println (render (.array ['+','.join('result (evaluate '+json.dumps(s,ensure_ascii=False)+' ('+str(p)+') ('+str(limit)+'))' for s,p,limit in cases[i:i+25])+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1010_machine_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=12) as pool:actual=[a for rows in pool.map(batch,range(0,len(cases),25)) for a in rows]
assert actual==expected,[(case,a,e) for case,a,e in zip(cases,actual,expected) if a!=e][:10]
s=(r/'SFT/Mathematics/CalculatorMachine.lean').read_text();names=re.findall(r'^\s*def (\w+)',s,re.M);p=w/'calculator1010_machine_audit.lean';p.write_text('import SFT.Mathematics.CalculatorMachine\n'+''.join('#print axioms SFT.Mathematics.CalculatorMachine.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1010_machine_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1010_machine_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Entire original Calculation fields,exact values/certificates,all traces,counts,rendering and errors for source functions,precedence,domains,operation/precision limits and nested parsing.'),indent=2));print('PASS',len(cases),'complete original calculations;',len(names),'emptyaxioms')
