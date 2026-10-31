import SFT.Physics.WaveSpeedRelation
import SFT.Mathematics.ExactTraceDistribution
namespace SFT.Physics.WaveSuperposition

-- Distinct branch tags retain full original records even when values coincide.
def junction {A B : Type} (left : List A) (right : List B) : List (Sum A B) :=
  left.map Sum.inl ++ right.map Sum.inr

def leftProjection {A B : Type} : List (Sum A B) → List A
  | [] => []
  | .inl a :: rest => a :: leftProjection rest
  | .inr _ :: rest => leftProjection rest

def rightProjection {A B : Type} : List (Sum A B) → List B
  | [] => []
  | .inl _ :: rest => rightProjection rest
  | .inr b :: rest => b :: rightProjection rest

theorem leftMap {A B : Type} (xs : List A) (rest : List (Sum A B)) :
    leftProjection (xs.map Sum.inl ++ rest) = xs ++ leftProjection rest := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih

theorem leftIgnoresRight {A B : Type} (ys : List B) :
    leftProjection (ys.map (Sum.inr : B → Sum A B)) = [] := by
  induction ys with
  | nil => rfl
  | cons y ys ih => exact ih

theorem rightMap {A B : Type} (ys : List B) :
    rightProjection (ys.map (Sum.inr : B → Sum A B)) = ys := by
  induction ys with
  | nil => rfl
  | cons y ys ih => exact congrArg (List.cons y) ih

theorem rightIgnoresLeft {A B : Type} (xs : List A) (rest : List (Sum A B)) :
    rightProjection (xs.map Sum.inl ++ rest) = rightProjection rest := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact ih

theorem recoversLeft {A B : Type} (xs : List A) (ys : List B) : leftProjection (junction xs ys) = xs := by
  unfold junction
  rw [leftMap,leftIgnoresRight,MechanicalAngularMotion.appendNil]

theorem recoversRight {A B : Type} (xs : List A) (ys : List B) : rightProjection (junction xs ys) = ys := by
  unfold junction
  rw [rightIgnoresLeft,rightMap]

theorem noBranchCollision {A B : Type} (a : A) (b : B) : (Sum.inl a : Sum A B) ≠ Sum.inr b := by
  intro h; cases h

theorem leftInjective {A B : Type} (a b : A) (h : (Sum.inl a : Sum A B) = Sum.inl b) : a = b := by
  cases h; rfl

theorem rightInjective {A B : Type} (a b : B) (h : (Sum.inr a : Sum A B) = Sum.inr b) : a = b := by
  cases h; rfl

theorem completeCount {A B : Type} (xs : List A) (ys : List B) :
    (junction xs ys).length = xs.length + ys.length := by
  have lengthMap {C D : Type} (f : C → D) (zs : List C) : (zs.map f).length = zs.length := by
    induction zs with
    | nil => rfl
    | cons z zs ih => exact congrArg Nat.succ ih
  unfold junction
  rw [MechanicalAngularMotion.appendLength,lengthMap,lengthMap]

theorem completeReconstruction {A B : Type} (a c : List A) (b d : List B)
    (h : junction a b = junction c d) : a = c ∧ b = d := by
  have l := congrArg leftProjection h
  have r := congrArg rightProjection h
  rw [recoversLeft,recoversLeft] at l
  rw [recoversRight,recoversRight] at r
  exact ⟨l,r⟩
end SFT.Physics.WaveSuperposition
