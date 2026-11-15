from pathlib import Path
import sys,json,subprocess,os,re,hashlib,concurrent.futures
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete import controller as c
from sft.mathematics.calculator import values as v
from dataclasses import asdict
old=Path('work/check_calculator1023_session.py').read_text();exec(old[old.index('def canon'):old.index('actions=')])
sequences=[ [('expression','2+3'),('press','='),('press','MS'),('press','C'),('press','MR'),('press','+'),('press','2'),('press','='),('press','CE'),('press','±'),('press','±'),('press','='),('restore',0),('press','⌫'),('insert','9',0),('mode','DEG'),('expression','30'),('press','sin'),('press','M+'),('press','M−'),('press','MC'),('history',)], [('expression','1/0'),('press','='),('press','±'),('press','nCr'),('press','CE'),('press','+'),('press','2'),('press','='),('mode','invalid'),('insert','x',-1),('insert','x',100),('restore',-1),('restore',100)] ]
sequences += [[('expression','1/2'),('press',button)] for row in c.MAIN_BUTTON_ROWS for button in row]
sequences += [[('catalog',name),('press','CE')] for name,_,_ in c.FUNCTION_CATALOG]
sequences += [[('press',x),('catalog',x)] for x in ['unknown',"a'b",'a"b',"a'\"b",'\x00\x1f\x85\xa0\u200b','😀\U000e0001','\n\r\t\\']]
sequences += [[('expression','7'),('press','='),('press',label)] for label in ['3','π','(','.','Ans','xʸ','n!','root']]
expected=[]
def snap(x):return dict(view=asdict(x.view()),session=snapshot(x.session),just_evaluated=x.just_evaluated)
for seq in sequences:
 x=c.CalculatorController(places=3,operation_limit=10);rows=[dict(error='',state=snap(x))]
 for action,*args in seq:
  error=''
  try:
   if action=='expression':x.set_expression(*args)
   elif action=='press':x.press(*args)
   elif action=='insert':x.insert(*args)
   elif action=='mode':x.set_angle_mode(*args)
   elif action=='restore':x.restore_history(*args)
   elif action=='catalog':x.insert_catalog(*args)
   else:x.clear_history()
  except (v.CalculatorHalt,ValueError) as e:error=str(e)
  rows.append(dict(error=error,state=snap(x)))
 expected+=rows
# JSON turns source tuples into arrays, preserving field ordering only where source uses sequences.
expected=json.loads(json.dumps(expected))
head=old[old.index("header='''")+10:old.index('def action')].replace('import SFT.Mathematics.CalculatorCompleteSession','import SFT.Mathematics.CalculatorCompleteController').replace(' CalculatorCompleteSession\n',' CalculatorCompleteController\n').replace('def snapshot (s : Session)','def sessionSnapshot (s : CalculatorCompleteSession.Session)')
head+='''def snapshot (s : State) : Except String SFT.Host.Canonical.Value := do
 let v ← view s
 pure (.object [("view",.object [("expression",.text v.expression),("result",.text v.result),("exact_details",.text v.exactDetails),("error",.text v.error),("memory_active",.boolean v.memoryActive),("angle_mode",.text v.angleMode),("history",.array (v.history.map SFT.Host.Canonical.Value.text))]),("session",sessionSnapshot s.session),("just_evaluated",.boolean s.justEvaluated)])
def action (s : State) (name text : String) (index : Int) : Except String State := do
 if name == "expression" then pure (setExpression s text)
 else if name == "press" then press s text
 else if name == "insert" then insert s text (some index)
 else if name == "mode" then setAngleMode s text
 else if name == "restore" then restoreHistory s index
 else if name == "catalog" then insertCatalog s text
 else pure (clearHistory s)
def run (actions : List (String × String × Int)) : Except String (List SFT.Host.Canonical.Value) := do
 let init := create 3 10
 let initial ← snapshot init
 let (_,rows) ← actions.foldlM (fun (s,rows) (name,text,index) => do
  let (next,error) := match action s name text index with | .ok next => (next,"") | .error e => (s,e)
  let result ← snapshot next
  pure (next,rows ++ [.object [("error",.text error),("state",result)]])) (init,[.object [("error",.text ""),("state",initial)]])
 pure rows
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def encoded(seq):
 return '['+','.join('('+json.dumps(a[0])+','+json.dumps(a[1] if len(a)>1 and isinstance(a[1],str) else '',ensure_ascii=False)+',('+str(a[2] if len(a)>2 else a[1] if len(a)>1 and isinstance(a[1],int) else 0)+'))' for a in seq)+']'
def batch(i):
 p=w/f'constants-recovery/CalculatorController1023_{i}.lean';p.write_text(head+'#eval show IO Unit from do\n for result in (['+','.join('run '+encoded(seq) for seq in sequences[i:i+8])+'] : List (Except String (List SFT.Host.Canonical.Value))) do\n  match result with\n  | Except.error e => IO.println e\n  | Except.ok rows => for row in rows do IO.println (render row)\n');x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,text=True,capture_output=True);(w/f'calculator1023_controller_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return [json.loads(line) for line in x.stdout.splitlines()]
with concurrent.futures.ThreadPoolExecutor(max_workers=10) as pool:actual=[x for rows in pool.map(batch,range(0,len(sequences),8)) for x in rows]
assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:1]
mods=['CalculatorCompleteController','CalculatorCompletePresentation'];names=[];hashes={}
for mod in mods:
 p=r/f'SFT/Mathematics/{mod}.lean';s=p.read_text();names+=['SFT.Mathematics.'+mod+'.'+n for n in re.findall(r'^def (\w+)',s,re.M)];hashes[mod]=hashlib.sha256(p.read_bytes()).hexdigest()
a=w/'calculator1023_controller_audit.lean';a.write_text('import SFT.Mathematics.CalculatorCompleteController\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(a)],env=env,text=True,capture_output=True);(w/'calculator1023_controller_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1023_controller_report.json').write_text(json.dumps(dict(status='PASS',states=len(expected),sequences=len(sequences),declarations=names,axioms=[],source_sha256=hashes),indent=2));print('PASS',len(expected),'complete controller/view/session states;',len(names),'zeroaxiom definitions')
