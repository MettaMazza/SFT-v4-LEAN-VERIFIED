from pathlib import Path
import json
w=Path('work');rows=json.loads((w/'coordisomer1473_core_cases.json').read_text());q=lambda x:json.dumps(x,ensure_ascii=False)
def label(x):return '(← heldLabel '+q(x['family'])+' '+q(x['label'])+')'
def cell(x):return 'Cell.empty '+q(x['empty']) if 'empty'in x else 'Cell.held '+label(x)
def form(name,f):
 return 'def '+name+' : Except String Form := do\n construct ['+','.join(label(x) for x in f['composition_labels'])+']\n  ['+','.join(label(x) for x in f['attachment_labels'])+']\n  ['+','.join('['+','.join(cell(x)for x in row)+']'for row in f['orientation_words'])+']\n  ['+','.join('((← count '+str(a)+'),(← count '+str(b)+'))'for a,b in f['adjacency_pairs'])+']\n'
s='''import SFT.Chemistry.CoordinationIsomerism
namespace SFT.Chemistry.CoordinationIsomerismWitnesses
open SFT.Host SFT.Physics.CapabilityValues CoordinationIsomerism
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
'''
s+=form('base',rows[0]['form'])+form('chiral',rows[4]['form'])
forced=[x for x in rows if x['op']=='forced'];s+=form('attachmentForm',forced[1]['right'])+form('orientationForm',forced[2]['right'])
s+='''def equivalenceResult : Except String Bool := do
 let f ← base
 return (← forced f f).exactEquivalence
def attachmentResult : Except String Bool := do
 return Text.equal (← forced (← base) (← attachmentForm)).nativeDistinctionClass.label "attachment-class-distinction"
def orientationResult : Except String Bool := do
 return Text.equal (← forced (← base) (← orientationForm)).nativeDistinctionClass.label "orientation-adjacency-class-distinction"
def mirrorResult : Except String Bool := do
 let f ← chiral
 let r ← forced f (← mirror f)
 return !r.exactEquivalence && Text.equal r.nativeDistinctionClass.label "mirror-complement-class-distinction"
def successor : Except String Form := do
 extend (← base) (← heldLabel "coordination-composition-label" "L")
  (← heldLabel "coordination-attachment-mode" "mode-one")
  [.held (← heldLabel "fold-orientation-fibre" "fibre-two"),
   .held (← heldLabel "fold-orientation-fibre" "fibre-two"),.empty "empty-One"]
  (.endpoints [← count 1,← count 2])
def sameCell : Cell → Cell → Bool
 | .held a,.held b => MulticentreSupport.sameLabel a b
 | .empty a,.empty b => Text.equal a b
 | .held _,.empty _ | .empty _,.held _ => false
def sameList {α : Type} (same : α → α → Bool) : List α → List α → Bool
 | [],[] => true
 | a::as,b::bs => same a b && sameList same as bs
 | [],_::_ | _::_,[] => false
def successorResult : Except String Bool := do
 let a ← base
 let b ← successor
 return sameList MulticentreSupport.sameLabel (b.composition.take 2) a.composition &&
  sameList MulticentreSupport.sameLabel (b.attachment.take 2) a.attachment &&
  sameList (sameList sameCell) (b.orientation.take 2) a.orientation &&
  sameList (fun (x,y) (u,v) => x.value==u.value && y.value==v.value) (b.adjacency.take 1) a.adjacency &&
  b.composition.length==3
def passed : Except String Bool → Bool
 | .ok value => value
 | .error _ => false
def equivalenceWitness := passed equivalenceResult
def attachmentWitness := passed attachmentResult
def mirrorWitness := passed mirrorResult
def orientationWitness := passed orientationResult
def successorWitness := passed successorResult
'''
for n in ['equivalence','attachment','mirror','orientation','successor']:s+='theorem '+n+'Passed : '+n+'Witness = true := by decide\n'
s+='end SFT.Chemistry.CoordinationIsomerismWitnesses\n'
(w/'turn1064_recovery/SFT/Chemistry/CoordinationIsomerismWitnesses.lean').write_text(s)
