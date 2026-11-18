from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1319/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.molecular_polarizability_law_v1 import PolarizabilityComponent, repeated_equal_field_response,exact_isotropic_response,MolecularPolarizabilityCarrier
from sft.claim_evidence import PositiveRatio as R
from sft.engine.exact import HeldLabel as L, PositiveCount as C
rows=[];expressions=[]
def record(expr,fn):
 try:out={'ok':fn()}
 except Exception as e:out={'error':str(e)}
 rows.append(out);expressions.append(expr)
def pair(r):return [r.numerator.value,r.denominator.value]
def comp(c):return [c.axis.family,c.axis.label,pair(c.induced_dipole_distinction),pair(c.electric_distinction)]
def ratio(n,d):return '⟨⟨'+str(n)+',by decide⟩,⟨'+str(d)+',by decide⟩⟩'
def lc(n,d,m,e,axis='a'):return '⟨⟨"molecular-response-axis","'+axis+'",rfl,rfl⟩,'+ratio(n,d)+','+ratio(m,e)+'⟩'
for n,d,m,e in [(6,1,2,1),(2,4,6,8),(1,9,7,5),(11,13,17,19),(12,6,3,9)]:
 c=PolarizabilityComponent(L('molecular-response-axis','a'),R.from_pair(n,d),R.from_pair(m,e));lean=lc(n,d,m,e)
 record('result ratioValue (.ok (exactResponse '+lean+'))',lambda c=c:pair(c.exact_response))
 for k in [1,2,5,11]:record('result componentValue (repeatedEqualFieldResponse (.component '+lean+') (.count ⟨'+str(k)+',by decide⟩))',lambda c=c,k=k:comp(repeated_equal_field_response(c,C(k))))
base=PolarizabilityComponent(L('molecular-response-axis','a'),R.from_pair(6,1),R.from_pair(2,1))
record('result componentValue (repeatedEqualFieldResponse .invalid (.count ⟨1,by decide⟩))',lambda:comp(repeated_equal_field_response('invalid',C(1))))
record('result componentValue (repeatedEqualFieldResponse (.component witnessComponent) .invalid)',lambda:comp(repeated_equal_field_response(base,0)))
for axis,induced,field,le in [(L('wrong','a'),R.from_pair(1,1),R.from_pair(1,1),'component ⟨"wrong","a",rfl,rfl⟩ (.ratio '+ratio(1,1)+') (.ratio '+ratio(1,1)+')'),(L('molecular-response-axis','a'),None,R.from_pair(1,1),'component axisA .invalid (.ratio '+ratio(1,1)+')'),(L('molecular-response-axis','a'),R.from_pair(1,1),None,'component axisA (.ratio '+ratio(1,1)+') .invalid')]:record('result componentValue ('+le+')',lambda axis=axis,induced=induced,field=field:comp(PolarizabilityComponent(axis,induced,field)))
cs=[PolarizabilityComponent(L('molecular-response-axis',a),R.from_pair(n,1),R.from_pair(d,1))for a,n,d in [('a',2,1),('b',6,2),('c',12,3)]]
for inds in [[],[0],[0,1],[0,1,2],[0,0,2],[0,1,2,0],[2,1,0]]:
 expr='result ratioValue (exactIsotropicResponse (.tuple ['+','.join('.component '+['firstComponent','secondComponent','thirdComponent'][i]for i in inds)+']))';record(expr,lambda inds=inds:pair(exact_isotropic_response(tuple(cs[i]for i in inds))))
record('result ratioValue (exactIsotropicResponse .other)',lambda:pair(exact_isotropic_response(list(cs))))
record('result ratioValue (exactIsotropicResponse (.tuple [.component firstComponent,.invalid,.component thirdComponent]))',lambda:pair(exact_isotropic_response((cs[0],None,cs[2]))))
families=['molecular-species','molecular-state','molecular-conformation','external-electric-distinction','polarizability-definition','measurement-method','measurement-condition','measurement-unit']
for wrong in [-1]+list(range(8)):
 fs=[('wrong'if i==wrong else f)for i,f in enumerate(families)];expr='result (fun _ => .boolean true) (validateCarrier ⟨'+','.join('⟨'+json.dumps(f)+',"held",rfl,rfl⟩'for f in fs)+'⟩)';record(expr,lambda fs=fs:bool(MolecularPolarizabilityCarrier(*(L(f,'held')for f in fs))))
(w/'polarizability1319_core_expected.json').write_text(json.dumps(rows,indent=2)+'\n')
(w/'MolecularPolarizabilityCases1319.lean').write_text('''import SFT.Chemistry.MolecularPolarizability
open SFT.Host SFT.Host.Canonical SFT.Chemistry.MolecularPolarizability
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratioValue (r : SFT.Chemistry.DihedralTorsion.Ratio) : Value := .array [.integer r.numerator.value,.integer r.denominator.value]
def componentValue (c : Component) : Value := .array [.text c.axis.family,.text c.axis.label,ratioValue c.induced,ratioValue c.electric]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
'''+',\n'.join(expressions)+']))\n');print('Prepared',len(rows),'original cases')
