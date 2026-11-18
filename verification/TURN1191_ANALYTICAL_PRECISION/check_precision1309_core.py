from pathlib import Path
import sys,json,subprocess,os,hashlib
from fractions import Fraction
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1309/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.analytical_precision_repeatability_law_v1 import replicate_record
from sft.engine.exact import HeldLabel
from sft.claim_evidence import EMPTY_ONE
q=lambda s:json.dumps(s);cases=[];expected=[]
def distance(x):return ['emptyOne']if x==EMPTY_ONE else [x.numerator,x.denominator]
supports=[[],[(1,1)],[(1,1),(1,1)],[(10,1),(101,10),(99,10)],[(10,1),(101,10),(99,10),(10,1)],[(2,4),(1,2),(4,8)],[(0,1)],[(1,1),(0,1)]]+[[((i*3+1)%7+1,(i%3)+1)for i in range(n)]for n in range(2,9)]
for vals,mf,af,cf in [(v,'analytical-sample','analytical-method','repeatability-condition')for v in supports]+[([(1,1)],'wrong','analytical-method','repeatability-condition'), ([(1,1)],'analytical-sample','wrong','repeatability-condition'), ([(1,1)],'analytical-sample','analytical-method','wrong')]:
 try:
  a,b,c=replicate_record(HeldLabel(mf,'s'),HeldLabel(af,'m'),HeldLabel(cf,'same'),tuple(Fraction(n,d)for n,d in vals));out=[[[v.numerator,v.denominator]for v in a],[distance(v)for v in b],distance(c)]
 except Exception as e:out=['error',str(e)]
 expected.append(out);cases.append('encode (do replicateFromCounts (← heldLabel '+q(mf)+' "s") (← heldLabel '+q(af)+' "m") (← heldLabel '+q(cf)+' "same") ['+','.join('('+str(n)+','+str(d)+')'for n,d in vals)+'])')
s='''import SFT.Chemistry.AnalyticalPrecision
open SFT.Chemistry.AnalyticalPrecision SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def encode : Except String Record → J
 | .error error => .array [.text "error",.text error]
 | .ok record => .array (recordFields record)
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(cases)+']))\n';p=w/'AnalyticalPrecisionCore1309.lean';p.write_text(s)
(w/'precision1309_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
p=subprocess.run(cmd,env=env,capture_output=True,text=True);(w/'precision1309_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:];actual=json.loads(p.stdout);assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:3]
(w/'precision1309_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),complete_record_fields=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',native_sha256=hashlib.sha256((r/'SFT/Chemistry/AnalyticalPrecision.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS',len(cases),'complete original replicate records and guards',flush=True)
