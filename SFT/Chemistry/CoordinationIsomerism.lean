import SFT.Chemistry.CoordinationGeometry
import SFT.Chemistry.MolecularGraphEnumeration
namespace SFT.Chemistry.CoordinationIsomerism
open SFT.Host SFT.Physics.CapabilityValues
open MolecularGraphEnumeration (permutations atIndex stringListLE newPosition)
-- Pinned V3 coordination_isomerism_law_v1.py; no selected occurrence map.
inductive Cell where
 | held (value : HeldLabel)
 | empty (identity : String := "empty-One")
structure Form where
 composition : List HeldLabel
 attachment : List HeldLabel
 orientation : List (List Cell)
 adjacency : List (PositiveCount × PositiveCount)
def emptyCell : Cell → Bool
 | .empty _ => true
 | .held _ => false
def validCell : Cell → Bool
 | .empty _ => true
 | .held h => Text.equal h.family "fold-orientation-fibre" &&
   (Text.equal h.label "fibre-one" || Text.equal h.label "fibre-two")
def normalizedPair (a b : Nat) : Nat × Nat := (min a b,max a b)
def samePair (a b : Nat × Nat) : Bool := a.1==b.1 && a.2==b.2
def distinctPairs (pairs : List (Nat × Nat)) : Bool :=
 (pairs.foldl (fun seen pair => if seen.any (samePair pair) then seen else seen++[pair]) []).length==pairs.length
def construct (composition attachment : List HeldLabel) (orientation : List (List Cell))
 (adjacency : List (PositiveCount × PositiveCount)) : Except String Form := do
 let width := composition.length
 if width<1 || attachment.length != width || orientation.length != width then
  throw "coordination form requires complete positive equal-width support"
 if !(composition.all fun h => Text.equal h.family "coordination-composition-label") then
  throw "coordination composition labels are invalid"
 if !(attachment.all fun h => Text.equal h.family "coordination-attachment-mode") then
  throw "coordination attachment labels are invalid"
 if orientation.any (fun word => word.length != 3 || word.all emptyCell) then
  throw "every occurrence requires one nonempty three-axis orientation word"
 if !(orientation.all fun word => word.all validCell) then
  throw "three axis positions admit only the two forced Fold fibre labels"
 if adjacency.any (fun (a,b) => a.value>width || b.value>width || a.value==b.value) then
  throw "coordination adjacency endpoint is outside the form"
 if !distinctPairs (adjacency.map fun (a,b) => normalizedPair a.value b.value) then
  throw "coordination adjacency pairs cannot duplicate"
 return ⟨composition,attachment,orientation,adjacency⟩
def cellText : Cell → String
 | .empty _ => "EmptyOne"
 | .held h => Text.intercalate ":" [h.family,h.label]
structure Vertex where
 composition : String
 attachment : String
 orientation : List String
structure Signature where
 vertices : List Vertex
 edges : List (Nat × Nat)
def vertexLE (a b : Vertex) : Bool :=
 stringListLE ([a.composition,a.attachment]++a.orientation) ([b.composition,b.attachment]++b.orientation)
def verticesLE : List Vertex → List Vertex → Bool
 | [],_ => true
 | _::_,[] => false
 | a::as,b::bs => if vertexLE a b && vertexLE b a then verticesLE as bs else vertexLE a b
def pairLE (a b : Nat × Nat) : Bool := if a.1==b.1 then a.2<=b.2 else a.1<=b.1
def insertPair (p : Nat × Nat) : List (Nat × Nat) → List (Nat × Nat)
 | [] => [p]
 | first::rest => if pairLE p first then p::first::rest else first::insertPair p rest
def sortPairs : List (Nat × Nat) → List (Nat × Nat)
 | [] => []
 | p::ps => insertPair p (sortPairs ps)
def edgesLE : List (Nat × Nat) → List (Nat × Nat) → Bool
 | [],_ => true
 | _::_,[] => false
 | a::as,b::bs => if samePair a b then edgesLE as bs else pairLE a b
def signatureLE (a b : Signature) : Bool :=
 if verticesLE a.vertices b.vertices && verticesLE b.vertices a.vertices then edgesLE a.edges b.edges
 else verticesLE a.vertices b.vertices
def sameSignature (a b : Signature) : Bool := signatureLE a b && signatureLE b a
def signatureFor (form : Form) (includeOrientation : Bool) (order : List Nat) : Except String Signature := do
 let vertices ← order.mapM fun old => do
  let comp ← match atIndex form.composition old with
   | some h => pure h.label
   | none => throw "tuple index out of range"
  let attach ← match atIndex form.attachment old with
   | some h => pure h.label
   | none => throw "tuple index out of range"
  let word ← if includeOrientation then do
   match atIndex form.orientation old with
   | some xs => pure (xs.map cellText)
   | none => throw "tuple index out of range"
   else pure []
  return Vertex.mk comp attach word
 let edges := sortPairs (form.adjacency.map fun (a,b) =>
  normalizedPair (newPosition (a.value-1) order) (newPosition (b.value-1) order))
 return ⟨vertices,edges⟩
def variants (form : Form) (includeOrientation : Bool := true) : Except String (List Signature) :=
 (permutations (List.range form.composition.length)).mapM (signatureFor form includeOrientation)
def canonical (form : Form) (includeOrientation : Bool := true) : Except String Signature := do
 match ← variants form includeOrientation with
 | [] => throw "min() arg is an empty sequence"
 | first::rest => return rest.foldl (fun best candidate => if signatureLE best candidate then best else candidate) first
def mirrorCell : Cell → Cell
 | .empty _ => .empty "empty-One"
 | .held h => if Text.equal h.label "fibre-one" then .held ⟨h.family,"fibre-two",h.familyHeld,by decide⟩
   else if Text.equal h.label "fibre-two" then .held ⟨h.family,"fibre-one",h.familyHeld,by decide⟩ else .held h
def mirror (form : Form) : Except String Form :=
 construct form.composition form.attachment (form.orientation.map fun word => word.map mirrorCell) form.adjacency
inductive Extension where
 | empty
 | endpoints (values : List PositiveCount)
def extend (form : Form) (composition attachment : HeldLabel) (word : List Cell)
 (prior : Extension) : Except String Form := do
 if !Text.equal composition.family "coordination-composition-label" then
  throw "coordination successor requires one composition label"
 if !Text.equal attachment.family "coordination-attachment-mode" then
  throw "coordination successor requires one attachment label"
 if word.length != 3 then throw "coordination successor requires one complete three-axis word"
 let width := form.composition.length
 let next : PositiveCount := ⟨width+1,Nat.zero_lt_succ width⟩
 let pairs : List (PositiveCount × PositiveCount) ← (match prior with
  | .empty => pure []
  | .endpoints values => do
   if values.any (fun p => p.value>width) then
    throw "successor adjacency must name only retained prior occurrences"
   let unique := values.foldl (fun seen p => if seen.any (fun q => q.value==p.value) then seen else seen++[p]) []
   if unique.length != values.length then throw "successor adjacency endpoints cannot duplicate"
   return values.map fun p => (p,next))
 construct (form.composition++[composition]) (form.attachment++[attachment])
  (form.orientation++[word]) (form.adjacency++pairs)
def insertText (s : String) : List String → List String
 | [] => [s]
 | first::rest => if Text.le s first then s::first::rest else first::insertText s rest
def sortText : List String → List String
 | [] => []
 | s::rest => insertText s (sortText rest)
def sameTexts (xs ys : List String) : Bool := stringListLE xs ys && stringListLE ys xs
structure Record where
 positiveOccurrenceCount : PositiveCount
 sameCompleteComposition : Bool
 exactEquivalence : Bool
 nativeDistinctionClass : HeldLabel
 leftSignature : Signature
 rightSignature : Signature
def forced (left right : Form) : Except String Record := do
 if left.composition.length != right.composition.length then
  throw "coordination isomer comparison requires equal positive width"
 if !sameTexts (sortText (left.composition.map HeldLabel.label)) (sortText (right.composition.map HeldLabel.label)) then
  throw "different composition is outside the isomer boundary"
 let a ← canonical left
 let b ← canonical right
 let equivalent := sameSignature a b
 let distinction ← if equivalent then pure "same-equivalence-class"
  else if !sameSignature (← canonical left false) (← canonical right false) then pure "attachment-class-distinction"
  else if sameSignature (← canonical (← mirror left)) b then pure "mirror-complement-class-distinction"
  else pure "orientation-adjacency-class-distinction"
 return ⟨← count left.composition.length,true,equivalent,← heldLabel "coordination-form-relation" distinction,a,b⟩
end SFT.Chemistry.CoordinationIsomerism

namespace SFT.Chemistry.CoordinationIsomerism
-- Bind the exhaustive source construction to its actual minimum operation.
theorem completeVariantMinimum (form : Form) (orientation : Bool)
 (first : Signature) (rest : List Signature)
 (enumerated : variants form orientation = .ok (first::rest)) :
 canonical form orientation = .ok
  (rest.foldl (fun best candidate => if signatureLE best candidate then best else candidate) first) := by
 unfold canonical
 rw [enumerated]
 rfl
-- EmptyOne identity is deliberately reset by V3's mirror operation.
theorem mirrorEmptyIdentity (identity : String) :
 mirrorCell (.empty identity) = .empty "empty-One" := rfl
-- Every generated variant uses the original complete occurrence permutation list.
theorem exhaustiveOccurrenceOrders (form : Form) (orientation : Bool) :
 variants form orientation =
  (MolecularGraphEnumeration.permutations (List.range form.composition.length)).mapM
   (signatureFor form orientation) := rfl
end SFT.Chemistry.CoordinationIsomerism
