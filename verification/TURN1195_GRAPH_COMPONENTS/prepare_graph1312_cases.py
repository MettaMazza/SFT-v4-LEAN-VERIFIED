from pathlib import Path
import sys,json,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1312/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.computational_chemistry_laws_v1 import ExactAtom,ExactBond,MolecularGraph,_refined_cells,canonical_graph_code
from sft.engine.exact import PositiveCount
from sft.claim_evidence import EMPTY_ONE,EmptyOne
q=lambda x:json.dumps(x,ensure_ascii=False)
pc=lambda n:'⟨'+str(n)+',by decide⟩'
expected=[];native=[]
for element in ['', '1C','C','Cl','C?','é','α','中','𐐀','\u0301','Ⅳ']:
 for hand,mag,ident in [('neutral',None,'empty-One'),('neutral',None,'other'),('gain',1,None),('loss',None,'empty-One'),('wrong',1,None)]:
  support=EMPTY_ONE if ident=='empty-One' else EmptyOne(ident) if ident else PositiveCount(mag)
  try:result={'ok':list(ExactAtom(element,EMPTY_ONE,hand,support).label)}
  except Exception as e:result={'error':str(e)}
  expected.append(result)
  sup='.emptyOne '+q(ident) if ident else '.count '+pc(mag)
  native.append('atomResult (constructAtom '+q(element)+' structuralAbsence '+q(hand)+' ('+sup+'))')
for n in range(1,5):
 pairs=list(itertools.combinations(range(1,n+1),2))
 for mask in range(1<<len(pairs)):
  atoms=tuple(ExactAtom('C' if i%2==0 else 'H') for i in range(n))
  bonds=tuple(ExactBond(PositiveCount(a),PositiveCount(b),PositiveCount(1)) for j,(a,b) in enumerate(pairs) if mask&(1<<j))
  graph=MolecularGraph(atoms,bonds);cells=_refined_cells(graph)
  labels=[a.label for a in atoms]
  sig=[(labels[i-1],tuple(sorted((order,orientation,labels[neighbour-1]) for neighbour,order,orientation in graph.neighbours(i)))) for i in range(1,n+1)]
  unique=sorted(set(sig));ranks=[unique.index(s)+1 for s in sig]
  for limit in [1,1000000]:
   try:code={'ok':canonical_graph_code(graph,PositiveCount(limit))}
   except Exception as e:code={'error':str(e)}
   expected.append({'initial':ranks,'code':code,'count':__import__('math').prod(__import__('math').factorial(len(c)) for c in cells)})
   an='['+','.join('⟨'+q(a.element)+',structuralAbsence,"neutral",structuralAbsence,"unresolved"⟩' for a in atoms)+']'
   bn='['+','.join('⟨'+pc(b.left.value)+','+pc(b.right.value)+','+pc(1)+',"unresolved"⟩' for b in bonds)+']'
   cs='['+','.join('['+','.join(map(str,c))+']'for c in cells)+']'
   native.append('graphResult ⟨'+an+','+bn+'⟩ '+cs+' '+pc(limit))
header='''import SFT.Chemistry.MolecularGraphRefinement
open SFT.Host.Canonical SFT.Chemistry.MolecularGraphCarrier
open SFT.Chemistry.MolecularGraphEnumeration SFT.Chemistry.MolecularGraphRefinement
set_option maxRecDepth 10000
set_option maxHeartbeats 100000000
def atomResult : Except String Atom → Value
 | .error error => .object [("error",.text error)]
 | .ok atom => .object [("ok",.array ((atomLabel atom).map Value.text))]
def codeValue (code : Code) : Value := .array [
 .array (code.atomWord.map fun row => .array (row.map Value.text)),
 .array (code.bondWord.map fun (a,b,c,d) => .array [.integer a,.integer b,.integer c,.text d])]
def codeResult : Except String Code → Value
 | .error error => .object [("error",.text error)]
 | .ok code => .object [("ok",codeValue code)]
def graphResult (graph : Graph) (cells : List (List Nat)) (limit : SFT.Physics.CapabilityValues.PositiveCount) : Value :=
 .object [("initial",.array ((initialSuccessor graph).map fun n => .integer (Int.ofNat n))),
 ("code",codeResult (enumerateCode graph cells limit)),("count",.integer (permutationCount cells))]
def main : IO Unit := IO.println (render (.array [
'''
(w/'MolecularGraphCases1312.lean').write_text(header+',\n'.join(native)+']))\n')
(w/'graph1312_cases_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
print('Prepared',len(expected),'original constructor/refinement/enumeration cases')
