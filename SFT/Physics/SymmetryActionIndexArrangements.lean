import SFT.Mathematics.ArrangementCompleteness
namespace SFT.Physics.SymmetryActionIndexArrangements
open SFT.Mathematics SFT.Mathematics.DiscreteObjects SFT.Foundation.Count.TraceDerivation
abbrev Form := List Nat
-- Instantiate the existing complete arrangement construction and proofs for
-- original zero-based state indices; the scientific support and order are unchanged.
def remainder (items : List Nat) (held : Nat) : List Nat :=
  match items with
  | [] => []
  | item::rest => if item = held then remainder rest held else item :: remainder rest held

theorem remainderLengthLe (items : List Nat) (held : Nat) :
    (remainder items held).length ≤ items.length := by
  induction items with
  | nil => exact Nat.le_refl _
  | cons item rest ih =>
    unfold remainder
    split
    · exact Nat.le_trans ih (Nat.le_succ _)
    · exact Nat.succ_le_succ ih

theorem remainderShorter (items : List Nat) (held : Nat) (member : held ∈ items) :
    (remainder items held).length < items.length := by
  induction items with
  | nil => cases member
  | cons item rest ih =>
    unfold remainder
    by_cases eq : item = held
    · rw [ite_eq_left eq]
      exact Nat.lt_succ_of_le (remainderLengthLe rest held)
    · rw [ite_eq_right eq]
      apply Nat.succ_lt_succ
      apply ih
      cases member with
      | head => exact False.elim (eq rfl)
      | tail _ h => exact h

def arrangementsBody (items : List Nat)
    (recur : (smaller : List Nat) → smaller.length < items.length → List Form) : List Form :=
  match items, recur with
  | [], _ => []
  | [item], _ => [[item]]
  | first::second::rest, recur =>
    (first::second::rest).attach.flatMap fun held =>
      (recur (remainder (first::second::rest) held.val)
        (remainderShorter _ _ held.property)).map (List.cons held.val)

def arrangementsCore : List Nat → List Form :=
  (measure (fun xs : List Nat => xs.length)).wf.fix arrangementsBody

theorem arrangementsStep (first second : Nat) (rest : List Nat) :
    arrangementsCore (first::second::rest) =
      (first::second::rest).attach.flatMap (fun held =>
        (arrangementsCore (remainder (first::second::rest) held.val)).map (List.cons held.val)) := by
  unfold arrangementsCore
  rw [WellFounded.fix_eq]
  rfl

theorem arrangementsSingle (label : Nat) : arrangementsCore [label] = [[label]] := by
  unfold arrangementsCore
  rw [WellFounded.fix_eq]
  rfl

def arrangements (items : List Nat) : Except String (List Form) :=
  if items.isEmpty || !distinct items then
    .error "ValueError: arrangements require a nonempty unique generated carrier"
  else .ok (arrangementsCore items)

theorem remainderMemberIff (items : List Nat) (held label : Nat) :
    label ∈ remainder items held ↔ label ∈ items ∧ label ≠ held := by
  induction items with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons item rest ih =>
    unfold remainder
    by_cases eq : item = held
    · rw [ite_eq_left eq]
      constructor
      · intro h; have p := ih.mp h; exact ⟨List.Mem.tail _ p.1,p.2⟩
      · intro h
        apply ih.mpr
        constructor
        · cases h.1 with
          | head => exact False.elim (h.2 eq)
          | tail _ hm => exact hm
        · exact h.2
    · rw [ite_eq_right eq]
      constructor
      · intro h
        cases h with
        | head => exact ⟨List.Mem.head _,eq⟩
        | tail _ hm => have p := ih.mp hm; exact ⟨List.Mem.tail _ p.1,p.2⟩
      · intro h
        cases h.1 with
        | head => exact List.Mem.head _
        | tail _ hm => exact List.Mem.tail _ (ih.mpr ⟨hm,h.2⟩)

theorem remainderExcludesHeld (items : List Nat) (held : Nat) :
    ¬ held ∈ remainder items held := fun h => ((remainderMemberIff items held held).mp h).2 rfl

theorem remainderPreservesDistinct (items : List Nat) (held : Nat)
    (unique : distinct items = true) : distinct (remainder items held) = true := by
  induction items with
  | nil => rfl
  | cons item rest ih =>
    have parts := (distinctCons item rest).mp unique
    change distinct (if item = held then remainder rest held else item :: remainder rest held) = true
    by_cases eq : item = held
    · rw [ite_eq_left eq]; exact ih parts.2
    · rw [ite_eq_right eq]
      apply (distinctCons item (remainder rest held)).mpr
      exact ⟨(absentIff _ _).mpr (fun h => (absentIff rest item).mp parts.1
        ((remainderMemberIff rest held item).mp h).1),ih parts.2⟩

theorem remainderAbsentPreserved (items : List Nat) (held : Nat)
    (absent : ¬ held ∈ items) : remainder items held = items := by
  induction items with
  | nil => rfl
  | cons item rest ih =>
    have neq : item ≠ held := by intro eq; cases eq; exact absent (List.Mem.head _)
    unfold remainder
    rw [ite_eq_right neq,ih (fun h => absent (List.Mem.tail _ h))]

theorem remainderRemovesExactlyOne (items : List Nat) (held : Nat)
    (unique : distinct items = true) (member : held ∈ items) :
    (remainder items held).length + 1 = items.length := by
  induction items with
  | nil => cases member
  | cons item rest ih =>
    have parts := (distinctCons item rest).mp unique
    unfold remainder
    by_cases eq : item = held
    · rw [ite_eq_left eq]
      cases eq
      rw [remainderAbsentPreserved rest held ((absentIff rest held).mp parts.1)]
      rfl
    · rw [ite_eq_right eq]
      have tail : held ∈ rest := by
        cases member with
        | head => exact False.elim (eq rfl)
        | tail _ h => exact h
      have smaller := ih parts.2 tail
      change ((remainder rest held).length + 1) + 1 = (rest.length + 1)
      exact congrArg (fun n => n+1) smaller

theorem recursiveRemainderAdmitted (first second : Nat) (rest : List Nat) (held : Nat)
    (unique : distinct (first::second::rest) = true) (member : held ∈ first::second::rest) :
    remainder (first::second::rest) held ≠ [] ∧ distinct (remainder (first::second::rest) held) = true := by
  constructor
  · intro empty
    have count := remainderRemovesExactlyOne _ held unique member
    rw [empty] at count
    have impossible : 0 = rest.length + 1 := Nat.succ.inj count
    exact Nat.noConfusion impossible
  · exact remainderPreservesDistinct _ held unique

theorem emptyArrangementsRejected : arrangements [] =
    .error "ValueError: arrangements require a nonempty unique generated carrier" := rfl

theorem singletonArrangement (label : Nat) : arrangements [label] = .ok [[label]] := by
  unfold arrangements
  change Except.ok (arrangementsCore [label]) = _
  rw [arrangementsSingle]

theorem remainderPermutation (items : List Nat) (held : Nat)
    (unique : distinct items = true) (member : held ∈ items) :
    List.Perm items (held :: remainder items held) := by
  induction items with
  | nil => cases member
  | cons item rest ih =>
    have parts := (distinctCons item rest).mp unique
    by_cases eq : item = held
    · cases eq
      change List.Perm (held::rest) (held :: (if held = held then remainder rest held else held :: remainder rest held))
      rw [ite_eq_left rfl,remainderAbsentPreserved rest held ((absentIff rest held).mp parts.1)]
    · have tail : held ∈ rest := by
        cases member with
        | head => exact False.elim (eq rfl)
        | tail _ hm => exact hm
      have prior := List.Perm.cons item (ih parts.2 tail)
      change List.Perm (item::rest) (held :: (if item = held then remainder rest held else item :: remainder rest held))
      rw [ite_eq_right eq]
      exact prior.trans (List.Perm.swap held item _)

theorem arrangementsEmpty : arrangementsCore [] = [] := by
  unfold arrangementsCore
  rw [WellFounded.fix_eq]
  rfl

theorem everyArrangementPermutesCarrier (items : List Nat) :
    distinct items = true → ∀ form, form ∈ arrangementsCore items → List.Perm form items := by
  apply (measure (fun xs : List Nat => xs.length)).wf.induction items
  intro carrier ih unique form member
  cases carrier with
  | nil => rw [arrangementsEmpty] at member; cases member
  | cons first tail =>
    cases tail with
    | nil =>
      rw [arrangementsSingle] at member
      cases member with
      | head => exact List.Perm.refl _
      | tail _ impossible => cases impossible
    | cons second rest =>
      rw [arrangementsStep] at member
      obtain ⟨held,_,branch⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ member
      obtain ⟨suffix,hs,eq⟩ := memMapPreimage _ _ _ branch
      rw [← eq]
      have smaller := ih (remainder (first::second::rest) held.val)
        (remainderShorter _ _ held.property) (remainderPreservesDistinct _ _ unique) suffix hs
      exact (List.Perm.cons held.val smaller).trans
        (remainderPermutation _ _ unique held.property).symm

theorem attachedFlatMapValues {α β : Type} (xs : List α) (P : α → Prop)
    (H : ∀ x, x ∈ xs → P x) (f : α → List β) :
    (xs.attachWith P H).flatMap (fun x => f x.val) = xs.flatMap f := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    change f x ++ (xs.attachWith P (fun y hy => H y (List.Mem.tail x hy))).flatMap (fun y => f y.val) =
      f x ++ xs.flatMap f
    exact congrArg (List.append (f x)) (ih _)

theorem arrangementsStepByValues (first second : Nat) (rest : List Nat) :
    arrangementsCore (first::second::rest) =
      (first::second::rest).flatMap (fun held =>
        (arrangementsCore (remainder (first::second::rest) held)).map (List.cons held)) := by
  rw [arrangementsStep]
  exact attachedFlatMapValues (first::second::rest) (fun x => x ∈ first::second::rest)
    (fun _ h => h) (fun held => (arrangementsCore (remainder (first::second::rest) held)).map (List.cons held))

theorem permutationMember {α : Type} {xs ys : List α} (p : List.Perm xs ys)
    (a : α) : a ∈ xs → a ∈ ys := by
  induction p with
  | nil => intro h; cases h
  | cons x p ih =>
    intro h
    cases h with
    | head => exact List.Mem.head _
    | tail _ h => exact List.Mem.tail _ (ih h)
  | swap x y xs =>
    intro h
    cases h with
    | head => exact List.Mem.tail _ (List.Mem.head _)
    | tail _ h =>
      cases h with
      | head => exact List.Mem.head _
      | tail _ h => exact List.Mem.tail _ (List.Mem.tail _ h)
  | trans p q ip iq => exact fun h => iq (ip h)

theorem permutationDistinct {xs ys : List Nat} (p : List.Perm xs ys) :
    distinct xs = true → distinct ys = true := by
  induction p with
  | nil => intro _; rfl
  | cons x p ih =>
    intro h
    have parts := (distinctCons _ _).mp h
    apply (distinctCons _ _).mpr
    exact ⟨(absentIff _ _).mpr (fun m => (absentIff _ _).mp parts.1
      (permutationMember p.symm x m)), ih parts.2⟩
  | swap x y xs =>
    intro h
    have first := (distinctCons y (x::xs)).mp h
    have second := (distinctCons x xs).mp first.2
    have noY := (absentIff (x::xs) y).mp first.1
    have noX := (absentIff xs x).mp second.1
    apply (distinctCons x (y::xs)).mpr
    constructor
    · apply (absentIff _ _).mpr
      intro m
      cases m with
      | head => exact noY (List.Mem.head _)
      | tail _ m => exact noX m
    · exact (distinctCons y xs).mpr
        ⟨(absentIff _ _).mpr (fun m => noY (List.Mem.tail _ m)),second.2⟩
  | trans p q ip iq => exact fun h => iq (ip h)

theorem remainderPermutationPreserved {xs ys : List Nat} (p : List.Perm xs ys) (held : Nat) :
    List.Perm (remainder xs held) (remainder ys held) := by
  induction p with
  | nil => exact List.Perm.nil
  | cons x p ih =>
    change List.Perm (if x = held then remainder _ held else x :: remainder _ held)
      (if x = held then remainder _ held else x :: remainder _ held)
    by_cases eq : x = held
    · rw [ite_eq_left eq,ite_eq_left eq]; exact ih
    · rw [ite_eq_right eq,ite_eq_right eq]; exact List.Perm.cons x ih
  | swap x y xs =>
    by_cases hx : x = held <;> by_cases hy : y = held
    · cases hx; cases hy; exact List.Perm.refl _
    · change List.Perm (if y = held then remainder (x::xs) held else y::remainder (x::xs) held)
        (if x = held then remainder (y::xs) held else x::remainder (y::xs) held)
      rw [ite_eq_right hy,ite_eq_left hx]
      change List.Perm (y::(if x = held then remainder xs held else x::remainder xs held))
        (if y = held then remainder xs held else y::remainder xs held)
      rw [ite_eq_left hx,ite_eq_right hy]
    · change List.Perm (if y = held then remainder (x::xs) held else y::remainder (x::xs) held)
        (if x = held then remainder (y::xs) held else x::remainder (y::xs) held)
      rw [ite_eq_left hy,ite_eq_right hx]
      change List.Perm (if x = held then remainder xs held else x::remainder xs held)
        (x::(if y = held then remainder xs held else y::remainder xs held))
      rw [ite_eq_right hx,ite_eq_left hy]
    · change List.Perm (if y = held then remainder (x::xs) held else y::remainder (x::xs) held)
        (if x = held then remainder (y::xs) held else x::remainder (y::xs) held)
      rw [ite_eq_right hy,ite_eq_right hx]
      change List.Perm (y::(if x = held then remainder xs held else x::remainder xs held))
        (x::(if y = held then remainder xs held else y::remainder xs held))
      rw [ite_eq_right hx,ite_eq_right hy]
      exact List.Perm.swap x y _
  | trans p q ip iq => exact ip.trans iq

theorem suffixPermutesRemainder (held : Nat) (suffix carrier : List Nat)
    (unique : distinct carrier = true) (p : List.Perm (held::suffix) carrier) :
    List.Perm suffix (remainder carrier held) := by
  have distinctForm := permutationDistinct p.symm unique
  have absent := (absentIff suffix held).mp ((distinctCons held suffix).mp distinctForm).1
  have removed := remainderPermutationPreserved p held
  change List.Perm (if held = held then remainder suffix held else held::remainder suffix held)
    (remainder carrier held) at removed
  rw [ite_eq_left rfl,remainderAbsentPreserved suffix held absent] at removed
  exact removed

theorem permutationLength {α : Type} {xs ys : List α} (p : List.Perm xs ys) : xs.length = ys.length := by
  induction p with
  | nil => rfl
  | cons x p ih => exact congrArg Nat.succ ih
  | swap x y xs => rfl
  | trans p q ip iq => exact ip.trans iq

theorem everyPermutationGenerated (carrier : List Nat) :
    carrier ≠ [] → distinct carrier = true →
      ∀ form, List.Perm form carrier → form ∈ arrangementsCore carrier := by
  apply (measure (fun xs : List Nat => xs.length)).wf.induction carrier
  intro items ih nonempty unique form p
  cases items with
  | nil => exact False.elim (nonempty rfl)
  | cons first tail =>
    cases tail with
    | nil =>
      have length := permutationLength p
      cases form with
      | nil => cases length
      | cons label rest =>
        cases rest with
        | cons x xs => exact Nat.noConfusion (Nat.succ.inj length)
        | nil =>
          have hm := permutationMember p label (List.Mem.head _)
          cases hm with
          | head => rw [arrangementsSingle]; exact List.Mem.head _
          | tail _ impossible => cases impossible
    | cons second rest =>
      cases form with
      | nil => have impossible := permutationLength p; cases impossible
      | cons held suffix =>
        have member := permutationMember p held (List.Mem.head _)
        have guards := recursiveRemainderAdmitted first second rest held unique member
        have suffixPermutation := suffixPermutesRemainder held suffix _ unique p
        have suffixGenerated := ih (remainder (first::second::rest) held)
          (remainderShorter _ _ member) guards.1 guards.2 suffix suffixPermutation
        rw [arrangementsStepByValues]
        exact SFT.Foundation.CommonRefinement.memFlatMap _ _ held _ member
          (memMap (List.cons held) suffix _ suffixGenerated)

theorem arrangementMembershipIff (carrier form : List Nat) (nonempty : carrier ≠ [])
    (unique : distinct carrier = true) :
    form ∈ arrangementsCore carrier ↔ List.Perm form carrier :=
  ⟨everyArrangementPermutesCarrier carrier unique form,everyPermutationGenerated carrier nonempty unique form⟩

theorem heldBranchesDistinct (labels : List Nat) (branches : Nat → List Form)
    (unique : distinct labels = true)
    (branchUnique : ∀ label, label ∈ labels → distinct (branches label) = true) :
    distinct (labels.flatMap (fun label => (branches label).map (List.cons label))) = true := by
  induction labels with
  | nil => rfl
  | cons label rest ih =>
    have parts := (distinctCons label rest).mp unique
    change distinct ((branches label).map (List.cons label) ++
      rest.flatMap (fun other => (branches other).map (List.cons other))) = true
    apply appendDistinct
    · exact mapDistinct (List.cons label) (fun a b eq => (List.cons.inj eq).2) _
        (branchUnique label (List.Mem.head _))
    · exact ih parts.2 (fun other h => branchUnique other (List.Mem.tail _ h))
    · intro form firstBranch laterBranch
      obtain ⟨suffix,_,eq⟩ := memMapPreimage (List.cons label) form _ firstBranch
      obtain ⟨other,hm,branch⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ laterBranch
      obtain ⟨otherSuffix,_,otherEq⟩ := memMapPreimage (List.cons other) form _ branch
      have same : label = other := (List.cons.inj (eq.trans otherEq.symm)).1
      cases same
      exact (absentIff rest label).mp parts.1 hm

theorem arrangementFamilyDistinct (carrier : List Nat) :
    distinct carrier = true → distinct (arrangementsCore carrier) = true := by
  apply (measure (fun xs : List Nat => xs.length)).wf.induction carrier
  intro items ih unique
  cases items with
  | nil => rw [arrangementsEmpty]; rfl
  | cons first tail =>
    cases tail with
    | nil => rw [arrangementsSingle]; rfl
    | cons second rest =>
      rw [arrangementsStepByValues]
      apply heldBranchesDistinct _ _ unique
      intro held member
      exact ih (remainder (first::second::rest) held)
        (remainderShorter _ _ member) (remainderPreservesDistinct _ _ unique)

theorem acceptedArrangementsCompleteUnique (carrier : List Nat) (results : List Form)
    (accepted : arrangements carrier = .ok results) :
    distinct results = true ∧ ∀ form, form ∈ results ↔ List.Perm form carrier := by
  unfold arrangements at accepted
  cases nonempty : carrier.isEmpty with
  | true => rw [nonempty] at accepted; cases accepted
  | false =>
    cases unique : distinct carrier with
    | false => rw [nonempty,unique] at accepted; cases accepted
    | true =>
      rw [nonempty,unique] at accepted
      cases accepted
      have ne : carrier ≠ [] := by intro eq; cases eq; cases nonempty
      exact ⟨arrangementFamilyDistinct carrier unique,
        fun form => arrangementMembershipIff carrier form ne unique⟩

end SFT.Physics.SymmetryActionIndexArrangements
