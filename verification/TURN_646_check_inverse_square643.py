from pathlib import Path
from fractions import Fraction
import ast,subprocess,os,json,hashlib
w=Path('work');r=(w/'constants-recovery').resolve();pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';raw=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/structural_constants.py'],text=True)
tree=ast.parse(raw);ns={'Fraction':Fraction};defs=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.lineno<180];exec(compile(ast.Module(body=defs,type_ignores=[]),'pinned_structural_operations','exec'),ns)
rows=[]
for sn in range(1,7):
 for sd in range(1,7):
  for rn in range(1,7):
   for rd in range(1,7):
    try:
     q=ns['inverse_square_response'](Fraction(sn,sd),Fraction(rn,rd));expected=f'"{q.numerator}/{q.denominator}"'
    except ValueError as e:expected=json.dumps('ValueError: '+str(e))
    rows.append(f'({sn},{sd},{rn},{rd},{expected})')
s='''import SFT.Physics.InverseSquare
open SFT.Physics.InverseSquare SFT.Physics.BoundaryGrowth SFT.Physics.FoldFirstReturn
open SFT.Foundation.ExactOperations
set_option maxRecDepth 20000
def cases : List (Nat × Nat × Nat × Nat × String) := [
'''+',\n'.join(rows)+''']
def main : IO Unit := do
 for (sn,sd,rn,rd,expected) in cases do
  if hs : 0<sn then
   if hd : 0<sd then
    if hr : 0<rn then
     if hrd : 0<rd then
      let source := normalizePositive sn sd hs hd
      let distance := normalizePositive rn rd hr hrd
      let actual := match response (.fraction (asFraction source)) (.fraction (asFraction distance)) with
       | .error e => e
       | .ok value => s!"{value.numerator}/{value.denominator}"
      if actual != expected then throw (IO.userError s!"mismatch {sn}/{sd} {rn}/{rd}: {actual} expected {expected}")
 let invalid : List Input := [.nonFraction,.fraction ⟨.ofNat 0,1,by decide,by decide⟩,.fraction ⟨.negSucc 0,1,by decide,by decide⟩]
 for source in invalid do
  for distance in invalid++[.fraction (asFraction two)] do
   match response source distance with
   | .error e => if e != "ValueError: source support must be an exact positive carrier" then throw (IO.userError "source guard precedence")
   | .ok _ => throw (IO.userError "invalid source admitted")
 for distance in invalid do
  match response (.fraction (asFraction two)) distance with
  | .error e => if e != "ValueError: distance ratio must be exact and above the One" then throw (IO.userError "distance guard")
  | .ok _ => throw (IO.userError "invalid distance admitted")
 IO.println "PASS 1296 exact source outputs/rejections and15 invalid-input/precedence cases"
'''
p=w/'InverseSquareCases643.lean';p.write_text(s);env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run',str(p)],env=env,text=True,capture_output=True);(w/'inverse_square643_cases.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr
report=dict(status='PASS',source_commit=pin,source_sha256=hashlib.sha256(raw.encode()).hexdigest(),source_output_cases=1296,invalid_input_precedence_cases=15,core_sha256=hashlib.sha256((r/'SFT/Physics/InverseSquare.lean').read_bytes()).hexdigest(),command='python3 work/check_inverse_square643.py');(w/'inverse_square643_cases_report.json').write_text(json.dumps(report,indent=2));print(o.stdout)
