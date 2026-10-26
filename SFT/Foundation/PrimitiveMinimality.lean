import SFT.Foundation.PrimitiveSquare
namespace SFT.Foundation.PrimitiveMaps
open ExactPartCarrier

def iterateWord (word : List Primitive) : Nat → Part → Part
  | 0, value => value
  | n+1, value => iterateWord word n (applyWord word value)

def WordGenerates (word : List Primitive) : Prop :=
  (∃ left right : Part, left ≠ right ∧ applyWord word left = applyWord word right) ∧
  ∃ n : Nat, ∃ value : Part, iterateWord word (n+1) value = value ∧ applyWord word value ≠ value

def LeastGenerator (word : List Primitive) : Prop :=
  WordGenerates word ∧ word ≠ [] ∧
  ∀ other, WordGenerates other → other ≠ [] → word.length ≤ other.length

theorem singletonIteration (p : Primitive) (n : Nat) (value : Part) :
    iterateWord [p] n value = applyWord (List.replicate n p) value := by
  induction n generalizing value with
  | zero => rfl
  | succ n ih => exact ih (applyPrimitive p value)

theorem constantIterationsFixOne (n : Nat) :
    applyWord (List.replicate n Primitive.constantOne) one = one := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih

theorem positiveConstantIterate (n : Nat) (value : Part) :
    iterateWord [.constantOne] (n+1) value = one := by
  rw [singletonIteration]
  exact constantIterationsFixOne n

theorem foldGenerates : WordGenerates [.fold] := by
  constructor
  · exact foldNoninjective
  · exact ⟨1,FoldDynamics.third,foldNonstaticReturn,foldCycleNonstatic⟩

theorem singletonGeneratorIffFold (p : Primitive) : WordGenerates [p] ↔ p = .fold := by
  constructor
  · intro h
    cases p with
    | identity =>
      obtain ⟨a,b,ne,eq⟩ := h.1
      exact False.elim (ne (identityInjective a b eq))
    | square =>
      obtain ⟨a,b,ne,eq⟩ := h.1
      exact False.elim (ne (squareInjective a b eq))
    | constantOne =>
      obtain ⟨n,value,returned,nonstatic⟩ := h.2
      rw [positiveConstantIterate] at returned
      cases returned
      exact False.elim (nonstatic rfl)
    | fold => rfl
  · intro eq
    cases eq
    exact foldGenerates

theorem nonemptyWordPositive (word : List Primitive) (h : word ≠ []) : 0 < word.length := by
  cases word with
  | nil => exact False.elim (h rfl)
  | cons p ps => exact Nat.zero_lt_succ _

theorem foldLeastGenerator : LeastGenerator [.fold] := by
  refine ⟨foldGenerates,?_,?_⟩
  · intro eq; cases eq
  · intro other _ nonempty
    exact nonemptyWordPositive other nonempty

theorem leastGeneratorUnique (word : List Primitive) (h : LeastGenerator word) : word = [.fold] := by
  have bound := h.2.2 [.fold] foldGenerates (by intro eq; cases eq)
  cases word with
  | nil => exact False.elim (h.2.1 rfl)
  | cons p ps =>
    cases ps with
    | nil =>
      have eq := (singletonGeneratorIffFold p).mp h.1
      cases eq
      rfl
    | cons q qs =>
      have impossible : 2 ≤ 1 := Nat.le_trans (Nat.le_add_left 2 qs.length) bound
      exact False.elim (Nat.not_succ_le_zero 0 (Nat.le_of_succ_le_succ impossible))

theorem leastGeneratorIff (word : List Primitive) : LeastGenerator word ↔ word = [.fold] := by
  constructor
  · exact leastGeneratorUnique word
  · intro eq; cases eq; exact foldLeastGenerator

theorem everyLargerWordNonminimal (word : List Primitive) (later : 1 < word.length) : ¬ LeastGenerator word := by
  intro least
  have bound := least.2.2 [.fold] foldGenerates (by intro eq; cases eq)
  exact Nat.not_lt_of_ge bound later

theorem appendPrimitiveIncreasesSize (word : List Primitive) (p : Primitive) :
    (word ++ [p]).length = word.length + 1 := by
  induction word with
  | nil => rfl
  | cons a rest ih => exact congrArg Nat.succ ih

theorem successorPreservesNonminimality (word : List Primitive) (p : Primitive)
    (later : 1 < word.length) : ¬ LeastGenerator (word ++ [p]) := by
  apply everyLargerWordNonminimal
  rw [appendPrimitiveIncreasesSize]
  exact Nat.lt_trans later (Nat.lt_succ_self _)

end SFT.Foundation.PrimitiveMaps
