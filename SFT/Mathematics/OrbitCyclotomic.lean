import SFT.Mathematics.OrbitCycleSupport
namespace SFT.Mathematics.OrbitCyclotomic
open OrbitOrderIdentity OrbitBinaryDepth OrbitCycleSupport
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity

/-- The source double-and-cast transition preserves reducedness on an odd core. -/
theorem iterateReduced (p q k : Nat) (hq : 0 < q) (odd : q%2 = 1)
 (reduced : Nat.gcd p q = 1) : Nat.gcd (rankIterate p q k) q = 1 := by
 have h := sameRemainderSameGcd (rankIterate p q k) (p*2^k) q hq
   (iterationRemainder p q k hq)
 exact h.trans ((gcdMultiplyReduced p q (2^k) hq reduced).trans
   (binaryPowerCoprimeOdd q k hq odd))

/-- A complete return reduces every later executed position to one cycle. -/
theorem iterateModuloPeriod (p q period : Nat) (positive : 0 < period)
 (returned : rankIterate p q period = p) (k : Nat) :
 rankIterate p q k = rankIterate p q (k%period) := by
 induction k using Nat.strongRecOn with
 | ind k ih =>
   by_cases before : k < period
   · rw [moduloBelow k period positive before]
   · have bound := Nat.le_of_not_gt before
     have smaller : k-period < k := Nat.sub_lt (Nat.lt_of_lt_of_le positive bound) positive
     have split : k = period+(k-period) :=
       (subtractAdd k period bound).symm.trans (Nat.add_comm _ _)
     calc
       rankIterate p q k = rankIterate p q (period+(k-period)) := congrArg _ split
       _ = rankIterate p q (k-period) := periodicFromReturn p q period (k-period) returned
       _ = rankIterate p q ((k-period)%period) := ih _ smaller
       _ = rankIterate p q (k%period) := congrArg _ (moduloRemoves k period positive bound).symm

def Reaches (q p r : Nat) : Prop := ∃ k, rankIterate p q k = r

theorem reachesSelf (q p : Nat) : Reaches q p p := ⟨0,rfl⟩

theorem reachesCompose (q p r s : Nat) (left : Reaches q p r)
 (right : Reaches q r s) : Reaches q p s := by
 obtain ⟨i,hi⟩ := left
 obtain ⟨j,hj⟩ := right
 exact ⟨i+j,(iterateAddition p q i j).trans ((congrArg (fun x => rankIterate x q j) hi).trans hj)⟩

theorem reachesWithinCycle (q p r period : Nat) (positive : 0 < period)
 (returned : rankIterate p q period = p) (reaches : Reaches q p r) :
 ∃ k, k < period ∧ rankIterate p q k = r := by
 obtain ⟨k,hk⟩ := reaches
 exact ⟨k%period,Nat.mod_lt _ positive,(iterateModuloPeriod p q period positive returned k).symm.trans hk⟩

theorem reachesReverse (q p r period : Nat) (positive : 0 < period)
 (returned : rankIterate p q period = p) (reaches : Reaches q p r) : Reaches q r p := by
 obtain ⟨k,before,hk⟩ := reachesWithinCycle q p r period positive returned reaches
 refine ⟨period-k,?_⟩
 calc
   rankIterate r q (period-k) = rankIterate (rankIterate p q k) q (period-k) :=
     congrArg (fun x => rankIterate x q (period-k)) hk.symm
   _ = rankIterate p q (k+(period-k)) := (iterateAddition p q k (period-k)).symm
   _ = rankIterate p q period := congrArg _ ((Nat.add_comm _ _).trans (subtractAdd period k (Nat.le_of_lt before)))
   _ = p := returned

/-- Two source cycles with a common member have the same members. -/
theorem overlappingCyclesCoincide (q p r shared period : Nat)
 (positive : 0 < period) (pReturn : rankIterate p q period = p)
 (rReturn : rankIterate r q period = r)
 (left : Reaches q p shared) (right : Reaches q r shared) :
 ∀ x, Reaches q p x ↔ Reaches q r x := by
 have sharedToP := reachesReverse q p shared period positive pReturn left
 have sharedToR := reachesReverse q r shared period positive rReturn right
 intro x
 constructor
 · intro h
   exact reachesCompose q r p x (reachesCompose q r shared p right sharedToP) h
 · intro h
   exact reachesCompose q p r x (reachesCompose q p shared r left sharedToR) h

/-- The cycles of admitted reduced ranks are disjoint or identical; every
rank belongs to its own cycle, so there are no omitted reduced residues. -/
theorem reducedCyclotomicPartition (q p r period : Nat)
 (pp : 0 < p) (pb : p ≤ q) (pr : Nat.gcd p q = 1)
 (rp : 0 < r) (rb : r ≤ q) (rr : Nat.gcd r q = 1)
 (first : FirstBinaryOrder q period) :
 Reaches q p p ∧ Reaches q r r ∧
 (∀ shared, Reaches q p shared → Reaches q r shared →
   ∀ x, Reaches q p x ↔ Reaches q r x) := by
 refine ⟨reachesSelf q p,reachesSelf q r,?_⟩
 intro shared left right
 exact overlappingCyclesCoincide q p r shared period first.1
   ((exactExecutedReturnIffOrder p q period pp pb pr).mpr first.2.1)
   ((exactExecutedReturnIffOrder r q period rp rb rr).mpr first.2.1) left right

theorem rangeLoopMember (n x : Nat) (acc : List Nat) :
 x ∈ List.range.loop n acc ↔ x < n ∨ x ∈ acc := by
 induction n generalizing acc with
 | zero =>
   constructor
   · intro h; exact Or.inr h
   · intro h; cases h with
     | inl h => exact False.elim (Nat.not_lt_zero x h)
     | inr h => exact h
 | succ n ih =>
   change x ∈ List.range.loop n (n::acc) ↔ _
   constructor
   · intro h
     cases (ih (n::acc)).mp h with
     | inl h => exact Or.inl (Nat.lt_trans h (Nat.lt_succ_self n))
     | inr h =>
       cases h with
       | head => exact Or.inl (Nat.lt_succ_self x)
       | tail _ h => exact Or.inr h
   · intro h
     apply (ih (n::acc)).mpr
     cases h with
     | inr h => exact Or.inr (List.Mem.tail n h)
     | inl h =>
       by_cases same : x = n
       · cases same; exact Or.inr (List.Mem.head _)
       · exact Or.inl (Nat.lt_of_le_of_ne (Nat.le_of_lt_succ h) same)

theorem rangeMember (n x : Nat) : x ∈ List.range n ↔ x < n := by
 constructor
 · intro h
   cases (rangeLoopMember n x []).mp h with
   | inl h => exact h
   | inr h => cases h
 · intro h; exact (rangeLoopMember n x []).mpr (Or.inl h)

theorem mapMember {α β : Type} (f : α → β) (xs : List α) (x : α) (h : x ∈ xs) :
 f x ∈ xs.map f := by
 induction h with
 | head => exact List.Mem.head _
 | tail _ _ ih => exact List.Mem.tail _ ih

theorem mapPreimage {α β : Type} (f : α → β) (xs : List α) (y : β)
 (h : y ∈ xs.map f) : ∃ x, x ∈ xs ∧ f x = y := by
 induction xs with
 | nil => cases h
 | cons a xs ih =>
   cases h with
   | head => exact ⟨a,List.Mem.head _,rfl⟩
   | tail _ h =>
     obtain ⟨x,member,same⟩ := ih h
     exact ⟨x,List.Mem.tail _ member,same⟩

/-- Membership in the complete, executed source cycle is precisely Fold
reachability; the full range of positions, rather than a sample, is used. -/
theorem cycleMemberIffReaches (q p r period : Nat) (positive : 0 < period)
 (returned : rankIterate p q period = p) :
 r ∈ cycleSupport p q period ↔ Reaches q p r := by
 constructor
 · intro h
   obtain ⟨k,_,same⟩ := mapPreimage (rankIterate p q) (List.range period) r h
   exact ⟨k,same⟩
 · intro h
   obtain ⟨k,before,same⟩ := reachesWithinCycle q p r period positive returned h
   rw [← same]
   exact mapMember (rankIterate p q) (List.range period) k ((rangeMember period k).mpr before)

theorem cycleMembersReduced (q p r period : Nat) (hq : 0 < q) (odd : q%2=1)
 (pp : 0 < p) (pb : p ≤ q) (pr : Nat.gcd p q = 1)
 (member : r ∈ cycleSupport p q period) : 0 < r ∧ r ≤ q ∧ Nat.gcd r q = 1 := by
 obtain ⟨k,_,same⟩ := mapPreimage (rankIterate p q) (List.range period) r member
 rw [← same]
 exact ⟨(iterateBounds p q k pp pb).1,(iterateBounds p q k pp pb).2,iterateReduced p q k hq odd pr⟩

theorem completeCyclesCoincide (q p r shared period : Nat)
 (positive : 0 < period) (pReturn : rankIterate p q period = p)
 (rReturn : rankIterate r q period = r)
 (left : shared ∈ cycleSupport p q period) (right : shared ∈ cycleSupport r q period) :
 ∀ x, x ∈ cycleSupport p q period ↔ x ∈ cycleSupport r q period := by
 have same := overlappingCyclesCoincide q p r shared period positive pReturn rReturn
   ((cycleMemberIffReaches q p shared period positive pReturn).mp left)
   ((cycleMemberIffReaches q r shared period positive rReturn).mp right)
 intro x
 exact (cycleMemberIffReaches q p x period positive pReturn).trans
   ((same x).trans (cycleMemberIffReaches q r x period positive rReturn).symm)

end SFT.Mathematics.OrbitCyclotomic
