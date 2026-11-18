from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1308/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.classical_quantum_correspondence_law_v1 import MolecularProcess,branchwise_certificate
from sft.engine.exact import HeldLabel
from sft.engine.canonical import canonical_value
cases=[('molecular-carrier','registered','admitted-chemical-transition-law','law',rows) for rows in [(),(('a','a'),),(('a','b'),),(('a','b'),('b','a')),(('b','c'),('a','d')),(('',''),),(('a','b'),('a','c')),(('a','b'),('c','b')),tuple((str(i),'out'+str(i))for i in range(6))]]
cases += [('wrong','x','admitted-chemical-transition-law','law',(('a','b'),)),('molecular-carrier','x','wrong','law',(('a','b'),)),('molecular-carrier','','admitted-chemical-transition-law','law',(('a','b'),))]
q=lambda x:json.dumps(x,ensure_ascii=False);calls=[];expected=[]
for family,label,lawfamily,lawlabel,rows in cases:
 try:actual=['ok',canonical_value(branchwise_certificate(MolecularProcess(HeldLabel(family,label),rows,HeldLabel(lawfamily,lawlabel))))]
 except Exception as e:actual=['error',str(e)]
 expected.append(actual);calls.append('encode (run '+ ' '.join(map(q,[family,label,lawfamily,lawlabel]))+' ['+','.join('('+q(a)+','+q(b)+')'for a,b in rows)+'])')
(w/'correspondence1308_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
(w/'MolecularCorrespondenceCoreProgram1308.lean').write_text('''import SFT.Chemistry.MolecularCorrespondence
open SFT.Host.Canonical SFT.Chemistry.MolecularCorrespondence
open SFT.Physics.CapabilityValues (heldLabel)
def encode : Except String Value → Value
 | .ok value => .array [.text "ok",value]
 | .error error => .array [.text "error",.text error]
def run (family label lawFamily lawLabel : String) (rows : List (String × String)) : Except String Value := do
 let process ← construct (← heldLabel family label) rows (← heldLabel lawFamily lawLabel)
 branchwiseCertificate process
def main : IO Unit := do
 IO.println (render (.array [\n'''+',\n'.join(calls)+']))\n')
print('Original source evaluated for',len(cases),'full certificates/guard cases')
