from pathlib import Path
import sys,subprocess,os,json,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rt=w/'v3-runtime500'
for name in ['__init__.py','app.py','native.py','page.py']:
 p=rt/'sft/mathematics/calculator_browser'/name;p.parent.mkdir(parents=True,exist_ok=True);b=(w/('calculator1026_original_'+name)).read_bytes()
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
sys.path.insert(0,str(rt.resolve()));from sft.mathematics.calculator_browser import native as n
from sft.mathematics.calculator_complete.machine import calculate
from sft.mathematics.calculator_complete.controller import CalculatorController
expressions=['1-1','1','1/3','1-2','-2/3','sqrt(2)','sqrt(4)','sqrt(-4)','complex(1,2)','complex(-1,2)','complex(1,-2)','exp(1)','ln(2)','sin(2)','cos(3)','atan(1)','floor(-1/3)','sum(1,2,3)']
expected=[]
for e in expressions:
 v=calculate(e,places=3).value;expected.append([n.native_value(v),n.contains_counter(v)])
head='''import SFT.Mathematics.CalculatorBrowserNative
open SFT.Mathematics SFT.Host CalculatorBrowserNative
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def output (s : String) : Except String Canonical.Value := do
 let c ← CalculatorCompleteMachine.calculate s 3
 pure (.array [.text (nativeValue c.value),.boolean (containsCounter c.value)])
def result : Except String Canonical.Value → Canonical.Value | .ok v => v | .error e => .object [("error",.text e)]
'''
head+='#eval IO.println (Canonical.render (.array ['+','.join('result (output '+json.dumps(e)+')'for e in expressions)+']))\n'
actions=[('expression','sqrt(2)'),('evaluate',''),('press','MS'),('expression','1/0'),('evaluate',''),('press','CE'),('expression','1-4'),('evaluate',''),('expression','complex(1,2)'),('evaluate',''),('press','C'),('expression','1+1='),('evaluate','')]
c=CalculatorController(places=3);views=[n.native_view(c)];code='def views : Except String (List Canonical.Value) := do\n let s := CalculatorCompleteController.create 3\n let out := [viewValue (← nativeView s)]\n'
for kind,arg in actions:
 if kind=='expression':c.set_expression(arg);line='let s := CalculatorCompleteController.setExpression s '+json.dumps(arg)
 elif kind=='evaluate':c.evaluate();line='let s ← CalculatorCompleteController.evaluate s'
 else:c.press(arg);line='let s ← CalculatorCompleteController.press s '+json.dumps(arg)
 views.append(n.native_view(c));code+=' '+line+'\n let out := out ++ [viewValue (← nativeView s)]\n'
code+=' pure out\n#eval match views with | .error e => IO.println e | .ok xs => IO.println (Canonical.render (.array xs))\n'
traces=['plain','one ≈ two','a ≈ b ≈ c',' ≈ start','approx≈plain','≈',' x ≈ y'];head+=code+'#eval IO.println (Canonical.render (.array (['+','.join(json.dumps(x,ensure_ascii=False)for x in traces)+'].map fun x => .text (String.ofList (beforeApprox (Text.chars x))))))\n'
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};p=w/'calculator1026_native_check.lean';p.write_text(head);x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1026_native_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];rows=[json.loads(x)for x in x.stdout.splitlines()];assert rows[0]==expected;assert rows[1]==json.loads(json.dumps(views));assert rows[2]==[x.split(' ≈ ',1)[0]for x in traces]
s=(r/'SFT/Mathematics/CalculatorBrowserNative.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1026_native_audit.lean';p.write_text('import SFT.Mathematics.CalculatorBrowserNative\n'+''.join('#print axioms SFT.Mathematics.CalculatorBrowserNative.'+n+'\n'for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1026_native_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1026_native_report.json').write_text(json.dumps(dict(status='PASS',typed_value_cases=len(expressions),complete_views=len(views),trace_split_cases=len(traces),declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest()),indent=2));print('PASS nativevalue/view andsource trace split;',len(names),'emptyaxiom definitions')
