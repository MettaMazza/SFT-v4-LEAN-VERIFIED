import SFT.Mathematics.CombinatorialArrangements
namespace SFT.Mathematics.CombinatorialArrangements
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem attachedFlatMapValues {α β : Type} (xs : List α) (P : α → Prop)
    (H : ∀ x, x ∈ xs → P x) (f : α → List β) :
    (xs.attachWith P H).flatMap (fun x => f x.val) = xs.flatMap f := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    change f x ++ (xs.attachWith P (fun y hy => H y (List.Mem.tail x hy))).flatMap (fun y => f y.val) =
      f x ++ xs.flatMap f
    exact congrArg (List.append (f x)) (ih _)

theorem arrangementsStepByValues (first second : String) (rest : List String) :
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

theorem permutationDistinct {xs ys : List String} (p : List.Perm xs ys) :
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

theorem remainderPermutationPreserved {xs ys : List String} (p : List.Perm xs ys) (held : String) :
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

theorem suffixPermutesRemainder (held : String) (suffix carrier : List String)
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

theorem everyPermutationGenerated (carrier : List String) :
    carrier ≠ [] → distinct carrier = true →
      ∀ form, List.Perm form carrier → form ∈ arrangementsCore carrier := by
  apply (measure (fun xs : List String => xs.length)).wf.induction carrier
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

theorem arrangementMembershipIff (carrier form : List String) (nonempty : carrier ≠ [])
    (unique : distinct carrier = true) :
    form ∈ arrangementsCore carrier ↔ List.Perm form carrier :=
  ⟨everyArrangementPermutesCarrier carrier unique form,everyPermutationGenerated carrier nonempty unique form⟩

theorem heldBranchesDistinct (labels : List String) (branches : String → List Form)
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

theorem arrangementFamilyDistinct (carrier : List String) :
    distinct carrier = true → distinct (arrangementsCore carrier) = true := by
  apply (measure (fun xs : List String => xs.length)).wf.induction carrier
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

theorem acceptedArrangementsCompleteUnique (carrier : List String) (results : List Form)
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

end SFT.Mathematics.CombinatorialArrangements
