from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_rearrangement1504/sft/chemistry').resolve()));from sft.chemistry import rearrangement_reaction_law_v1 as v
q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Chemistry.Rearrangement
namespace SFT.Chemistry.RearrangementWitnesses
open SFT.Physics.CapabilityValues SFT.Host AdditionCarrier AdditionGraph Rearrangement
set_option maxRecDepth 20000
set_option maxHeartbeats 0
'''
def atom(a):return '(← atom '+q(a.label)+')'
def support(h):return '(← support '+q(h.label)+')'
def state(x):
 atoms='['+','.join(atom(a)for a in x.atoms)+']';bonds='['+','.join('(← bond '+atom(b.left)+' '+atom(b.right)+' '+support(b.held_support)+')'for b in x.bonds)+']'
 assert not x.free_supports
 return '(← state (← heldLabel "addition-state" '+q(x.identity.label)+') '+atoms+' '+bonds+' [])'
for name,fn in [('singleMove',v._single_move),('threeMoves',v._three_moves),('degenerate',v._degenerate)]:
 result=fn();s+='def '+name+' : Except String Result := do\n transform (← heldLabel "registered-reaction" '+q(result.reaction_identity.label)+') '+state(result.source)+' '+state(result.terminal)+'\n'
s+='''def witnesses : Except String (List Bool) := do
 let single ← singleMove
 let multi ← threeMoves
 let degenerate ← degenerate
 let unchangedRejected := match transform single.reactionIdentity single.source single.source with
  | .error _ => true
  | .ok _ => false
 let compositionRejected := match (do
  let shortened ← state (← heldLabel "addition-state" "shortened")
   (single.source.atoms.take (single.source.atoms.length-1)) (single.source.bonds.take (single.source.bonds.length-1)) []
  transform single.reactionIdentity single.source shortened) with
  | .error _ => true
  | .ok _ => false
 let alternatives ← match single.candidateTargetIncidences with
  | [] => throw "tuple index out of range"
  | row::_ => pure row.2
 let anchor ← match single.source.atoms with
  | [] => throw "tuple index out of range"
  | a::_ => pure a
 let successor ← extend single anchor (← atom "rearr-successor-atom") (← support "rearr-successor-support")
 let firstFormed ← match single.formedIncidences with
  | [] => throw "tuple index out of range"
  | e::_ => pure e
 return [(connectedComponents single.source).length == (connectedComponents single.terminal).length && (connectedComponents single.terminal).length == 1,
  AdditionTransform.sameLabels single.source.atoms single.terminal.atoms && AdditionTransform.sameSupport (supports single.source) (supports single.terminal),
  single.movedSupportCount.value == 1 && !sameIncidences single.brokenIncidences single.formedIncidences,
  multi.movedSupportCount.value == 3,
  alternatives.length == 5 && alternatives.any (NucleophilicCarrier.sameEdge firstFormed),
  single.pathClasses.length == 2 && ((single.pathClasses.map HeldLabel.label).zip ["direct-held-support-relocation","opened-support-then-exact-reclosure"]).all (fun (a,b) => Text.equal a b),
  degenerate.constitutionallyDegenerate && degenerate.movedSupportCount.value == 3,
  ← reverseReconstruction multi,unchangedRejected,compositionRejected,successor]
end SFT.Chemistry.RearrangementWitnesses
'''
(w/'turn1064_recovery/SFT/Chemistry/RearrangementWitnesses.lean').write_text(s)
print('Translated three original example constructors and11witnesses')
