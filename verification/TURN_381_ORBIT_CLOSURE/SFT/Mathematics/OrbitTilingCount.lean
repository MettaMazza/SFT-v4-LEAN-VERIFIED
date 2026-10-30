import SFT.Mathematics.OrbitCyclotomic
namespace SFT.Mathematics.OrbitTilingCount
open OrbitOrderIdentity OrbitCycleSupport OrbitCyclotomic
open SFT.Foundation.FractionReduction

def Unique : List Nat → Prop
 | [] => True
 | x::xs => (¬ x ∈ xs) ∧ Unique xs

theorem filterMember (p : Nat → Bool) (xs : List Nat) (x : Nat) :
 x ∈ xs.filter p ↔ x ∈ xs ∧ p x = true := by
 induction xs with
 | nil =>
   constructor
   · intro h; cases h
   · intro h; cases h.1
 | cons a xs ih =>
   change x ∈ (match p a with | true => a::xs.filter p | false => xs.filter p) ↔ _
   cases ha : p a with
   | false =>
     constructor
     · intro h; have h := ih.mp h; exact ⟨List.Mem.tail a h.1,h.2⟩
     · intro h
       cases h.1 with
       | head => rw [ha] at h; cases h.2
       | tail _ m => exact ih.mpr ⟨m,h.2⟩
   | true =>
     constructor
     · intro h
       cases h with
       | head => exact ⟨List.Mem.head _,ha⟩
       | tail _ m => have h := ih.mp m; exact ⟨List.Mem.tail a h.1,h.2⟩
     · intro h
       cases h.1 with
       | head => exact List.Mem.head _
       | tail _ m => exact List.Mem.tail _ (ih.mpr ⟨m,h.2⟩)

theorem uniqueFilter (p : Nat → Bool) (xs : List Nat) (h : Unique xs) : Unique (xs.filter p) := by
 induction xs with
 | nil => trivial
 | cons a xs ih =>
   change Unique (match p a with | true => a::xs.filter p | false => xs.filter p)
   cases p a with
   | false => exact ih h.2
   | true => exact ⟨fun m => h.1 ((filterMember p xs a).mp m).1,ih h.2⟩

theorem filterLength (p : Nat → Bool) (xs : List Nat) : (xs.filter p).length ≤ xs.length := by
 induction xs with
 | nil => exact Nat.le_refl _
 | cons a xs ih =>
   change (match p a with | true => a::xs.filter p | false => xs.filter p).length ≤ xs.length+1
   cases p a with
   | false => exact Nat.le_trans ih (Nat.le_succ _)
   | true => exact Nat.succ_le_succ ih

theorem filterRemovalShorter (p : Nat → Bool) (xs : List Nat) (x : Nat)
 (member : x ∈ xs) (removed : p x = false) : (xs.filter p).length < xs.length := by
 induction xs with
 | nil => cases member
 | cons a xs ih =>
   change (match p a with | true => a::xs.filter p | false => xs.filter p).length < xs.length+1
   cases ha : p a with
   | false => exact Nat.lt_succ_of_le (filterLength p xs)
   | true =>
     have tail : x ∈ xs := by
       cases member with
       | head => rw [removed] at ha; cases ha
       | tail _ h => exact h
     exact Nat.succ_lt_succ (ih tail)

theorem subsetLength (xs ys : List Nat) (unique : Unique xs)
 (subset : ∀ x, x ∈ xs → x ∈ ys) : xs.length ≤ ys.length := by
 induction xs generalizing ys with
 | nil => exact Nat.zero_le _
 | cons a xs ih =>
   have shorter := filterRemovalShorter (fun x => decide (x ≠ a)) ys a
     (subset a (List.Mem.head _)) (decide_eq_false (fun h => h rfl))
   have bound := ih (ys.filter (fun x => decide (x ≠ a))) unique.2 (by
     intro x m
     apply (filterMember _ _ _).mpr
     refine ⟨subset x (List.Mem.tail _ m),decide_eq_true ?_⟩
     intro same; cases same; exact unique.1 m)
   exact Nat.succ_le_of_lt (Nat.lt_of_le_of_lt bound shorter)

theorem sameMembersLength (xs ys : List Nat) (ux : Unique xs) (uy : Unique ys)
 (same : ∀ x, x ∈ xs ↔ x ∈ ys) : xs.length = ys.length :=
 Nat.le_antisymm (subsetLength xs ys ux (fun x h => (same x).mp h))
   (subsetLength ys xs uy (fun x h => (same x).mpr h))

theorem splitLength (p : Nat → Bool) (xs : List Nat) :
 (xs.filter p).length + (xs.filter (fun x => !p x)).length = xs.length := by
 induction xs with
 | nil => rfl
 | cons a xs ih =>
   change (match p a with | true => a::xs.filter p | false => xs.filter p).length +
     (match !p a with | true => a::xs.filter (fun x => !p x) | false => xs.filter (fun x => !p x)).length = xs.length+1
   cases p a with
   | false => exact congrArg Nat.succ ih
   | true => exact (Nat.succ_add _ _).trans (congrArg Nat.succ ih)

theorem uniqueRangeLoop (n : Nat) (acc : List Nat) (unique : Unique acc)
 (after : ∀ x, x ∈ acc → n ≤ x) : Unique (List.range.loop n acc) := by
 induction n generalizing acc with
 | zero => exact unique
 | succ n ih =>
   apply ih (n::acc)
   · exact ⟨fun m => Nat.not_succ_le_self n (after n m),unique⟩
   · intro x h
     cases h with
     | head => exact Nat.le_refl _
     | tail _ m => exact Nat.le_trans (Nat.le_succ _) (after x m)

theorem uniqueRange (n : Nat) : Unique (List.range n) :=
 uniqueRangeLoop n [] True.intro (fun _ h => by cases h)

theorem uniqueMap (f : Nat → Nat) (xs : List Nat) (unique : Unique xs)
 (injective : ∀ x, x ∈ xs → ∀ y, y ∈ xs → f x = f y → x = y) : Unique (xs.map f) := by
 induction xs with
 | nil => trivial
 | cons a xs ih =>
   constructor
   · intro h
     obtain ⟨x,m,same⟩ := mapPreimage f xs (f a) h
     have eq := injective x (List.Mem.tail _ m) a (List.Mem.head _) same
     cases eq; exact unique.1 m
   · exact ih unique.2 (fun x hx y hy eq => injective x (List.Mem.tail _ hx) y (List.Mem.tail _ hy) eq)

theorem cycleUnique (p q period : Nat) (hq : 0 < q) (odd : q%2=1)
 (reduced : Nat.gcd p q = 1) (first : FirstBinaryOrder q period) : Unique (cycleSupport p q period) :=
 uniqueMap (rankIterate p q) (List.range period) (uniqueRange period)
   (fun i hi j hj same => positionsInjective p q period i j hq odd reduced first
     ((rangeMember period i).mp hi) ((rangeMember period j).mp hj) same)

theorem negTrue (b : Bool) : (!b) = true ↔ b = false := by
 cases b <;> decide

def has (xs : List Nat) (x : Nat) : Bool :=
 match xs with
 | [] => false
 | y::ys => if x = y then true else has ys x

theorem hasMember (xs : List Nat) (x : Nat) : has xs x = true ↔ x ∈ xs := by
 induction xs with
 | nil => constructor <;> intro h <;> cases h
 | cons y ys ih =>
   unfold has
   by_cases same : x = y
   · rw [ite_eq_left same]
     constructor
     · intro _; cases same; exact List.Mem.head _
     · intro _; rfl
   · rw [ite_eq_right same]
     constructor
     · intro h; exact List.Mem.tail _ (ih.mp h)
     · intro h
       cases h with
       | head => exact False.elim (same rfl)
       | tail _ m => exact ih.mpr m

theorem hasAbsent (xs : List Nat) (x : Nat) (absent : ¬ x ∈ xs) : has xs x = false := by
 cases eq : has xs x with
 | false => rfl
 | true => exact False.elim (absent ((hasMember xs x).mp eq))

theorem countClosedCyclesAux (q period size : Nat) (hq : 0 < q) (odd : q%2=1)
 (first : FirstBinaryOrder q period) (support : List Nat) (sizeEq : support.length = size)
 (unique : Unique support)
 (admitted : ∀ p, p ∈ support → 0 < p ∧ p ≤ q ∧ Nat.gcd p q = 1)
 (closed : ∀ p, p ∈ support → ∀ x, x ∈ cycleSupport p q period → x ∈ support) :
 ∃ count, support.length = period*count := by
 induction size using Nat.strongRecOn generalizing support with
 | ind size ih =>
   cases support with
   | nil => exact ⟨0,(Nat.mul_zero period).symm⟩
   | cons p ps =>
     let held := cycleSupport p q period
     let selected : Nat → Bool := fun x => has held x
     let rest := (p::ps).filter (fun x => !selected x)
     have pAdmitted := admitted p (List.Mem.head _)
     have returned := (exactExecutedReturnIffOrder p q period pAdmitted.1 pAdmitted.2.1 pAdmitted.2.2).mpr first.2.1
     have self : p ∈ held := (cycleMemberIffReaches q p p period first.1 returned).mpr (reachesSelf q p)
     have pSelected : selected p = true := (hasMember held p).mpr self
     have removed : (!selected p) = false := by rw [pSelected]; rfl
     have smaller : rest.length < size := by
       rw [← sizeEq]
       exact filterRemovalShorter (fun x => !selected x) (p::ps) p (List.Mem.head _) removed
     have restAdmitted : ∀ r, r ∈ rest → 0 < r ∧ r ≤ q ∧ Nat.gcd r q = 1 := by
       intro r member
       exact admitted r ((filterMember _ _ _).mp member).1
     have restClosed : ∀ r, r ∈ rest → ∀ x, x ∈ cycleSupport r q period → x ∈ rest := by
       intro r member x inCycle
       have rm := (filterMember _ _ _).mp member
       have ra := admitted r rm.1
       apply (filterMember _ _ _).mpr
       refine ⟨closed r rm.1 x inCycle,(negTrue (selected x)).mpr ?_⟩
       apply hasAbsent
       intro inHeld
       have rReturn := (exactExecutedReturnIffOrder r q period ra.1 ra.2.1 ra.2.2).mpr first.2.1
       have same := completeCyclesCoincide q p r x period first.1 returned rReturn inHeld inCycle
       have rSelf := (cycleMemberIffReaches q r r period first.1 rReturn).mpr (reachesSelf q r)
       have rHeld := (same r).mpr rSelf
       have rSelected : selected r = true := (hasMember held r).mpr rHeld
       have rNotSelected := (negTrue (selected r)).mp rm.2
       rw [rSelected] at rNotSelected
       cases rNotSelected
     obtain ⟨count,countEq⟩ := ih rest.length smaller rest rfl
       (uniqueFilter _ _ unique) restAdmitted restClosed
     have selectedSize : ((p::ps).filter selected).length = period := by
       have same : ∀ x, x ∈ (p::ps).filter selected ↔ x ∈ held := by
         intro x
         constructor
         · intro h; exact (hasMember held x).mp ((filterMember _ _ _).mp h).2
         · intro h
           exact (filterMember _ _ _).mpr ⟨closed p (List.Mem.head _) x h,(hasMember held x).mpr h⟩
       exact (sameMembersLength _ held (uniqueFilter _ _ unique)
         (cycleUnique p q period hq odd pAdmitted.2.2 first) same).trans
         (completeCycleCardinality p q period)
     refine ⟨count+1,?_⟩
     have split := splitLength selected (p::ps)
     rw [selectedSize] at split
     change period + rest.length = (p::ps).length at split
     rw [countEq] at split
     exact split.symm.trans ((Nat.add_comm _ _).trans (Nat.mul_succ period count).symm)

/-- Exact finite counting of the disjoint complete Fold cycles. Each
recursive removal deletes a whole cycle, not sampled representatives. -/
theorem closedResidueCount (q period : Nat) (hq : 0 < q) (odd : q%2=1)
 (first : FirstBinaryOrder q period) (support : List Nat) (unique : Unique support)
 (admitted : ∀ p, p ∈ support → 0 < p ∧ p ≤ q ∧ Nat.gcd p q = 1)
 (closed : ∀ p, p ∈ support → ∀ x, x ∈ cycleSupport p q period → x ∈ support) :
 ∃ count, support.length = period*count :=
 countClosedCyclesAux q period support.length hq odd first support rfl unique admitted closed

def positiveRanks (q : Nat) : List Nat := (List.range (q-1)).map (fun i => i+1)

def reducedResidues (q : Nat) : List Nat :=
 (positiveRanks q).filter (fun p => decide (Nat.gcd p q = 1))

theorem positiveRankMember (q p : Nat) (hq : 0 < q) :
 p ∈ positiveRanks q ↔ 0 < p ∧ p < q := by
 have qForm : q = (q-1)+1 := (subtractAdd q 1 hq).symm
 constructor
 · intro h
   obtain ⟨i,member,same⟩ := mapPreimage (fun i => i+1) (List.range (q-1)) p h
   have before := (rangeMember (q-1) i).mp member
   rw [← same]
   refine ⟨Nat.zero_lt_succ _,?_⟩
   rw [qForm]
   exact Nat.succ_lt_succ before
 · intro h
   have pForm : p = (p-1)+1 := (subtractAdd p 1 h.1).symm
   have before : p-1 < q-1 := by
     have bound := h.2
     rw [qForm,pForm] at bound
     exact Nat.lt_of_succ_lt_succ bound
   have member := mapMember (fun i => i+1) (List.range (q-1)) (p-1)
     ((rangeMember (q-1) (p-1)).mpr before)
   rw [← pForm] at member
   exact member

theorem reducedResidueMember (q p : Nat) (hq : 0 < q) :
 p ∈ reducedResidues q ↔ 0 < p ∧ p < q ∧ Nat.gcd p q = 1 := by
 constructor
 · intro h
   have parts := (filterMember _ _ _).mp h
   have bounds := (positiveRankMember q p hq).mp parts.1
   exact ⟨bounds.1,bounds.2,of_decide_eq_true parts.2⟩
 · intro h
   exact (filterMember _ _ _).mpr ⟨(positiveRankMember q p hq).mpr ⟨h.1,h.2.1⟩,decide_eq_true h.2.2⟩

theorem positiveRanksUnique (q : Nat) : Unique (positiveRanks q) :=
 uniqueMap (fun i => i+1) (List.range (q-1)) (uniqueRange (q-1))
   (fun _ _ _ _ same => Nat.succ.inj same)

theorem reducedResiduesClosed (q period : Nat) (aboveOne : 1 < q) (odd : q%2=1)
 (p : Nat) (member : p ∈ reducedResidues q) (x : Nat)
 (inCycle : x ∈ cycleSupport p q period) : x ∈ reducedResidues q := by
 have hq := Nat.lt_trans (Nat.zero_lt_succ 0) aboveOne
 have pa := (reducedResidueMember q p hq).mp member
 have xa := cycleMembersReduced q p x period hq odd pa.1 (Nat.le_of_lt pa.2.1) pa.2.2 inCycle
 have unequal : x ≠ q := by
   intro same
   have eq := xa.2.2
   rw [same,gcdSelf] at eq
   exact (Nat.ne_of_gt aboveOne) eq
 exact (reducedResidueMember q x hq).mpr ⟨xa.1,Nat.lt_of_le_of_ne xa.2.1 unequal,xa.2.2⟩

/-- The source reduced-residue count is exactly orbit length times orbit
count, for every supplied odd denominator above the One and its first order. -/
theorem reducedResidueProduct (q period : Nat) (aboveOne : 1 < q) (odd : q%2=1)
 (first : FirstBinaryOrder q period) :
 ∃ count, (reducedResidues q).length = period*count := by
 have hq := Nat.lt_trans (Nat.zero_lt_succ 0) aboveOne
 apply closedResidueCount q period hq odd first (reducedResidues q)
 · exact uniqueFilter _ _ (positiveRanksUnique q)
 · intro p member
   have h := (reducedResidueMember q p hq).mp member
   exact ⟨h.1,Nat.le_of_lt h.2.1,h.2.2⟩
 · exact reducedResiduesClosed q period aboveOne odd

def PrimeDenominator (q : Nat) : Prop :=
 1 < q ∧ ∀ d, d ∣ q → d = 1 ∨ d = q

theorem primeRankReduced (q p : Nat) (prime : PrimeDenominator q)
 (positive : 0 < p) (below : p < q) : Nat.gcd p q = 1 := by
 have factors := gcdDivides p q
 cases prime.2 (Nat.gcd p q) factors.2 with
 | inl h => exact h
 | inr h =>
   rw [h] at factors
   exact False.elim (Nat.not_le_of_gt below (divisorBound q p positive factors.1))

theorem filterAll (p : Nat → Bool) (xs : List Nat) (all : ∀ x, x ∈ xs → p x = true) :
 xs.filter p = xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
   change (match p x with | true => x::xs.filter p | false => xs.filter p) = x::xs
   rw [all x (List.Mem.head _)]
   exact congrArg (List.cons x) (ih (fun y h => all y (List.Mem.tail x h)))

theorem primeReducedCount (q : Nat) (prime : PrimeDenominator q) :
 (reducedResidues q).length = q-1 := by
 have hq := Nat.lt_trans (Nat.zero_lt_succ 0) prime.1
 have all : reducedResidues q = positiveRanks q := filterAll _ _ (by
   intro p member
   have bounds := (positiveRankMember q p hq).mp member
   exact decide_eq_true (primeRankReduced q p prime bounds.1 bounds.2))
 rw [all]
 unfold positiveRanks
 rw [mappedLength]
 exact rangeLoopLength (q-1) []

/-- Prime-period divisibility follows from the complete cyclotomic tiling
and the count of all positive residues below the prime. -/
theorem primePeriodDivides (q period : Nat) (prime : PrimeDenominator q)
 (odd : q%2=1) (first : FirstBinaryOrder q period) : period ∣ q-1 := by
 obtain ⟨count,eq⟩ := reducedResidueProduct q period prime.1 odd first
 rw [primeReducedCount q prime] at eq
 exact ⟨count,eq⟩

end SFT.Mathematics.OrbitTilingCount
