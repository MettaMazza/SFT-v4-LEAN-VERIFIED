from pathlib import Path
from fractions import Fraction
from collections import namedtuple
import ast,subprocess,os,json,hashlib
w=Path('work');r=(w/'constants-recovery').resolve();pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';raw=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/inverse_square_validation.py'],text=True);tree=ast.parse(raw);fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='positive_integer_exponents_in_interval');ns={'Fraction':Fraction,'PositiveCount':namedtuple('PositiveCount','value')};exec(compile(ast.Module(body=[fn],type_ignores=[]),'pinned_interval_operation','exec'),ns);rows=[]
for ln in range(1,7):
 for ld in range(1,5):
  for un in range(1,7):
   for ud in range(1,5):
    try:result=ns[fn.name](Fraction(ln,ld),Fraction(un,ud));expected=','.join(str(x.value) for x in result)
    except ValueError as e:expected='ValueError: '+str(e)
    rows.append(f'({ln},{ld},{un},{ud},{json.dumps(expected)})')
s='''import SFT.Physics.InverseSquareInterval
open SFT.Physics.InverseSquareInterval SFT.Physics.BoundaryGrowth SFT.Physics.FoldFirstReturn
open SFT.Foundation.ExactOperations
set_option maxRecDepth 20000
def cases : List (Nat × Nat × Nat × Nat × String) := [
'''+',\n'.join(rows)+''']
def main : IO Unit := do
 for (ln,ld,un,ud,expected) in cases do
  if hl : 0<ln then
   if hd : 0<ld then
    if hu : 0<un then
     if hud : 0<ud then
      let lo := normalizePositive ln ld hl hd
      let hi := normalizePositive un ud hu hud
      let actual := match checked (.fraction (asFraction lo)) (.fraction (asFraction hi)) with
       | .error e => e
       | .ok values => String.intercalate "," (values.map toString)
      if actual != expected then throw (IO.userError s!"interval mismatch {ln}/{ld}..{un}/{ud}: {actual}")
 let invalid : List Input := [.fraction ⟨.ofNat 0,1,by decide,by decide⟩,.fraction ⟨.negSucc 0,1,by decide,by decide⟩]
 for input in invalid do
  match checked input (.fraction (asFraction two)) with
  | .error e => if e != "ValueError: reported exponent interval must be positive and ordered" then throw (IO.userError e)
  | .ok _ => throw (IO.userError "invalid lower admitted")
  match checked (.fraction (asFraction two)) input with
  | .error e => if e != "ValueError: reported exponent interval must be positive and ordered" then throw (IO.userError e)
  | .ok _ => throw (IO.userError "invalid upper admitted")
  match checked input .nonFraction with
  | .error e => if e != "ValueError: reported exponent bounds must be exact fractions" then throw (IO.userError e)
  | .ok _ => throw (IO.userError "nonfraction admitted")
 IO.println "PASS576 exact source interval cases and6 invalid/precedence cases"
''';p=w/'InverseSquareIntervalCases644.lean';p.write_text(s);o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run',str(p)],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True,capture_output=True);(w/'inverse_square_interval644_cases.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;(w/'inverse_square_interval644_cases_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,source_sha256=hashlib.sha256(raw.encode()).hexdigest(),core_sha256=hashlib.sha256((r/'SFT/Physics/InverseSquareInterval.lean').read_bytes()).hexdigest(),source_cases=576,invalid_cases=6,source_execution='Pinned function body with positive-count value records; all enumerated candidates start at1 and advance positively.'),indent=2));print(o.stdout)
