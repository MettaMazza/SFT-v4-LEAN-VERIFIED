from pathlib import Path
import sys,os,json,re,subprocess,io,contextlib,builtins,ast
from unittest.mock import patch
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete import __main__ as cli
cases=[(None,[],False,3,'rad'),(None,[':help',':rad',':deg',':grad','1+1=',':ms',':mr',':m+',':m-',':history',':mc',':clear',':history',' ',':quit'],False,3,'rad'),(None,['sqrt(2)',':ms',':mr','1/0','ans^2',':history','exit'],True,3,'rad'),(None,['complex(1,2)',':ms',':mr','0',':ms',':mr','EXIT'],False,3,'rad'),(None,['sin(30)',':ms',':mr',':clear',':mr',':history'],False,3,'deg'),(None,['1','1/0','2'],True,0,'rad')]
cases += [(e,[],proof,p,m)for e in ['1+1=','sqrt(2)','1/0','cos(60)','log(8,2)','']for proof in [False,True]for p,m in [(3,'rad'),(5,'deg')]]
expected=[]
for e,lines,proof,p,m in cases:
 argv=['sft-calculator','--places',str(p),'--angle',m]+(['--proof']if proof else [])+([e]if e is not None else ['--terminal']);out=io.StringIO();err=io.StringIO()
 with patch.object(sys,'argv',argv),patch('builtins.input',side_effect=lines+[EOFError()]),contextlib.redirect_stdout(out),contextlib.redirect_stderr(err):code=cli.main()
 expected.append(dict(stdout=out.getvalue(),stderr=err.getvalue(),exit=code))
from sft.mathematics.calculator_complete import evidence as evidence_source
receipt=evidence_source._receipt(Path(evidence_source.__file__).resolve().parents[3],evidence_source.CALCULATOR_CLAIM_ID)
head='''import SFT.Mathematics.CalculatorCompleteTerminal
open SFT.Mathematics SFT.Host CalculatorCompleteTerminal
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def run (expression : Option String) (inputs : List String) (proof : Bool) (places : Int) (mode : String) : Canonical.Value := Id.run do
 let mut state : CalculatorCompleteSession.Session := {places:=places,angleMode:=mode}
 let mut stdout := ""
 let mut stderr := ""
 let mut code := 0
 match expression with
 | some expr =>
  let r := oneExpression state expr proof (some [⟨"SFT-MATH-SCIENTIFIC-CALCULATOR-006",.text "RECEIPT",false⟩])
  stdout := r.stdout
  stderr := r.stderr
  code := r.exitCode.getD 0
 | none =>
  stdout := introduction
  for input in inputs do
   let r := step state (some input) proof (some [⟨"SFT-MATH-SCIENTIFIC-CALCULATOR-006",.text "RECEIPT",false⟩])
   state := r.session
   stdout := Text.append stdout r.stdout
   stderr := Text.append stderr r.stderr
   match r.exitCode with | none => pure () | some c => code := c; break
 return .object [("stdout",.text stdout),("stderr",.text stderr),("exit",.integer (Int.ofNat code))]
'''
head=head.replace('RECEIPT',receipt)
head+='#eval do\n for x in ['+',\n'.join('run ('+('none'if e is None else 'some '+json.dumps(e))+') '+json.dumps(lines)+' '+str(proof).lower()+' ('+str(p)+') '+json.dumps(m)for e,lines,proof,p,m in cases)+'] do IO.println (Canonical.render x)\n'
p=w/'calculator1025_terminal_check.lean';p.write_text(head);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1025_terminal_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(x)for x in x.stdout.splitlines()];assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e][:2]
s=(r/'SFT/Mathematics/CalculatorCompleteTerminal.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1025_terminal_audit.lean';p.write_text('import SFT.Mathematics.CalculatorCompleteTerminal\n'+''.join('#print axioms SFT.Mathematics.CalculatorCompleteTerminal.'+n+'\n'for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1025_terminal_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1025_terminal_report.json').write_text(json.dumps(dict(status='PASS',complete_runs=len(cases),axioms=[],declarations=names),indent=2));print('PASS',len(cases),'complete original terminal executions;',len(names),'emptyaxiom definitions')
