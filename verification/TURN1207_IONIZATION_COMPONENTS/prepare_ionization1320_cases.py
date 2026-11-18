from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1320/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.molecular_ionization_law_v1 import ordered_ionization_take,least_adiabatic_take,vertical_not_below_adiabatic,MolecularIonizationCarrier
from sft.claim_evidence import PositiveRatio as R
from sft.engine.exact import HeldLabel as L
rows=[];expr=[]
def record(code,f):
 try:v={'ok':f()}
 except Exception as e:v={'error':str(e)}
 rows.append(v);expr.append(code)
def pair(r):return [r.numerator.value,r.denominator.value]
def ratio(p):return R.from_pair(*p)
def height(p):return '.ratio ⟨⟨'+str(p[0])+',by decide⟩,⟨'+str(p[1])+',by decide⟩⟩'
def support(xs):return '.tuple ['+','.join(height(p)for p in xs)+']'
for h,l in [((8,1),(3,1)),((16,2),(6,2)),((9,2),(3,2)),((5,7),(2,7)),((3,1),(6,2)),((3,7),(8,7)),((1,2),(1,3)),((137,29),(23,31))]:record('result ratioValue (orderedIonizationTake ('+height(h)+') ('+height(l)+'))',lambda h=h,l=l:pair(ordered_ionization_take(ratio(h),ratio(l))))
for h,l,lh,ll in [(None,ratio((3,1)),'.invalid',height((3,1))),(ratio((8,1)),None,height((8,1)),'.invalid')]:record('result ratioValue (orderedIonizationTake ('+lh+') ('+ll+'))',lambda h=h,l=l:pair(ordered_ionization_take(h,l)))
for xs in [[],[(8,1)],[(8,1),(6,1),(7,1)],[(7,1),(8,1),(6,1)],[(12,2),(6,1),(8,1)],[(8,1),(3,1)],[(9,2),(7,2),(8,2)]]:
 record('result ratioValue (leastAdiabaticTake ('+height((3,1))+') ('+support(xs)+'))',lambda xs=xs:pair(least_adiabatic_take(ratio((3,1)),tuple(ratio(p)for p in xs))))
record('result ratioValue (leastAdiabaticTake initial .other)',lambda:pair(least_adiabatic_take(ratio((3,1)),[ratio((8,1))])))
record('result ratioValue (leastAdiabaticTake initial (.tuple [.invalid]))',lambda:pair(least_adiabatic_take(ratio((3,1)),(None,))))
for xs,held in [([(8,1),(6,1),(7,1)],p)for p in [(8,1),(6,1),(7,1),(9,1),(14,2)]]+[([], (7,1)), ([(2,1),(8,1)],(8,1)), ([(12,2),(7,1)],(6,1)), ([(12,2),(7,1)],(12,2))]:
 record('result Value.boolean (verticalNotBelowAdiabatic initial ('+support(xs)+') ('+height(held)+'))',lambda xs=xs,held=held:vertical_not_below_adiabatic(ratio((3,1)),tuple(ratio(p)for p in xs),ratio(held)))
families=['molecular-species','initial-molecular-state','initial-molecular-conformation','resulting-ionic-state','removed-carrier','held-removal-orientation','ionization-path','measurement-condition']
for wrong in [-1]+list(range(8)):
 fs=[('wrong'if i==wrong else f)for i,f in enumerate(families)];code='result (fun _ => .boolean true) (validateCarrier ⟨'+','.join('⟨'+json.dumps(f)+',"held",rfl,rfl⟩'for f in fs)+'⟩)';record(code,lambda fs=fs:bool(MolecularIonizationCarrier(*(L(f,'held')for f in fs))))
(w/'ionization1320_core_expected.json').write_text(json.dumps(rows,indent=2)+'\n')
(w/'MolecularIonizationCases1320.lean').write_text('''import SFT.Chemistry.MolecularIonization
open SFT.Host SFT.Host.Canonical SFT.Chemistry.MolecularIonization
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratioValue (r : SFT.Chemistry.DihedralTorsion.Ratio) : Value := .array [.integer r.numerator.value,.integer r.denominator.value]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
'''+',\n'.join(expr)+']))\n');print('Prepared',len(rows),'original source cases')
