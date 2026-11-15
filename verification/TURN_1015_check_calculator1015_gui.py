from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator import gui,values as v
from sft.mathematics.calculator.session import CalculatorSession
class TclError(Exception):pass
class Var:
 def __init__(self,x=''):self.x=x
 def get(self):return self.x
 def set(self,x):self.x=x
class Entry:
 def __init__(self,a):self.a=a;self.cursor=0;self.selection=None
 def index(self,key):
  if key=='insert':return min(self.cursor,len(self.a.expression.get()))
  if self.selection is None:raise TclError()
  return self.selection[0 if key=='sel.first' else 1]
 def icursor(self,x):self.cursor=len(self.a.expression.get()) if x=='end' else x
 def focus_set(self):pass
class History:
 def __init__(self):self.rows=[];self.selected=()
 def insert(self,_,row):self.rows.append(row)
 def see(self,_):pass
 def delete(self,*_):self.rows=[]
 def curselection(self):return self.selected
class Trace:
 def __init__(self):self.content=''
 def configure(self,**kwargs):pass
 def delete(self,*_):self.content=''
 def insert(self,_,text):self.content=text
class Root:
 def __init__(self):self.clipboard=''
 def clipboard_clear(self):self.clipboard=''
 def clipboard_append(self,x):self.clipboard+=x

def app(expr='',selection=None):
 a=gui.SFTCalculatorApp.__new__(gui.SFTCalculatorApp);a.tk=type('Tk',(),{'TclError':TclError});a.root=Root();a.session=CalculatorSession(places=3);a.expression=Var(expr);a.result=Var('0');a.mode=Var('RAD');a.memory_indicator=Var();a.entry=Entry(a);a.entry.cursor=min(1,len(expr));a.entry.selection=selection;a.history_list=History();a.trace_text=Trace();return a
def canon(x):
 if isinstance(x,v.CertifiedInterval):return {'interval':[v.exact_text(x.lower),v.exact_text(x.upper),list(x.certificate)]}
 if isinstance(x,v.ComplexFibre):return {'complex':[v.exact_text(x.real),v.exact_text(x.orthogonal)]}
 return {'scalar':v.exact_text(x)}
def snapshot(a):return dict(expression=a.expression.get(),result=a.result.get(),mode=a.mode.get(),indicator=a.memory_indicator.get(),memory=canon(a.session.memory),answer=canon(a.session.answer),history=list(a.history_list.rows),trace=a.trace_text.content,clipboard=a.root.clipboard,history_count=len(a.session.history),angle_mode=a.session.angle_mode)
expected=[];expressions=[]
for expr,sel in [('',None),('12',None),('12',(0,1))]:
 for label in [x for row in gui.BUTTON_ROWS for x in row]:
  a=app(expr,sel);a.press(label);expected.append(snapshot(a));selection='none' if sel is None else 'some (0,1)';expressions.append('runPress '+json.dumps(expr)+' ('+selection+') '+json.dumps(label,ensure_ascii=False))
sequence=['1','+','1','=','MS','MR','+','Ans','=','M+','M−','MC','C','sin','3','0',')','=']
a=app();seq=[]
for label in sequence:a.press(label);seq.append(snapshot(a))
expected+=seq
header='''import SFT.Mathematics.CalculatorGUI
open SFT.Mathematics SFT.Host CalculatorGUI CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def canonical : CalculatorValues.Value → Canonical.Value
 | .scalar v => .object [("scalar",.text (exactText v))]
 | .complex v => .object [("complex",.array [.text (exactText v.real),.text (exactText v.orthogonal)])]
 | .interval v => .object [("interval",.array [.text (exactText v.lower),.text (exactText v.upper),.array (v.certificate.map Canonical.Value.text)])]
def snapshot (s : State) : Canonical.Value := .object [("expression",.text s.expression),("result",.text s.result),("mode",.text s.mode),("indicator",.text s.memoryIndicator),("memory",canonical s.session.memory),("answer",canonical s.session.answer),("history",.array (s.historyRows.map Canonical.Value.text)),("trace",.text s.trace),("clipboard",.text s.clipboard),("history_count",.integer (Int.ofNat s.session.history.length)),("angle_mode",.text s.session.angleMode)]
def runPress (expr : String) (selection : Option (Nat × Nat)) (label : String) : Except String Canonical.Value := do
 let state : State := {session := {places := 3},expression := expr,cursor := min 1 (Text.chars expr).length,selection := selection}
 pure (snapshot (← press state label))
def get : Except String Canonical.Value → Canonical.Value | .ok x => x | .error e => .object [("error",.text e)]
'''
header+='#eval do\n for x in ['+',\n'.join(expressions)+'] do IO.println (Canonical.render (get x))\n'
header+='''#eval do
 let mut s : State := {session := {places := 3}}
 for label in '''+json.dumps(sequence,ensure_ascii=False)+''' do
  match press s label with
  | .error e => IO.println e
  | .ok next =>
   s := next
   IO.println (Canonical.render (snapshot s))
'''
p=w/'constants-recovery/CalculatorGUI1015.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1015_gui_output.log').write_text(x.stdout+x.stderr);assert x.returncode==0,(x.returncode,x.stdout[-1500:]);actual=[json.loads(x) for x in x.stdout.splitlines()];assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
s=(r/'SFT/Mathematics/CalculatorGUI.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1015_gui_audit.lean';p.write_text('import SFT.Mathematics.CalculatorGUI\n'+''.join('#print axioms SFT.Mathematics.CalculatorGUI.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1015_gui_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
report=dict(status='PASS',cases=len(expected),declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='OriginalSFTCalculatorApp.press/evaluate application-owned state via supplied widget boundary;allbuttonlabels,empty/existing/selectedexpressions,serialmemoryandcalculation. HostTk layout/clipboardintegrationnotclaimedbythischeck.');(w/'calculator1015_gui_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(expected),'originalcontrollerstates;',len(names),'emptyaxioms')
