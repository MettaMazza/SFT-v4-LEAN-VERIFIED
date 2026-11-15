from pathlib import Path
from fractions import Fraction
from itertools import product
import sys,os,re,json,subprocess,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import symmetry_action_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
values=[Fraction(1,4),Fraction(1,2),Fraction(3,4),Fraction(1)]
cases=[()]+[(i,) for i in range(4)]+[x for n in range(2,6) for x in product(range(4),repeat=n)]
s='''import SFT.Physics.SymmetryActionPaths
import SFT.Physics.VacuumLedgerProofs
import SFT.Host.Canonical
open SFT.Physics.SymmetryAction SFT.Physics.SymmetryActionPaths SFT.Physics.VacuumLedgerProofs SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
for i,v in enumerate(values):s+=f'def v{i} : Input := .fraction (natRatio {v.numerator} {v.denominator} (by decide))\n'
s+='def paths : List (List Input) := [\n'+',\n'.join('['+','.join('v'+str(i) for i in c)+']' for c in cases)+']\n'
s+='''def report (p : List Input) : Value := .array [result frac (pathAction p),result frac (endpointSeparation p),result Value.boolean (isMonotoneDescent p),result Value.boolean (descentTelescopes p),result Value.boolean (detourCannotLowerAction p)]
#eval IO.println (render (.array (paths.map report)))
'''
expected=[]
for c in cases:
 p=tuple(values[i] for i in c);row=[]
 for fn in ['path_action','endpoint_separation','is_monotone_descent','descent_telescopes','detour_cannot_lower_action']:
  try:v=canonical_value(getattr(src,fn)(p))
  except ValueError as e:v={'error':str(e)}
  except IndexError as e:v={'error':'IndexError: '+str(e)}
  row.append(v)
 expected.append(row)
p=w/'constants-recovery/SymmetryPaths990.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'symmetry990_paths_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
code=(r/'SFT/Physics/SymmetryActionPaths.lean').read_text();ns=re.findall(r'^(?:def|theorem) (\w+)',code,re.M);audit=w/'symmetry990_paths_audit.lean';audit.write_text('import SFT.Physics.SymmetryActionPaths\n'+''.join('#print axioms SFT.Physics.SymmetryActionPaths.'+n+'\n' for n in ns));out=subprocess.check_output([lean,str(audit)],env=env,text=True);(w/'symmetry990_paths_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(ns),out
(w/'symmetry990_paths_report.json').write_text(json.dumps(dict(status='PASS',paths=len(cases),operation_cases=len(cases)*5,declarations=ns,axioms=[],lean_sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(cases),'paths;',len(cases)*5,'operation cases;',len(ns),'empty declarations')
