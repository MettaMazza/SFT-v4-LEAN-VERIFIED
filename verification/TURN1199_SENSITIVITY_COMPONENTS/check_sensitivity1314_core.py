from pathlib import Path
import sys,json,subprocess,os,hashlib,itertools
from fractions import Fraction
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1314/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.analytical_sensitivity_law_v1 import sensitivity_segments
from sft.engine.exact import HeldLabel
from sft.claim_evidence import EMPTY_ONE
q=lambda s:json.dumps(s);cases=[];expected=[]
supports=[[],[(1,2)],[(1,2),(2,5),(3,5)],[(1,2),(2,5),(3,5),(4,6)],[(1,5),(2,3)],[(1,2),(1,3)],[(2,2),(1,3)],[(0,1),(1,2)],[(1,0),(2,2)],[(-1,1),(1,2)],[(1,-2),(2,2)],[(Fraction(1,3),Fraction(4,7)),(Fraction(2,3),Fraction(1,7))]]
supports += [[(Fraction(i+1,3),Fraction(v,7))for i,v in enumerate(values)]for values in itertools.product([1,2,3],repeat=3)]
inputs=[(v,'analyte','analytical-method','analytical-condition')for v in supports]+[([(1,2),(2,5)],a,m,c)for a,m,c in [('wrong','analytical-method','analytical-condition'),('analyte','wrong','analytical-condition'),('analyte','analytical-method','wrong')]]
def rat(x):
 x=Fraction(x);return '(SFT.Physics.LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
for vals,af,mf,cf in inputs:
 try:
  result=sensitivity_segments(HeldLabel(af,'a'),HeldLabel(mf,'m'),HeldLabel(cf,'c'),tuple((Fraction(a),Fraction(b))for a,b in vals));out=[[('emptyOne'if side==EMPTY_ONE else side.label),[v.numerator,v.denominator]]for side,v in result]
 except Exception as e:out=['error',str(e)]
 expected.append(out);cases.append('encode (do sensitivitySegments (← heldLabel '+q(af)+' "a") (← heldLabel '+q(mf)+' "m") (← heldLabel '+q(cf)+' "c") ['+','.join('('+rat(a)+','+rat(b)+')'for a,b in vals)+'])')
s='''import SFT.Chemistry.AnalyticalSensitivity
open SFT.Chemistry.AnalyticalSensitivity SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def encode : Except String (List Segment) → J
 | .error error => .array [.text "error",.text error]
 | .ok rows => .array (rows.map fun row => .array [
   .text (match row.side with | .emptyOne => "emptyOne" | .rises => "rises" | .falls => "falls"),
   .array [.integer row.magnitude.num,.integer (.ofNat row.magnitude.den)]])
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(cases)+']))\n';p=w/'AnalyticalSensitivityCore1314.lean';p.write_text(s)
(w/'sensitivity1314_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
p=subprocess.run(cmd,env=env,capture_output=True,text=True);(w/'sensitivity1314_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:];actual=json.loads(p.stdout);assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:3]
(w/'sensitivity1314_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),complete_record_fields=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',native_sha256=hashlib.sha256((r/'SFT/Chemistry/AnalyticalSensitivity.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS',len(cases),'complete original segment records and guards',flush=True)
