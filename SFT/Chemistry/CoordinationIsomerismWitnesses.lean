import SFT.Chemistry.CoordinationIsomerism
namespace SFT.Chemistry.CoordinationIsomerismWitnesses
open SFT.Host SFT.Physics.CapabilityValues CoordinationIsomerism
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
def base : Except String Form := do
 construct [(← heldLabel "coordination-composition-label" "L"),(← heldLabel "coordination-composition-label" "L")]
  [(← heldLabel "coordination-attachment-mode" "mode-one"),(← heldLabel "coordination-attachment-mode" "mode-one")]
  [[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-one"),Cell.empty "empty-One",Cell.empty "empty-One"],[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-two"),Cell.empty "empty-One",Cell.empty "empty-One"]]
  [((← count 1),(← count 2))]
def chiral : Except String Form := do
 construct [(← heldLabel "coordination-composition-label" "A"),(← heldLabel "coordination-composition-label" "B"),(← heldLabel "coordination-composition-label" "C")]
  [(← heldLabel "coordination-attachment-mode" "mode-one"),(← heldLabel "coordination-attachment-mode" "mode-one"),(← heldLabel "coordination-attachment-mode" "mode-one")]
  [[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-one"),Cell.empty "empty-One",Cell.empty "empty-One"],[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-one"),Cell.held (← heldLabel "fold-orientation-fibre" "fibre-two"),Cell.empty "empty-One"],[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-two"),Cell.held (← heldLabel "fold-orientation-fibre" "fibre-one"),Cell.empty "empty-One"]]
  [((← count 1),(← count 2)),((← count 2),(← count 3)),((← count 3),(← count 1))]
def attachmentForm : Except String Form := do
 construct [(← heldLabel "coordination-composition-label" "L"),(← heldLabel "coordination-composition-label" "L")]
  [(← heldLabel "coordination-attachment-mode" "mode-one"),(← heldLabel "coordination-attachment-mode" "mode-two")]
  [[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-one"),Cell.empty "empty-One",Cell.empty "empty-One"],[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-two"),Cell.empty "empty-One",Cell.empty "empty-One"]]
  [((← count 1),(← count 2))]
def orientationForm : Except String Form := do
 construct [(← heldLabel "coordination-composition-label" "L"),(← heldLabel "coordination-composition-label" "L")]
  [(← heldLabel "coordination-attachment-mode" "mode-one"),(← heldLabel "coordination-attachment-mode" "mode-one")]
  [[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-one"),Cell.empty "empty-One",Cell.empty "empty-One"],[Cell.held (← heldLabel "fold-orientation-fibre" "fibre-one"),Cell.empty "empty-One",Cell.empty "empty-One"]]
  [((← count 1),(← count 2))]
def equivalenceResult : Except String Bool := do
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
theorem equivalencePassed : equivalenceWitness = true := by decide
theorem attachmentPassed : attachmentWitness = true := by decide
theorem mirrorPassed : mirrorWitness = true := by decide
theorem orientationPassed : orientationWitness = true := by decide
theorem successorPassed : successorWitness = true := by decide
end SFT.Chemistry.CoordinationIsomerismWitnesses
