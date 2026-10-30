import SFT.Host.Text
namespace SFT.Physics.DimensionComposition
-- Pinned measurement_laws.py DIMENSION_COMPOSITION: finite products and exact
-- quotients of independent kind carriers. The two counts retain numerator and
-- denominator orientation. Zero here means absence of a factor, not a physical
-- quantity or a new scientific value.
inductive Path where
  | kind : String → Path
  | product : Path → Path → Path
  | quotient : Path → Path → Path

def support : Path → List String
  | .kind k => [k]
  | .product a b => support a ++ support b
  | .quotient a b => support a ++ support b

def counts : Path → String → Nat × Nat
  | .kind k, q => if k = q then (1,0) else (0,0)
  | .product a b, q =>
      let x := counts a q
      let y := counts b q
      (x.1+y.1,x.2+y.2)
  | .quotient a b, q =>
      let x := counts a q
      let y := counts b q
      (x.1+y.2,x.2+y.1)

def reduced (n d : Nat) : Nat × Nat := (n-d,d-n)
def formAt (p : Path) (kind : String) : Nat × Nat :=
  reduced (counts p kind).1 (counts p kind).2
def SameDimension (a b : Path) : Prop := ∀ k, formAt a k = formAt b k

theorem kindOwnCount (k : String) : counts (.kind k) k = (1,0) := by
  unfold counts; rw [ite_eq_left rfl]
theorem kindOtherCount (k q : String) (h : k ≠ q) : counts (.kind k) q = (0,0) := by
  unfold counts; rw [ite_eq_right h]
theorem reducedEqual (n : Nat) : reduced n n = (0,0) := by
  unfold reduced; rw [Nat.sub_self]
theorem subtractShared (n d c : Nat) : (n+c)-(d+c)=n-d := by
  induction c with
  | zero => rfl
  | succ c ih => exact (Nat.succ_sub_succ_eq_sub (n+c) (d+c)).trans ih

theorem subtractOfLe (n d : Nat) (h : n ≤ d) : n-d=0 := by
  induction d generalizing n with
  | zero =>
    have hn := Nat.eq_zero_of_le_zero h
    cases hn
    rfl
  | succ d ih =>
    cases n with
    | zero => exact Nat.zero_sub _
    | succ n => exact (Nat.succ_sub_succ_eq_sub n d).trans (ih n (Nat.le_of_succ_le_succ h))

theorem commonFactorsCancel (n d c : Nat) :
    reduced (n+c) (d+c) = reduced n d := by
  unfold reduced; rw [subtractShared,subtractShared]
theorem numeratorOnly (n : Nat) : reduced n 0 = (n,0) := by
  unfold reduced; rw [Nat.sub_zero,Nat.zero_sub]
theorem denominatorOnly (n : Nat) : reduced 0 n = (0,n) := by
  unfold reduced; rw [Nat.sub_zero,Nat.zero_sub]
theorem noTwoResidualSides (n d : Nat) :
    (reduced n d).1 = 0 ∨ (reduced n d).2 = 0 := by
  cases Nat.le_total n d with
  | inl h => exact Or.inl (subtractOfLe _ _ h)
  | inr h => exact Or.inr (subtractOfLe _ _ h)

theorem ownKindForm (k : String) : formAt (.kind k) k = (1,0) := by
  unfold formAt; rw [kindOwnCount]; rfl
theorem independentKinds (k q : String) (h : k ≠ q) :
    ¬ SameDimension (.kind k) (.kind q) := by
  intro same
  have eq := same k
  unfold formAt at eq
  rw [kindOwnCount,kindOtherCount q k (fun e => h e.symm)] at eq
  have impossible := congrArg Prod.fst eq
  exact Nat.noConfusion impossible

theorem sameReflexive (p : Path) : SameDimension p p := fun _ => rfl
theorem sameSymmetric (p q : Path) (h : SameDimension p q) : SameDimension q p :=
  fun k => (h k).symm
theorem sameTransitive (p q r : Path) (hpq : SameDimension p q)
    (hqr : SameDimension q r) : SameDimension p r :=
  fun k => (hpq k).trans (hqr k)

theorem quotientSelf (p : Path) (k : String) :
    formAt (.quotient p p) k = (0,0) := by
  dsimp only [formAt, counts]
  rw [Nat.add_comm (counts p k).2 (counts p k).1]
  exact reducedEqual _

theorem productCommutes (a b : Path) : SameDimension (.product a b) (.product b a) := by
  intro k
  dsimp only [formAt, counts]
  rw [Nat.add_comm (counts a k).1 (counts b k).1,
      Nat.add_comm (counts a k).2 (counts b k).2]

theorem productAssociates (a b c : Path) :
    SameDimension (.product (.product a b) c) (.product a (.product b c)) := by
  intro k
  dsimp only [formAt, counts]
  rw [Nat.add_assoc,Nat.add_assoc]

theorem doubleQuotient (a b c : Path) :
    SameDimension (.quotient (.quotient a b) c) (.quotient a (.product b c)) := by
  intro k
  dsimp only [formAt, counts]
  rw [Nat.add_assoc,Nat.add_assoc]

theorem quotientOfQuotient (a b c : Path) :
    SameDimension (.quotient a (.quotient b c)) (.quotient (.product a c) b) := by
  intro k
  dsimp only [formAt, counts]
  have swap (x y z : Nat) : x+(y+z)=(x+z)+y :=
    (congrArg (fun n => x+n) (Nat.add_comm y z)).trans (Nat.add_assoc x z y).symm
  rw [swap (counts a k).1 (counts b k).2 (counts c k).1,
      swap (counts a k).2 (counts b k).1 (counts c k).2]

theorem sharedKindCancellation (a : Path) (k q : String) :
    formAt (.quotient (.product a (.kind k)) (.kind k)) q = formAt a q := by
  change reduced (((counts a q).1+(counts (.kind k) q).1)+(counts (.kind k) q).2)
    (((counts a q).2+(counts (.kind k) q).2)+(counts (.kind k) q).1) =
    reduced (counts a q).1 (counts a q).2
  cases h : decide (k=q) with
  | true =>
    have hk := of_decide_eq_true h
    cases hk
    rw [kindOwnCount]
    change reduced ((counts a k).1+1+0) ((counts a k).2+0+1) = _
    rw [Nat.add_zero,Nat.add_zero]
    exact commonFactorsCancel _ _ 1
  | false =>
    have hk : k ≠ q := of_decide_eq_false h
    rw [kindOtherCount k q hk]
    change reduced ((counts a q).1+0+0) ((counts a q).2+0+0) = _
    rw [Nat.add_zero,Nat.add_zero]


theorem outsideSupport (p : Path) (k : String) (absent : k ∉ support p) :
    counts p k = (0,0) := by
  induction p with
  | kind q =>
    apply kindOtherCount
    intro h
    cases h
    exact absent List.mem_cons_self
  | product a b ha hb =>
    have xa := ha (fun h => absent (List.mem_append_left (support b) h))
    have xb := hb (fun h => absent (List.mem_append_right (support a) h))
    change ((counts a k).1+(counts b k).1,(counts a k).2+(counts b k).2) = _
    rw [xa,xb]
    rfl
  | quotient a b ha hb =>
    have xa := ha (fun h => absent (List.mem_append_left (support b) h))
    have xb := hb (fun h => absent (List.mem_append_right (support a) h))
    change ((counts a k).1+(counts b k).2,(counts a k).2+(counts b k).1) = _
    rw [xa,xb]
    rfl

theorem absentForm (p : Path) (k : String) (absent : k ∉ support p) :
    formAt p k = (0,0) := by
  unfold formAt
  rw [outsideSupport p k absent]
  rfl

theorem allForward {A : Type} (p : A → Bool) (xs : List A)
    (passed : xs.all p = true) (x : A) (member : x ∈ xs) : p x = true := by
  induction xs with
  | nil => cases member
  | cons a rest ih =>
    cases hp : p a with
    | false =>
      rw [List.all_cons,hp] at passed
      cases passed
    | true =>
      have tail : rest.all p = true := by
        rw [List.all_cons,hp] at passed
        exact passed
      cases member with
      | head => exact hp
      | tail _ h => exact ih tail h

theorem allBackward {A : Type} (p : A → Bool) (xs : List A)
    (each : ∀ x, x ∈ xs → p x = true) : xs.all p = true := by
  induction xs with
  | nil => rfl
  | cons a rest ih =>
    have hp := each a List.mem_cons_self
    have tail := ih (fun x h => each x (List.mem_cons_of_mem a h))
    rw [List.all_cons,hp,tail]
    rfl

def membership (k : String) : (xs : List String) → Decidable (k ∈ xs)
  | [] => .isFalse (fun h => nomatch h)
  | a::rest =>
    match decEq k a with
    | .isTrue equal => .isTrue (equal ▸ List.mem_cons_self)
    | .isFalse different =>
      match membership k rest with
      | .isTrue member => .isTrue (List.mem_cons_of_mem a member)
      | .isFalse absent => .isFalse (fun member =>
          match member with
          | .head _ => different rfl
          | .tail _ h => absent h)

def sameDimension (a b : Path) : Bool :=
  (support a ++ support b).all (fun k => decide (formAt a k = formAt b k))

theorem finiteComparisonSound (a b : Path) (passed : sameDimension a b = true) :
    SameDimension a b := by
  intro k
  cases membership k (support a ++ support b) with
  | isTrue member =>
    exact of_decide_eq_true (allForward _ _ passed k member)
  | isFalse absent =>
    have ha : k ∉ support a := fun m => absent (List.mem_append_left (support b) m)
    have hb : k ∉ support b := fun m => absent (List.mem_append_right (support a) m)
    exact (absentForm a k ha).trans (absentForm b k hb).symm

theorem finiteComparisonComplete (a b : Path) (same : SameDimension a b) :
    sameDimension a b = true :=
  allBackward _ _ (fun k _ => decide_eq_true (same k))

theorem finiteComparisonIff (a b : Path) :
    sameDimension a b = true ↔ SameDimension a b :=
  ⟨finiteComparisonSound a b,finiteComparisonComplete a b⟩

theorem unlikeKindsRejected (k q : String) (h : k ≠ q) :
    sameDimension (.kind k) (.kind q) = false := by
  cases passed : sameDimension (.kind k) (.kind q) with
  | false => rfl
  | true => exact False.elim (independentKinds k q h (finiteComparisonSound _ _ passed))



theorem sharedProductCancellation (a b : Path) :
    SameDimension (.quotient (.product a b) b) a := by
  intro k
  change reduced (((counts a k).1+(counts b k).1)+(counts b k).2)
    (((counts a k).2+(counts b k).2)+(counts b k).1) =
    reduced (counts a k).1 (counts a k).2
  rw [Nat.add_assoc,Nat.add_assoc,Nat.add_comm (counts b k).2 (counts b k).1]
  exact commonFactorsCancel _ _ _

theorem regroupFour (a b c d : Nat) : (a+b)+(c+d)=(a+d)+(b+c) := by
  calc
    (a+b)+(c+d) = a+(b+(c+d)) := Nat.add_assoc _ _ _
    _ = a+((b+c)+d) := congrArg (fun n => a+n) (Nat.add_assoc b c d).symm
    _ = a+(d+(b+c)) := congrArg (fun n => a+n) (Nat.add_comm (b+c) d)
    _ = (a+d)+(b+c) := (Nat.add_assoc a d (b+c)).symm

theorem dimensionViewsTelescope (a b c : Path) :
    SameDimension (.product (.quotient a b) (.quotient b c)) (.quotient a c) := by
  intro k
  change reduced (((counts a k).1+(counts b k).2)+((counts b k).1+(counts c k).2))
    (((counts a k).2+(counts b k).1)+((counts b k).2+(counts c k).1)) =
    reduced ((counts a k).1+(counts c k).2) ((counts a k).2+(counts c k).1)
  rw [regroupFour (counts a k).1 (counts b k).2 (counts b k).1 (counts c k).2,
      regroupFour (counts a k).2 (counts b k).1 (counts b k).2 (counts c k).1,
      Nat.add_comm (counts b k).2 (counts b k).1]
  exact commonFactorsCancel _ _ _

end SFT.Physics.DimensionComposition
