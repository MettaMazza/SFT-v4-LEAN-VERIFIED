from pathlib import Path
import sys,json,subprocess,os,re,hashlib,builtins
from unittest.mock import patch
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser import app as a
cases=[(private,no,fail)for private,no in [(False,False),(False,True),(True,False),(True,True)]for fail in ['none','bind','address','browser','keyboard','serve','close']]
expected=[]
for private,no,fail in cases:
 trace=[]
 class Server:
  server_address=('0.0.0.0',8877)
  def serve_forever(self,*,poll_interval):
   trace.append(['serve_forever',str(poll_interval)])
   if fail=='keyboard':raise KeyboardInterrupt()
   if fail=='serve':raise RuntimeError('serve failed')
  def server_close(self):
   trace.append(['server_close'])
   if fail=='close':raise RuntimeError('close failed')
 class Application:
  entry_path='/'
  def __init__(self,*,places,operation_limit,share):trace.append(['CalculatorWebApplication',places,operation_limit,share])
  def __setattr__(self,k,v):
   if k=='network_url':trace.append(['set network_url',v])
   object.__setattr__(self,k,v)
  def bind(self,*,start_port):
   trace.append(['bind',start_port])
   if fail=='bind':raise RuntimeError('bind failed')
   return Server()
 def address():
  trace.append(['_local_network_address'])
  if fail=='address':raise RuntimeError('address failed')
  return '192.168.1.4'
 def browser(url,*,new,autoraise):
  trace.append(['webbrowser.open',url,new,autoraise])
  if fail=='browser':raise RuntimeError('browser failed')
 def printed(value,*,flush):trace.append(['print',value,flush])
 error=''
 with patch.object(a,'CalculatorWebApplication',Application),patch.object(a,'_local_network_address',address),patch.object(a.webbrowser,'open',browser),patch.object(builtins,'print',printed):
  try:a.launch_browser_calculator(start_port=8877,places=3,operation_limit=123,open_browser=not no,share=not private)
  except RuntimeError as e:error=str(e)
 expected.append({'trace':trace,'error':error})
head='''import SFT.Mathematics.CalculatorBrowserLaunch
open SFT.Mathematics.CalculatorBrowserLaunch SFT.Host
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def value (r : List Canonical.Value × Except String Unit) : Canonical.Value := .object [("trace",.array r.1),("error",.text (match r.2 with | .ok _ => "" | .error e => e))]
'''
for private,no,fail in cases:
 args='{privateMode := '+str(private).lower()+',noBrowser := '+str(no).lower()+',port := 8877,places := 3,limit := 123}'
 host='{bind := '+('.error "bind failed"'if fail=='bind'else '.ok 8877')+',address := '+('.error "address failed"'if fail=='address'else '.ok "192.168.1.4"')+',browser := '+('.error "browser failed"'if fail=='browser'else '.ok ()')+',serve := '+('.keyboardInterrupt'if fail=='keyboard'else '.failed "serve failed"'if fail=='serve'else '.returned')+',close := '+('.error "close failed"'if fail=='close'else '.ok ()')+'}'
 head+='#eval IO.println (Canonical.render (value (launch '+args+' '+host+')))\n'
# Exercise the original parser and inspect the exact call to the launcher.
p=w/'v3-runtime500/sft/mathematics/calculator_browser/__main__.py';b=(w/'calculator1026_original___main__.py').read_bytes()
if p.exists():assert p.read_bytes()==b
else:p.write_bytes(b)
from sft.mathematics.calculator_browser import __main__ as cli
for private,no in [(False,False),(False,True),(True,False),(True,True)]:
 argv=['calculator','--port','8877','--places','3','--limit','123']+(['--private']if private else [])+(['--no-browser']if no else [])
 with patch.object(sys,'argv',argv),patch.object(cli,'launch_browser_calculator')as run:assert cli.main()==0
 expected.append(run.call_args.kwargs);head+='#eval IO.println (Canonical.render (mainArguments {privateMode := '+str(private).lower()+',noBrowser := '+str(no).lower()+',port := 8877,places := 3,limit := 123}))\n'
for present in [False,True]:
 app=a.CalculatorWebApplication();app.server=object()if present else None;trace=[]
 class T:
  def __init__(self,*,target,name,daemon):trace.append(['Thread','server.shutdown',name,daemon])
  def start(self):trace.append(['start'])
 if present:app.server=type('Server',(),{'shutdown':lambda self:None})()
 with patch.object(a,'Thread',T):app.request_shutdown()
 expected.append(trace);head+='#eval IO.println (Canonical.render (.array (requestShutdown '+str(present).lower()+')))\n'
p=w/'calculator1027_launch_check.lean';p.write_text(head);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/'calculator1027_launch_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=[json.loads(s)for s in x.stdout.splitlines()];assert actual==expected,[(i,ac,ex)for i,(ac,ex)in enumerate(zip(actual,expected))if ac!=ex][:1]
p=r/'SFT/Mathematics/CalculatorBrowserLaunch.lean';s=p.read_text();names=re.findall(r'^def (\w+)',s,re.M);q=w/'calculator1027_launch_audit.lean';q.write_text('import SFT.Mathematics.CalculatorBrowserLaunch\n'+''.join('#print axioms SFT.Mathematics.CalculatorBrowserLaunch.'+n+'\n'for n in names));x=subprocess.run([lean,str(q)],env=env,capture_output=True,text=True);(w/'calculator1027_launch_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1027_launch_report.json').write_text(json.dumps(dict(status='PASS',launch_traces=len(cases),main_routes=4,shutdown_traces=2,declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'complete launch/main/shutdown traces;',len(names),'emptyaxiom definitions')
