import SFT.Physics.ThermalEquilibriumMultinomial
import SFT.Physics.CollectiveRadiationUniqueness
namespace SFT.Physics.ThermalEquilibriumEnumeration
open ThermalEquilibriumResponse ThermalEquilibriumWeights ThermalEquilibriumMultinomial
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.FractionReduction
open SFT.Mathematics.DiscreteObjects VacuumLedgerProofs SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000

private theorem sumAccumulator (counts : List Nat) (acc : Nat) :
 counts.foldl Nat.add acc=acc+counts.foldl Nat.add 0 := by
 induction counts generalizing acc with
 | nil => exact (Nat.add_zero acc).symm
 | cons c cs ih =>
   change cs.foldl Nat.add (acc+c)=acc+cs.foldl Nat.add (0+c)
   rw [ih (acc+c),ih (0+c),Nat.zero_add,Nat.add_assoc]
private theorem sumHead (c : Nat) (cs : List Nat) :
 (c::cs).foldl Nat.add 0=c+cs.foldl Nat.add 0 := by
 change cs.foldl Nat.add (0+c)=_
 rw [Nat.zero_add,sumAccumulator]

-- Exact invariant of the original recursive walk, including its held prefix.
theorem originalWalkSound (throw levels : Nat) (prior : List Nat) (remaining : Nat)
 (word : List Nat) (member : word∈walkForms throw levels prior remaining) :
 ∃ suffix, word=prior++suffix ∧ suffix.length=levels+1 ∧
   suffix.foldl Nat.add 0=remaining ∧ countedThrow word=throw := by
 induction levels generalizing prior remaining with
 | zero =>
   change word∈(if countedThrow (prior++[remaining])==throw then [prior++[remaining]] else []) at member
   cases decision : countedThrow (prior++[remaining])==throw with
   | false => rw [decision] at member; cases member
   | true =>
     rw [decision] at member
     cases member with
     | head => exact ⟨[remaining],rfl,rfl,Nat.zero_add _,Nat.eq_of_beq_eq_true decision⟩
     | tail _ impossible => cases impossible
 | succ levels ih =>
   obtain ⟨c,held,branch⟩ := memFlatMapOrigin _ (List.range (remaining+1)) word member
   obtain ⟨suffix,wordEq,length,total,throwEq⟩ := ih (prior++[c]) (remaining-c) branch
   refine ⟨c::suffix,?_,?_,?_,throwEq⟩
   · exact wordEq.trans (appendAssociative prior [c] suffix)
   · exact congrArg Nat.succ length
   · rw [sumHead,total,Nat.add_comm]
     exact subtractAdd remaining c (Nat.le_of_lt_succ ((SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mp held))

theorem originalWalkComplete (throw levels : Nat) (prior suffix : List Nat) (remaining : Nat)
 (length : suffix.length=levels+1) (total : suffix.foldl Nat.add 0=remaining)
 (throwEq : countedThrow (prior++suffix)=throw) : prior++suffix∈walkForms throw levels prior remaining := by
 induction levels generalizing prior suffix remaining with
 | zero =>
   cases suffix with
   | nil => exact False.elim (Nat.noConfusion length)
   | cons c cs =>
     cases cs with
     | cons d ds => exact False.elim (Nat.noConfusion (Nat.succ.inj length))
     | nil =>
       have same : c=remaining := (Nat.zero_add c).symm.trans total
       cases same
       change prior++[remaining]∈(if countedThrow (prior++[remaining])==throw then [prior++[remaining]] else [])
       rw [throwEq]
       have eq : (throw==throw)=true := naturalEqualityReflexive throw
       rw [eq]
       exact .head _
 | succ levels ih =>
   cases suffix with
   | nil => exact False.elim (Nat.noConfusion length)
   | cons c cs =>
     have tailLength : cs.length=levels+1 := Nat.succ.inj length
     have bound : c≤remaining := by rw [←total,sumHead]; exact Nat.le_add_right _ _
     have tailTotal : cs.foldl Nat.add 0=remaining-c := by
       rw [←total,sumHead,Nat.add_comm c,SFT.Foundation.ExactCast.addSubtract]
     have reassociate : (prior++[c])++cs=prior++(c::cs) := appendAssociative prior [c] cs
     have tailThrow : countedThrow ((prior++[c])++cs)=throw := by rw [reassociate]; exact throwEq
     have kept := ih (prior++[c]) cs (remaining-c) tailLength tailTotal tailThrow
     rw [←reassociate]
     exact memFlatMap _ (List.range (remaining+1)) _ _
       ((SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mpr (Nat.lt_succ_of_le bound)) kept

theorem originalWalkMembership (throw levels : Nat) (prior : List Nat) (remaining : Nat) (word : List Nat) :
 word∈walkForms throw levels prior remaining ↔
 ∃ suffix, word=prior++suffix ∧ suffix.length=levels+1 ∧
   suffix.foldl Nat.add 0=remaining ∧ countedThrow word=throw := by
 constructor
 · exact originalWalkSound throw levels prior remaining word
 · intro held
   obtain ⟨suffix,eq,length,total,throwEq⟩ := held
   rw [eq] at throwEq ⊢
   exact originalWalkComplete throw levels prior suffix remaining length total throwEq

theorem originalCompleteFixedCountThrowCensus (n : Nat) (word : List Nat) :
 word∈walkForms (countedThrow (originalCounts n)) (n+1) [] ((originalCounts n).foldl Nat.add 0) ↔
 word.length=n+2 ∧ word.foldl Nat.add 0=(originalCounts n).foldl Nat.add 0 ∧
 countedThrow word=countedThrow (originalCounts n) := by
 constructor
 · intro member
   obtain ⟨suffix,eq,length,total,throwEq⟩ := originalWalkSound _ _ _ _ word member
   change word=suffix at eq
   rw [←eq] at length total
   exact ⟨length,total,throwEq⟩
 · intro conditions
   exact originalWalkComplete _ (n+1) [] word _ conditions.1 conditions.2.1 conditions.2.2

private theorem cancelPrefix (prior left right : List Nat) (eq : prior++left=prior++right) : left=right := by
 induction prior with
 | nil => exact eq
 | cons p ps ih => exact ih (List.cons.inj eq).2
private theorem branchHeadsEqual (throw levels : Nat) (prior : List Nat) (remaining a b : Nat)
 (word : List Nat) (left : word∈walkForms throw levels (prior++[a]) (remaining-a))
 (right : word∈walkForms throw levels (prior++[b]) (remaining-b)) : a=b := by
 obtain ⟨xs,eqLeft,_,_,_⟩ := originalWalkSound _ _ _ _ word left
 obtain ⟨ys,eqRight,_,_,_⟩ := originalWalkSound _ _ _ _ word right
 have same := eqLeft.symm.trans eqRight
 rw [appendAssociative,appendAssociative] at same
 exact (List.cons.inj (cancelPrefix prior (a::xs) (b::ys) same)).1

theorem originalWalkUnique (throw levels : Nat) (prior : List Nat) (remaining : Nat) :
 distinct (walkForms throw levels prior remaining)=true := by
 induction levels generalizing prior remaining with
 | zero =>
   change distinct (if countedThrow (prior++[remaining])==throw then [prior++[remaining]] else [])=true
   cases countedThrow (prior++[remaining])==throw <;> rfl
 | succ levels ih =>
   have branches : ∀ axis : List Nat, distinct axis=true →
     distinct (axis.flatMap (fun count => walkForms throw levels (prior++[count]) (remaining-count)))=true := by
     intro axis unique
     induction axis with
     | nil => rfl
     | cons a rest induction =>
       have parts := (distinctCons _ _).mp unique
       apply appendDistinct
       · exact ih (prior++[a]) (remaining-a)
       · exact induction parts.2
       · intro word first later
         obtain ⟨b,held,branch⟩ := memFlatMapOrigin _ rest word later
         have same := branchHeadsEqual throw levels prior remaining a b word first branch
         rw [←same] at held
         exact (absentIff _ _).mp parts.1 held
   exact branches (List.range (remaining+1)) (CollectiveRadiationUniqueness.originalRangeUnique _)

def originalForms (n : Nat) : List (List Nat) :=
 walkForms (countedThrow (originalCounts n)) (n+1) [] ((originalCounts n).foldl Nat.add 0)

theorem originalFormsOperation (n : Nat) :
 fixedCountThrowForms (.integer (.ofNat (n+2)))=.ok (originalForms n) := by
 unfold fixedCountThrowForms
 rw [originalCountOperation]
 change Except.ok (walkForms (countedThrow (originalCounts n)) ((originalCounts n).length-1) []
   ((originalCounts n).foldl Nat.add 0)) = _
 rw [originalDyadicCountLength]
 rfl

theorem originalTargetPresent (n : Nat) : originalCounts n∈originalForms n :=
 (originalCompleteFixedCountThrowCensus n _).mpr ⟨originalDyadicCountLength n,rfl,rfl⟩

theorem originalFormsUnique (n : Nat) : distinct (originalForms n)=true := originalWalkUnique _ _ _ _

theorem originalEnumeratedStrictMaximum (n : Nat) (word : List Nat)
 (member : word∈originalForms n) (different : originalCounts n≠word) :
 multinomialCount word<multinomialCount (originalCounts n) := by
 have conditions := (originalCompleteFixedCountThrowCensus n word).mp member
 exact originalDyadicMultinomialStrictMaximum n word conditions.1 conditions.2.1.symm conditions.2.2.symm different
private theorem maxLeft (a b : Nat) : a≤max a b := by
 rw [Nat.max_def]
 split
 · assumption
 · exact Nat.le_refl _
private theorem maxRight (a b : Nat) : b≤max a b := by
 rw [Nat.max_def]
 split
 · exact Nat.le_refl _
 · rename_i h
   cases Nat.le_total a b with
   | inl hab => exact False.elim (h hab)
   | inr hba => exact hba
private theorem maxBound (a b c : Nat) (ha : a≤c) (hb : b≤c) : max a b≤c := by
 rw [Nat.max_def]
 split
 · exact hb
 · exact ha

private theorem maximumBound (target : List Nat) (words : List (List Nat))
 (bound : ∀ w ∈ words, multinomialCount w≤multinomialCount target) (acc : Nat)
 (initial : acc≤multinomialCount target) :
 ((words.map (fun w => (w,multinomialCount w))).foldl (fun m row => max m row.2) acc)≤multinomialCount target := by
 induction words generalizing acc with
 | nil => exact initial
 | cons w ws ih =>
   exact ih (fun v hv => bound v (.tail w hv)) _
     (maxBound _ _ _ initial (bound w (.head ws)))
private theorem maximumRetains (words : List (List Nat)) (acc : Nat) :
 acc≤((words.map (fun w => (w,multinomialCount w))).foldl (fun m row => max m row.2) acc) := by
 induction words generalizing acc with
 | nil => exact Nat.le_refl _
 | cons w ws ih => exact Nat.le_trans (maxLeft _ _) (ih _)
private theorem maximumIncludes (words : List (List Nat)) (acc : Nat) (target : List Nat) (held : target∈words) :
 multinomialCount target≤((words.map (fun w => (w,multinomialCount w))).foldl (fun m row => max m row.2) acc) := by
 induction words generalizing acc with
 | nil => cases held
 | cons w ws ih =>
   cases held with
   | head => exact Nat.le_trans (maxRight _ _) (maximumRetains ws _)
   | tail _ member => exact ih _ member

theorem originalMaximumFold (n : Nat) :
 (((originalForms n).map (fun w => (w,multinomialCount w))).foldl (fun m row => max m row.2) 0)=
 multinomialCount (originalCounts n) := by
 apply Nat.le_antisymm
 · apply maximumBound _ _ _ 0 (Nat.zero_le _)
   intro word member
   cases decEq word (originalCounts n) with
   | isTrue eq => rw [eq]; exact Nat.le_refl _
   | isFalse different => exact Nat.le_of_lt (originalEnumeratedStrictMaximum n word member (fun eq => different eq.symm))
 · exact maximumIncludes _ 0 _ (originalTargetPresent n)

private theorem mappedSelection (target : List Nat) (words : List (List Nat)) :
 (((words.map (fun w => (w,multinomialCount w))).filter
   (fun row => row.2==multinomialCount target)).map Prod.fst)=
 words.filter (fun w => multinomialCount w==multinomialCount target) := by
 induction words with
 | nil => rfl
 | cons w ws ih =>
   change (((w,multinomialCount w)::ws.map (fun w => (w,multinomialCount w))).filter
     (fun row => row.2==multinomialCount target)).map Prod.fst = _
   cases h : multinomialCount w==multinomialCount target with
   | false =>
     rw [List.filter_cons_of_neg (p:=fun row : List Nat×Nat => row.2==multinomialCount target)
       (fun ht => Bool.noConfusion (h.symm.trans ht))]
     rw [List.filter_cons_of_neg (p:=fun w => multinomialCount w==multinomialCount target)
       (fun ht => Bool.noConfusion (h.symm.trans ht))]
     exact ih
   | true =>
     rw [List.filter_cons_of_pos (p:=fun row : List Nat×Nat => row.2==multinomialCount target) h,
       List.filter_cons_of_pos (p:=fun w => multinomialCount w==multinomialCount target) h]
     exact congrArg (List.cons w) ih

private theorem selectionAbsent (p : List Nat→Bool) (target : List Nat) (words : List (List Nat))
 (absent : ¬target∈words) (accepted : ∀ w ∈ words, p w=true → w=target) : words.filter p=[] := by
 induction words with
 | nil => rfl
 | cons w ws ih =>
   have rejected : ¬p w=true := fun h => absent ((accepted w (.head ws) h) ▸ List.Mem.head ws)
   rw [List.filter_cons_of_neg rejected]
   exact ih (fun h => absent (.tail w h)) (fun v hv => accepted v (.tail w hv))
private theorem selectionUnique (p : List Nat→Bool) (target : List Nat) (words : List (List Nat))
 (unique : distinct words=true) (held : target∈words)
 (accepted : ∀ w ∈ words, p w=true ↔ w=target) : words.filter p=[target] := by
 induction words with
 | nil => cases held
 | cons w ws ih =>
   have parts := (distinctCons _ _).mp unique
   cases decEq w target with
   | isTrue eq =>
     cases eq
     rw [List.filter_cons_of_pos ((accepted target (.head ws)).mpr rfl)]
     rw [selectionAbsent p target ws ((absentIff _ _).mp parts.1)
       (fun v hv => (accepted v (.tail target hv)).mp)]
   | isFalse different =>
     rw [List.filter_cons_of_neg (fun h => different ((accepted w (.head ws)).mp h))]
     apply ih parts.2
     · cases held with
       | head => exact False.elim (different rfl)
       | tail _ h => exact h
     · exact fun v hv => accepted v (.tail w hv)

theorem originalSurvivorList (n : Nat) :
 ((((originalForms n).map (fun w => (w,multinomialCount w))).filter
   (fun row => row.2==multinomialCount (originalCounts n))).map Prod.fst)=[originalCounts n] := by
 rw [mappedSelection]
 apply selectionUnique _ _ _ (originalFormsUnique n) (originalTargetPresent n)
 intro word member
 constructor
 · intro accepted
   cases decEq word (originalCounts n) with
   | isTrue eq => exact eq
   | isFalse different =>
     have strict := originalEnumeratedStrictMaximum n word member (fun eq => different eq.symm)
     rw [Nat.eq_of_beq_eq_true accepted] at strict
     exact False.elim (Nat.lt_irrefl _ strict)
 · intro eq
   rw [eq]
   exact naturalEqualityReflexive _

private theorem wordEquality (word : List Nat) : (word==word)=true := by
 induction word with
 | nil => rfl
 | cons c cs ih =>
   change ((c==c)&&(cs==cs))=true
   rw [naturalEqualityReflexive,ih]
   rfl

theorem originalEveryCanonicalMaximumCertificate (n : Nat) :
 canonicalMaximumCertificate (.integer (.ofNat (n+2))) = .ok
   ⟨originalCounts n,(originalForms n).length,[originalCounts n],true⟩ := by
 unfold canonicalMaximumCertificate
 rw [originalCountOperation,originalFormsOperation]
 dsimp only [Except.bind,Bind.bind]
 rw [originalMaximumFold,originalSurvivorList]
 have unique : ([originalCounts n]==[originalCounts n])=true := by
   change ((originalCounts n==originalCounts n)&&true)=true
   rw [wordEquality]
   rfl
 rw [unique]
 rfl
end SFT.Physics.ThermalEquilibriumEnumeration
