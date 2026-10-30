import SFT.Mathematics.OrbitOrderExistence
namespace SFT.Mathematics.OrbitLoopCompletion
open OrbitOrderIdentity OrbitBinaryDepth OrbitCycleSupport OrbitCyclotomic OrbitTilingCount
open OrbitNumberWitnesses OrbitReplayCorrespondence OrbitOrderExistence

theorem rangeLoopAppend (n : Nat) (left right : List Nat) :
 List.range.loop n (left++right) = List.range.loop n left ++ right := by
 induction n generalizing left with
 | zero => rfl
 | succ n ih => exact ih (n::left)

theorem rangeSuccessor (n : Nat) : List.range (n+1) = List.range n ++ [n] :=
 rangeLoopAppend n [] [n]

theorem mapAppend (f : Nat → Nat) (xs ys : List Nat) :
 (xs++ys).map f = xs.map f ++ ys.map f := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (f x)) ih

theorem cycleSuccessor (p q n : Nat) :
 cycleSupport p q (n+1) = cycleSupport p q n ++ [rankIterate p q n] := by
 unfold cycleSupport
 rw [rangeSuccessor,mapAppend]
 rfl

theorem natBeqSelf (x : Nat) : Nat.beq x x = true := by
 induction x with
 | zero => rfl
 | succ x ih => exact ih

theorem containsMember (xs : List Nat) (x : Nat) : xs.contains x = true ↔ x ∈ xs := by
 induction xs with
 | nil => constructor <;> intro h <;> cases h
 | cons a xs ih =>
   change (match x == a with | true => true | false => xs.contains x) = true ↔ _
   cases same : x == a with
   | true =>
     have eq := Nat.eq_of_beq_eq_true same
     constructor
     · intro _; cases eq; exact List.Mem.head _
     · intro _; rfl
   | false =>
     constructor
     · intro h; exact List.Mem.tail _ (ih.mp h)
     · intro h
       cases h with
       | head => change Nat.beq x x = false at same; rw [natBeqSelf] at same; cases same
       | tail _ m => exact ih.mpr m

theorem containsAbsent (xs : List Nat) (x : Nat) (absent : ¬ x ∈ xs) : xs.contains x = false := by
 cases eq : xs.contains x with
 | false => rfl
 | true => exact False.elim (absent ((containsMember xs x).mp eq))

theorem currentFreshBeforeReturn (p q period count : Nat) (hq : 0 < q) (odd : q%2=1)
 (reduced : Nat.gcd p q = 1) (first : FirstBinaryOrder q period) (before : count < period) :
 (cycleSupport p q count).contains (rankIterate p q count) = false := by
 apply containsAbsent
 intro member
 obtain ⟨i,im,same⟩ := mapPreimage (rankIterate p q) (List.range count) _ member
 have earlier := (rangeMember count i).mp im
 exact noEarlierCollision p q period i count hq odd reduced first earlier before same

theorem currentRepeatedAtReturn (p q period : Nat) (positive : 0 < p) (bound : p ≤ q)
 (reduced : Nat.gcd p q = 1) (first : FirstBinaryOrder q period) :
 (cycleSupport p q period).contains (rankIterate p q period) = true := by
 have returned := (exactExecutedReturnIffOrder p q period positive bound reduced).mpr first.2.1
 apply (containsMember _ _).mpr
 rw [returned]
 exact mapMember (rankIterate p q) (List.range period) 0 ((rangeMember period 0).mpr first.1)

theorem orbitReplayCompletes (p q period fuel count : Nat) (positive : 0 < p) (bound : p ≤ q)
 (odd : q%2=1) (reduced : Nat.gcd p q = 1) (first : FirstBinaryOrder q period)
 (before : count ≤ period) (enough : period ≤ count+fuel) :
 orbitReplay q fuel (rankIterate p q count) (cycleSupport p q count) = some (cycleSupport p q period) := by
 have hq := Nat.lt_of_lt_of_le positive bound
 induction fuel generalizing count with
 | zero =>
   have eq : count = period := Nat.le_antisymm before enough
   rw [eq]
   unfold orbitReplay
   rw [currentRepeatedAtReturn p q period positive bound reduced first]
   rfl
 | succ fuel ih =>
   by_cases eq : count = period
   · rw [eq]
     unfold orbitReplay
     rw [currentRepeatedAtReturn p q period positive bound reduced first]
     rfl
   · have earlier := Nat.lt_of_le_of_ne before eq
     unfold orbitReplay
     rw [currentFreshBeforeReturn p q period count hq odd reduced first earlier]
     rw [← cycleSuccessor]
     exact ih (count+1) earlier ((Nat.add_right_comm count fuel 1) ▸ enough)

/-- Both original loops terminate with the same first period, and the
complete returned orbit has precisely that length. -/
theorem originalOrbitOrderIdentity (p q : Nat) (positive : 0 < p) (bound : p ≤ q)
 (aboveOne : 1 < q) (odd : q%2=1) (reduced : Nat.gcd p q = 1) :
 ∃ period trace, orderWitness q = some period ∧ orbitWitness p q = some trace ∧
   FirstBinaryOrder q period ∧ trace.length = period ∧
   OrbitRun q p [] trace := by
 have hq := Nat.lt_trans (Nat.zero_lt_succ 0) aboveOne
 obtain ⟨period,_,first,periodBound⟩ := firstOrderExists q hq odd
 have order := orderReplayCompletes q period q 1 aboveOne first (by decide) first.1
   (Nat.le_trans periodBound (Nat.le_add_left q 1))
 have orbit := orbitReplayCompletes p q period q 0 positive bound odd reduced first
   (Nat.zero_le period) (by rw [Nat.zero_add]; exact periodBound)
 change orderWitness q = some period at order
 change orbitWitness p q = some (cycleSupport p q period) at orbit
 exact ⟨period,cycleSupport p q period,order,orbit,first,completeCycleCardinality p q period,
   orbitReplayCorrespondence q q p [] (cycleSupport p q period) orbit⟩

theorem appendMember (xs ys : List Nat) (x : Nat) : x ∈ xs++ys ↔ x ∈ xs ∨ x ∈ ys := by
 induction xs with
 | nil =>
   constructor
   · intro h; exact Or.inr h
   · intro h; cases h with
     | inl h => cases h
     | inr h => exact h
 | cons a xs ih =>
   constructor
   · intro h
     cases h with
     | head => exact Or.inl (List.Mem.head _)
     | tail _ m =>
       cases ih.mp m with
       | inl m => exact Or.inl (List.Mem.tail _ m)
       | inr m => exact Or.inr m
   · intro h
     cases h with
     | inl m =>
       cases m with
       | head => exact List.Mem.head _
       | tail _ m => exact List.Mem.tail _ (ih.mpr (Or.inl m))
     | inr m => exact List.Mem.tail _ (ih.mpr (Or.inr m))

theorem appendOneUnique (xs : List Nat) (x : Nat) (unique : Unique xs) (fresh : ¬ x ∈ xs) :
 Unique (xs++[x]) := by
 induction xs with
 | nil => exact ⟨(fun h => by cases h),True.intro⟩
 | cons a xs ih =>
   constructor
   · intro h
     cases (appendMember xs [x] a).mp h with
     | inl h => exact unique.1 h
     | inr h =>
       cases h with
       | head => exact fresh (List.Mem.head _)
       | tail _ h => cases h
   · exact ih unique.2 (fun h => fresh (List.Mem.tail _ h))

theorem appendOneLength (xs : List Nat) (x : Nat) : (xs++[x]).length = xs.length+1 := by
 induction xs with
 | nil => rfl
 | cons a xs ih => exact congrArg Nat.succ ih

/-- Termination also holds for the original even-denominator orbit loop;
the repeated rank can occur after a transient prefix. -/
theorem finiteOrbitReplayTotal (q fuel current : Nat) (seen : List Nat)
 (hq : 0 < q) (positive : 0 < current) (bound : current ≤ q) (unique : Unique seen)
 (contained : ∀ x, x ∈ seen → x ∈ positiveRanks (q+1))
 (enough : q ≤ seen.length+fuel) : ∃ trace, orbitReplay q fuel current seen = some trace := by
 induction fuel generalizing current seen with
 | zero =>
   have repeated : seen.contains current = true := by
     cases hit : seen.contains current with
     | true => rfl
     | false =>
       have fresh : ¬ current ∈ seen := by
         intro m
         have yes := (containsMember seen current).mpr m
         rw [hit] at yes; cases yes
       have longer := subsetLength (current::seen) (positiveRanks (q+1)) ⟨fresh,unique⟩ (by
         intro x m
         cases m with
         | head => exact (positiveRankMember (q+1) current (Nat.zero_lt_succ q)).mpr ⟨positive,Nat.lt_succ_of_le bound⟩
         | tail _ m => exact contained x m)
       have carrierSize : (positiveRanks (q+1)).length = q :=
         (mappedLength _ _).trans (rangeLoopLength q [])
       rw [carrierSize] at longer
       exact False.elim (Nat.not_succ_le_self seen.length (Nat.le_trans longer enough))
   exact ⟨seen,by unfold orbitReplay; rw [repeated]; rfl⟩
 | succ fuel ih =>
   cases hit : seen.contains current with
   | true => exact ⟨seen,by unfold orbitReplay; rw [hit]; rfl⟩
   | false =>
     have fresh : ¬ current ∈ seen := by
       intro m
       have yes := (containsMember seen current).mpr m
       rw [hit] at yes; cases yes
     have nextBounds := foldRankBounds current q hq
     obtain ⟨trace,result⟩ := ih (foldRank current q) (seen++[current]) nextBounds.1 nextBounds.2
       (appendOneUnique seen current unique fresh) (by
         intro x m
         cases (appendMember seen [current] x).mp m with
         | inl m => exact contained x m
         | inr m =>
           cases m with
           | head => exact (positiveRankMember (q+1) current (Nat.zero_lt_succ q)).mpr ⟨positive,Nat.lt_succ_of_le bound⟩
           | tail _ m => cases m) (by
         rw [appendOneLength]
         exact (Nat.add_right_comm seen.length fuel 1) ▸ enough)
     exact ⟨trace,by unfold orbitReplay; rw [hit]; exact result⟩

theorem everyPositivePartOrbitTerminates (p q : Nat) (positive : 0 < p) (bound : p ≤ q) :
 ∃ trace, orbitWitness p q = some trace ∧ OrbitRun q p [] trace := by
 have hq := Nat.lt_of_lt_of_le positive bound
 obtain ⟨trace,finished⟩ := finiteOrbitReplayTotal q q p [] hq positive bound True.intro
   (fun _ h => by cases h) (by change q ≤ 0+q; rw [Nat.zero_add]; exact Nat.le_refl _)
 exact ⟨trace,finished,orbitReplayCorrespondence q q p [] trace finished⟩

end SFT.Mathematics.OrbitLoopCompletion
