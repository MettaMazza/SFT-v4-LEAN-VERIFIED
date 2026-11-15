from pathlib import Path
import sys,json,subprocess,os,re,hashlib,concurrent.futures
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator import values as v
from sft.mathematics.calculator_browser.app import CalculatorWebApplication
from sft.mathematics.calculator_complete.controller import MAIN_BUTTON_ROWS,FUNCTION_CATALOG
old=(w/'check_calculator1023_session.py').read_text();exec(old[old.index('def canon'):old.index('actions=')])
sequences=[[
 {'action':'evaluate','expression':'2+3'}, {'action':'press','label':'MS'},
 {'action':'evaluate','expression':'1-4'}, {'action':'state'},
 {'action':'evaluate','expression':'1/0'}, {'action':'press','label':'C'},
 {'action':'evaluate','expression':'2'}, {'action':'press','label':'M−'},
 {'action':'press','label':'MC'},{'action':'history','index':False},
 {'action':'history','index':True},{'action':'history','index':-1},
 {'action':'mode','mode':'DEG'}, {'action':'mode','mode':'bad','expression':'9'},
 {'action':'function','name':'sum'},{'action':'clear_history'}]]
sequences += [[{'action':'evaluate','expression':e},{'action':'state'}]for e in ['1-1','sqrt(2)','sqrt(-4)','complex(1,2)','complex(-1,2)','complex(1,-2)','sqrt(-2)','floor(-1/3)','cos(3)']]
sequences += [[{'action':'evaluate','expression':'2'},{'action':'press','label':b}]for row in MAIN_BUTTON_ROWS for b in row]
sequences += [[{'action':'function','name':name}]for name,_,_ in FUNCTION_CATALOG]
for action,key in [('press','label'),('mode','mode'),('function','name'),('history','index')]:
 for bad in [None,{},[],1.5,True,1,'missing']:
  sequences.append([{'action':action,key:bad,'expression':'7'}])
sequences += [[p]for p in [{},{'action':'unknown','expression':'8'},{'action':None},{'expression':False},{'expression':17},{'action':'state','expression':'4'}]]
def f(v):
 if isinstance(v,str):return '.text '+json.dumps(v,ensure_ascii=False)
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer ('+str(v)+')'
 return '.other'
def enc(p):return '{'+','.join(k+' := '+('some ('+f(v)+')'if k=='expression'else f(v))for k,v in p.items())+'}'
header=old[old.index("header='''")+10:old.index('def action')].replace('import SFT.Mathematics.CalculatorCompleteSession','import SFT.Mathematics.CalculatorBrowserTransaction')
header+='''
open SFT.Host CalculatorBrowserTransaction
def run (ps : List Payload) : Except String (List Canonical.Value) := do
 let (_,rows) ← ps.foldlM (fun (s,rows) p => do
  let (next,outcome) := applyController s p
  let reply ← response next outcome
  pure (next,rows ++ [.object [("response",reply),("session",snapshot next.session),("just_evaluated",.boolean next.justEvaluated)]])) (CalculatorCompleteController.create 3 10000,[])
 pure rows
'''
expected=[]
for seq in sequences:
 app=CalculatorWebApplication(places=3)
 for p in seq:
  reply=app.apply(p);expected.append(dict(response=reply,session=snapshot(app.controller.session),just_evaluated=app.controller.just_evaluated))
expected=json.loads(json.dumps(expected))
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'calculator1026_transaction_check{i}.lean';p.write_text(header+'#eval show IO Unit from do\n for result in (['+','.join('run ['+','.join(enc(p)for p in seq)+']'for seq in sequences[i:i+8])+'] : List (Except String (List Canonical.Value))) do\n  match result with\n  | .error e => IO.println e\n  | .ok rows => for row in rows do IO.println (Canonical.render row)\n');x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1026_transaction_check{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];return [json.loads(s)for s in x.stdout.splitlines()]
with concurrent.futures.ThreadPoolExecutor(max_workers=16)as pool:actual=[v for rows in pool.map(batch,range(0,len(sequences),8))for v in rows]
assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e][:1]
p=r/'SFT/Mathematics/CalculatorBrowserTransaction.lean';s=p.read_text();names=re.findall(r'^def (\w+)',s,re.M);a=w/'calculator1026_transaction_audit.lean';a.write_text('import SFT.Mathematics.CalculatorBrowserTransaction\n'+''.join('#print axioms SFT.Mathematics.CalculatorBrowserTransaction.'+n+'\n'for n in names));x=subprocess.run([lean,str(a)],env=env,capture_output=True,text=True);(w/'calculator1026_transaction_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1026_transaction_report.json').write_text(json.dumps(dict(status='PASS',states=len(actual),sequences=len(sequences),declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2));print('PASS',len(actual),'full responses/session states;',len(names),'zeroaxiom definitions')
