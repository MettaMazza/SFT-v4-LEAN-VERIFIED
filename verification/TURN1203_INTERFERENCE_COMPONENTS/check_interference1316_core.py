from pathlib import Path
import sys,json,subprocess,os,hashlib,itertools
from fractions import Fraction
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1316/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.analytical_selectivity_interference_law_v1 import interference_matrix
from sft.engine.exact import HeldLabel
from sft.claim_evidence import EMPTY_ONE
q=lambda s:json.dumps(s);cases=[];expected=[]
normal=[('interferent','i1',1,5),('interferent','i2',2,6)]
supports=[(5,normal),(5,normal+[('interferent','i3',1,4)]),(5,[]),(0,normal),(-1,normal),(5,[('wrong','i1',1,5)]),(5,[('interferent','i1',0,5)]),(5,[('interferent','i1',1,0)]),(5,[('interferent','i1',-1,5)]),(5,[('interferent','i1',1,-5)]),(5,normal+[normal[0]]),(Fraction(2,3),[('interferent','r',Fraction(1,7),Fraction(4,5))])]
supports += [(b,[('interferent','i',1,m)])for b,m in itertools.product([1,2,3],repeat=2)]
inputs=[(base,rows,'analyte','analytical-method','analytical-condition')for base,rows in supports]+[(5,normal,a,m,c)for a,m,c in [('wrong','analytical-method','analytical-condition'),('analyte','wrong','analytical-condition'),('analyte','analytical-method','wrong')]]
def pair(x):return [x.numerator,x.denominator]
def rat(x):
 x=Fraction(x);return '(SFT.Physics.LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
for baseline,rows,af,mf,cf in inputs:
 try:
  result=interference_matrix(HeldLabel(af,'a'),HeldLabel(mf,'m'),HeldLabel(cf,'c'),Fraction(baseline),tuple((HeldLabel(f,n),Fraction(p),Fraction(m))for f,n,p,m in rows));out=[[[i.family,i.label],(['emptyOne']if diff==EMPTY_ONE else [diff[0].label,pair(diff[1])]),pair(ratio),pair(pure)]for i,diff,ratio,pure in result]
 except Exception as e:out=['error',str(e)]
 expected.append(out);cases.append('encode (do interferenceMatrix (← heldLabel '+q(af)+' "a") (← heldLabel '+q(mf)+' "m") (← heldLabel '+q(cf)+' "c") '+rat(baseline)+' ['+','.join('⟨(← heldLabel '+q(f)+' '+q(n)+'),'+rat(p)+','+rat(m)+'⟩'for f,n,p,m in rows)+'])')
s='''import SFT.Chemistry.AnalyticalInterferenceMatrix
open SFT.Chemistry.AnalyticalInterferenceMatrix SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def ratio (q : Rat) : J := .array [.integer q.num,.integer (.ofNat q.den)]
def differenceValue : Difference → J
 | .emptyOne => .array [.text "emptyOne"]
 | .raises q => .array [.text "raises",ratio q]
 | .lowers q => .array [.text "lowers",ratio q]
def encode : Except String (List Row) → J
 | .error error => .array [.text "error",.text error]
 | .ok rows => .array (rows.map fun row => .array [.array [.text row.interferent.family,.text row.interferent.label],differenceValue row.difference,ratio row.responseRatio,ratio row.pureResponse])
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(cases)+']))\n';p=w/'AnalyticalInterferenceMatrixCore1316.lean';p.write_text(s)
(w/'interference1316_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'interference1316_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:];actual=json.loads(p.stdout);assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:3]
(w/'interference1316_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),complete_record_fields=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',native_sha256=hashlib.sha256((r/'SFT/Chemistry/AnalyticalInterferenceMatrix.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS',len(cases),'complete original interference records and guards',flush=True)
