import SFT.Foundation.FoldSorted

/-! Source is_uniform: exact signed adjacent differences, singleton One,
and a nonempty singleton set of gaps followed by terminal One. -/
namespace SFT.Foundation.FoldUniformCheck
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction
open FoldDynamics FoldUniform FoldUniformOrder FoldSorted

inductive Gap where
  | zero
  | positive (magnitude : ExactPartCarrier.Part)
  | negative (magnitude : ExactPartCarrier.Part)

def difference (previous next : ExactPartCarrier.Part) : Gap :=
  if h : strictlyLarger next previous then
    .positive (normalizePart (takeNumerator next previous) (takeDenominator next previous)
      (takePositive next previous h) (Nat.le_of_lt (takeStrictlyBelowOne next previous h)))
  else if h : strictlyLarger previous next then
    .negative (normalizePart (takeNumerator previous next) (takeDenominator previous next)
      (takePositive previous next h) (Nat.le_of_lt (takeStrictlyBelowOne previous next h)))
  else .zero

def samePart (p q : ExactPartCarrier.Part) : Bool :=
  decide (p.numerator*q.denominator = q.numerator*p.denominator)

theorem samePartIff (p q : ExactPartCarrier.Part) : samePart p q = true ↔ p = q := by
  constructor
  · intro h; exact reducedValueIdentity p q (of_decide_eq_true h)
  · intro h; cases h; exact decide_eq_true rfl

def sameGap (a : Gap) (b : Gap) : Bool :=
  match a with
  | .zero => match b with
    | .zero => true
    | .positive _ => false
    | .negative _ => false
  | .positive p => match b with
    | .zero => false
    | .positive q => samePart p q
    | .negative _ => false
  | .negative p => match b with
    | .zero => false
    | .positive _ => false
    | .negative q => samePart p q

theorem sameGapSelf (g : Gap) : sameGap g g = true := by
  cases g with
  | zero => rfl
  | positive p => exact (samePartIff p p).mpr rfl
  | negative p => exact (samePartIff p p).mpr rfl

theorem sameGapIff (a b : Gap) : sameGap a b = true ↔ a = b := by
  cases a <;> cases b
  · exact ⟨fun _ => rfl,fun _ => rfl⟩
  · exact ⟨fun h => Bool.noConfusion h,fun h => Gap.noConfusion h⟩
  · exact ⟨fun h => Bool.noConfusion h,fun h => Gap.noConfusion h⟩
  · exact ⟨fun h => Bool.noConfusion h,fun h => Gap.noConfusion h⟩
  · constructor
    · intro h; exact congrArg Gap.positive ((samePartIff _ _).mp h)
    · intro h; cases h; exact sameGapSelf _
  · exact ⟨fun h => Bool.noConfusion h,fun h => Gap.noConfusion h⟩
  · exact ⟨fun h => Bool.noConfusion h,fun h => Gap.noConfusion h⟩
  · exact ⟨fun h => Bool.noConfusion h,fun h => Gap.noConfusion h⟩
  · constructor
    · intro h; exact congrArg Gap.negative ((samePartIff _ _).mp h)
    · intro h; cases h; exact sameGapSelf _

def chainGaps (p : ExactPartCarrier.Part) : List ExactPartCarrier.Part → List Gap
  | [] => []
  | q::qs => difference p q :: chainGaps q qs

def gaps : List ExactPartCarrier.Part → List Gap
  | [] => []
  | p::ps => chainGaps p ps

def allSame (g : Gap) : List Gap → Bool
  | [] => true
  | h::hs => sameGap h g && allSame g hs

def singletonGapSet : List Gap → Bool
  | [] => false
  | g::gs => allSame g gs

def lastPart (p : ExactPartCarrier.Part) : List ExactPartCarrier.Part → ExactPartCarrier.Part
  | [] => p
  | q::qs => lastPart q qs

def isUniform : List ExactPartCarrier.Part → Bool
  | [] => false
  | p::ps => match ps with
    | [] => samePart p one
    | q::qs => singletonGapSet (gaps (p::q::qs)) && samePart (lastPart q qs) one

theorem emptyNotUniform : isUniform [] = false := rfl

theorem singletonUniformIff (p : ExactPartCarrier.Part) : isUniform [p] = true ↔ p = one :=
  samePartIff p one

theorem positiveDifference (p q : ExactPartCarrier.Part) (h : strictlyLarger q p) :
    difference p q = .positive (normalizePart (takeNumerator q p) (takeDenominator q p)
      (takePositive q p h) (Nat.le_of_lt (takeStrictlyBelowOne q p h))) := by
  unfold difference
  rw [dite_eq_left h]

theorem negativeDifference (p q : ExactPartCarrier.Part) (h : strictlyLarger p q) :
    difference p q = .negative (normalizePart (takeNumerator p q) (takeDenominator p q)
      (takePositive p q h) (Nat.le_of_lt (takeStrictlyBelowOne p q h))) := by
  unfold difference
  rw [dite_eq_right (Nat.not_lt_of_gt h),dite_eq_left h]

theorem zeroDifferenceIff (p q : ExactPartCarrier.Part) : difference p q = .zero ↔ p = q := by
  constructor
  · intro eq
    unfold difference at eq
    split at eq
    next h => cases eq
    next h =>
      split at eq
      next rev => cases eq
      next rev => exact reducedValueIdentity p q (Nat.le_antisymm (Nat.le_of_not_gt rev) (Nat.le_of_not_gt h))
  · intro eq
    cases eq
    unfold difference
    rw [dite_eq_right (Nat.lt_irrefl _),dite_eq_right (Nat.lt_irrefl _)]

theorem adjacentDifference (n i : Nat) (hi : 0 < i) (bound : i+1 ≤ n) :
    difference (divisionPoint n i hi (Nat.le_trans (Nat.le_succ i) bound))
      (divisionPoint n (i+1) (Nat.zero_lt_succ i) bound) =
      .positive (divisionPoint n 1 (by decide) (Nat.lt_of_lt_of_le (Nat.zero_lt_succ i) bound)) := by
  have order := (divisionOrder n i (i+1) hi (Nat.zero_lt_succ i) (Nat.le_trans (Nat.le_succ i) bound) bound).mpr (Nat.lt_succ_self i)
  rw [positiveDifference _ _ order]
  exact congrArg Gap.positive (Except.ok.inj ((takeAdmitted _ _ order).symm.trans (adjacentGap n i hi bound)))

theorem andTrueParts (a b : Bool) (h : (a && b) = true) : a = true ∧ b = true := by
  cases a <;> cases b <;> cases h
  exact ⟨rfl,rfl⟩

theorem chainExtend (g : Gap) (p : ExactPartCarrier.Part) (ps : List ExactPartCarrier.Part)
    (q : ExactPartCarrier.Part) (old : allSame g (chainGaps p ps) = true)
    (next : sameGap (difference (lastPart p ps) q) g = true) :
    allSame g (chainGaps p (ps ++ [q])) = true := by
  induction ps generalizing p with
  | nil =>
    change (sameGap (difference p q) g && true) = true
    change sameGap (difference p q) g = true at next
    rw [next]; rfl
  | cons r rs ih =>
    have both := andTrueParts _ _ old
    change (sameGap (difference p r) g && allSame g (chainGaps r (rs ++ [q]))) = true
    rw [both.1,ih r both.2 next]
    rfl

theorem lastSnoc (p : ExactPartCarrier.Part) (ps : List ExactPartCarrier.Part) (q : ExactPartCarrier.Part) :
    lastPart p (ps ++ [q]) = q := by
  induction ps generalizing p with
  | nil => rfl
  | cons r rs ih => exact ih r

theorem prefixUniformWitness (n k : Nat) (hn : 0 < n) (hk : 0 < k) (bound : k ≤ n) :
    ∃ p ps, divisionPrefix n k bound = p::ps ∧
      allSame (.positive (divisionPoint n 1 (by decide) hn)) (chainGaps p ps) = true ∧
      lastPart p ps = divisionPoint n k hk bound := by
  induction k with
  | zero => exact False.elim (Nat.lt_irrefl _ hk)
  | succ k ih =>
    cases k with
    | zero => exact ⟨divisionPoint n 1 (by decide) bound,[],rfl,rfl,rfl⟩
    | succ k =>
      have priorBound : k+1 ≤ n := Nat.le_trans (Nat.le_succ _) bound
      obtain ⟨p,ps,list,chain,last⟩ := ih (Nat.zero_lt_succ k) priorBound
      let q := divisionPoint n (k+1+1) (Nat.zero_lt_succ _) bound
      refine ⟨p,ps ++ [q],?_,?_,lastSnoc p ps q⟩
      · change divisionPrefix n (k+1) priorBound ++ [q] = p::(ps ++ [q])
        rw [list]
        rfl
      · apply chainExtend _ p ps q chain
        rw [last,adjacentDifference n (k+1) (Nat.zero_lt_succ k) bound]
        exact sameGapSelf _

theorem chainUniform (p : ExactPartCarrier.Part) (ps : List ExactPartCarrier.Part) (g : Gap)
    (chain : allSame g (chainGaps p ps) = true) (last : lastPart p ps = one) :
    isUniform (p::ps) = true := by
  cases ps with
  | nil => exact (samePartIff p one).mpr last
  | cons q qs =>
    have both := andTrueParts _ _ chain
    have gap := (sameGapIff (difference p q) g).mp both.1
    change (allSame (difference p q) (chainGaps q qs) && samePart (lastPart q qs) one) = true
    change lastPart q qs = one at last
    rw [gap,both.2,(samePartIff _ _).mpr last]
    rfl

theorem uniformDivisionPasses (n : Nat) (hn : 0 < n) : isUniform (uniformDivision n hn) = true := by
  obtain ⟨p,ps,list,chain,last⟩ := prefixUniformWitness n n hn hn (Nat.le_refl n)
  change isUniform (divisionPrefix n n (Nat.le_refl n)) = true
  rw [list]
  exact chainUniform p ps _ chain (last.trans (terminalIsOne n hn))

theorem everyEvenDivisionRemainsUniform (n : Nat) (hn : 0 < n) :
    isUniform (foldedDistinct (uniformDivision (n+n) (Nat.add_pos_left hn n))) = true := by
  rw [foldedUniformDivision n hn]
  exact uniformDivisionPasses n hn

theorem allSameIff (g : Gap) (gs : List Gap) :
    allSame g gs = true ↔ ∀ h, h ∈ gs → h = g := by
  induction gs with
  | nil => exact ⟨(fun _ _ h => nomatch h),(fun _ => rfl)⟩
  | cons x xs ih =>
    constructor
    · intro h y member
      have both := andTrueParts _ _ h
      cases member with
      | head => exact (sameGapIff x g).mp both.1
      | tail _ member => exact ih.mp both.2 y member
    · intro all
      have head := (sameGapIff x g).mpr (all x (.head _))
      have tail := ih.mpr (fun y member => all y (.tail _ member))
      change (sameGap x g && allSame g xs) = true
      rw [head,tail]
      rfl

theorem singletonGapSetIff (gs : List Gap) :
    singletonGapSet gs = true ↔ ∃ g, g ∈ gs ∧ ∀ h, h ∈ gs → h = g := by
  cases gs with
  | nil =>
    constructor
    · intro h; exact Bool.noConfusion h
    · intro ⟨g,member,_⟩; cases member
  | cons x xs =>
    constructor
    · intro same
      refine ⟨x,.head _,?_⟩
      intro y member
      cases member with
      | head => rfl
      | tail _ member => exact (allSameIff x xs).mp same y member
    · intro ⟨g,_,all⟩
      apply (allSameIff x xs).mpr
      intro y member
      exact (all y (.tail _ member)).trans (all x (.head _)).symm

end SFT.Foundation.FoldUniformCheck
