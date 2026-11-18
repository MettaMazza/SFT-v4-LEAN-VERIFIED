from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1324/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.intermolecular_binding_law_v1 import *
from sft.engine.exact import HeldLabel as L,PositiveCount as C
from sft.claim_evidence import PositiveRatio as R,EMPTY_ONE
rows=[];expr=[]
def record(code,f):
 try:out={'ok':f()}
 except Exception as e:out={'error':str(e)}
 rows.append(out);expr.append(code)
def pair(r):return [r.numerator.value,r.denominator.value]
def ratio(x):return None if x is None else EMPTY_ONE if x=='empty' else R(C(x[0]),C(x[1]))
def hi(x):return '.invalid'if x is None else '.emptyOne'if x=='empty'else '.ratio ⟨⟨'+str(x[0])+',by decide⟩,⟨'+str(x[1])+',by decide⟩⟩'
def ci(n):return '.other'if n is None else '.count ⟨'+str(n)+',by decide⟩'
for h,l in [((29,6),(4,1)),((7,2),(1,3)),((14,2),(3,1)),((1,2),(1,2)),((2,4),(1,2)),((3,1),(14,2)),(None,(1,1)),((1,1),None),('empty',(1,1)),((1,1),'empty')]:record('result ratioValue (exactBindingTake ('+hi(h)+') ('+hi(l)+'))',lambda h=h,l=l:pair(exact_intermolecular_binding_take(ratio(h),ratio(l))))
for xs,tupled in [([],True),([(1,1)],True),([(5,2),(7,3)],True),([(2,4),(2,4),(1,3)],True),([(1,2),(2,3),(3,4),(4,5)],True),([(1,1),None],True),([None,(1,1)],True),([(1,1),'empty'],True),([(5,2),(7,3)],False)]:
 vals=[ratio(x)for x in xs];values=tuple(vals)if tupled else vals;code='.tuple ['+','.join(hi(x)for x in xs)+']'if tupled else '.other'
 record('result ratioValue (exactSeparatedState ('+code+'))',lambda values=values:pair(exact_separated_constituent_state(values)))
for h,l,a in [((29,6),(4,1),(11,5)),((7,2),(1,3),(1,137)),((14,2),(3,1),(2,4)),((1,1),(1,1),(2,1)),((1,1),(2,1),None),((2,1),(1,1),None),((2,1),(1,1),'empty'),(None,(1,1),(2,1))]:record('result Value.boolean (appendSharedConstituentPreservesBinding ('+hi(h)+') ('+hi(l)+') ('+hi(a)+'))',lambda h=h,l=l,a=a:append_shared_constituent_preserves_binding(ratio(h),ratio(l),ratio(a)))
for h,l,k in [((29,6),(4,1),3),((29,6),(4,1),1),((7,2),(1,3),137),((1,1),(1,1),2),((1,1),(2,1),3),((2,1),(1,1),None),(None,(1,1),2),((1,1),None,2),('empty',(1,1),2),((1,1),'empty',2)]:record('result ratioValue (repeatedUnitBinding ('+hi(h)+') ('+hi(l)+') ('+ci(k)+'))',lambda h=h,l=l,k=k:pair(repeated_unit_binding(ratio(h),ratio(l),None if k is None else C(k))))
families=['bound-composite','bound-composite-state','finite-separation-organization','intermolecular-channel','measurement-condition','held-energy-unit']
def label(x):return '⟨'+json.dumps(x.family)+','+json.dumps(x.label)+',rfl,rfl⟩'
for case in ['valid','three','not-tuple','short','mismatch','duplicate','wrong-constituent','wrong-state']+list(range(6)):
 cs=[L('molecular-constituent','A'),L('molecular-constituent','B')];ss=[L('constituent-state','a'),L('constituent-state','b')];fs=[L('wrong'if i==case else f,'held')for i,f in enumerate(families)]
 if case=='three':cs.append(L('molecular-constituent','C'));ss.append(L('constituent-state','c'))
 if case=='short':cs=cs[:1];ss=ss[:1]
 if case=='mismatch':ss=ss[:1]
 if case=='duplicate':cs=[cs[0],cs[0]]
 if case=='wrong-constituent':cs[0]=L('wrong','A')
 if case=='wrong-state':ss[0]=L('wrong','a')
 native='.other'if case=='not-tuple'else '.tuple ['+','.join(label(x)for x in cs)+']';code='⟨('+native+'),['+','.join(label(x)for x in ss)+'],'+','.join(label(x)for x in fs)+'⟩';values=(cs if case=='not-tuple'else tuple(cs),tuple(ss),*fs)
 record('result (fun _ => .boolean true) (validateCarrier '+code+')',lambda values=values:bool(IntermolecularBindingCarrier(*values)))
record('result (fun _ => .boolean true) (.ok unboundInteractionForm)',lambda:unbound_interaction_form()is EMPTY_ONE)
(w/'intermolecular1324_core_expected.json').write_text(json.dumps(rows,indent=2)+'\n')
(w/'IntermolecularBindingCases1324.lean').write_text('''import SFT.Chemistry.IntermolecularBinding
open SFT.Host SFT.Host.Canonical SFT.Chemistry.IntermolecularBinding
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratioValue (r : SFT.Chemistry.DihedralTorsion.Ratio) : Value := .array [.integer r.numerator.value,.integer r.denominator.value]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
'''+',\n'.join(expr)+']))\n');print('Prepared',len(rows),'original source cases')
s=(w/'check_vibrational1322_core.py').read_text().replace('VibrationalFrequency','IntermolecularBinding').replace('vibrational1322','intermolecular1324').replace('1322','1324');(w/'check_intermolecular1324_core.py').write_text(s)
