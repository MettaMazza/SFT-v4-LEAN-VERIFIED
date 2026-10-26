import SFT.Foundation.FoldFibres
import SFT.Foundation.CountTrace

/-! fold_dynamics.py uniform_partition: the two generated index halves,
with positive endpoint One retained by the original cast. -/
namespace SFT.Foundation.FoldUniform
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction
open FoldDynamics FoldCastLaws FoldPhaseLaws FoldPhaseFull FoldFibres ExactCast

def divisionPoint (n i : Nat) (hi : 0 < i) (bound : i ≤ n) : ExactPartCarrier.Part :=
  normalizePart i n hi bound

theorem divisionPointCongr (n i j : Nat) (hi : 0 < i) (hj : 0 < j)
    (ib : i ≤ n) (jb : j ≤ n) (h : i = j) :
    divisionPoint n i hi ib = divisionPoint n j hj jb := by
  cases h
  rfl

theorem lowerIndexImage (n i : Nat) (hi : 0 < i) (bound : i ≤ n) :
    foldPart (divisionPoint (n+n) i hi (Nat.le_trans bound (Nat.le_add_right _ _))) =
      divisionPoint n i hi bound := by
  unfold divisionPoint
  rw [foldNormalized]
  apply normalizationByFactors _ _ i n 2
  · exact (castRetains _ _ (Nat.add_pos_left (Nat.lt_of_lt_of_le hi bound) _)
      (Nat.add_le_add bound bound)).trans (twoTimes i).symm
  · exact (twoTimes n).symm

theorem upperIndexImage (n i : Nat) (hi : 0 < i) (bound : i ≤ n) :
    foldPart (divisionPoint (n+n) (i+n) (Nat.add_pos_left hi n)
      (Nat.add_le_add_right bound n)) = divisionPoint n i hi bound := by
  unfold divisionPoint
  rw [foldNormalized]
  apply normalizationByFactors _ _ i n 2
  · calc
      castNumerator ((i+n)+(i+n)) (n+n) = castNumerator ((i+i)+(n+n)) (n+n) :=
        congrArg (fun x => castNumerator x (n+n)) (additionShuffle i n)
      _ = castNumerator (i+i) (n+n) := castAddingOne _ _ (Nat.add_pos_left hi i)
        (Nat.add_pos_left (Nat.lt_of_lt_of_le hi bound) n)
      _ = i+i := castRetains _ _ (Nat.add_pos_left (Nat.lt_of_lt_of_le hi bound) n)
        (Nat.add_le_add bound bound)
      _ = 2*i := (twoTimes i).symm
  · exact (twoTimes n).symm

theorem indexPairCollision (n i : Nat) (hi : 0 < i) (bound : i ≤ n) :
    foldPart (divisionPoint (n+n) i hi (Nat.le_trans bound (Nat.le_add_right _ _))) =
      foldPart (divisionPoint (n+n) (i+n) (Nat.add_pos_left hi n)
        (Nat.add_le_add_right bound n)) :=
  (lowerIndexImage n i hi bound).trans (upperIndexImage n i hi bound).symm

theorem everyEvenIndexImage (n i : Nat) (_hn : 0 < n) (hi : 0 < i) (bound : i ≤ n+n) :
    ∃ j, ∃ hj : 0 < j, ∃ jb : j ≤ n,
      foldPart (divisionPoint (n+n) i hi bound) = divisionPoint n j hj jb := by
  by_cases lower : i ≤ n
  · exact ⟨i,hi,lower,lowerIndexImage n i hi lower⟩
  · have above : n < i := Nat.lt_of_not_ge lower
    have positive : 0 < i-n := subtractPositive i n above
    have restored : i-n+n = i := subtractAdd i n (Nat.le_of_lt above)
    have small : i-n ≤ n := cancelAddedBound _ _ n (by rw [restored]; exact bound)
    refine ⟨i-n,positive,small,?_⟩
    have eq : divisionPoint (n+n) (i-n+n) (Nat.add_pos_left positive n)
        (Nat.add_le_add_right small n) = divisionPoint (n+n) i hi bound :=
      divisionPointCongr _ _ _ _ _ _ _ restored
    exact (congrArg foldPart eq).symm.trans (upperIndexImage n (i-n) positive small)

theorem divisionPointInjective (n i j : Nat) (hi : 0 < i) (hj : 0 < j)
    (ib : i ≤ n) (jb : j ≤ n) (h : divisionPoint n i hi ib = divisionPoint n j hj jb) : i = j := by
  let q := divisionPoint n j hj jb
  have vi := normalizedValuePreserved i n hi (Nat.lt_of_lt_of_le hi ib)
  have vj := normalizedValuePreserved j n hj (Nat.lt_of_lt_of_le hj jb)
  change i*(divisionPoint n i hi ib).denominator = (divisionPoint n i hi ib).numerator*n at vi
  rw [h] at vi
  have cross : i*q.denominator = j*q.denominator := vi.trans vj.symm
  apply Nat.eq_of_mul_eq_mul_left (denominatorPositive q)
  exact (Nat.mul_comm _ _).trans (cross.trans (Nat.mul_comm _ _))

theorem terminalIsOne (n : Nat) (hn : 0 < n) :
    divisionPoint n n hn (Nat.le_refl n) = one := by
  exact normalizationByFactors _ _ 1 1 n hn (Nat.le_refl n) (by decide) (by decide)
    (Nat.mul_one n).symm (Nat.mul_one n).symm

theorem exactEvenImageSet (n : Nat) (hn : 0 < n) (p : ExactPartCarrier.Part) :
    (∃ i, ∃ hi : 0 < i, ∃ ib : i ≤ n+n, foldPart (divisionPoint (n+n) i hi ib) = p) ↔
    (∃ j, ∃ hj : 0 < j, ∃ jb : j ≤ n, divisionPoint n j hj jb = p) := by
  constructor
  · intro h
    obtain ⟨i,hi,ib,image⟩ := h
    obtain ⟨j,hj,jb,eq⟩ := everyEvenIndexImage n i hn hi ib
    exact ⟨j,hj,jb,eq.symm.trans image⟩
  · intro h
    obtain ⟨j,hj,jb,image⟩ := h
    exact ⟨j,hj,Nat.le_trans jb (Nat.le_add_right _ _),(lowerIndexImage n j hj jb).trans image⟩

open Count.TraceDerivation

def divisionPrefix (n : Nat) : (k : Nat) → k ≤ n → List ExactPartCarrier.Part
  | 0,_ => []
  | k+1,h => divisionPrefix n k (Nat.le_trans (Nat.le_succ k) h) ++
      [divisionPoint n (k+1) (Nat.zero_lt_succ k) h]

def uniformDivision (n : Nat) (_hn : 0 < n) : List ExactPartCarrier.Part :=
  divisionPrefix n n (Nat.le_refl n)

theorem prefixOrigin (n k : Nat) (bound : k ≤ n) (p : ExactPartCarrier.Part)
    (h : p ∈ divisionPrefix n k bound) :
    ∃ i, ∃ hi : 0 < i, ∃ ib : i ≤ k, divisionPoint n i hi (Nat.le_trans ib bound) = p := by
  induction k with
  | zero => cases h
  | succ k ih =>
    cases memAppendCases p _ _ h with
    | inl old =>
      obtain ⟨i,hi,ib,eq⟩ := ih (Nat.le_trans (Nat.le_succ k) bound) old
      exact ⟨i,hi,Nat.le_trans ib (Nat.le_succ k),eq⟩
    | inr last =>
      cases last with
      | head => exact ⟨k+1,Nat.zero_lt_succ k,Nat.le_refl _,rfl⟩
      | tail _ impossible => cases impossible

theorem prefixContains (n k i : Nat) (bound : k ≤ n) (hi : 0 < i) (ib : i ≤ k) :
    divisionPoint n i hi (Nat.le_trans ib bound) ∈ divisionPrefix n k bound := by
  induction k with
  | zero => exact False.elim (Nat.not_lt_of_ge ib hi)
  | succ k ih =>
    cases Nat.eq_or_lt_of_le ib with
    | inl eq =>
      cases eq
      exact memAppendRight _ _ _ (List.Mem.head _)
    | inr less =>
      exact memAppendLeft _ _ _ (ih (Nat.le_trans (Nat.le_succ k) bound) (Nat.le_of_lt_succ less))

theorem uniformDivisionMembership (n : Nat) (hn : 0 < n) (p : ExactPartCarrier.Part) :
    p ∈ uniformDivision n hn ↔ ∃ i, ∃ hi : 0 < i, ∃ ib : i ≤ n, divisionPoint n i hi ib = p := by
  constructor
  · exact prefixOrigin n n (Nat.le_refl n) p
  · intro ⟨i,hi,ib,eq⟩
    cases eq
    exact prefixContains n n i (Nat.le_refl n) hi ib

theorem foldedEnumerationMembership (n : Nat) (hn : 0 < n) (p : ExactPartCarrier.Part) :
    p ∈ (uniformDivision (n+n) (Nat.add_pos_left hn n)).map foldPart ↔ p ∈ uniformDivision n hn := by
  constructor
  · intro h
    obtain ⟨q,hq,eq⟩ := memMapPreimage foldPart p _ h
    obtain ⟨i,hi,ib,qi⟩ := (uniformDivisionMembership _ _ q).mp hq
    have source : foldPart (divisionPoint (n+n) i hi ib) = p := (congrArg foldPart qi).trans eq
    exact (uniformDivisionMembership _ _ p).mpr ((exactEvenImageSet n hn p).mp ⟨i,hi,ib,source⟩)
  · intro h
    obtain ⟨i,hi,ib,eq⟩ := (exactEvenImageSet n hn p).mpr ((uniformDivisionMembership _ _ p).mp h)
    have member := (uniformDivisionMembership (n+n) (Nat.add_pos_left hn n) _).mpr ⟨i,hi,ib,rfl⟩
    have mapped := memMap foldPart _ _ member
    exact eq ▸ mapped

end SFT.Foundation.FoldUniform
