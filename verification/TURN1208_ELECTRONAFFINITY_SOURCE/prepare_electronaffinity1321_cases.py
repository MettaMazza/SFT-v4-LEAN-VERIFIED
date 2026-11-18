from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1321/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.molecular_electron_affinity_law_v1 import exact_electron_affinity_difference,ElectronAffinityDifference,MolecularElectronAffinityCarrier
from sft.claim_evidence import PositiveRatio as R,EMPTY_ONE,EmptyOne
from sft.engine.exact import HeldLabel as L
rows=[];expr=[]
def record(code,f):
 try:v={'ok':f()}
 except Exception as e:v={'error':str(e)}
 rows.append(v);expr.append(code)
def height(p):return '.ratio ⟨⟨'+str(p[0])+',by decide⟩,⟨'+str(p[1])+',by decide⟩⟩'
def encoded(d):return [d.state_order_orientation.family,d.state_order_orientation.label,None if isinstance(d.magnitude,EmptyOne) else [d.magnitude.numerator.value,d.magnitude.denominator.value]]
pairs=[((8,1),(3,1)),((3,1),(8,1)),((3,1),(3,1)),((6,2),(3,1)),((1,3),(1,2)),((1,2),(1,3)),((137,29),(23,31)),((16,2),(6,2)),((5,7),(2,7)),((2,7),(5,7)),((4,6),(6,9))]
for a,b in pairs:record('result differenceValue (exactElectronAffinityDifference ('+height(a)+') ('+height(b)+'))',lambda a=a,b=b:encoded(exact_electron_affinity_difference(R.from_pair(*a),R.from_pair(*b))))
for a,b,la,lb in [(None,R.from_pair(3,1),'.invalid',height((3,1))),(R.from_pair(8,1),None,height((8,1)),'.invalid'),(EMPTY_ONE,R.from_pair(3,1),'.emptyOne',height((3,1))),(R.from_pair(8,1),EMPTY_ONE,height((8,1)),'.emptyOne')]:record('result differenceValue (exactElectronAffinityDifference ('+la+') ('+lb+'))',lambda a=a,b=b:encoded(exact_electron_affinity_difference(a,b)))
for family,magnitude,lean in [('electron-affinity-state-order',R.from_pair(5,1),height((5,1))),('electron-affinity-state-order',EMPTY_ONE,'.emptyOne'),('electron-affinity-state-order',EmptyOne('alternative'),'.otherEmptyOne "alternative"'),('wrong',R.from_pair(5,1),height((5,1))),('electron-affinity-state-order',None,'.invalid')]:record('result (fun _ => .boolean true) (validateDifference ⟨⟨'+json.dumps(family)+',"held",rfl,rfl⟩,'+lean+'⟩)',lambda family=family,magnitude=magnitude:bool(ElectronAffinityDifference(L(family,'held'),magnitude)))
families=['molecular-species','initial-molecular-state','resulting-anion-state','gained-carrier','held-gain-orientation','electron-gain-path','measurement-condition']
for wrong in [-1]+list(range(7)):
 fs=[('wrong' if i==wrong else f)for i,f in enumerate(families)];record('result (fun _ => .boolean true) (validateCarrier ⟨'+','.join('⟨'+json.dumps(f)+',"held",rfl,rfl⟩'for f in fs)+'⟩)',lambda fs=fs:bool(MolecularElectronAffinityCarrier(*(L(f,'held')for f in fs))))
(w/'electronaffinity1321_core_expected.json').write_text(json.dumps(rows,indent=2)+'\n')
(w/'MolecularElectronAffinityCases1321.lean').write_text('''import SFT.Chemistry.MolecularElectronAffinity
open SFT.Host SFT.Host.Canonical SFT.Chemistry.MolecularElectronAffinity
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def differenceValue (d : Difference) : Value := .array [.text d.orientation.family,.text d.orientation.label,
 match d.magnitude with
 | .ratio r => .array [.integer r.numerator.value,.integer r.denominator.value]
 | .emptyOne | .otherEmptyOne _ | .invalid => .null]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
'''+',\n'.join(expr)+']))\n');print('Prepared',len(rows),'original cases')
