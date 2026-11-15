from pathlib import Path
import sys,json,subprocess,os,re,hashlib
from unittest.mock import patch
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser.app import CalculatorWebApplication
ops=[('initial',None),('apply',None,{'action':'evaluate','expression':'2+2'}),('new','second'),('apply','second',{'action':'evaluate','expression':'8'}),('initial',None),('initial','second'),('apply','missing',{'action':'evaluate','expression':'9'}),('apply','',{'action':'state'}),('new',''),('apply','',{'action':'evaluate','expression':'3'}),('apply','',{'action':'bad','expression':'7'}),('new','default'),('initial',None),('apply',None,{'action':'evaluate','expression':'5'}),('apply','missing',{'action':'state'}),('new','second'),('initial','second'),('apply','second',{'action':'evaluate','expression':'1-4'}),('initial',None)]
with patch('sft.mathematics.calculator_browser.app.secrets.token_urlsafe',side_effect=['token','default']):app=CalculatorWebApplication(places=3)
expected=[]
for op in ops:
 if op[0]=='initial':expected.append(app.initial_payload(op[1]))
 elif op[0]=='new':
  with patch('sft.mathematics.calculator_browser.app.secrets.token_urlsafe',return_value=op[1]):expected.append(app.new_page_payload())
 else:expected.append(app.apply(op[2],op[1]))
def field(v):return '.text '+json.dumps(v)
def payload(p):return '{'+','.join(k+' := '+('some ('+field(v)+')'if k=='expression'else field(v))for k,v in p.items())+'}'
def opt(v):return 'none'if v is None else '(some '+json.dumps(v)+')'
s='''import SFT.Mathematics.CalculatorBrowserSessions
open SFT.Mathematics SFT.Host CalculatorBrowserSessions
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def run : Except String (List Canonical.Value) := do
 let a := create "default" "token" 3
 let rows := []
'''
for op in ops:
 if op[0]=='initial':s+=' let v ← initialPayload a '+opt(op[1])+'\n'
 elif op[0]=='new':s+=' let (a,r) := newPagePayload a '+json.dumps(op[1])+'\n let v ← r\n'
 else:s+=' let (a,r) := apply a '+payload(op[2])+' '+opt(op[1])+'\n let v ← r\n'
 s+=' let rows := rows ++ [v]\n'
s+=' pure rows\n#eval match run with | .error e => IO.println e | .ok rows => IO.println (Canonical.render (.array rows))\n'
p=w/'calculator1026_sessions_check.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/'calculator1026_sessions_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);expected=json.loads(json.dumps(expected));assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e][:1]
p=r/'SFT/Mathematics/CalculatorBrowserSessions.lean';s=p.read_text();names=re.findall(r'^def (\w+)',s,re.M);a=w/'calculator1026_sessions_audit.lean';a.write_text('import SFT.Mathematics.CalculatorBrowserSessions\n'+''.join('#print axioms SFT.Mathematics.CalculatorBrowserSessions.'+n+'\n'for n in names));x=subprocess.run([lean,str(a)],env=env,capture_output=True,text=True);(w/'calculator1026_sessions_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1026_sessions_report.json').write_text(json.dumps(dict(status='PASS',complete_responses=len(actual),declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2));print('PASS',len(actual),'full page/session responses;',len(names),'zeroaxiom definitions')
