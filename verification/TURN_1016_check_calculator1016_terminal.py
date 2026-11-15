from pathlib import Path
import sys,json,subprocess,os,re,hashlib,io,contextlib,builtins
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.mathematics.calculator import __main__ as cli
cases=[(None,[],False,3,'rad'),(None,[':help',':rad',':deg',':grad','1+1=',':ms',':mr',':m+',':m-',':history',':mc',':clear',':history',' ','quit'],False,3,'rad'),(None,['sqrt(2)',':ms',':mr','1/0','ans^2',':history','exit'],True,3,'rad'),(None,['complex(1,2)',':ms',':mr','0',':ms',':mr','EXIT'],False,3,'rad'),(None,['sin(30)',':ms',':mr','atan(1)',':history'],False,3,'deg'),(None,['1','1/0','2'],True,0,'rad')]
cases += [(expr,[],trace,places,mode) for expr in ['1+1=','sqrt(2)','1/0','cos(60)','log(8,2)',''] for trace in [False,True] for places,mode in [(3,'rad'),(5,'deg')]]
expected=[]
for expression,lines,trace,places,mode in cases:
 argv=['calculator','--places',str(places),'--angle',mode]+(['--trace'] if trace else [])+([expression] if expression is not None else [])
 stdout=io.StringIO();stderr=io.StringIO();iterator=iter(lines)
 def get_input(prompt):
  try:return next(iterator)
  except StopIteration:raise EOFError()
 oldargv=sys.argv;oldinput=builtins.input
 try:
  sys.argv=argv;builtins.input=get_input
  with contextlib.redirect_stdout(stdout),contextlib.redirect_stderr(stderr):code=cli.main()
 finally:sys.argv=oldargv;builtins.input=oldinput
 expected.append(dict(stdout=stdout.getvalue(),stderr=stderr.getvalue(),exit=code))
header='''import SFT.Mathematics.CalculatorTerminal
open SFT.Mathematics SFT.Host CalculatorTerminal
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def linesText (lines : List String) : String := if lines.isEmpty then "" else Text.append (Text.intercalate "\\n" lines) "\\n"
def run (expression : Option String) (inputs : List String) (trace : Bool) (places : Int) (mode : String) : Canonical.Value := Id.run do
 let mut state : CalculatorSession.Session := {places := places,angleMode := mode}
 let mut stdout := []
 let mut stderr := []
 let mut code := 0
 match expression with
 | some expr =>
  let result := oneExpression state expr trace
  stdout := result.stdout
  stderr := result.stderr
  code := result.exitCode.getD 0
 | none =>
  stdout := [introduction]
  for input in inputs do
   let result := step state (some input) trace
   state := result.session
   stdout := stdout ++ result.stdout
   stderr := stderr ++ result.stderr
   match result.exitCode with
   | none => pure ()
   | some c =>
    code := c
    break
 return .object [("stdout",.text (linesText stdout)),("stderr",.text (linesText stderr)),("exit",.integer (Int.ofNat code))]
'''
header+='#eval do\n for x in ['+',\n'.join('run ('+('none' if e is None else 'some '+json.dumps(e))+') '+json.dumps(lines)+' '+str(trace).lower()+' ('+str(p)+') '+json.dumps(mode) for e,lines,trace,p,mode in cases)+'] do IO.println (Canonical.render x)\n'
header += '#eval IO.println (Canonical.render argumentSchema)\n'
import ast
syntax=ast.parse((w/'v3-runtime500/sft/mathematics/calculator/__main__.py').read_text());main=next(n for n in syntax.body if isinstance(n,ast.FunctionDef) and n.name=='main');constructor=main.body[0].value;schema={k.arg:ast.literal_eval(k.value) for k in constructor.keywords};schema['arguments']=[]
for n in main.body:
 if isinstance(n,ast.Expr) and isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Attribute) and n.value.func.attr=='add_argument':
  d={'name':ast.literal_eval(n.value.args[0])}
  for k in n.value.keywords:
   d[k.arg]=k.value.id if isinstance(k.value,ast.Name) else ast.literal_eval(k.value)
   if isinstance(d[k.arg],tuple):d[k.arg]=list(d[k.arg])
  schema['arguments'].append(d)
p=w/'constants-recovery/CalculatorTerminal1016.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1016_terminal_output.log').write_text(x.stdout+x.stderr);assert x.returncode==0,(x.returncode,x.stdout[-1000:]);actual=[json.loads(line) for line in x.stdout.splitlines()];assert actual[-1]==schema;actual=actual[:-1];assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
s=(r/'SFT/Mathematics/CalculatorTerminal.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1016_terminal_audit.lean';p.write_text('import SFT.Mathematics.CalculatorTerminal\n'+''.join('#print axioms SFT.Mathematics.CalculatorTerminal.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1016_terminal_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
report=dict(status='PASS',cases=len(expected),argument_schema=True,declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='OriginalCLI main complete stdout/stderr and exitcodes for direct/interactiveexpression,allmemory/history/mode/help/quitbranches,EOF,traceanddomainerrors;parsedargumentboundary.');(w/'calculator1016_terminal_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(expected),'fulloriginalCLI runs;',len(names),'emptyaxioms')
