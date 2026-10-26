import SFT.Foundation.PartSelection
/-! Literal part_equivalence.py pair_cells/lifted_a/lifted_b and
has_generated_bijection, plus constructive proofs of the source pairing clauses.
Natural values here are the source host range indices, not added magnitudes. -/
namespace SFT.Foundation.CommonRefinement
open Count.TraceDerivation
open Count.Representation

def pairLabel (a b : String) : String := SFT.Host.Text.join ["(",a,",",b,")"]

def pairCells (as bs : List String) : List String :=
  as.flatMap fun a => bs.map (pairLabel a)

def liftedA (aHeld bAll : List String) : List String := pairCells aHeld bAll

def liftedB (aAll bHeld : List String) : List String := pairCells aAll bHeld

def indices : Nat → List Nat
  | 0 => []
  | n+1 => 0 :: (indices n).map Nat.succ

def generatedPairs (left right : List String) : List (Nat × Nat) :=
  (indices left.length).zip (indices right.length)

def hasGeneratedBijection (left right : List String) : Bool :=
  left.length == right.length && (generatedPairs left right).all
    (fun pair => pair.1 < left.length && pair.2 < right.length)

theorem indexBounded (n i : Nat) (h : i ∈ indices n) : i < n := by
  induction n generalizing i with
  | zero => cases h
  | succ n ih =>
    cases h with
    | head => exact Nat.zero_lt_succ n
    | tail _ htail =>
      obtain ⟨j,hj,eq⟩ := memMapPreimage Nat.succ i (indices n) htail
      cases eq
      exact Nat.succ_lt_succ (ih j hj)

theorem everyIndexGenerated (n i : Nat) (h : i < n) : i ∈ indices n := by
  induction n generalizing i with
  | zero => exact False.elim (Nat.not_lt_zero i h)
  | succ n ih =>
    cases i with
    | zero => exact List.Mem.head _
    | succ i => exact List.Mem.tail _ (memMap Nat.succ i _ (ih i (Nat.lt_of_succ_lt_succ h)))

theorem zippedBounds (n m : Nat) (xs ys : List Nat)
    (hx : ∀ x, x ∈ xs → x < n) (hy : ∀ y, y ∈ ys → y < m) :
    (xs.zip ys).all (fun p => p.1 < n && p.2 < m) = true := by
  induction xs generalizing ys with
  | nil => rfl
  | cons x xs ih =>
    cases ys with
    | nil => rfl
    | cons y ys =>
      exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr
        ⟨decide_eq_true (hx x (List.Mem.head _)),decide_eq_true (hy y (List.Mem.head _))⟩,
        ih ys (fun a h => hx a (List.Mem.tail _ h)) (fun b h => hy b (List.Mem.tail _ h))⟩

theorem generatedPairsBounded (left right : List String) :
    (generatedPairs left right).all (fun p => p.1 < left.length && p.2 < right.length) = true :=
  zippedBounds _ _ _ _ (indexBounded left.length) (indexBounded right.length)

theorem naturalEqualityReflexive (n : Nat) : (n == n) = true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih

theorem generatedBijectionIffEqualLength (left right : List String) :
    hasGeneratedBijection left right = true ↔ left.length = right.length := by
  constructor
  · intro h
    exact Nat.eq_of_beq_eq_true ((andTrue _ _).mp h).1
  · intro h
    apply (andTrue _ _).mpr
    constructor
    · rw [h]; exact naturalEqualityReflexive _
    · exact generatedPairsBounded left right

theorem zipSelf {α : Type} (xs : List α) : xs.zip xs = xs.map (fun x => (x,x)) := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons (x,x)) ih

theorem acceptedPairCoversLeft (left right : List String)
    (h : hasGeneratedBijection left right = true) (i : Fin left.length) :
    (i.val,i.val) ∈ generatedPairs left right := by
  have eq := (generatedBijectionIffEqualLength left right).mp h
  unfold generatedPairs
  rw [←eq,zipSelf]
  exact memMap (fun n => (n,n)) i.val _ (everyIndexGenerated _ _ i.isLt)

theorem acceptedPairCoversRight (left right : List String)
    (h : hasGeneratedBijection left right = true) (i : Fin right.length) :
    (i.val,i.val) ∈ generatedPairs left right := by
  have eq := (generatedBijectionIffEqualLength left right).mp h
  unfold generatedPairs
  rw [eq,zipSelf]
  exact memMap (fun n => (n,n)) i.val _ (everyIndexGenerated _ _ i.isLt)

structure ExactPairing (α β : Type) where
  forward : α → β
  backward : β → α
  leftInverse : ∀ a, backward (forward a) = a
  rightInverse : ∀ b, forward (backward b) = b

def identityPairing (α : Type) : ExactPairing α α :=
  ⟨fun a => a, fun a => a, fun _ => rfl, fun _ => rfl⟩

def reversePairing {α β : Type} (p : ExactPairing α β) : ExactPairing β α :=
  ⟨p.backward,p.forward,p.rightInverse,p.leftInverse⟩

def chainPairings {α β γ : Type} (p : ExactPairing α β) (q : ExactPairing β γ) : ExactPairing α γ where
  forward := fun a => q.forward (p.forward a)
  backward := fun c => p.backward (q.backward c)
  leftInverse := fun a => (congrArg p.backward (q.leftInverse (p.forward a))).trans (p.leftInverse a)
  rightInverse := fun c => (congrArg q.forward (p.rightInverse (q.backward c))).trans (q.rightInverse c)

theorem pairingInjective {α β : Type} (p : ExactPairing α β) (a b : α)
    (h : p.forward a = p.forward b) : a = b :=
  (p.leftInverse a).symm.trans ((congrArg p.backward h).trans (p.leftInverse b))

theorem pairingOnto {α β : Type} (p : ExactPairing α β) (b : β) : ∃ a, p.forward a = b :=
  ⟨p.backward b,p.rightInverse b⟩

def uniformRefinement {α β γ : Type} (p : ExactPairing α β) : ExactPairing (α × γ) (β × γ) where
  forward := fun a => (p.forward a.1,a.2)
  backward := fun b => (p.backward b.1,b.2)
  leftInverse := fun a => by
    cases a with
    | mk x y => exact congrArg (fun z => (z,y)) (p.leftInverse x)
  rightInverse := fun b => by
    cases b with
    | mk x y => exact congrArg (fun z => (z,y)) (p.rightInverse x)

def equalSizeIndexPairing (n m : Nat) (h : n = m) : ExactPairing (Fin n) (Fin m) := by
  cases h
  exact identityPairing (Fin n)

def acceptedIndexPairing (left right : List String) (h : hasGeneratedBijection left right = true) :
    ExactPairing (Fin left.length) (Fin right.length) :=
  equalSizeIndexPairing _ _ ((generatedBijectionIffEqualLength left right).mp h)

theorem generatedBijectionReflexive (xs : List String) : hasGeneratedBijection xs xs = true :=
  (generatedBijectionIffEqualLength xs xs).mpr rfl

theorem generatedBijectionSymmetric (xs ys : List String) (h : hasGeneratedBijection xs ys = true) :
    hasGeneratedBijection ys xs = true :=
  (generatedBijectionIffEqualLength ys xs).mpr ((generatedBijectionIffEqualLength xs ys).mp h).symm

theorem generatedBijectionTransitive (xs ys zs : List String)
    (hxy : hasGeneratedBijection xs ys = true) (hyz : hasGeneratedBijection ys zs = true) :
    hasGeneratedBijection xs zs = true :=
  (generatedBijectionIffEqualLength xs zs).mpr
    (((generatedBijectionIffEqualLength xs ys).mp hxy).trans
      ((generatedBijectionIffEqualLength ys zs).mp hyz))

def originCells (as bs : List String) : List (String × String) :=
  as.flatMap fun a => bs.map (fun b => (a,b))

theorem memFlatMap {α β : Type} (f : α → List β) (as : List α) (a : α) (b : β)
    (ha : a ∈ as) (hb : b ∈ f a) : b ∈ as.flatMap f := by
  induction as with
  | nil => cases ha
  | cons x xs ih =>
    cases ha with
    | head => exact memAppendLeft _ _ _ hb
    | tail _ h => exact memAppendRight _ _ _ (ih h)

theorem memFlatMapOrigin {α β : Type} (f : α → List β) (as : List α) (b : β)
    (h : b ∈ as.flatMap f) : ∃ a, a ∈ as ∧ b ∈ f a := by
  induction as with
  | nil => cases h
  | cons a as ih =>
    cases memAppendCases b (f a) (as.flatMap f) h with
    | inl first => exact ⟨a,List.Mem.head _,first⟩
    | inr tail =>
      obtain ⟨x,hx,hb⟩ := ih tail
      exact ⟨x,List.Mem.tail _ hx,hb⟩

theorem originCellIffSources (as bs : List String) (a b : String) :
    (a,b) ∈ originCells as bs ↔ a ∈ as ∧ b ∈ bs := by
  constructor
  · intro h
    obtain ⟨x,hx,row⟩ := memFlatMapOrigin (fun x => bs.map (fun y => (x,y))) as (a,b) h
    obtain ⟨y,hy,eq⟩ := memMapPreimage (fun y => (x,y)) (a,b) bs row
    cases eq
    exact ⟨hx,hy⟩
  · intro h
    exact memFlatMap _ as a (a,b) h.1 (memMap (fun b => (a,b)) b bs h.2)

theorem pairLabelGenerated (as bs : List String) (a b : String) (ha : a ∈ as) (hb : b ∈ bs) :
    pairLabel a b ∈ pairCells as bs :=
  memFlatMap _ as a _ ha (memMap (pairLabel a) b bs hb)

theorem generatedLabelHasOrigins (as bs : List String) (cell : String) (h : cell ∈ pairCells as bs) :
    ∃ a, a ∈ as ∧ ∃ b, b ∈ bs ∧ pairLabel a b = cell := by
  obtain ⟨a,ha,row⟩ := memFlatMapOrigin (fun a => bs.map (pairLabel a)) as cell h
  obtain ⟨b,hb,eq⟩ := memMapPreimage (pairLabel a) cell bs row
  exact ⟨a,ha,b,hb,eq⟩

theorem mapLength {α β : Type} (f : α → β) (xs : List α) : (xs.map f).length = xs.length := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg Nat.succ ih

theorem appendLength {α : Type} (xs ys : List α) : (xs ++ ys).length = xs.length + ys.length := by
  induction xs with
  | nil => exact (Nat.zero_add ys.length).symm
  | cons x xs ih =>
    change Nat.succ ((xs ++ ys).length) = Nat.succ xs.length + ys.length
    rw [ih]
    exact (Nat.succ_add _ _).symm

theorem pairCellsEqualLeftLength (as cs bs : List String) (h : as.length = cs.length) :
    (pairCells as bs).length = (pairCells cs bs).length := by
  induction as generalizing cs with
  | nil =>
    cases cs with
    | nil => rfl
    | cons c cs => cases h
  | cons a as ih =>
    cases cs with
    | nil => cases h
    | cons c cs =>
      have tail := ih cs (Nat.succ.inj h)
      change ((bs.map (pairLabel a)) ++ pairCells as bs).length =
        ((bs.map (pairLabel c)) ++ pairCells cs bs).length
      rw [appendLength,appendLength,mapLength,mapLength,tail]

theorem uniformRefinementPreservesGeneratedPairing (xs ys descendants : List String)
    (h : hasGeneratedBijection xs ys = true) :
    hasGeneratedBijection (pairCells xs descendants) (pairCells ys descendants) = true :=
  (generatedBijectionIffEqualLength _ _).mpr
    (pairCellsEqualLeftLength xs ys descendants ((generatedBijectionIffEqualLength xs ys).mp h))

theorem equalSourceControl :
    hasGeneratedBijection (liftedA ["a1"] ["b1","b2","b3","b4"])
      (liftedB ["a1","a2"] ["b1","b2"]) = true := rfl

theorem unequalSourceControl :
    hasGeneratedBijection (liftedA ["a1"] ["b1","b2","b3"])
      (liftedB ["a1","a2"] ["b1"]) = false := rfl

end SFT.Foundation.CommonRefinement
