from pathlib import Path
from fractions import Fraction
import ast,json,subprocess,os,hashlib
w=Path('work'); r=(w/'constants-recovery').resolve()
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
raw=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/atomic_constants.py'],text=True)
node=next(n for n in ast.parse(raw).body if isinstance(n,ast.FunctionDef) and n.name=='greatest_whole_not_exceeding')
ns={'Fraction':Fraction};exec(compile(ast.Module(body=[node],type_ignores=[]),'pinned-greatest-whole','exec'),ns)
rows=[]
for n in range(1,33):
 for d in range(1,17):
  try: expected=str(ns[node.name](Fraction(n,d)))
  except ValueError as e: expected='ValueError: '+str(e)
  rows.append(f'({n},{d},{json.dumps(expected)})')
s='''import SFT.Physics.AtomicBoundary
open SFT.Physics.AtomicBoundary SFT.Physics.BoundaryGrowth SFT.Physics.FoldFirstReturn
open SFT.Foundation.ExactOperations
set_option maxRecDepth 20000
def cases : List (Nat × Nat × String) := [
'''+',\n'.join(rows)+''']
def main : IO Unit := do
 for (n,d,expected) in cases do
  if hn : 0<n then
   if hd : 0<d then
    let p := normalizePositive n d hn hd
    let actual := match greatestWhole (.fraction (asFraction p)) with
     | .ok k => toString k
     | .error e => e
    if actual != expected then throw (IO.userError s!"mismatch {n}/{d}")
 let invalid : List Input := [.nonFraction,.fraction ⟨.ofNat 0,1,by decide,by decide⟩,.fraction ⟨.negSucc 0,1,by decide,by decide⟩]
 for value in invalid do
  match greatestWhole value with
  | .ok _ => throw (IO.userError "invalid admitted")
  | .error e => if e != "ValueError: greatest-whole construction requires a positive ratio at least One" then throw (IO.userError "wrong guard")
 match atomicEndpoint with
 | .ok 137 => pure ()
 | _ => throw (IO.userError "endpoint")
 IO.println "PASS512 source fractions,3 invalid inputs and derived endpoint137"
'''
(r/'AtomicBoundaryCases649.lean').write_text(s)
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','AtomicBoundaryCases649.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True,capture_output=True)
(w/'atomic_boundary649_cases.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
(w/'atomic_boundary649_cases_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,source_sha256=hashlib.sha256(raw.encode()).hexdigest(),fraction_cases=512,invalid_cases=3,endpoint=137,core_sha256=hashlib.sha256((r/'SFT/Physics/AtomicBoundary.lean').read_bytes()).hexdigest()),indent=2))
print(p.stdout)
