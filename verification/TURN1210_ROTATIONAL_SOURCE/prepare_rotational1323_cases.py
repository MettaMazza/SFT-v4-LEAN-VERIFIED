from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1323/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.rotational_constant_law_v1 import *
from sft.engine.exact import HeldLabel as L,PositiveCount as C
from sft.claim_evidence import PositiveRatio as R,EMPTY_ONE
rows=[];expr=[]
def record(code,f):
 try:out={'ok':f()}
 except Exception as e:out={'error':str(e)}
 rows.append(out);expr.append(code)
def pair(r):return [r.numerator.value,r.denominator.value]
def ci(n):return '.other'if n is None else '.count ⟨'+str(n)+',by decide⟩'
def count(n):return None if n is None else C(n)
for n,d in [(12,3),(1,1),(137,31),(2,7),(6,9),(None,3),(12,None),(None,None)]:record('result ratioValue (exactAxisRotationalConstant ('+ci(n)+') ('+ci(d)+'))',lambda n=n,d=d:pair(exact_axis_rotational_constant(count(n),count(d))))
for n,d,k in [(12,3,5),(12,3,1),(2,7,11),(137,31,23),(6,9,4),(None,3,2),(12,None,2),(12,3,None),(None,None,None)]:record('result ratioValue (repeatedEqualIntervalConstant ('+ci(n)+') ('+ci(d)+') ('+ci(k)+'))',lambda n=n,d=d,k=k:pair(repeated_equal_interval_constant(count(n),count(d),count(k))))
for fn,lean in [(rotational_level_multiple,'rotationalLevelMultiple'),(adjacent_rotational_gap_multiple,'adjacentRotationalGapMultiple')]:
 for j in [1,2,3,4,137,None]:record('result (fun x => .integer x.value) ('+lean+' ('+ci(j)+'))',lambda j=j,fn=fn:fn(count(j)).value)
for n,d,j in [(12,3,3),(1,1,1),(2,7,8),(6,9,137),(12,3,None)]:record('result ratioValue (rotationalLevelRatio (.ratio ⟨⟨'+str(n)+',by decide⟩,⟨'+str(d)+',by decide⟩⟩) ('+ci(j)+'))',lambda n=n,d=d,j=j:pair(rotational_level_ratio(R(C(n),C(d)),count(j))))
for x,lean in [(None,'.invalid'),(EMPTY_ONE,'.emptyOne')]:record('result ratioValue (rotationalLevelRatio '+lean+' ('+ci(1)+'))',lambda x=x:pair(rotational_level_ratio(x,C(1))))
families={0:'molecular-species',1:'molecular-state',2:'generated-molecular-geometry',4:'rotational-axis',5:'rotational-axis-equivalence',8:'observation-interval-unit'}
for wrong in [-1]+list(range(9)):
 fields=[];ls=[]
 for i in range(9):
  if i in families:
   f='wrong'if i==wrong else families[i];label='principal-axis-A'if i==4 else 'held';fields.append(L(f,label));ls.append('⟨'+json.dumps(f)+','+json.dumps(label)+',rfl,rfl⟩')
  else:
   n=None if i==wrong else {3:3,6:12,7:3}[i];fields.append(count(n));ls.append(ci(n))
 record('result (fun _ => .boolean true) (validateCarrier ⟨'+','.join(ls)+'⟩)',lambda fields=fields:bool(RotationalAxisCarrier(*fields)))
for axis in ['principal-axis-A','principal-axis-B','principal-axis-C','bad-axis']:
 fields=[L('molecular-species','held'),L('molecular-state','held'),L('generated-molecular-geometry','held'),C(3),L('rotational-axis',axis),L('rotational-axis-equivalence','held'),C(12),C(3),L('observation-interval-unit','held')]
 ls=['⟨'+json.dumps(f.family)+','+json.dumps(f.label)+',rfl,rfl⟩'if isinstance(f,L)else ci(f.value)for f in fields]
 record('result (fun _ => .boolean true) (validateCarrier ⟨'+','.join(ls)+'⟩)',lambda fields=fields:bool(RotationalAxisCarrier(*fields)))
record('result (fun _ => .boolean true) (.ok unexcitedRotationalForm)',lambda:unexcited_rotational_form()is EMPTY_ONE)
(w/'rotational1323_core_expected.json').write_text(json.dumps(rows,indent=2)+'\n')
(w/'RotationalConstantCases1323.lean').write_text('''import SFT.Chemistry.RotationalConstant
open SFT.Host SFT.Host.Canonical SFT.Chemistry.RotationalConstant
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratioValue (r : SFT.Chemistry.DihedralTorsion.Ratio) : Value := .array [.integer r.numerator.value,.integer r.denominator.value]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
'''+',\n'.join(expr)+']))\n');print('Prepared',len(rows),'original cases')
