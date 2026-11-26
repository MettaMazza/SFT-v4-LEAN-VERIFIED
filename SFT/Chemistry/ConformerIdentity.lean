import SFT.Chemistry.ConformerCarrier
import SFT.Foundation.CountTrace
import SFT.Host.SHA256Chunks
namespace SFT.Chemistry.ConformerIdentity
open SFT.Physics.CapabilityValues ConformerCarrier
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation
open MolecularGraphEnumeration (atIndex permutations permutationsAt selections)

-- itertools.permutations retains the input order as its identity candidate.
theorem identityPermutationGenerated (items : List Nat) : items∈permutations items := by
 change items∈permutationsAt items.length items
 induction items with
 | nil => exact List.Mem.head []
 | cons first rest ih =>
  change first::rest ∈ (selections (first::rest)).flatMap (fun pair =>
   (permutationsAt rest.length pair.2).map (List.cons pair.1))
  apply memFlatMap _ _ (first,rest) (first::rest) (List.Mem.head _)
  exact memMap (List.cons first) rest _ ih

private theorem indexAppendLeft {α : Type} (xs ys : List α) (i : Nat) (inside : i<xs.length) :
 atIndex (xs++ys) i=atIndex xs i := by
 induction xs generalizing i with
 | nil => cases inside
 | cons x xs ih =>
  cases i with
  | zero => rfl
  | succ i => exact ih i (Nat.lt_of_succ_lt_succ inside)
private theorem indexAtAppend {α : Type} (xs : List α) (x : α) :
 atIndex (xs++[x]) xs.length=some x := by
 induction xs with
 | nil => rfl
 | cons first rest ih => exact ih
private theorem indexMap {α β : Type} (f : α→β) (xs : List α) (i : Nat) :
 atIndex (xs.map f) i=(atIndex xs i).map f := by
 induction xs generalizing i with
 | nil => rfl
 | cons first rest ih => cases i with
   | zero => rfl
   | succ i => exact ih i
private theorem indexRange (n i : Nat) (inside : i<n) :
 atIndex (List.range n) i=some i := by
 induction n generalizing i with
 | zero => cases inside
 | succ n ih =>
  rw [SFT.Host.SHA256Chunks.rangeShift]
  cases i with
  | zero => rfl
  | succ i =>
   change atIndex ((List.range n).map Nat.succ) i=some (i+1)
   rw [indexMap,ih i (Nat.lt_of_succ_lt_succ inside)]
   rfl

private theorem positionEqual (a b : PositiveCount) (h : a.value=b.value) : a=b := by
 cases a; cases b; cases h; rfl

theorem identityPosition (size : Nat) (position : PositiveCount) (inside : position.value≤size) :
 ConformerCarrier.apply ⟨positions size⟩ position = .ok position := by
 have indexed : atIndex (positions size) (position.value-1)=some position := by
  unfold positions
  rw [indexMap,indexRange size (position.value-1) (Nat.lt_of_lt_of_le (Nat.sub_lt position.positive (Nat.zero_lt_succ 0)) inside)]
  have value : position.value-1+1=position.value := by
   cases h : position.value with
   | zero => have positive := position.positive; rw [h] at positive; cases positive
   | succ n => rfl
  have same : (⟨position.value-1+1,Nat.zero_lt_succ (position.value-1)⟩ : PositiveCount)=position := by
   exact positionEqual _ _ value
  exact congrArg some same
 unfold ConformerCarrier.apply
 rw [indexed]

-- A rotor's ordered site word is preserved pointwise by the identity candidate.
theorem identitySiteWord (size : Nat) (sites : List PositiveCount)
 (inside : ∀ site, site∈sites → site.value≤size) :
 sites.mapM (ConformerCarrier.apply ⟨positions size⟩) = .ok sites := by
 have loop (remaining acc : List PositiveCount)
  (within : ∀ site, site∈remaining → site.value≤size) :
  List.mapM.loop (m:=Except String) (ConformerCarrier.apply ⟨positions size⟩) remaining acc =
   .ok (List.reverseAux acc remaining) := by
  induction remaining generalizing acc with
  | nil =>
   rfl
  | cons first rest ih =>
   have firstEq := identityPosition size first (within first (List.Mem.head rest))
   change (do
    let value ← ConformerCarrier.apply ⟨positions size⟩ first
    List.mapM.loop (m:=Except String) (ConformerCarrier.apply ⟨positions size⟩) rest (value::acc)) =
     .ok (List.reverseAux acc (first::rest))
   rw [firstEq]
   change List.mapM.loop (m:=Except String) (ConformerCarrier.apply ⟨positions size⟩) rest (first::acc) = _
   exact ih (first::acc) (fun site member => within site (List.Mem.tail first member))
 exact loop sites [] inside

-- The same identity action retains the exact ordered-bond normalization.
theorem identityBond (size : Nat) (left right : PositiveCount)
 (leftInside : left.value≤size) (rightInside : right.value≤size) :
 (do
   let first ← ConformerCarrier.apply ⟨positions size⟩ left
   let second ← ConformerCarrier.apply ⟨positions size⟩ right
   orderedBond first second) = orderedBond left right := by
 rw [identityPosition size left leftInside,identityPosition size right rightInside]
 rfl
end SFT.Chemistry.ConformerIdentity
