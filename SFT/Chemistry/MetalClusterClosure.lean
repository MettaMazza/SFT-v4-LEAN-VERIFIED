import SFT.Chemistry.MulticentreDerivation
import SFT.Chemistry.InorganicColourDerivation
namespace SFT.Chemistry.MetalClusterClosure
open SFT.Chemistry.MulticentreSupport SFT.Physics.CapabilityValues
-- Proof-only measure: occurrences of relation endpoints not yet reached.
def missing (support xs : List HeldLabel) : Nat := match support with
 | [] => 0
 | u::us => (if contains xs u then 0 else 1) + missing us xs

theorem containsAppend (xs ys : List HeldLabel) (x : HeldLabel) :
 contains (xs++ys) x = (contains xs x || contains ys x) := by
 induction xs with
 | nil => rfl
 | cons a xs ih =>
  change (sameLabel x a || contains (xs++ys) x) = ((sameLabel x a || contains xs x) || contains ys x)
  rw [ih]
  cases sameLabel x a <;> cases contains xs x <;> rfl

theorem appendPreserves (xs ys : List HeldLabel) (x : HeldLabel)
 (h : contains xs x=true) : contains (xs++ys) x=true := by
 rw [containsAppend,h]; rfl

theorem missingMonotone (u xs ys : List HeldLabel)
 (preserves : ∀ x, contains xs x=true → contains ys x=true) : missing u ys ≤ missing u xs := by
 induction u with
 | nil => exact Nat.le_refl 0
 | cons a u ih =>
  unfold missing
  cases hx : contains xs a with
  | false =>
   cases hy : contains ys a with
   | false => exact Nat.add_le_add_left ih 1
   | true =>
    change 0 + missing u ys ≤ 1 + missing u xs
    rw [Nat.zero_add]
    exact Nat.le_trans ih (Nat.le_add_left _ _)
  | true =>
   rw [preserves a hx]
   exact Nat.add_le_add_left ih 0

theorem missingStrict (u xs ys : List HeldLabel) (x : HeldLabel)
 (member : x ∈ u) (absent : contains xs x=false) (present : contains ys x=true)
 (preserves : ∀ a, contains xs a=true → contains ys a=true) : missing u ys < missing u xs := by
 induction u with
 | nil => cases member
 | cons a u ih =>
  cases member with
  | head =>
   unfold missing
   rw [absent,present]
   change 0 + missing u ys < 1 + missing u xs
   rw [Nat.zero_add,Nat.one_add]
   exact Nat.lt_succ_of_le (missingMonotone u xs ys preserves)
  | tail _ hm =>
   have h := ih hm
   unfold missing
   cases hx : contains xs a with
   | false =>
    cases hy : contains ys a with
    | false => exact Nat.add_lt_add_left h 1
    | true =>
     change 0 + missing u ys < 1 + missing u xs
     rw [Nat.zero_add,Nat.one_add]
     exact Nat.lt_succ_of_lt h
   | true =>
    rw [preserves a hx]
    exact Nat.add_lt_add_left h 0

def Progress (u xs ys : List HeldLabel) : Prop := ys=xs ∨ missing u ys < missing u xs

theorem progressTrans (u xs ys zs : List HeldLabel)
 (first : Progress u xs ys) (second : Progress u ys zs) : Progress u xs zs := by
 cases first with
 | inl same => cases same; exact second
 | inr small =>
  cases second with
  | inl same => cases same; exact Or.inr small
  | inr smaller => exact Or.inr (Nat.lt_trans smaller small)

theorem addProgress (u xs : List HeldLabel) (x : HeldLabel) (member : x ∈ u) :
 Progress u xs (addReached xs x) := by
 unfold addReached
 cases hx : contains xs x with
 | true => exact Or.inl rfl
 | false =>
  apply Or.inr
  apply missingStrict u xs (xs++[x]) x member hx
  · rw [containsAppend]
    have self : sameLabel x x=true := InorganicColourDerivation.sameLabelSelf x
    change (contains xs x || (sameLabel x x || false))=true
    rw [self]; cases contains xs x <;> rfl
  · exact appendPreserves xs [x]

theorem scanProgress (u : List HeldLabel) (es : List Edge) (xs : List HeldLabel)
 (covered : ∀ e, e ∈ es → e.left ∈ u ∧ e.right ∈ u) : Progress u xs (scanEdges es xs) := by
 induction es generalizing xs with
 | nil => exact Or.inl rfl
 | cons e es ih =>
  have endpoints := covered e (List.Mem.head es)
  have tail : ∀ f, f ∈ es → f.left ∈ u ∧ f.right ∈ u := fun f h => covered f (List.Mem.tail e h)
  change Progress u xs (scanEdges es (if contains xs e.left || contains xs e.right then addReached (addReached xs e.left) e.right else xs))
  cases incident : (contains xs e.left || contains xs e.right) with
  | false => exact ih xs tail
  | true =>
   exact progressTrans u xs _ _ (progressTrans u xs _ _
    (addProgress u xs e.left endpoints.1) (addProgress u (addReached xs e.left) e.right endpoints.2))
    (ih _ tail)

def endpoints : List Edge → List HeldLabel
 | [] => []
 | e::es => e.left::e.right::endpoints es

theorem endpointsCovered (es : List Edge) : ∀ e, e ∈ es → e.left ∈ endpoints es ∧ e.right ∈ endpoints es := by
 induction es with
 | nil => intro e h; cases h
 | cons f es ih =>
  intro e h
  cases h with
  | head => exact ⟨List.Mem.head _,List.Mem.tail _ (List.Mem.head _)⟩
  | tail _ h =>
   have hh := ih e h
   exact ⟨List.Mem.tail _ (List.Mem.tail _ hh.1),List.Mem.tail _ (List.Mem.tail _ hh.2)⟩

-- Exact source while-loop: a full ordered scan, repeated precisely when it changes.
-- The termination measure depends solely on the finite supplied relation endpoints.
theorem closureDecreases (es : List Edge) (xs : List HeldLabel)
 (h : xs.length < (scanEdges es xs).length) :
 missing (endpoints es) (scanEdges es xs) < missing (endpoints es) xs := by
 cases scanProgress (endpoints es) es xs (endpointsCovered es) with
 | inl same => rw [same] at h; exact False.elim ((Nat.lt_irrefl _) h)
 | inr small => exact small

def closureOrder (es : List Edge) : WellFoundedRelation (List HeldLabel) :=
 measure (missing (endpoints es))

def closureBody (es : List Edge) (xs : List HeldLabel)
 (recur : (ys : List HeldLabel) → (closureOrder es).rel ys xs → List HeldLabel) : List HeldLabel :=
 if h : xs.length < (scanEdges es xs).length then
  recur (scanEdges es xs) (closureDecreases es xs h)
 else scanEdges es xs

def closure (es : List Edge) : List HeldLabel → List HeldLabel :=
 (closureOrder es).wf.fix (closureBody es)

theorem closureEquation (es : List Edge) (xs : List HeldLabel) :
 closure es xs = if xs.length < (scanEdges es xs).length then closure es (scanEdges es xs) else scanEdges es xs := by
 unfold closure
 rw [WellFounded.fix_eq]
 unfold closureBody
 split <;> rfl

theorem closureFixed (es : List Edge) (xs : List HeldLabel) :
 scanEdges es (closure es xs) = closure es xs := by
 rw [closureEquation]
 split
 · exact closureFixed es (scanEdges es xs)
 · have same := MulticentreDerivation.scanEdgesStopsExactly es xs (by assumption)
   rw [same]; exact same
termination_by missing (endpoints es) xs
decreasing_by
 have progress := scanProgress (endpoints es) es xs (endpointsCovered es)
 cases progress with
 | inl same => rename_i h; rw [same] at h; exact False.elim ((Nat.lt_irrefl _) h)
 | inr small => exact small
theorem missingBound (u xs : List HeldLabel) : missing u xs ≤ u.length := by
 induction u with
 | nil => exact Nat.le_refl 0
 | cons a u ih =>
  unfold missing
  cases contains xs a with
  | true =>
   change 0 + missing u xs ≤ u.length+1
   rw [Nat.zero_add]
   exact Nat.le_trans ih (Nat.le_succ _)
  | false =>
   change 1 + missing u xs ≤ u.length+1
   rw [Nat.one_add]
   exact Nat.succ_le_succ ih

theorem finiteScanEqualsClosure (fuel : Nat) (es : List Edge) (xs : List HeldLabel)
 (enough : missing (endpoints es) xs < fuel) : connectedScan fuel es xs = closure es xs := by
 induction fuel generalizing xs with
 | zero => exact False.elim (Nat.not_lt_zero _ enough)
 | succ fuel ih =>
  rw [connectedScan,closureEquation]
  split
  · apply ih
    exact Nat.lt_of_lt_of_le (closureDecreases es xs (by assumption)) (Nat.le_of_lt_succ enough)
  · rfl

theorem endpointBoundScan (es : List Edge) (xs : List HeldLabel) :
 connectedScan ((endpoints es).length+1) es xs = closure es xs :=
 finiteScanEqualsClosure _ es xs (Nat.lt_succ_of_le (missingBound _ xs))
end SFT.Chemistry.MetalClusterClosure
