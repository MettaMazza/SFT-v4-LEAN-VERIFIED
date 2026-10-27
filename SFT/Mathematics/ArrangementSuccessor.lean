import SFT.Mathematics.ArrangementCompleteness
namespace SFT.Mathematics.CombinatorialArrangements
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem remainderAppend (left right : List String) (held : String) :
    remainder (left ++ right) held = remainder left held ++ remainder right held := by
  induction left with
  | nil => rfl
  | cons x xs ih =>
    change (if x = held then remainder (xs ++ right) held else x :: remainder (xs ++ right) held) =
      (if x = held then remainder xs held else x :: remainder xs held) ++ remainder right held
    by_cases eq : x = held
    · rw [ite_eq_left eq,ite_eq_left eq,ih]
    · rw [ite_eq_right eq,ite_eq_right eq,ih]; rfl

theorem freshSuccessorRemainder (items : List String) (fresh : String)
    (absent : ¬ fresh ∈ items) : remainder (items ++ [fresh]) fresh = items := by
  rw [remainderAppend,remainderAbsentPreserved items fresh absent]
  change items ++ (if fresh = fresh then [] else [fresh]) = items
  rw [ite_eq_left rfl]
  have appendEmpty : ∀ xs : List String, xs ++ [] = xs := by
    intro xs
    induction xs with
    | nil => rfl
    | cons x xs ih => exact congrArg (List.cons x) ih
  exact appendEmpty items

theorem splitAtMember (items : List String) (held : String) (member : held ∈ items) :
    ∃ before after, items = before ++ held :: after := by
  induction member with
  | head tail => exact ⟨[],tail,rfl⟩
  | tail x h ih =>
    obtain ⟨before,after,eq⟩ := ih
    exact ⟨x::before,after,congrArg (List.cons x) eq⟩

theorem insertionPermutation (before after : List String) (fresh : String) :
    List.Perm (before ++ fresh :: after) (fresh :: (before ++ after)) := by
  induction before with
  | nil => exact List.Perm.refl _
  | cons x xs ih =>
    exact (List.Perm.cons x ih).trans (List.Perm.swap fresh x _)

theorem freshArrangementPartition (items form : List String) (fresh : String)
    (nonempty : items ≠ []) (unique : distinct items = true) (absent : ¬ fresh ∈ items) :
    form ∈ arrangementsCore (items ++ [fresh]) ↔
      ∃ before after, before ++ after ∈ arrangementsCore items ∧ form = before ++ fresh :: after := by
  have successorUnique := freshAppendDistinct items fresh unique ((absentIff items fresh).mpr absent)
  have freshMember : fresh ∈ items ++ [fresh] := memAppendRight fresh items [fresh] (List.Mem.head _)
  constructor
  · intro generated
    have permutation := everyArrangementPermutesCarrier _ successorUnique form generated
    have member := permutationMember permutation.symm fresh freshMember
    obtain ⟨before,after,eq⟩ := splitAtMember form fresh member
    have moved : List.Perm (fresh :: (before ++ after)) (items ++ [fresh]) := by
      rw [eq] at permutation
      exact (insertionPermutation before after fresh).symm.trans permutation
    have prior := suffixPermutesRemainder fresh (before ++ after) _ successorUnique moved
    rw [freshSuccessorRemainder items fresh absent] at prior
    exact ⟨before,after,everyPermutationGenerated items nonempty unique _ prior,eq⟩
  · intro h
    obtain ⟨before,after,prior,eq⟩ := h
    have p := everyArrangementPermutesCarrier items unique _ prior
    have carrier := remainderPermutation (items ++ [fresh]) fresh successorUnique freshMember
    rw [freshSuccessorRemainder items fresh absent] at carrier
    have result := (insertionPermutation before after fresh).trans
      ((List.Perm.cons fresh p).trans carrier.symm)
    rw [eq]
    apply everyPermutationGenerated _ _ successorUnique _ result
    intro empty
    rw [empty] at freshMember
    cases freshMember

theorem priorArrangementExcludesFresh (items form : List String) (fresh : String)
    (unique : distinct items = true) (absent : ¬ fresh ∈ items)
    (generated : form ∈ arrangementsCore items) : ¬ fresh ∈ form :=
  fun member => absent (permutationMember
    (everyArrangementPermutesCarrier items unique form generated) fresh member)

theorem insertionPositionUnique (left right otherLeft otherRight : List String) (fresh : String)
    (absentLeft : ¬ fresh ∈ left) (absentOther : ¬ fresh ∈ otherLeft)
    (same : left ++ fresh :: right = otherLeft ++ fresh :: otherRight) :
    left = otherLeft ∧ right = otherRight := by
  induction left generalizing otherLeft with
  | nil =>
    cases otherLeft with
    | nil => exact ⟨rfl,(List.cons.inj same).2⟩
    | cons x xs =>
      have eq : fresh = x := (List.cons.inj same).1
      cases eq
      exact False.elim (absentOther (List.Mem.head _))
  | cons x xs ih =>
    cases otherLeft with
    | nil =>
      have eq : x = fresh := (List.cons.inj same).1
      cases eq
      exact False.elim (absentLeft (List.Mem.head _))
    | cons y ys =>
      have parts := List.cons.inj same
      cases parts.1
      have smaller := ih ys (fun h => absentLeft (List.Mem.tail _ h))
        (fun h => absentOther (List.Mem.tail _ h)) parts.2
      exact ⟨congrArg (List.cons x) smaller.1,smaller.2⟩

theorem freshArrangementUniqueProvenance (items form : List String) (fresh : String)
    (nonempty : items ≠ []) (unique : distinct items = true) (absent : ¬ fresh ∈ items)
    (generated : form ∈ arrangementsCore (items ++ [fresh])) :
    ∃ before after, before ++ after ∈ arrangementsCore items ∧
      form = before ++ fresh :: after ∧
      ∀ otherBefore otherAfter,
        otherBefore ++ otherAfter ∈ arrangementsCore items →
        form = otherBefore ++ fresh :: otherAfter →
        before = otherBefore ∧ after = otherAfter := by
  obtain ⟨before,after,prior,eq⟩ :=
    (freshArrangementPartition items form fresh nonempty unique absent).mp generated
  refine ⟨before,after,prior,eq,?_⟩
  intro otherBefore otherAfter otherPrior otherEq
  have noFresh := priorArrangementExcludesFresh items (before ++ after) fresh unique absent prior
  have noOther := priorArrangementExcludesFresh items (otherBefore ++ otherAfter) fresh unique absent otherPrior
  exact insertionPositionUnique before after otherBefore otherAfter fresh
    (fun h => noFresh (memAppendLeft fresh before after h))
    (fun h => noOther (memAppendLeft fresh otherBefore otherAfter h))
    (eq.symm.trans otherEq)

end SFT.Mathematics.CombinatorialArrangements
