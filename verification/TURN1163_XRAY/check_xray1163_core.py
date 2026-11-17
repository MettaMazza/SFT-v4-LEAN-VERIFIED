from pathlib import Path
import sys,json,subprocess,os,hashlib
from fractions import Fraction
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1163/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.analytical_terminal_laws_v1 import ExactAnalyticalCoordinate,exact_side_relation,complete_vector
from sft.engine.exact import HeldLabel,PositiveCount
from sft.claim_evidence import EMPTY_ONE
q=lambda s:json.dumps(s)
def sup(x):return ['emptyOne']if x==EMPTY_ONE else [x.numerator,x.denominator]
def label(x):return [x.family,x.label]
def val(x):return [label(x.carrier),label(x.coordinate_kind),sup(x.coordinate),label(x.response_kind),sup(x.response),label(x.side),label(x.condition),x.position.value]
def row(pos=1,ck='coordinate',rk='response',co=(2,1),resp=(2,3),side='higher',carrier='carrier',condition='condition',bad=-1):
 fs=['analytical-carrier','analytical-coordinate-kind','analytical-response-kind','held-side','analytical-condition'];ls=[carrier,ck,rk,side,condition]
 if bad>=0:fs[bad]='wrong-family'
 le=['(← heldLabel '+q(f)+' '+q(l)+')'for f,l in zip(fs,ls)]
 se=lambda x:'.emptyOne'if x is None else '(.positive (← ratio '+str(x[0])+' '+str(x[1])+'))'
 expr='(do construct '+le[0]+' '+le[1]+' '+se(co)+' '+le[2]+' '+se(resp)+' '+le[3]+' '+le[4]+' (← count '+str(pos)+'))'
 try:a=ExactAnalyticalCoordinate(HeldLabel(fs[0],ls[0]),HeldLabel(fs[1],ls[1]),EMPTY_ONE if co is None else Fraction(*co),HeldLabel(fs[2],ls[2]),EMPTY_ONE if resp is None else Fraction(*resp),HeldLabel(fs[3],ls[3]),HeldLabel(fs[4],ls[4]),PositiveCount(pos))
 except Exception:a=None
 return expr,a
cases=[];expected=[]
for side in ['higher','lower','preserving','alternating','coincident','unresolved','invented']:
 for co in [(2,1),None]:
  for resp in [(2,3),None]:
   e,a=row(side=side,co=co,resp=resp);cases.append('encodeConstruct '+e);expected.append(['rejected']if a is None else val(a))
for kw in [dict(bad=i)for i in range(5)]+[dict(co=(0,1)),dict(resp=(0,1)),dict(pos=0)]:
 e,a=row(**kw);cases.append('encodeConstruct '+e);expected.append(['rejected']if a is None else val(a))
construct_count=len(cases)
sets=[[row(pos=i+1,ck='coordinate-'+str(i),co=(i+1,3))for i in range(n)]for n in range(11)]
sets += [[row(),row(pos=2,resp=(7,8))],[row(co=(1,2)),row(pos=2,co=(2,4))],[row(),row(pos=2,rk='other')],[row(),row(pos=2,condition='other',ck='other')],[row(),row(pos=2,carrier='other',ck='other')],[row(pos=2)],[row(),row(pos=3,ck='other')]]
for rows in sets:
 cases.append('encodeVector (do completeVector ['+','.join('(← '+e+')'for e,_ in rows)+'])')
 try:expected.append([val(x)for x in complete_vector(tuple(x for _,x in rows))])
 except Exception:expected.append(['rejected'])
vector_count=len(sets)
for a,b,c,d in [(a,b,c,d)for a in [1,3,5]for b in [1,2]for c in [1,3,5]for d in [1,2]]:
 cases.append('encodeRelation (do return exactSideRelation (← ratio '+str(a)+' '+str(b)+') (← ratio '+str(c)+' '+str(d)+'))');side,distance=exact_side_relation(Fraction(a,b),Fraction(c,d));expected.append([label(side),sup(distance)])
s='''import SFT.Chemistry.XrayDiffraction
open SFT.Chemistry.XrayDiffraction SFT.Chemistry.AnalyticalAccuracy SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def encodeLabel (l : HeldLabel) : J := .array [.text l.family,.text l.label]
def support : ExactSupport → J
 | .emptyOne => .array [.text "emptyOne"]
 | .positive q => let v := rational q; .array [.integer (.ofNat v.1),.integer (.ofNat v.2)]
def encodeRow (r : Coordinate) : J := .array [encodeLabel r.carrier,encodeLabel r.coordinateKind,support r.coordinate,encodeLabel r.responseKind,support r.response,encodeLabel r.side,encodeLabel r.condition,.integer (.ofNat r.position.value)]
def encodeConstruct : Except String Coordinate → J
 | .error _ => .array [.text "rejected"]
 | .ok r => encodeRow r
def encodeVector : Except String (List Coordinate) → J
 | .error _ => .array [.text "rejected"]
 | .ok rs => .array (rs.map encodeRow)
def encodeRelation : Except String (HeldLabel × ExactSupport) → J
 | .error _ => .array [.text "rejected"]
 | .ok (l,s) => .array [encodeLabel l,support s]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(cases)+']))\n';p=w/'XrayDiffractionCore1163.lean';p.write_text(s)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'xray1163_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1800:]+p.stderr[-500:];actual=json.loads(p.stdout);assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:3]
(w/'xray1163_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),constructor_cases=construct_count,complete_vector_cases=vector_count,side_relation_cases=len(cases)-construct_count-vector_count,all_eight_fields_preserved=True,native_sha256=hashlib.sha256((r/'SFT/Chemistry/XrayDiffraction.lean').read_bytes()).hexdigest(),original_sha256=hashlib.sha256((w/'pinned1163/sft/chemistry/analytical_terminal_laws_v1.py').read_bytes()).hexdigest()),indent=2));print('PASS',len(cases),'complete original comparisons')
