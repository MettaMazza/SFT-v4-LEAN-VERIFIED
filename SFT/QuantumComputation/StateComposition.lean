import SFT.QuantumComputation.InformationUnit
import SFT.QuantumComputation.ReversibleComposition
namespace SFT.QuantumComputation.StateComposition
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleComposition
open SFT.Foundation.Count.TraceDerivation

theorem pairRowsMembership (cycle : List String) (left : Word × String)
    (right result : List (Word × String)) (accepted : pairWith cycle left right = some result)
    (row : Word × String) : row ∈ result ↔
      ∃ source, source ∈ right ∧ jointBranch cycle left source = some row := by
  induction right generalizing result with
  | nil => cases Option.some.inj accepted; constructor
           · intro h; cases h
           · intro ⟨source,h,_⟩; cases h
  | cons first rest ih =>
    unfold pairWith at accepted
    cases generated : jointBranch cycle left first with
    | none => rw [generated] at accepted; cases accepted
    | some cell =>
      rw [generated] at accepted
      cases tail : pairWith cycle left rest with
      | none => rw [tail] at accepted; cases accepted
      | some rows =>
        rw [tail] at accepted
        cases Option.some.inj accepted
        constructor
        · intro member
          cases member with
          | head => exact ⟨first,.head _,generated⟩
          | tail _ held =>
            obtain ⟨source,member,image⟩ := (ih rows tail).mp held
            exact ⟨source,.tail _ member,image⟩
        · intro ⟨source,member,image⟩
          cases member with
          | head =>
            have same := Option.some.inj (generated.symm.trans image)
            cases same; exact .head _
          | tail _ held => exact .tail _ ((ih rows tail).mpr ⟨source,held,image⟩)

theorem jointRowsMembership (cycle : List String) (left right result : List (Word × String))
    (accepted : jointBranches cycle left right = some result) (row : Word × String) :
    row ∈ result ↔ ∃ l, l ∈ left ∧ ∃ r, r ∈ right ∧ jointBranch cycle l r = some row := by
  induction left generalizing result with
  | nil => cases Option.some.inj accepted; constructor
           · intro h; cases h
           · intro ⟨l,h,_⟩; cases h
  | cons first rest ih =>
    unfold jointBranches at accepted
    cases generated : pairWith cycle first right with
    | none => rw [generated] at accepted; cases accepted
    | some cells =>
      rw [generated] at accepted
      cases tail : jointBranches cycle rest right with
      | none => rw [tail] at accepted; cases accepted
      | some rows =>
        rw [tail] at accepted
        cases Option.some.inj accepted
        constructor
        · intro member
          cases memAppendCases row cells rows member with
          | inl held => exact ⟨first,.head _,(pairRowsMembership _ _ _ _ generated row).mp held⟩
          | inr held =>
            obtain ⟨l,member,r,bound,image⟩ := (ih rows tail).mp held
            exact ⟨l,.tail _ member,r,bound,image⟩
        · intro ⟨l,member,r,bound,image⟩
          cases member with
          | head => exact memAppendLeft _ _ _ ((pairRowsMembership _ _ _ _ generated row).mpr ⟨r,bound,image⟩)
          | tail _ held => exact memAppendRight _ _ _ ((ih rows tail).mpr ⟨l,held,r,bound,image⟩)
def Cell (left right : State) (l r row : Word × String) : Prop :=
  l ∈ left.branches ∧ r ∈ right.branches ∧ jointBranch left.phaseCycle l r = some row

theorem compositionRowsExactly (left right result : State) (accepted : compose left right = .ok result)
    (row : Word × String) : row ∈ result.branches ↔ ∃ l r, Cell left right l r row := by
  have exactRows := jointRowsMembership _ _ _ _ (compositionSource left right result accepted).2.2.1 row
  constructor
  · intro h
    obtain ⟨l,hl,r,hr,generated⟩ := exactRows.mp h
    exact ⟨l,r,hl,hr,generated⟩
  · intro ⟨l,r,hl,hr,generated⟩
    exact exactRows.mpr ⟨l,hl,r,hr,generated⟩

theorem everyPairCell (left right result : State)
    (leftAdmitted : makeState left.branches left.phaseCycle = .ok left)
    (rightAdmitted : makeState right.branches right.phaseCycle = .ok right)
    (accepted : compose left right = .ok result)
    (l r : Word × String) (hl : l ∈ left.branches) (hr : r ∈ right.branches) :
    ∃ row, row ∈ result.branches ∧ Cell left right l r row := by
  have source := compositionSource left right result accepted
  have positive := Nat.lt_of_lt_of_le (by decide : 0 < 2) (admittedPhaseCycle left leftAdmitted).2.2
  have rp : r.2 ∈ left.phaseCycle := source.1.symm ▸ admittedPhaseMember right rightAdmitted r hr
  obtain ⟨row,generated,_⟩ := jointBranchExists left.phaseCycle positive l r
    (admittedPhaseMember left leftAdmitted l hl) rp
  exact ⟨row,(compositionRowsExactly _ _ _ accepted row).mpr ⟨l,r,hl,hr,generated⟩,hl,hr,generated⟩

theorem leftMarginalExactly (left right result : State)
    (leftAdmitted : makeState left.branches left.phaseCycle = .ok left)
    (rightAdmitted : makeState right.branches right.phaseCycle = .ok right)
    (accepted : compose left right = .ok result) (l : Word × String) :
    l ∈ left.branches ↔ ∃ r row, row ∈ result.branches ∧ Cell left right l r row := by
  constructor
  · intro hl
    have nonempty := (admittedPhaseCycle right rightAdmitted).1
    cases branches : right.branches with
    | nil => rw [branches] at nonempty; cases nonempty
    | cons first rest =>
      have hr : first ∈ right.branches := branches ▸ List.Mem.head rest
      obtain ⟨row,member,cell⟩ := everyPairCell left right result leftAdmitted rightAdmitted accepted l first hl hr
      exact ⟨first,row,member,cell⟩
  · intro ⟨r,row,_,cell⟩; exact cell.1

theorem rightMarginalExactly (left right result : State)
    (leftAdmitted : makeState left.branches left.phaseCycle = .ok left)
    (rightAdmitted : makeState right.branches right.phaseCycle = .ok right)
    (accepted : compose left right = .ok result) (r : Word × String) :
    r ∈ right.branches ↔ ∃ l row, row ∈ result.branches ∧ Cell left right l r row := by
  constructor
  · intro hr
    have nonempty := (admittedPhaseCycle left leftAdmitted).1
    cases branches : left.branches with
    | nil => rw [branches] at nonempty; cases nonempty
    | cons first rest =>
      have hl : first ∈ left.branches := branches ▸ List.Mem.head rest
      obtain ⟨row,member,cell⟩ := everyPairCell left right result leftAdmitted rightAdmitted accepted first r hl hr
      exact ⟨first,row,member,cell⟩
  · intro ⟨l,row,_,cell⟩; exact cell.2.1

theorem exactComponentWordAndPhase (left right : State) (l r row : Word × String)
    (cell : Cell left right l r row) : row.1 = l.1 ++ ["joint"] ++ r.1 ∧
    ∃ li ri, phaseIndex l.2 left.phaseCycle = some li ∧ phaseIndex r.2 left.phaseCycle = some ri ∧
      labelAt left.phaseCycle ((li+ri)%left.phaseCycle.length) = some row.2 :=
  jointBranchMeaning left.phaseCycle l r row cell.2.2

open SFT.Mathematics.DiscreteObjects SFT.QuantumComputation.ReversibleObservation

theorem allFalseWitness {α : Type} (predicate : α → Bool) (items : List α)
    (failed : items.all predicate = false) : ∃ item, item ∈ items ∧ predicate item = false := by
  induction items with
  | nil => cases failed
  | cons first rest ih =>
    cases checked : predicate first with
    | false => exact ⟨first,.head _,checked⟩
    | true =>
      rw [List.all_cons,checked] at failed
      obtain ⟨item,member,failed⟩ := ih failed
      exact ⟨item,.tail _ member,failed⟩

theorem correlatedMissingCell (joint : List (String × String))
    (nonempty : joint.isEmpty = false) (unique : distinct joint = true) :
    isFactorable joint = .ok false ↔
      ∃ left, left ∈ joint ∧ ∃ right, right ∈ joint ∧ (left.1,right.2) ∉ joint := by
  unfold isFactorable
  rw [nonempty,unique]
  change Except.ok (joint.all (fun left => joint.all (fun right => has joint (left.1,right.2)))) =
    (Except.ok false : Except String Bool) ↔ _
  constructor
  · intro failed
    obtain ⟨left,leftHeld,leftFailed⟩ := allFalseWitness _ joint (Except.ok.inj failed)
    obtain ⟨right,rightHeld,missing⟩ := allFalseWitness _ joint leftFailed
    refine ⟨left,leftHeld,right,rightHeld,?_⟩
    intro member
    have existsTrue := (hasIff joint (left.1,right.2)).mpr member
    rw [missing] at existsTrue
    cases existsTrue
  · intro ⟨left,leftHeld,right,rightHeld,missing⟩
    cases checked : joint.all (fun left => joint.all (fun right => has joint (left.1,right.2))) with
    | false => rfl
    | true => exact False.elim (missing ((factorClosure joint).mp checked left leftHeld right rightHeld))

end SFT.QuantumComputation.StateComposition
