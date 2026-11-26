import SFT.Chemistry.LigandStateSplittingDerivation
namespace SFT.Chemistry.LigandStateSplittingRetention
open LigandStateSplitting
-- Count any selected source members, not just the total cardinality.
def selected (accept : Support → Bool) : List Support → Nat
 | [] => 0
 | first::rest => (if accept first then 1 else 0)+selected accept rest
def selectedMembers (accept : Support → Bool) : List Level → Nat
 | [] => 0
 | first::rest => selected accept first.members+selectedMembers accept rest
theorem selectedAppend (accept : Support → Bool) (xs ys : List Support) :
 selected accept (xs++ys)=selected accept xs+selected accept ys := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons first rest ih =>
  change (if accept first then 1 else 0)+selected accept (rest++ys) =
   ((if accept first then 1 else 0)+selected accept rest)+selected accept ys
  rw [ih]
  exact (Nat.add_assoc _ _ _).symm
theorem additionRetainsSelected (accept : Support → Bool) (s : Support) (rank : Rank) (levels : List Level) :
 selectedMembers accept (addSupport s rank levels)=selectedMembers accept levels+(if accept s then 1 else 0) := by
 induction levels with
 | nil =>
  change ((if accept s then 1 else 0)+0)+0=0+(if accept s then 1 else 0)
  cases decision : accept s <;> rfl
 | cons first rest ih =>
  unfold addSupport
  split
  · change selected accept (first.members++[s])+selectedMembers accept rest =
     (selected accept first.members+selectedMembers accept rest)+(if accept s then 1 else 0)
    rw [selectedAppend]
    change (selected accept first.members+((if accept s then 1 else 0)+0))+selectedMembers accept rest = _
    rw [Nat.add_zero]
    exact Nat.add_right_comm _ _ _
  · change selected accept first.members+selectedMembers accept (addSupport s rank rest) =
     (selected accept first.members+selectedMembers accept rest)+(if accept s then 1 else 0)
    rw [ih]
    exact (Nat.add_assoc _ _ _).symm
theorem insertionRetainsSelected (accept : Support → Bool) (value : Level) (levels : List Level) :
 selectedMembers accept (insertLevel value levels)=selected accept value.members+selectedMembers accept levels := by
 induction levels with
 | nil => rfl
 | cons first rest ih =>
  unfold insertLevel
  split
  · rfl
  · change selected accept first.members+selectedMembers accept (insertLevel value rest)=
     selected accept value.members+(selected accept first.members+selectedMembers accept rest)
    rw [ih]
    exact Nat.add_left_comm _ _ _
theorem sortingRetainsSelected (accept : Support → Bool) (levels : List Level) :
 selectedMembers accept (sortedLevels levels)=selectedMembers accept levels := by
 induction levels with
 | nil => rfl
 | cons first rest ih =>
  change selectedMembers accept (insertLevel first (sortedLevels rest))=_
  rw [insertionRetainsSelected,ih]
  rfl
theorem groupingRetainsSelected (accept : Support → Bool) (supports : List Support) (g : Geometry) (initial : List Level) :
 selectedMembers accept (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) initial)=
 selectedMembers accept initial+selected accept supports := by
 induction supports generalizing initial with
 | nil => exact (Nat.add_zero _).symm
 | cons first rest ih =>
  change selectedMembers accept (rest.foldl (fun groups s => addSupport s (interactionRank s g) groups)
   (addSupport first (interactionRank first g) initial)) =
    selectedMembers accept initial+((if accept first then 1 else 0)+selected accept rest)
  rw [ih,additionRetainsSelected]
  exact Nat.add_assoc _ _ _
theorem partitionRetainsEverySelectedMember (accept : Support → Bool) (supports : List Support) (g : Geometry) :
 selectedMembers accept (sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) []))=
 selected accept supports := by
 rw [sortingRetainsSelected,groupingRetainsSelected]
 exact Nat.zero_add _
def consistent (g : Geometry) (levels : List Level) : Prop :=
 ∀ l, l ∈ levels → ∀ s, s ∈ l.members → rankNumber (interactionRank s g)=rankNumber l.rank
theorem additionPreservesIncidenceClass (g : Geometry) (s : Support) (levels : List Level)
 (prior : consistent g levels) : consistent g (addSupport s (interactionRank s g) levels) := by
 induction levels with
 | nil =>
  intro l hl member hm
  cases hl with
  | tail _ impossible => cases impossible
  | head =>
   cases hm with
   | tail _ impossible => cases impossible
   | head => rfl
 | cons first rest ih =>
  have firstValid := prior first (List.Mem.head _)
  have restValid : consistent g rest := fun l hl => prior l (List.Mem.tail _ hl)
  unfold addSupport
  split
  · rename_i same
    have equalRanks : rankNumber (interactionRank s g)=rankNumber first.rank := Nat.eq_of_beq_eq_true same
    intro l hl member hm
    cases hl with
    | tail _ later => exact restValid l later member hm
    | head =>
     cases SFT.Foundation.Count.TraceDerivation.memAppendCases member first.members [s] hm with
     | inl old => exact (firstValid member old).trans equalRanks.symm
     | inr last =>
      cases last with
      | head => rfl
      | tail _ impossible => cases impossible
  · intro l hl member hm
    cases hl with
    | head => exact firstValid member hm
    | tail _ later => exact ih restValid l later member hm
theorem insertionPreservesIncidenceClass (g : Geometry) (value : Level) (levels : List Level)
 (valueValid : ∀ s, s ∈ value.members → rankNumber (interactionRank s g)=rankNumber value.rank)
 (prior : consistent g levels) : consistent g (insertLevel value levels) := by
 induction levels with
 | nil =>
  intro l hl
  cases hl with
  | head => exact valueValid
  | tail _ impossible => cases impossible
 | cons first rest ih =>
  have restValid : consistent g rest := fun l hl => prior l (List.Mem.tail _ hl)
  unfold insertLevel
  split
  · intro l hl
    cases hl with
    | head => exact valueValid
    | tail _ old => exact prior l old
  · intro l hl
    cases hl with
    | head => exact prior first (List.Mem.head _)
    | tail _ old => exact ih restValid l old
theorem sortingPreservesIncidenceClass (g : Geometry) (levels : List Level)
 (prior : consistent g levels) : consistent g (sortedLevels levels) := by
 induction levels with
 | nil => exact prior
 | cons first rest ih =>
  apply insertionPreservesIncidenceClass
  · exact prior first (List.Mem.head _)
  · exact ih (fun l hl => prior l (List.Mem.tail _ hl))
theorem groupingPreservesIncidenceClass (supports : List Support) (g : Geometry) (initial : List Level)
 (prior : consistent g initial) :
 consistent g (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) initial) := by
 induction supports generalizing initial with
 | nil => exact prior
 | cons first rest ih => exact ih _ (additionPreservesIncidenceClass g first initial prior)
theorem partitionIncidenceClass (supports : List Support) (g : Geometry) :
 consistent g (sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) [])) := by
 apply sortingPreservesIncidenceClass
 apply groupingPreservesIncidenceClass
 intro l hl
 cases hl
def distinctRanks : List Level → Prop
 | [] => True
 | first::rest => (∀ l, l ∈ rest → rankNumber l.rank ≠ rankNumber first.rank) ∧ distinctRanks rest
theorem additionRankOrigin (s : Support) (rank : Rank) (levels : List Level) :
 ∀ l, l ∈ addSupport s rank levels → rankNumber l.rank=rankNumber rank ∨
 ∃ old, old ∈ levels ∧ rankNumber l.rank=rankNumber old.rank := by
 induction levels with
 | nil =>
  intro l hl
  cases hl with
  | head => exact Or.inl rfl
  | tail _ impossible => cases impossible
 | cons first rest ih =>
  intro l hl
  change l ∈ (if rankNumber rank==rankNumber first.rank then
    Level.mk rank (first.members++[s])::rest else first::addSupport s rank rest) at hl
  cases same : (rankNumber rank==rankNumber first.rank) with
  | true =>
   rw [same] at hl
   cases hl with
   | head => exact Or.inl rfl
   | tail _ old => exact Or.inr ⟨l,List.Mem.tail _ old,rfl⟩
  | false =>
   rw [same] at hl
   cases hl with
   | head => exact Or.inr ⟨first,List.Mem.head _,rfl⟩
   | tail _ later =>
    cases ih l later with
    | inl same => exact Or.inl same
    | inr found =>
     obtain ⟨old,present,same⟩ := found
     exact Or.inr ⟨old,List.Mem.tail _ present,same⟩
theorem additionPreservesDistinctRanks (s : Support) (rank : Rank) (levels : List Level)
 (prior : distinctRanks levels) : distinctRanks (addSupport s rank levels) := by
 induction levels with
 | nil => exact ⟨(by intro l hl; cases hl),True.intro⟩
 | cons first rest ih =>
  unfold addSupport
  split
  · rename_i same
    have equalRanks := Nat.eq_of_beq_eq_true same
    exact ⟨fun l hl eq => prior.1 l hl (eq.trans equalRanks),prior.2⟩
  · rename_i different
    constructor
    · intro l hl eq
      cases additionRankOrigin s rank rest l hl with
      | inl new =>
       have equality := new.symm.trans eq
       have same : (rankNumber rank==rankNumber first.rank)=true := by
        rw [equality]
        have selfEqual (n : Nat) : (n==n)=true := by
         induction n with
         | zero => rfl
         | succ n ih => exact ih
        exact selfEqual _
       exact different same
      | inr found =>
       obtain ⟨old,present,same⟩ := found
       exact prior.1 old present (same.symm.trans eq)
    · exact ih prior.2
theorem insertionRankOrigin (value : Level) (levels : List Level) :
 ∀ l, l ∈ insertLevel value levels → l=value ∨ l ∈ levels := by
 induction levels with
 | nil =>
  intro l hl
  cases hl with
  | head => exact Or.inl rfl
  | tail _ impossible => cases impossible
 | cons first rest ih =>
  intro l hl
  change l ∈ (if rankNumber value.rank<=rankNumber first.rank then
   value::first::rest else first::insertLevel value rest) at hl
  split at hl
  · cases hl with
    | head => exact Or.inl rfl
    | tail _ old => exact Or.inr old
  · cases hl with
    | head => exact Or.inr (List.Mem.head _)
    | tail _ later =>
     cases ih l later with
     | inl same => exact Or.inl same
     | inr old => exact Or.inr (List.Mem.tail _ old)
theorem insertionPreservesDistinctRanks (value : Level) (levels : List Level)
 (fresh : ∀ l, l ∈ levels → rankNumber l.rank ≠ rankNumber value.rank)
 (prior : distinctRanks levels) : distinctRanks (insertLevel value levels) := by
 induction levels with
 | nil => exact ⟨(by intro l hl; cases hl),True.intro⟩
 | cons first rest ih =>
  unfold insertLevel
  split
  · exact ⟨fresh,prior⟩
  · constructor
    · intro l hl eq
      cases insertionRankOrigin value rest l hl with
      | inl new =>
       cases new
       exact fresh first (List.Mem.head _) eq.symm
      | inr old => exact prior.1 l old eq
    · exact ih (fun l hl => fresh l (List.Mem.tail _ hl)) prior.2
theorem sortingPreservesDistinctRanks (levels : List Level) (prior : distinctRanks levels) :
 distinctRanks (sortedLevels levels) := by
 induction levels with
 | nil => exact True.intro
 | cons first rest ih =>
  apply insertionPreservesDistinctRanks
  · intro l hl
    -- Sorting only reorders complete levels.
    have origin : ∀ (ls : List Level) (x : Level), x ∈ sortedLevels ls → x ∈ ls := by
     intro ls
     induction ls with
     | nil => intro x hx; cases hx
     | cons a tail ih =>
      intro x hx
      cases insertionRankOrigin a (sortedLevels tail) x hx with
      | inl same => cases same; exact List.Mem.head _
      | inr old => exact List.Mem.tail _ (ih x old)
    exact prior.1 l (origin rest l hl)
  · exact ih prior.2
theorem groupingPreservesDistinctRanks (supports : List Support) (g : Geometry) (initial : List Level)
 (prior : distinctRanks initial) :
 distinctRanks (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) initial) := by
 induction supports generalizing initial with
 | nil => exact prior
 | cons first rest ih => exact ih _ (additionPreservesDistinctRanks first (interactionRank first g) initial prior)
theorem partitionHasDistinctRanks (supports : List Support) (g : Geometry) :
 distinctRanks (sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) [])) :=
 sortingPreservesDistinctRanks _ (groupingPreservesDistinctRanks supports g [] True.intro)
theorem equalRankIdentifiesLevel (levels : List Level) (unique : distinctRanks levels)
 (a b : Level) (ha : a ∈ levels) (hb : b ∈ levels) (same : rankNumber a.rank=rankNumber b.rank) : a=b := by
 induction levels with
 | nil => cases ha
 | cons first rest ih =>
  cases ha with
  | head =>
   cases hb with
   | head => rfl
   | tail _ old => exact False.elim (unique.1 b old same.symm)
  | tail _ oldA =>
   cases hb with
   | head => exact False.elim (unique.1 a oldA same)
   | tail _ oldB => exact ih unique.2 oldA oldB
theorem exactIncidenceEquivalence (supports : List Support) (g : Geometry) (a b : Level)
 (ha : a ∈ sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) []))
 (hb : b ∈ sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) []))
 (s t : Support) (hs : s ∈ a.members) (ht : t ∈ b.members) :
 rankNumber (interactionRank s g)=rankNumber (interactionRank t g) ↔ a=b := by
 have sourceS := partitionIncidenceClass supports g a ha s hs
 have sourceT := partitionIncidenceClass supports g b hb t ht
 constructor
 · intro same
   exact equalRankIdentifiesLevel _ (partitionHasDistinctRanks supports g) a b ha hb
    (sourceS.symm.trans (same.trans sourceT))
 · intro same
   cases same
   exact sourceS.trans sourceT.symm
theorem generatedEachMemberOnce :
 (do
  let supports ← generated
  pure (supports.all (fun s => selected (sameSupport s) supports == 1)) : Except String Bool) = .ok true := rfl
end SFT.Chemistry.LigandStateSplittingRetention
