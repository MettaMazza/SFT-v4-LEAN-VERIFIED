import SFT.Foundation.AssemblySupport
namespace SFT.Foundation.AssemblySets
open FoldAssembly AssemblySupport CommonRefinement Count.Representation

def distinctWords : List Word → List Word
  | [] => []
  | w :: ws => if containsWord w ws then distinctWords ws else w :: distinctWords ws

def sameWordSet (xs ys : List Word) : Bool :=
  everyWord (fun w => containsWord w ys) xs && everyWord (fun w => containsWord w xs) ys

theorem sameWordSetIff (xs ys : List Word) : sameWordSet xs ys = true ↔ ∀ w, w ∈ xs ↔ w ∈ ys := by
  constructor
  · intro h w
    have parts := (andTrue _ _).mp h
    exact ⟨fun hx => (containsWordIff _ _).mp ((everyWordIff _ _).mp parts.1 w hx),
      fun hy => (containsWordIff _ _).mp ((everyWordIff _ _).mp parts.2 w hy)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(everyWordIff _ _).mpr (fun w hw => (containsWordIff _ _).mpr ((h w).mp hw)),
      (everyWordIff _ _).mpr (fun w hw => (containsWordIff _ _).mpr ((h w).mpr hw))⟩

theorem distinctLengthBound (ws : List Word) : (distinctWords ws).length ≤ ws.length := by
  induction ws with
  | nil => exact Nat.le.refl
  | cons w ws ih =>
    cases h : containsWord w ws with
    | false =>
      change (if containsWord w ws then distinctWords ws else w :: distinctWords ws).length ≤ (w :: ws).length
      rw [h]
      exact Nat.succ_le_succ ih
    | true =>
      change (if containsWord w ws then distinctWords ws else w :: distinctWords ws).length ≤ (w :: ws).length
      rw [h]
      exact Nat.le.step ih

theorem distinctIdentityOfUnique (ws : List Word) (h : ws.Nodup) : distinctWords ws = ws := by
  induction ws with
  | nil => rfl
  | cons w ws ih =>
    cases h with
    | cons fresh tail =>
      have absent : containsWord w ws = false := by
        cases hm : containsWord w ws with
        | false => rfl
        | true => exact False.elim (fresh w ((containsWordIff _ _).mp hm) rfl)
      change (if containsWord w ws then distinctWords ws else w :: distinctWords ws) = w :: ws
      rw [absent]
      exact congrArg (List.cons w) (ih tail)

theorem equalDistinctLengthIffUnique (ws : List Word) : ws.length = (distinctWords ws).length ↔ ws.Nodup := by
  constructor
  · intro eq
    induction ws with
    | nil => exact List.Pairwise.nil
    | cons w ws ih =>
      cases hm : containsWord w ws with
      | true =>
        change (w :: ws).length = (if containsWord w ws then distinctWords ws else w :: distinctWords ws).length at eq
        rw [hm] at eq
        change Nat.succ ws.length = (distinctWords ws).length at eq
        have bound := distinctLengthBound ws
        rw [←eq] at bound
        exact False.elim (Nat.not_succ_le_self _ bound)
      | false =>
        change (w :: ws).length = (if containsWord w ws then distinctWords ws else w :: distinctWords ws).length at eq
        rw [hm] at eq
        change Nat.succ ws.length = Nat.succ (distinctWords ws).length at eq
        constructor
        · intro y hy same
          cases same
          have yes := (containsWordIff w ws).mpr hy
          exact Bool.noConfusion (hm.symm.trans yes)
        · exact ih (Nat.succ.inj eq)
  · intro h
    exact congrArg List.length (distinctIdentityOfUnique ws h).symm

def sourceUniquenessCheck (ws : List Word) : Bool := ws.length == (distinctWords ws).length

theorem sourceUniquenessIff (ws : List Word) : sourceUniquenessCheck ws = true ↔ ws.Nodup := by
  constructor
  · intro h
    exact (equalDistinctLengthIffUnique ws).mp (Nat.eq_of_beq_eq_true h)
  · intro h
    have eq := (equalDistinctLengthIffUnique ws).mpr h
    unfold sourceUniquenessCheck
    rw [eq]
    exact naturalEqualityReflexive _

theorem distinctMembershipIff (ws : List Word) (v : Word) : v ∈ distinctWords ws ↔ v ∈ ws := by
  induction ws with
  | nil => constructor <;> intro h <;> cases h
  | cons w ws ih =>
    change v ∈ (if containsWord w ws then distinctWords ws else w :: distinctWords ws) ↔ v ∈ w :: ws
    cases hm : containsWord w ws with
    | true =>
      constructor
      · intro h; exact List.Mem.tail _ (ih.mp h)
      · intro h
        cases h with
        | head => exact ih.mpr ((containsWordIff _ _).mp hm)
        | tail _ ht => exact ih.mpr ht
    | false =>
      constructor
      · intro h
        cases h with
        | head => exact List.Mem.head _
        | tail _ ht => exact List.Mem.tail _ (ih.mp ht)
      · intro h
        cases h with
        | head => exact List.Mem.head _
        | tail _ ht => exact List.Mem.tail _ (ih.mpr ht)

theorem distinctWordsUnique (ws : List Word) : (distinctWords ws).Nodup := by
  induction ws with
  | nil => exact List.Pairwise.nil
  | cons w ws ih =>
    change (if containsWord w ws then distinctWords ws else w :: distinctWords ws).Nodup
    cases hm : containsWord w ws with
    | true => exact ih
    | false =>
      constructor
      · intro y hy eq
        cases eq
        have member := (distinctMembershipIff ws w).mp hy
        have yes := (containsWordIff _ _).mpr member
        exact Bool.noConfusion (hm.symm.trans yes)
      · exact ih

end SFT.Foundation.AssemblySets
