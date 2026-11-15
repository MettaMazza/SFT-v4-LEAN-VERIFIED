from pathlib import Path
import sys,json,subprocess,os,re,hashlib,types
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.mathematics.calculator import gui
class TclError(Exception):pass
class Host:
 def __init__(self,themes,fail):self.themes=themes;self.fail=fail;self.next=0;self.calls=[]
 def val(self,x):
  if isinstance(x,Widget):return {'ref':x.name}
  if isinstance(x,float):return {'float':str(x)}
  if isinstance(x,(list,tuple)):return [self.val(v) for v in x]
  if callable(x):
   if x.__name__!='<lambda>':return {'callback':x.__name__}
   if x.__defaults__:return {'callback':'press','label':x.__defaults__[0]}
   return {'callback':x.__code__.co_names[-1]}
  return x
 def record(self,name,method,args,kwargs):self.calls.append(dict(target=name,method=method,args=[self.val(x) for x in args],kwargs={k:self.val(v) for k,v in kwargs.items()}))
 def factory(self,kind):
  def make(*args,**kwargs):
   name='w'+str(self.next);self.next+=1;self.record(name,'new:'+kind,args,kwargs);return Widget(self,name)
  return make
class Widget:
 def __init__(self,host,name):self.host=host;self.name=name
 def __getattr__(self,method):
  if method=='tk':return Widget(self.host,'root.tk')
  def call(*args,**kwargs):
   self.host.record(self.name,method,args,kwargs)
   if method=='theme_names':return self.host.themes
   if self.name=='root.tk' and self.host.fail:raise TclError()
  return call
cases=[(themes,fail) for themes in [[],['clam'],['aqua','clam'],['vista','aqua','clam'],['other']] for fail in [False,True]]
expected=[]
oldtk=sys.modules.get('tkinter');oldttk=sys.modules.get('tkinter.ttk')
try:
 for themes,fail in cases:
  h=Host(themes,fail);tk=types.ModuleType('tkinter');ttk=types.ModuleType('tkinter.ttk');tk.ttk=ttk;tk.TclError=TclError
  for name in ['StringVar','Listbox','Text']:setattr(tk,name,h.factory('tk.'+name))
  for name in ['Style','Frame','Label','Combobox','Entry','Button','Notebook']:setattr(ttk,name,h.factory('ttk.'+name))
  sys.modules['tkinter']=tk;sys.modules['tkinter.ttk']=ttk
  app=gui.SFTCalculatorApp(Widget(h,'root'),places=3);expected.append(h.calls)
finally:
 for name,value in [('tkinter',oldtk),('tkinter.ttk',oldttk)]:
  if value is None:sys.modules.pop(name,None)
  else:sys.modules[name]=value
launch_expected=[]
import builtins
original_import=builtins.__import__
for present in [False,True]:
 h=Host(['clam'],False);tk=types.ModuleType('tkinter');ttk=types.ModuleType('tkinter.ttk');tk.ttk=ttk;tk.TclError=TclError
 for name in ['StringVar','Listbox','Text']:setattr(tk,name,h.factory('tk.'+name))
 for name in ['Style','Frame','Label','Combobox','Entry','Button','Notebook']:setattr(ttk,name,h.factory('ttk.'+name))
 def new_root():
  h.record('root','new:tk.Tk',[],{});return Widget(h,'root')
 tk.Tk=new_root;sys.modules['tkinter']=tk;sys.modules['tkinter.ttk']=ttk
 def importer(name,*args,**kwargs):
  if name=='tkinter' and not present:raise ImportError('unavailable')
  return original_import(name,*args,**kwargs)
 try:
  builtins.__import__=importer
  try:gui.launch_gui(places=3);launch_expected.append({'ok':h.calls})
  except gui.CalculatorHalt as error:launch_expected.append({'error':str(error)})
 finally:
  builtins.__import__=original_import
  for name,value in [('tkinter',oldtk),('tkinter.ttk',oldttk)]:
   if value is None:sys.modules.pop(name,None)
   else:sys.modules[name]=value
header='''import SFT.Mathematics.CalculatorLayout
open SFT.Mathematics SFT.Host CalculatorLayout
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval do
'''+''.join(' IO.println (Canonical.render (.array (constructorCalls '+json.dumps(themes)+')))\n' for themes,fail in cases)
header += '\ndef launchResult : Except String (List Canonical.Value) → Canonical.Value | .ok xs => .object [("ok",.array xs)] | .error e => .object [("error",.text e)]\n#eval IO.println (Canonical.render (launchResult (launchCalls false ["clam"])))\n#eval IO.println (Canonical.render (launchResult (launchCalls true ["clam"])))\n'
p=w/'constants-recovery/CalculatorLayout1016.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1016_layout_output.log').write_text(x.stdout+x.stderr);assert x.returncode==0,(x.returncode,x.stdout[-1000:]);actual=[json.loads(line) for line in x.stdout.splitlines()];assert actual[-2:]==launch_expected; actual=actual[:-2];assert actual==expected,[(i,j,a,e) for i,(aa,ee) in enumerate(zip(actual,expected)) for j,(a,e) in enumerate(zip(aa,ee)) if a!=e][:3]
s=(r/'SFT/Mathematics/CalculatorLayout.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1016_layout_audit.lean';p.write_text('import SFT.Mathematics.CalculatorLayout\n'+''.join('#print axioms SFT.Mathematics.CalculatorLayout.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1016_layout_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
report=dict(status='PASS',cases=len(expected)+2,calls=sum(len(x) for x in expected),declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Both originallaunchpathsand every original constructor hostcall,args,kwargs,callbackandlayoutorder;allthemeprioritybranchesandcaughtTk scalingfailure;hostcallsobservedbyrecordingadapter.');(w/'calculator1016_layout_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(expected),'fullconstructortraces;',report['calls'],'calls;',len(names),'emptyaxioms')
