from pathlib import Path
import sys,json,subprocess,os,hashlib
from fractions import Fraction
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1162/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.analytical_accuracy_trueness_law_v1 import ReferenceComparison,comparison_record
from sft.engine.exact import HeldLabel,PositiveCount
from sft.claim_evidence import EMPTY_ONE
q=lambda s:json.dumps(s)
cases=[];expected=[]
def value(x):
 if x==EMPTY_ONE:return ['emptyOne']
 side,d=x;return [side.family,side.label,[d.numerator,d.denominator]]
def row(a,b,c,d,rank=1,mf='measurand',method='method-a',af='analytical-method'):
 expression='(do construct (← heldLabel '+q(mf)+' "analyte-a") (← heldLabel '+q(af)+' '+q(method)+') (← ratio '+str(a)+' '+str(b)+') (← ratio '+str(c)+' '+str(d)+') (← count '+str(rank)+'))'
 try:actual=ReferenceComparison(HeldLabel(mf,'analyte-a'),HeldLabel(af,method),Fraction(a,b),Fraction(c,d),PositiveCount(rank))
 except Exception:actual=None
 return expression,actual
for a,b,c,d in [(a,b,c,d)for a in [1,2,10,101]for b in [1,10]for c in [1,10]for d in [1,3]]+[(0,1,1,1),(1,1,0,1)]:
 expression,actual=row(a,b,c,d);cases.append('encodeRow '+expression);expected.append(['rejected']if actual is None else [[actual.observed.numerator,actual.observed.denominator],[actual.reference.numerator,actual.reference.denominator],value(actual.discrepancy)])
for kwargs in [dict(mf='wrong'),dict(af='wrong'),dict(rank=0)]:
 expression,actual=row(1,1,1,1,**kwargs);cases.append('encodeRow '+expression);expected.append(['rejected'])
for width in range(9):
 rows=[row(i+1,3,2,1,i+1)for i in range(width)]
 expr='(do comparisonRecord ['+','.join('(← '+e+')'for e,_ in rows)+'])';cases.append('encodeRecord '+expr)
 try:record=comparison_record(tuple(a for _,a in rows));expected.append([[[x.numerator,x.denominator],[y.numerator,y.denominator],value(d)]for x,y,d in record])
 except Exception:expected.append(['rejected'])
for rows in [[row(1,1,1,1,2)],[row(1,1,1,1,1),row(2,1,1,1,1)],[row(1,1,1,1,1),row(2,1,1,1,2,method='other')]]:
 cases.append('encodeRecord (do comparisonRecord ['+','.join('(← '+e+')'for e,_ in rows)+'])')
 try:record=comparison_record(tuple(a for _,a in rows));expected.append([[[x.numerator,x.denominator],[y.numerator,y.denominator],value(d)]for x,y,d in record])
 except Exception:expected.append(['rejected'])
text='''import SFT.Chemistry.AnalyticalAccuracy
open SFT.Chemistry.AnalyticalAccuracy SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def pair (p : Nat × Nat) : J := .array [.integer (.ofNat p.1),.integer (.ofNat p.2)]
def encodeDifference : Discrepancy → J
 | .emptyOne => .array [.text "emptyOne"]
 | .apart side distance => .array [.text side.family,.text side.label,pair distance]
def encodeReading (r : Reading) : J := .array [pair r.1,pair r.2.1,encodeDifference r.2.2]
def encodeRow (r : Except String ReferenceComparison) : J := match r with
 | .error _ => .array [.text "rejected"]
 | .ok r => encodeReading (reading r)
def encodeRecord (r : Except String (List Reading)) : J := match r with
 | .error _ => .array [.text "rejected"]
 | .ok rows => .array (rows.map encodeReading)
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(cases)+']))\n';p=w/'AnalyticalAccuracyCore1162.lean';p.write_text(text)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
p=subprocess.run(cmd,env=env,capture_output=True,text=True);(w/'accuracy1162_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:];actual=json.loads(p.stdout);assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:3]
report=dict(status='PASS',cases=len(cases),constructor_and_discrepancy_cases=len(cases)-12,complete_record_cases=12,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',native_sha256=hashlib.sha256((r/'SFT/Chemistry/AnalyticalAccuracy.lean').read_bytes()).hexdigest(),original_sha256=hashlib.sha256((w/'pinned1162/sft/chemistry/analytical_accuracy_trueness_law_v1.py').read_bytes()).hexdigest());(w/'accuracy1162_core_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(cases),'complete original operation comparisons')
