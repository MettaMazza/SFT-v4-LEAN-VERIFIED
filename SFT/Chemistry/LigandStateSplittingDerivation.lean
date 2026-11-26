import SFT.Chemistry.LigandStateSplitting
namespace SFT.Chemistry.LigandStateSplittingDerivation
open LigandStateSplitting
-- This is the predicate used by the source's interaction_rank filter.
def incidence (s : Support) (word : List CoordinationIsomerism.Cell) : Bool :=
 let first := presentAt word (s.firstAxis.value-1)
 let second := presentAt word (s.secondAxis.value-1)
 if SFT.Host.Text.equal s.kind.label "held-axis-contrast" then first != second else first && second
theorem incidenceAppend (s : Support) (words : List (List CoordinationIsomerism.Cell))
 (word : List CoordinationIsomerism.Cell) :
 ((words++[word]).filter (incidence s)).length =
 (words.filter (incidence s)).length + (if incidence s word then 1 else 0) := by
 induction words with
 | nil =>
  change (List.filter (incidence s) [word]).length = 0 + _
  rw [List.filter]
  cases h : incidence s word <;> rfl
 | cons first rest ih =>
  simp only [List.cons_append,List.filter]
  cases h : incidence s first with
  | false => exact ih
  | true =>
   change ((rest++[word]).filter (incidence s)).length+1 = (rest.filter (incidence s)).length+1+_
   rw [ih]
   exact Nat.add_right_comm _ _ _
theorem rankIsCompleteIncidence (s : Support) (g : Geometry) :
 rankNumber (interactionRank s g) = (g.words.filter (incidence s)).length := by
 unfold interactionRank
 change rankNumber (if h : 0 < (g.words.filter (incidence s)).length then Rank.positive ⟨_,h⟩ else Rank.absent) = _
 split
 · rfl
 · rename_i absent
   change 0 = _
   cases h : (g.words.filter (incidence s)).length with
   | zero => rfl
   | succ n => exact False.elim (absent (h ▸ Nat.zero_lt_succ n))
theorem rankSuccessor (s : Support) (g : Geometry) (word : List CoordinationIsomerism.Cell) :
 rankNumber (interactionRank s ⟨g.centre,g.words++[word]⟩) =
 rankNumber (interactionRank s g) + (if incidence s word then 1 else 0) := by
 rw [rankIsCompleteIncidence,rankIsCompleteIncidence]
 exact incidenceAppend s g.words word
def memberCount : List Level → Nat
 | [] => 0
 | level::rest => level.members.length+memberCount rest
theorem addSupportMemberCount (s : Support) (rank : Rank) (levels : List Level) :
 memberCount (addSupport s rank levels) = memberCount levels+1 := by
 induction levels with
 | nil => rfl
 | cons first rest ih =>
  unfold addSupport
  split
  · change (first.members++[s]).length+memberCount rest = (first.members.length+memberCount rest)+1
    rw [SFT.Foundation.CommonRefinement.appendLength]
    exact Nat.add_right_comm _ _ _
  · change first.members.length+memberCount (addSupport s rank rest) = (first.members.length+memberCount rest)+1
    rw [ih]
    exact (Nat.add_assoc _ _ _).symm
theorem insertLevelMemberCount (value : Level) (levels : List Level) :
 memberCount (insertLevel value levels) = value.members.length+memberCount levels := by
 induction levels with
 | nil => rfl
 | cons first rest ih =>
  unfold insertLevel
  split
  · rfl
  · change first.members.length+memberCount (insertLevel value rest) =
     value.members.length+(first.members.length+memberCount rest)
    rw [ih]
    exact Nat.add_left_comm _ _ _
theorem sortedMemberCount (levels : List Level) : memberCount (sortedLevels levels) = memberCount levels := by
 induction levels with
 | nil => rfl
 | cons first rest ih =>
  change memberCount (insertLevel first (sortedLevels rest)) = first.members.length+memberCount rest
  rw [insertLevelMemberCount,ih]
theorem groupMemberCount (supports : List Support) (g : Geometry) (initial : List Level) :
 memberCount (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) initial) =
 memberCount initial+supports.length := by
 induction supports generalizing initial with
 | nil => exact (Nat.add_zero _).symm
 | cons first rest ih =>
  change memberCount (rest.foldl (fun groups s => addSupport s (interactionRank s g) groups)
   (addSupport first (interactionRank first g) initial)) = memberCount initial+(rest.length+1)
  rw [ih,addSupportMemberCount]
  exact (Nat.add_right_comm _ _ _).trans (Nat.add_assoc _ _ _)
theorem partitionCardinality (supports : List Support) (g : Geometry) :
 memberCount (sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) [])) = supports.length := by
 rw [sortedMemberCount,groupMemberCount]
 exact Nat.zero_add _
end SFT.Chemistry.LigandStateSplittingDerivation
