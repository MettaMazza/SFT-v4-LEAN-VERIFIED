from pathlib import Path
import sys,json,subprocess,os,hashlib,itertools
from fractions import Fraction
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1315/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.analytical_detection_quantification_law_v1 import boundary_record
from sft.engine.exact import HeldLabel
from sft.claim_evidence import EMPTY_ONE
q=lambda s:json.dumps(s);cases=[];expected=[]
normal=([1,2],[(1,[2,3]),(2,[4,5])])
inputs=[normal,([1,2],[(1,[2,3]),(2,[4,5]),(3,[6,7])]),([] ,[(1,[2])]),([1],[]),([0],[(1,[2])]),([-1],[(1,[2])]),([1],[(0,[2])]),([1],[(1,[])]),([1],[(1,[0])]),([1],[(1,[-2])]),([1],[(2,[3,4]),(1,[5,6])]),([1],[(1,[3]),(1,[3,3])]),([Fraction(1,3)],[(Fraction(1,2),[Fraction(1,2),Fraction(2,3)])])]
inputs += [([1,2],[(1,list(v))])for v in itertools.product([1,2,3,4],repeat=2)]
rows=[(b,l,'analyte','analytical-method','analytical-condition')for b,l in inputs]+[(normal[0],normal[1],a,m,c)for a,m,c in [('wrong','analytical-method','analytical-condition'),('analyte','wrong','analytical-condition'),('analyte','analytical-method','wrong')]]
def pair(x):return [x.numerator,x.denominator]
def label(x):return ['emptyOne']if x==EMPTY_ONE else [x.family,x.label]
def rat(x):
 x=Fraction(x);return '(SFT.Physics.LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
for blanks,levels,af,mf,cf in rows:
 try:
  result=boundary_record(HeldLabel(af,'a'),HeldLabel(mf,'m'),HeldLabel(cf,'c'),tuple(map(Fraction,blanks)),tuple((Fraction(a),tuple(map(Fraction,rs)))for a,rs in levels));out=[[pair(a),label(d),label(qt),(['emptyOne']if sp==EMPTY_ONE else pair(sp))]for a,d,qt,sp in result]
 except Exception as e:out=['error',str(e)]
 expected.append(out);cases.append('encode (do boundaryRecord (← heldLabel '+q(af)+' "a") (← heldLabel '+q(mf)+' "m") (← heldLabel '+q(cf)+' "c") ['+','.join(map(rat,blanks))+'] ['+','.join('('+rat(a)+',['+','.join(map(rat,rs))+'])'for a,rs in levels)+'])')
s='''import SFT.Chemistry.AnalyticalDetection
open SFT.Chemistry.AnalyticalDetection SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def label : Classification → J
 | .emptyOne => .array [.text "emptyOne"]
 | .held family name => .array [.text family,.text name]
def ratio (q : Rat) : J := .array [.integer q.num,.integer (.ofNat q.den)]
def spreadValue : Spread → J
 | .emptyOne => .array [.text "emptyOne"]
 | .apart q => ratio q
def encode : Except String (List Row) → J
 | .error error => .array [.text "error",.text error]
 | .ok rows => .array (rows.map fun row => .array [ratio row.amount,label row.detection,label row.quantification,spreadValue row.spread])
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(cases)+']))\n';p=w/'AnalyticalDetectionCore1315.lean';p.write_text(s)
(w/'detection1315_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'detection1315_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:];actual=json.loads(p.stdout);assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:3]
(w/'detection1315_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),complete_record_fields=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',native_sha256=hashlib.sha256((r/'SFT/Chemistry/AnalyticalDetection.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS',len(cases),'complete original boundary records and guards',flush=True)
