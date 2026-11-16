from pathlib import Path
import sys,json,subprocess,os,re,hashlib,io,contextlib
from unittest.mock import patch,MagicMock
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser import app as a
from sft.mathematics.calculator.values import CalculatorHalt
cases=[(share,host,port,attempts,success)for share,host in [(True,None),(False,None),(True,'0.0.0.0'),(False,'127.0.0.1'),(True,'127.0.0.1'),(False,'0.0.0.0')]for port,attempts,success in [(8765,24,8765),(8765,24,8767),(1023,24,1023),(65512,24,65512),(65511,30,65537),(8765,0,8765),(8765,-2,8765),(8765,2,9999)]]
expected=[]
for share,host,port,attempts,success in cases:
 app=a.CalculatorWebApplication(share=share);trace=[]
 def server(address,handler):
  trace.append(list(address))
  if address[1]!=success:raise OSError('occupied')
  s=MagicMock();s.server_address=address;return s
 with patch.object(a,'ThreadingHTTPServer',side_effect=server):
  try:out={'port':app.bind(host=host,start_port=port,attempts=attempts).server_address[1]};assert app.server.daemon_threads is True
  except CalculatorHalt as e:out={'error':str(e)}
 expected.append({'trace':trace,'result':out})
head='''import SFT.Mathematics.CalculatorBrowserTransport
open SFT.Mathematics.CalculatorBrowserTransport SFT.Host
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def resultValue (r : List (String × Int) × Except String Int) : Canonical.Value := .object [("trace",.array (r.1.map fun (h,p) => .array [.text h,.integer p])),("result",match r.2 with | .ok p => .object [("port",.integer p)] | .error e => .object [("error",.text e)])]
'''
for share,host,port,attempts,success in cases:head+='#eval IO.println (Canonical.render (resultValue (bind '+str(share).lower()+' '+('none'if host is None else '(some '+json.dumps(host)+')')+' ('+str(port)+') ('+str(attempts)+') (fun p => decide (p = '+str(success)+')))))\n'
app=a.CalculatorWebApplication();H=app.handler_type();handler=object.__new__(H);calls=[];handler.send_response=lambda status:calls.append(['status',status]);handler.send_header=lambda k,v:calls.append([k,v]);handler.end_headers=lambda:calls.append(['end']);H._headers(handler,201,'text/html; charset=utf-8',17100);expected.append(calls[1:-1]);head+='#eval IO.println (Canonical.render (.array ((headers "text/html; charset=utf-8" 17100).map fun (k,v) => .array [.text k,.text v])))\n'
for address in ['127.0.0.1','127.1.2.3','192.168.1.4','10.0.0.2','127','']:
 sock=MagicMock();sock.getsockname.return_value=(address,0)
 with patch.object(a.socket,'socket',return_value=sock):
  try:out={'address':a._local_network_address()}
  except CalculatorHalt as e:out={'error':str(e)}
  sock.close.assert_called_once()
 expected.append(out);head+='#eval IO.println (Canonical.render (match localAddress '+json.dumps(address)+' with | .ok v => .object [("address",.text v)] | .error e => .object [("error",.text e)]))\n'
for share in [False,True]:
 for open_browser in [False,True]:
  server=MagicMock();server.server_address=('0.0.0.0',8877);app=MagicMock();app.bind.return_value=server;app.entry_path='/';out=io.StringIO()
  with patch.object(a,'CalculatorWebApplication',return_value=app),patch.object(a,'_local_network_address',return_value='192.168.1.4'),patch.object(a.webbrowser,'open')as opened,contextlib.redirect_stdout(out):a.launch_browser_calculator(start_port=8877,share=share,open_browser=open_browser)
  server.serve_forever.assert_called_once_with(poll_interval=0.2);server.server_close.assert_called_once()
  if open_browser:opened.assert_called_once_with('http://127.0.0.1:8877/',new=1,autoraise=True)
  else:opened.assert_not_called()
  expected.append(out.getvalue().splitlines());head+='#eval IO.println (Canonical.render (.array ((launchMessages 8877 '+('(some "192.168.1.4")'if share else 'none')+').map Canonical.Value.text)))\n'
p=w/'calculator1027_transport_check.lean';p.write_text(head);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/'calculator1027_transport_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(s)for s in x.stdout.splitlines()];assert actual==expected,[(i,ac,ex)for i,(ac,ex)in enumerate(zip(actual,expected))if ac!=ex][:1]
p=r/'SFT/Mathematics/CalculatorBrowserTransport.lean';s=p.read_text();names=re.findall(r'^def (\w+)',s,re.M);q=w/'calculator1027_transport_audit.lean';q.write_text('import SFT.Mathematics.CalculatorBrowserTransport\n'+''.join('#print axioms SFT.Mathematics.CalculatorBrowserTransport.'+n+'\n'for n in names));x=subprocess.run([lean,str(q)],env=env,capture_output=True,text=True);(w/'calculator1027_transport_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1027_transport_report.json').write_text(json.dumps(dict(status='PASS',binding_cases=len(cases),headers=1,address_cases=6,launch_message_cases=4,declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),scope='Header values, binding guards and ordered attempts, resolved address rejection, launch messages; original launch host calls inspected separately, full native HTTP/launch adapter remains to assemble.'),indent=2));print('PASS',len(expected),'source comparisons;',len(names),'zeroaxiom definitions')
