from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1319/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.molecular_polarizability_validation_v1 import _prediction_map
from sft.claim_evidence import FoldTable,FoldPair,FoldWord
from sft.engine.exact import HeldLabel
cases=[];expr=[]
def table(n=252,family='target-id',width=16,word=True):return FoldTable(tuple(FoldPair(HeldLabel(family,'row-'+str(i)),FoldWord(tuple(HeldLabel('held','value')for _ in range(width)))if word else HeldLabel('held','wrong'))for i in range(n)))
for n,family,width,word in [(252,'target-id',16,True),(0,'target-id',16,True),(251,'target-id',16,True),(253,'target-id',16,True),(252,'other',16,True),(252,'target-id',15,True),(252,'target-id',17,True),(252,'target-id',16,False)]:
 try:r=_prediction_map(table(n,family,width,word));out={'ok':[[k,len(v.cells)]for k,v in r.items()]}
 except Exception as e:out={'error':str(e)}
 cases.append(out);expr.append('result ((table '+str(n)+' '+json.dumps(family)+' '+str(width)+' '+str(word).lower()+') >>= predictionMap)')
for value,lean in [(FoldWord(()),'.word []'),(HeldLabel('held','value'),'.label ⟨"held","value",rfl,rfl⟩')]:
 try:r=_prediction_map(value);out={'ok':[[k,len(v.cells)]for k,v in r.items()]}
 except Exception as e:out={'error':str(e)}
 cases.append(out);expr.append('result (predictionMap ('+lean+'))')
(w/'polarizability1319_prediction_cases_expected.json').write_text(json.dumps(cases,indent=2)+'\n')
(w/'MolecularPolarizabilityPredictionCases1319.lean').write_text('''import SFT.Chemistry.MolecularPolarizabilityPrediction
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Chemistry.MolecularPolarizabilityPrediction
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def table (n : Nat) (family : String) (width : Nat) (word : Bool) : Except String CapabilityValues.Value := do
 let entries ← (List.range n).mapM fun i => do
  let key ← CapabilityValues.heldLabel family (Text.append "row-" (toString i))
  pure (.label key,
   if word then .word (List.replicate width (.label ⟨"held","value",rfl,rfl⟩)) else .label ⟨"held","wrong",rfl,rfl⟩)
 CapabilityValues.table entries
def result : Except String (List (String × List CapabilityValues.Value)) → Value
 | .error e => .object [("error",.text e)]
 | .ok rows => .object [("ok",.array (rows.map fun (key,word) => .array [.text key,.integer word.length]))]
def main : IO Unit := IO.println (render (.array [
'''+',\n'.join(expr)+']))\n');print('Prepared',len(cases),'original prediction-domain cases')
