from pathlib import Path
import sys,json,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_solidlocal1485/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.solid_state_local_coordination_law_v1 import primitive_formula
from sft.engine.exact import HeldLabel
cases=[[],['A#1'],['A#1','A#2','B#1','B#2'],['B#1','A#1','B#2','A#2'],['A#1','A#1'],['A'],['A#1#extra','A#2'],['#1'],[' #1'],['α#1','β#2','α#3'],['A#1','a#1']]
for a,b in itertools.product(range(1,7),repeat=2):cases.append([f'A#{i+1}'for i in range(a)]+[f'B#{i+1}'for i in range(b)])
expected=[]
for xs in cases:
 try:
  fs=primitive_formula(tuple(HeldLabel('species-occurrence',x)for x in xs));expected.append({'ok':[{'species':{'family':f.species.family,'label':f.species.label},'primitive_count':f.primitive_count.value}for f in fs]})
 except Exception as e:expected.append({'error':str(e)})
(w/'solidlocal1486_formula_expected.json').write_text(json.dumps(expected,ensure_ascii=False)+'\n')
q=lambda x:json.dumps(x,ensure_ascii=False)
source='''import SFT.Chemistry.SolidLocal
import Lean
open SFT.Chemistry.SolidLocal SFT.Physics.CapabilityValues SFT.Host
abbrev J := Canonical.Value
def encode (x : Except String (List FormulaEntry)) : J := match x with
 | .error e => .object [("error",.text e)]
 | .ok fs => .object [("ok",.array (fs.map fun f => .object [("species",.object [("family",.text f.species.family),("label",.text f.species.label)]),("primitive_count",.integer (.ofNat f.primitiveCount.value))]))]
def run (xs : List String) : J := encode (do primitiveFormula (← xs.mapM (heldLabel "species-occurrence")))
def main : IO Unit := IO.println (Canonical.render (.array (['''+','.join('['+','.join(map(q,x))+']'for x in cases)+'''].map run)))
'''
(w/'SolidLocalFormulaProgram1486.lean').write_text(source)
print('Prepared',len(cases),'full original formula comparisons')
