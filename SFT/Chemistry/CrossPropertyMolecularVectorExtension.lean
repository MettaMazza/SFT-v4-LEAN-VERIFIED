import SFT.Chemistry.CrossPropertyMolecularVector
namespace SFT.Chemistry.CrossPropertyMolecularVectorExtension
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SFT.Chemistry.CrossPropertyMolecularVector
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- The following local steps discharge the original set-uniqueness guard;
-- no additional carrier, property or scientific premise is introduced.
private theorem natSame (n : Nat) : (n == n) = true := by
 exact decide_eq_true rfl
private theorem natSwap (a b : Nat) : (a == b) = (b == a) := by
 induction a generalizing b with
 | zero => cases b <;> rfl
 | succ a ih =>
  cases b with
  | zero => rfl
  | succ b => exact ih b
private theorem listSame (xs : List Nat) : (xs == xs) = true := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change ((x == x) && (xs == xs)) = true
  rw [natSame,ih]
  rfl
private theorem listSwap (xs ys : List Nat) : (xs == ys) = (ys == xs) := by
 induction xs generalizing ys with
 | nil => cases ys <;> rfl
 | cons x xs ih =>
  cases ys with
  | nil => rfl
  | cons y ys =>
   change ((x == y) && (xs == ys)) = ((y == x) && (ys == xs))
   rw [natSwap,ih]
private theorem labelSame (x : HeldLabel) : equalLabel x x = true := by
 unfold equalLabel Text.equal
 rw [listSame,listSame]
 rfl
private theorem labelSwap (x y : HeldLabel) : equalLabel x y = equalLabel y x := by
 unfold equalLabel Text.equal
 rw [listSwap (x.family.toUTF8.data.toList.map UInt8.toNat) (y.family.toUTF8.data.toList.map UInt8.toNat),
  listSwap (x.label.toUTF8.data.toList.map UInt8.toNat) (y.label.toUTF8.data.toList.map UInt8.toNat)]
private theorem absentAt (items : List Projection) (family : HeldLabel)
 (absent : (items.map Projection.propertyFamily).any (equalLabel family)=false)
 (item : Projection) (present : item ∈ items) : equalLabel family item.propertyFamily=false := by
 induction items with
 | nil => cases present
 | cons first rest ih =>
  change (equalLabel family first.propertyFamily ||
    (rest.map Projection.propertyFamily).any (equalLabel family))=false at absent
  have head : equalLabel family first.propertyFamily=false := by
   cases h : equalLabel family first.propertyFamily with
   | false => rfl
   | true => rw [h] at absent; cases absent
  have tail : (rest.map Projection.propertyFamily).any (equalLabel family)=false := by
   rw [head] at absent
   exact absent
  cases present with
  | head => exact head
  | tail _ member => exact ih tail member
private theorem matchingAbsent (items : List Projection) (family : HeldLabel)
 (absent : (items.map Projection.propertyFamily).any (equalLabel family)=false) :
 matching items family=[] := by
 induction items with
 | nil => rfl
 | cons first rest ih =>
  have head := absentAt (first::rest) family absent first (List.Mem.head _)
  have tail : (rest.map Projection.propertyFamily).any (equalLabel family)=false := by
   change (equalLabel family first.propertyFamily ||
     (rest.map Projection.propertyFamily).any (equalLabel family))=false at absent
   rw [head] at absent
   exact absent
  have reverse : equalLabel first.propertyFamily family=false := (labelSwap _ _).trans head
  dsimp only [matching]
  rw [reverse]
  exact ih tail
private theorem matchingUniqueMember (items : List Projection)
 (unique : distinctAtoms (items.map Projection.propertyFamily)=true)
 (item : Projection) (present : item ∈ items) : matching items item.propertyFamily=[item] := by
 induction items with
 | nil => cases present
 | cons first rest ih =>
  change (!(rest.map Projection.propertyFamily).any (equalLabel first.propertyFamily) &&
    distinctAtoms (rest.map Projection.propertyFamily))=true at unique
  have absent : (rest.map Projection.propertyFamily).any (equalLabel first.propertyFamily)=false := by
   cases h : (rest.map Projection.propertyFamily).any (equalLabel first.propertyFamily) with
   | false => rfl
   | true => rw [h] at unique; cases unique
  have remaining : distinctAtoms (rest.map Projection.propertyFamily)=true := by
   rw [absent] at unique
   exact unique
  cases present with
  | head =>
   dsimp only [matching]
   rw [labelSame]
   exact congrArg (List.cons item) (matchingAbsent rest item.propertyFamily absent)
  | tail _ member =>
   have different := absentAt rest first.propertyFamily absent item member
   dsimp only [matching]
   rw [different]
   exact ih remaining member
-- compose_exact_property_vector returns the supplied tuple after its exact
-- nonempty, duplicate-family and complete-support guards.
theorem acceptedComposition (carrier : CrossPropertyMolecularVector.Carrier) (items result : List Projection)
 (accepted : composeExactPropertyVector (.carrier carrier) (.tuple items)=.ok result) :
 result=items ∧ distinctAtoms (items.map Projection.propertyFamily)=true := by
 cases items with
 | nil => cases accepted
 | cons first rest =>
  change (if !distinctAtoms ((first::rest).map Projection.propertyFamily) then
    Except.error "a property family may occur only once in one exact vector"
   else if !sameSupport ((first::rest).map Projection.propertyFamily) carrier.applicablePropertyFamilies then
    Except.error "projection support differs from the carrier's complete applicable support"
   else Except.ok (first::rest))=.ok result at accepted
  split at accepted <;> try { cases accepted }
  rename_i unique
  split at accepted <;> try { cases accepted }
  have distinct : distinctAtoms ((first::rest).map Projection.propertyFamily)=true := by
   cases h : distinctAtoms ((first::rest).map Projection.propertyFamily) with
   | true => rfl
   | false => exact False.elim (unique (by rw [h]; rfl))
  exact ⟨(Except.ok.inj accepted).symm,distinct⟩
-- Every retained input record, not merely its numerical result, is the unique
-- named projection of the actual successful source composition.
theorem completeVectorProjectsEveryEntry (carrier : CrossPropertyMolecularVector.Carrier) (items result : List Projection)
 (accepted : composeExactPropertyVector (.carrier carrier) (.tuple items)=.ok result)
 (item : Projection) (present : item ∈ items) :
 projectExactProperty result (.held item.propertyFamily)=.ok item := by
 obtain ⟨same,unique⟩ := acceptedComposition carrier items result accepted
 subst result
 unfold projectExactProperty
 dsimp only
 rw [matchingUniqueMember items unique item present]
-- The extended carrier and tuple are precisely those supplied to composition
-- inside lawful_projection_extension_preserves_existing. Acceptance of that
-- operation supplies its original support and uniqueness checks.
theorem appendedCompositionPreservesEveryEntry (carrier : CrossPropertyMolecularVector.Carrier)
 (items : List Projection) (extension : Projection) (result : List Projection)
 (accepted : composeExactPropertyVector (.carrier carrier) (.tuple (items++[extension]))=.ok result)
 (item : Projection) (present : item ∈ items) :
 projectExactProperty result (.held item.propertyFamily)=.ok item := by
 have included : item ∈ items++[extension] := by
  clear accepted
  induction present with
  | head => exact List.Mem.head _
  | tail _ _ ih => exact List.Mem.tail _ ih
 exact completeVectorProjectsEveryEntry carrier (items++[extension]) result accepted item included
end SFT.Chemistry.CrossPropertyMolecularVectorExtension
