from pathlib import Path
import sys,json,subprocess,os,re,hashlib
from unittest.mock import patch
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser.page import PAGE,render_page
from sft.mathematics.calculator_browser.app import CalculatorWebApplication
cases=[('abc',{}),('__SFT_INITIAL_JSON__',{'x':'second substitution'}),('é😀\\\n"',{'z':'é😀\x7f','a':[True,False,None,17,-3]}),('token',{'__SFT_TOKEN_JSON__':'__SFT_INITIAL_JSON__'})]
with patch('sft.mathematics.calculator_browser.app.secrets.token_urlsafe',side_effect=['token','default']):app=CalculatorWebApplication(places=3)
cases.append(('token',app.initial_payload()));app.apply({'action':'evaluate','expression':'sqrt(2)'});cases.append(('token',app.initial_payload()))
def enc(v):
 if isinstance(v,str):return '(.text '+json.dumps(v,ensure_ascii=False)+')'
 if isinstance(v,bool):return '(.boolean '+str(v).lower()+')'
 if v is None:return '.null'
 if isinstance(v,int):return '(.integer ('+str(v)+'))'
 if isinstance(v,(list,tuple)):return '(.array ['+','.join(enc(x)for x in v)+'])'
 return '(.object ['+','.join('('+json.dumps(k)+','+enc(x)+')'for k,x in v.items())+'])'
s='''import SFT.Mathematics.CalculatorBrowserPage
open SFT.Mathematics.CalculatorBrowserPage SFT.Host
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
for token,initial in cases:s+='#eval IO.println (Canonical.render (.text (renderPage '+json.dumps(token,ensure_ascii=False)+' '+enc(initial)+')))\n'
p=w/'calculator1027_page_check.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/'calculator1027_page_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=[json.loads(x)for x in x.stdout.splitlines()];expected=[render_page(t,i)for t,i in cases];assert actual==expected,[(i,a[:200],e[:200])for i,(a,e)in enumerate(zip(actual,expected))if a!=e]
p=r/'SFT/Mathematics/CalculatorBrowserPage.lean';s=p.read_text();names=re.findall(r'^ ?def (\w+)',s,re.M);a=w/'calculator1027_page_audit.lean';a.write_text('import SFT.Mathematics.CalculatorBrowserPage\n'+''.join('#print axioms SFT.Mathematics.CalculatorBrowserPage.'+n+'\n'for n in names));x=subprocess.run([lean,str(a)],env=env,capture_output=True,text=True);(w/'calculator1027_page_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1027_page_report.json').write_text(json.dumps(dict(status='PASS',full_page_cases=len(cases),template_bytes=len(PAGE.encode()),declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2));print('PASS',len(cases),'complete rendered pages;',len(names),'zeroaxiom definitions')
