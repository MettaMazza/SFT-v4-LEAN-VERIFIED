from pathlib import Path
import sys,json,subprocess,os,re,hashlib,io
from unittest.mock import patch
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');source=Path('/Volumes/One Touch/ernos-labs-sft-platform');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser import app as a
from sft.mathematics.calculator_complete.explorer import RegisteredMathematicsExplorer
cases=[('GET','/',{},'token','default'),('GET','/health',{},'token','default'),('GET','/absent',{},'token','default')]
for expression in ['1+1','1-4','sqrt(2)','complex(1,2)','1/0']:cases.append(('POST','/api/action',{'action':'evaluate','expression':expression},'token','default'))
cases += [('POST','/api/action',{'action':'state'},token,sid)for token,sid in [('bad','default'),('token',''),('token','missing')]]
cases += [('POST','/api/law',p,'token','default')for p in [{},{'claim_id':1},{'claim_id':'missing'},{'claim_id':'SFT-MATH-EXACT-ARITHMETIC-001'},{'claim_id':'SFT-MATH-SCIENTIFIC-CALCULATOR-006'},{'claim_id':'SFT-MATH-EXACT-ARITHMETIC-001','replay':True}]]
cases += [('POST',path,{},'token','default')for path in ['/api/close','/unknown']]
expected=[]
for method,path,payload,token,sid in cases:
 with patch.object(a.secrets,'token_urlsafe',side_effect=['token','default','page']):
  app=a.CalculatorWebApplication(places=3);app.explorer=RegisteredMathematicsExplorer(source);H=app.handler_type();h=object.__new__(H);h.path=path;h.wfile=io.BytesIO();headers=[];code=[];closed=[];h.send_response=lambda x:code.append(x);h.send_header=lambda k,v:headers.append([k,v]);h.end_headers=lambda:None;h.headers={'X-SFT-Token':token,'X-SFT-Session':sid};h._read_json=lambda:payload;app.request_shutdown=lambda:closed.append(True)
  if method=='GET':h.do_GET()
  else:h.do_POST()
  expected.append(dict(status=code[0],headers=headers,body=h.wfile.getvalue().decode(),shutdown=bool(closed)))
def enc(v):
 if isinstance(v,str):return '(.text '+json.dumps(v,ensure_ascii=False)+')'
 if isinstance(v,bool):return '(.boolean '+str(v).lower()+')'
 if v is None:return '.null'
 if isinstance(v,int):return '(.integer ('+str(v)+'))'
 if isinstance(v,list):return '(.array ['+','.join(enc(x)for x in v)+'])'
 return '(.object ['+','.join('('+json.dumps(k)+','+enc(x)+')'for k,x in v.items())+'])'
prior=(w/'calculator1025_routes_check.lean').read_text();rows='\n'.join(l for l in prior.splitlines()if l.startswith('def rows ')or l.startswith('def regs '))
head='''import SFT.Mathematics.CalculatorBrowserHTTP
import SFT.Mathematics.CalculatorCompleteCatalog
open SFT.Mathematics SFT.Host CalculatorBrowserHTTP
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''+rows+'''
def reply (r : Except String Reply) : Canonical.Value := match r with
 | .error e => .object [("error",.text e)]
 | .ok r => .object [("status",.integer (.ofNat r.status)),("headers",.array (r.headers.map fun (k,v) => .array [.text k,.text v])),("body",.text r.body),("shutdown",.boolean r.shutdown)]
def initial := CalculatorBrowserSessions.create "default" "token" 3
'''
for method,path,payload,token,sid in cases:
 if method=='GET':expr='(get initial '+json.dumps(path)+' "page").2'
 else:expr='(post initial (CalculatorCompleteCatalog.explorer rows regs) '+json.dumps(path)+' '+json.dumps(token)+' '+json.dumps(sid)+' (.ok '+enc(payload)[9:-1]+')).2' # strip (.object ...)
 head+='#eval IO.println (Canonical.render (reply '+expr+'))\n'
# Exercise source _read_json boundary independently; JSON decoding remains the original host-library input.
reads=[('',b'{}'),('-1',b'{}'),('0',b'{}'),('65537',b'{}'),('2',b'{}'),('2',b'[]'),('4',b'null'),('1',b'1'),('4',b'true'),('5',b'"abc"'),('2',b'{!'),('1',b'\xff'),('²',b'{}'),('٢',b'{}'),(' 2',b'{}')]
for raw,body in reads:
 app=a.CalculatorWebApplication();H=app.handler_type();h=object.__new__(H);h.headers={'Content-Length':raw};h.rfile=io.BytesIO(body)
 try:result=h._read_json();expected.append({'ok':result})
 except (ValueError,UnicodeDecodeError)as e:expected.append({'error':str(e)})
 try:n=int(raw);length='.ok ('+str(n)+')'
 except ValueError as e:length='.error '+json.dumps(str(e))
 try:val=json.loads(body[:int(raw)].decode());decoded='.ok '+enc(val)
 except (ValueError,UnicodeDecodeError)as e:decoded='.error '+json.dumps(str(e))
 head+='#eval IO.println (Canonical.render (match readJSON '+str(raw.isdigit()).lower()+' ('+length+') ('+decoded+') with | .ok v => .object [("ok",.object v)] | .error e => .object [("error",.text e)]))\n'
p=w/'calculator1027_http_check.lean';p.write_text(head);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/'calculator1027_http_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(s)for s in x.stdout.splitlines()];assert actual==expected,[(i,ac,ex)for i,(ac,ex)in enumerate(zip(actual,expected))if ac!=ex][:1]
p=r/'SFT/Mathematics/CalculatorBrowserHTTP.lean';s=p.read_text();names=re.findall(r'^ ?def (\w+)',s,re.M);q=w/'calculator1027_http_audit.lean';q.write_text('import SFT.Mathematics.CalculatorBrowserHTTP\n'+''.join('#print axioms SFT.Mathematics.CalculatorBrowserHTTP.'+n+'\n'for n in names));x=subprocess.run([lean,str(q)],env=env,capture_output=True,text=True);(w/'calculator1027_http_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1027_http_report.json').write_text(json.dumps(dict(status='PASS',full_http_responses=len(cases),request_boundary_cases=len(reads),declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),host_boundary='Python standard-library isdigit/int/UTF-8/JSON results supplied explicitly; native source guards, ordering, routes, JSON output, headers and state tested.'),indent=2));print('PASS',len(expected),'complete HTTP/request comparisons;',len(names),'zeroaxiom definitions')
