from pathlib import Path
import sys,json,subprocess,os,re
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_shell_periodicity_successor_laws_v1 as src
values=[False,True,None,'2',-2,-1,0]+list(range(1,34))+[136,137,138,273,274,275]
def expr(x):
 if isinstance(x,bool):return 'AtomicShellPeriodicity.Input.count (.boolean '+str(x).lower()+')'
 if isinstance(x,int):return 'AtomicShellPeriodicity.Input.count (.integer ('+str(x)+'))'
 return 'AtomicShellPeriodicity.Input.nonInteger'
s='''import SFT.Physics.AtomicShellPeriodicity
open SFT.Physics SFT.Host.Canonical AtomicShellPeriodicity
set_option maxRecDepth 20000
def countResult : Except String Nat → Value
 | .error e => .object [("error",.text e)]
 | .ok n => .integer (.ofNat n)
def listResult : Except String (List Nat) → Value
 | .error e => .object [("error",.text e)]
 | .ok xs => .array (xs.map fun n => .integer (.ofNat n))
def pairResult : Except String (List (Nat × Nat)) → Value
 | .error e => .object [("error",.text e)]
 | .ok xs => .array (xs.map fun p => .array [.integer (.ofNat p.1),.integer (.ofNat p.2)])
#eval do
 let inputs : List AtomicShellPeriodicity.Input := ['''+','.join(expr(x) for x in values)+''']
 IO.println (render (.object [("capacity",.array (inputs.map fun x => countResult (shellCapacity x))),("order",.array (inputs.map fun x => pairResult (generatedSubshellOrder x))),("closures",.array (inputs.map fun x => listResult (generatedPeriodClosures x))),("widths",.array (inputs.map fun x => listResult (generatedPeriodWidths x)))]))
''';p=r/'AtomicShellCompare956.lean';p.write_text(s)
actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),text=True))
def run(fn,x):
 try:return fn(x)
 except ValueError as e:return {'error':str(e)}
expected=json.loads(json.dumps({k:[run(fn,x) for x in values] for k,fn in [('capacity',src.shell_capacity),('order',src.generated_subshell_order),('closures',src.generated_period_closures),('widths',src.generated_period_widths)]}))
assert actual==expected
names=['SFT.Physics.AtomicShellPeriodicity.'+n for n in re.findall(r'^(?:def|theorem|inductive) (\w+)',(r/'SFT/Physics/AtomicShellPeriodicity.lean').read_text(),re.M)];a=(w/'atomicshell956_core_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in a for n in names)
(w/'atomicshell956_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS all four source operations on',len(values),'inputs;includes entire274cover order and boundary failures;17empty axioms')
