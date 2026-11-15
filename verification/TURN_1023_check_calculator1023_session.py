from pathlib import Path
import sys,os,json,subprocess,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete.session import CalculatorSession
from sft.mathematics.calculator import values as v
from fractions import Fraction

def canon(x):
 if isinstance(x,v.CertifiedInterval):return {'interval':[v.exact_text(x.lower),v.exact_text(x.upper),list(x.certificate)]}
 if isinstance(x,v.ComplexFibre):return {'complex':[v.exact_text(x.real),v.exact_text(x.orthogonal)]}
 return {'scalar':v.exact_text(x)}
def calc(x):return dict(expression=x.expression,value=canon(x.value),trace=list(x.trace),tokens_read=x.tokens_read,operations_executed=x.operations_executed)
def snapshot(s):return dict(places=s.places,angle_mode=s.angle_mode,operation_limit=s.operation_limit,memory=canon(s.memory),answer=canon(s.answer),history=[dict(index=e.index,expression=e.expression,angle_mode=e.angle_mode,calculation=calc(e.calculation)) for e in s.history])
actions=[('eval','1+1='),('store',''),('eval','ans+mem='),('add',''),('subtract',''),('mode','deg'),('eval','sin(30)'),('store',''),('eval','1/0'),('mode','bad'),('add',''),('subtract',''),('clear',''),('eval','mem+ans='),('history',''),('mode','grad'),('eval','atan(1)'),('store_explicit',''),('eval','mem'),('add_explicit',''),('subtract_explicit',''),('eval','mem'),('clear',''),('history','')]
actions += [('eval','2+3'),('store',''),('all_clear',''),('eval','ans+mem'),('eval','12345'),('eval','2^6')]
expected=[]
for places,mode,limit in [(3,'rad',10000),(6,'deg',10000),(0,'rad',10000),(3,'rad',3)]:
 s=CalculatorSession(places=places,angle_mode=mode,operation_limit=limit);seq=[snapshot(s)]
 for action,arg in actions:
  error=''
  try:
   if action=='eval':s.evaluate(arg)
   elif action=='mode':s.set_angle_mode(arg)
   elif action=='store':s.memory_store()
   elif action=='add':s.memory_add()
   elif action=='subtract':s.memory_subtract()
   elif action=='clear':s.memory_clear()
   elif action=='history':s.clear_history()
   elif action=='all_clear':s.all_clear()
   elif action=='store_explicit':s.memory_store(v.scalar_from_projection(Fraction(-3,2)))
   elif action=='add_explicit':s.memory_add(v.forward(2))
   elif action=='subtract_explicit':s.memory_subtract(v.counter(3))
  except (v.CalculatorHalt,ValueError) as e:error=str(e)
  seq.append(dict(error=error,state=snapshot(s)))
 expected.append(seq)
header='''import SFT.Mathematics.CalculatorCompleteSession
open SFT.Mathematics SFT.Host.Canonical CalculatorValues CalculatorCompleteSession
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def canonical : CalculatorValues.Value → SFT.Host.Canonical.Value
 | .scalar v => .object [("scalar",.text (exactText v))]
 | .complex v => .object [("complex",.array [.text (exactText v.real),.text (exactText v.orthogonal)])]
 | .interval v => .object [("interval",.array [.text (exactText v.lower),.text (exactText v.upper),.array (v.certificate.map SFT.Host.Canonical.Value.text)])]
def calculation (x : CalculatorMachine.Calculation) : SFT.Host.Canonical.Value := .object [("expression",.text x.expression),("value",canonical x.value),("trace",.array (x.trace.map SFT.Host.Canonical.Value.text)),("tokens_read",.integer (Int.ofNat x.tokensRead)),("operations_executed",.integer (Int.ofNat x.operationsExecuted))]
def snapshot (s : Session) : SFT.Host.Canonical.Value := .object [("places",.integer s.places),("angle_mode",.text s.angleMode),("operation_limit",.integer s.operationLimit),("memory",canonical s.memory),("answer",canonical s.answer),("history",.array (s.history.map fun e => .object [("index",.integer (Int.ofNat e.index)),("expression",.text e.expression),("angle_mode",.text e.angleMode),("calculation",calculation e.calculation)]))]
def action (s : Session) (name arg : String) : Except String Session := do
 if name == "eval" then pure (← evaluate s arg).2
 else if name == "mode" then setAngleMode s arg
 else if name == "store" then pure (memoryStore s).2
 else if name == "add" then pure (← memoryAdd s).2
 else if name == "subtract" then pure (← memorySubtract s).2
 else if name == "clear" then pure (memoryClear s).2
 else if name == "history" then pure (clearHistory s)
 else if name == "all_clear" then pure (allClear s)
 else if name == "store_explicit" then pure (memoryStore s (some (.scalar (← scalarFromProjection (SFT.Physics.LeptonIntervals.normalize (-3) 2 (by decide)))))).2
 else if name == "add_explicit" then pure (← memoryAdd s (some (.scalar (← forward (CalculatorSeries.natural 2))))).2
 else pure (← memorySubtract s (some (.scalar (← counter (CalculatorSeries.natural 3))))).2
'''
rows=','.join('('+json.dumps(a)+','+json.dumps(b)+')' for a,b in actions)
header+='''def run (places : Int) (mode : String) (limit : Int) : List SFT.Host.Canonical.Value := Id.run do
 let mut s : Session := {places := places,angleMode := mode,operationLimit := limit}
 let mut results := [snapshot s]
 for (name,arg) in ['''+rows+'''] do
  let mut error := ""
  match action s name arg with
  | .ok next => s := next
  | .error e => error := e
  results := results ++ [.object [("error",.text error),("state",snapshot s)]]
 return results
#eval do
 for rows in [run 3 "rad" 10000,run 6 "deg" 10000,run 0 "rad" 10000,run 3 "rad" 3] do
  for row in rows do IO.println (render row)
'''
p=w/'constants-recovery/CalculatorSession1023.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1023_session_output.log').write_text(x.stdout+x.stderr);assert x.returncode==0,(x.returncode,x.stdout[-3000:],x.stderr[-3000:]);actual=[json.loads(line) for line in x.stdout.splitlines()]; flat=[e for seq in expected for e in seq]; assert actual==flat,[(i,a,e) for i,(a,e) in enumerate(zip(actual,flat)) if a!=e][:3]
s=(r/'SFT/Mathematics/CalculatorCompleteSession.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1023_session_audit.lean';p.write_text('import SFT.Mathematics.CalculatorCompleteSession\n'+''.join('#print axioms SFT.Mathematics.CalculatorCompleteSession.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1023_session_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
report=dict(status='PASS',cases=len(expected)*(len(actions)+1),declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Complete original session snapshots after ordered actions including failures,history,answer,memory and angle/precision behavior.');(w/'calculator1023_session_report.json').write_text(json.dumps(report,indent=2));print('PASS',report['cases'],'complete session states;',len(names),'empty axioms')
