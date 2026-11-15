from pathlib import Path
import sys,os,json,re,subprocess,hashlib,random,concurrent.futures
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator.machine_v3 import Calculator
from sft.mathematics.calculator import values as v
expressions=['0.1+0.2','1-1','1-3','1.25e-2','-2^2','2^-2','2^3^2','--2','+2','2+3*4','(2+3)*4','5!','5!%','100%','sqrt(2)','root(8,3)','root(-8,3)','sqrt(-4)','sqrt(-2)','exp(1)','ln(2)','log10(10)','log(8,2)','sin(1)','cos(1)','tan(1)','pi','e','empty','EMPTY_ONE','complex(1,2)^2','conj(complex(1,2))','recip(complex(1,2))','abs(complex(3,4))','pow(2,3)','ncr(10,3)','npr(5,2)','root(2,0)','ncr(2,3)','ln(0)','1/0','1!%','abs(-2)','2^^3','sqrt()','sqrt(1,2)','root(2)','unknown(2)','Unknown','1 2','(1+2','1+2)','1+','*2','1e','1e+','sqrt(1,)','complex(sqrt(2),1)','١.٥+٢.٥','', ' . ','(((1)))','1,2']
expressions += ['pi+1','PI','pi()','sqrt(pi)','sin(pi)','2*pi','complex(pi,1)','(pi)','pi^2']
expressions += ['('*depth+'1'+')'*depth for depth in [5,15,30]]
expressions += [f'({i}+{j})*({j}-{i})/{i}' for i in range(1,7) for j in [1,3,5]]
expressions += ['\u00a01+2=\u2003','1+2\u001c=','1+2=',' 1+2 =  ','1=2','1==','tau','phi','golden','2^(1/2)','pow(4,1/2)','root(pi,2)','log(100)','log(8,2)','log()','log(1,2,3)','hypot(3,4)','sum(1,2,3)','prod(1,2,3)','mean(1,2,3)','variance(1,2,3)','stddev(1,2,3)','sum()','gcd(-6,9)','lcm(-6,9)','mod(-7,-3)','floor(-1.2)','ceil(-1.2)','asin(1/2)','acos(1/2)','atan(2)','sinh(1)','cosh(1)','tanh(1)','asinh(-2)','acosh(2)','atanh(1/2)','log2(8)','cbrt(2)','sin(pi)','ans+mem','ANS','tau(1)']
cases=[(s,3,10000,'rad') for s in expressions]+[(f+'('+arg+')',3,10000,mode) for f,arg in [('sin','30'),('cos','60'),('tan','45'),('asin','1/2'),('acos','1/2'),('atan','1')] for mode in ['deg','grad','rad','invalid']]+[('1+2+3',p,limit,'rad') for p in [0,1,60,61] for limit in [-1,0,1,2]]
def canon(x):
 if isinstance(x,v.CertifiedInterval):return {'interval':[v.exact_text(x.lower),v.exact_text(x.upper),list(x.certificate)]}
 if isinstance(x,v.ComplexFibre):return {'complex':[v.exact_text(x.real),v.exact_text(x.orthogonal)]}
 return {'scalar':v.exact_text(x)}
expected=[]
for s,p,limit,mode in cases:
 try:
  x=Calculator(places=p,operation_limit=limit,angle_mode=mode,symbols={"ANS":v.forward(2),"mem":v.counter(3)}).calculate(s);expected.append({'ok':{'expression':x.expression,'value':canon(x.value),'trace':list(x.trace),'tokens_read':x.tokens_read,'operations_executed':x.operations_executed,'render':x.render(p)}})
 except v.CalculatorHalt as e:expected.append({'error':str(e)})
 except ValueError:expected.append({'error':'ValueError'})
header='''import SFT.Mathematics.CalculatorMachineV3
open SFT.Mathematics SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def canonical : CalculatorValues.Value → Value
 | .scalar v => .object [("scalar",.text (CalculatorValues.exactText v))]
 | .complex v => .object [("complex",.array [.text (CalculatorValues.exactText v.real),.text (CalculatorValues.exactText v.orthogonal)])]
 | .interval v => .object [("interval",.array [.text (CalculatorValues.exactText v.lower),.text (CalculatorValues.exactText v.upper),.array (v.certificate.map Value.text)])]
def evaluate (s : String) (p limit : Int) (mode : String) : Except String Value := do
 let x ← CalculatorMachineV3.calculate s p limit mode [("ANS",.scalar (← CalculatorValues.forward (CalculatorSeries.natural 2))),("mem",.scalar (← CalculatorValues.counter (CalculatorSeries.natural 3)))]
 let display ← CalculatorMachine.render x p
 pure (.object [("expression",.text x.expression),("value",canonical x.value),("trace",.array (x.trace.map Value.text)),("tokens_read",.integer (Int.ofNat x.tokensRead)),("operations_executed",.integer (Int.ofNat x.operationsExecuted)),("render",.text display)])
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'constants-recovery/CalculatorMachine1015_{i}.lean';p.write_text(header+'#eval IO.println (render (.array ['+','.join('result (evaluate '+json.dumps(s,ensure_ascii=False)+' ('+str(p)+') ('+str(limit)+') '+json.dumps(mode)+')' for s,p,limit,mode in cases[i:i+25])+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1015_machine_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=12) as pool:actual=[a for rows in pool.map(batch,range(0,len(cases),25)) for a in rows]
assert actual==expected,[(case,a,e) for case,a,e in zip(cases,actual,expected) if a!=e][:10]
s=(r/'SFT/Mathematics/CalculatorMachineV3.lean').read_text();names=re.findall(r'^\s*def (\w+)',s,re.M);p=w/'calculator1015_machine_audit.lean';p.write_text('import SFT.Mathematics.CalculatorMachineV3\n'+''.join('#print axioms SFT.Mathematics.CalculatorMachineV3.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1015_machine_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1015_machine_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Entire original Calculation fields,exact values/certificates,all traces,counts,rendering and errors for source functions,precedence,domains,operation/precision limits and nested parsing.'),indent=2));print('PASS',len(cases),'complete original calculations;',len(names),'emptyaxioms')
