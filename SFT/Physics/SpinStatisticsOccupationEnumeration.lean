import SFT.Physics.SpinStatisticsCondensation
import SFT.Physics.CollectiveRadiationUniqueness
namespace SFT.Physics.SpinStatisticsOccupationEnumeration
open SpinStatisticsCondensation VacuumLedgerProofs SFT.Foundation.Count.TraceDerivation SFT.Foundation.FractionReduction
open SFT.Mathematics.DiscreteObjects SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem minLeft (a b : Nat) : min a b≤a := by
 rw [Nat.min_def]
 split
 · exact Nat.le_refl _
 · rename_i h
   exact Nat.le_of_lt (Nat.lt_of_not_ge h)
private theorem minRight (a b : Nat) : min a b≤b := by
 rw [Nat.min_def]
 split
 · assumption
 · exact Nat.le_refl _
private theorem minBound (c a b : Nat) (ha : c≤a) (hb : c≤b) : c≤min a b := by
 rw [Nat.min_def]
 split
 · exact ha
 · exact hb
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
-- The source's own capped occupation recursion, with its complete held prefix.
theorem originalWalkSound (cap levels : Nat) (prior : List Nat) (remaining : Nat)
 (word : List Nat) (member : word∈walk cap levels prior remaining) :
 ∃ suffix, word=prior++suffix ∧ suffix.length=levels+1 ∧
 suffix.foldl Nat.add 0=remaining ∧ ∀ c∈suffix, c≤cap := by
 induction levels generalizing prior remaining with
 | zero =>
   change word∈(if remaining≤cap then [prior++[remaining]] else []) at member
   split at member
   · rename_i bound
     cases member with
     | head =>
       refine ⟨[remaining],rfl,rfl,Nat.zero_add _,?_⟩
       intro c h
       cases h with
       | head => exact bound
       | tail _ h => cases h
     | tail _ h => cases h
   · cases member
 | succ levels ih =>
   obtain ⟨c,held,branch⟩ := memFlatMapOrigin _ (List.range (min cap remaining+1)) word member
   have bound := Nat.le_of_lt_succ ((SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mp held)
   obtain ⟨suffix,wordEq,length,total,capped⟩ := ih (prior++[c]) (remaining-c) branch
   refine ⟨c::suffix,wordEq.trans (appendAssociative prior [c] suffix),congrArg Nat.succ length,?_,?_⟩
   · rw [sumHead,total,Nat.add_comm]
     exact subtractAdd remaining c (Nat.le_trans bound (minRight _ _))
   · intro d hd
     cases hd with
     | head => exact Nat.le_trans bound (minLeft _ _)
     | tail _ h => exact capped d h

theorem originalWalkComplete (cap levels : Nat) (prior suffix : List Nat) (remaining : Nat)
 (length : suffix.length=levels+1) (total : suffix.foldl Nat.add 0=remaining)
 (capped : ∀ c∈suffix,c≤cap) : prior++suffix∈walk cap levels prior remaining := by
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
       change prior++[remaining]∈(if remaining≤cap then [prior++[remaining]] else [])
       rw [if_pos (capped remaining (.head []))]
       exact .head _
 | succ levels ih =>
   cases suffix with
   | nil => exact False.elim (Nat.noConfusion length)
   | cons c cs =>
     have tailLength : cs.length=levels+1 := Nat.succ.inj length
     have bound : c≤remaining := by rw [←total,sumHead];exact Nat.le_add_right _ _
     have tailTotal : cs.foldl Nat.add 0=remaining-c := by
       rw [←total,sumHead,Nat.add_comm c,SFT.Foundation.ExactCast.addSubtract]
     have reassociate : (prior++[c])++cs=prior++(c::cs) := appendAssociative prior [c] cs
     have kept := ih (prior++[c]) cs (remaining-c) tailLength tailTotal (fun d hd => capped d (.tail c hd))
     rw [←reassociate]
     exact memFlatMap _ (List.range (min cap remaining+1)) _ _
       ((SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mpr
         (Nat.lt_succ_of_le (minBound _ _ _ (capped c (.head cs)) bound))) kept

theorem originalWalkMembership (cap levels : Nat) (prior : List Nat) (remaining : Nat) (word : List Nat) :
 word∈walk cap levels prior remaining ↔
 ∃ suffix, word=prior++suffix ∧ suffix.length=levels+1 ∧
 suffix.foldl Nat.add 0=remaining ∧ ∀ c∈suffix,c≤cap := by
 constructor
 · exact originalWalkSound cap levels prior remaining word
 · intro held
   obtain ⟨suffix,eq,length,total,capped⟩ := held
   rw [eq]
   exact originalWalkComplete cap levels prior suffix remaining length total capped
private theorem cancelPrefix (prior left right : List Nat) (eq : prior++left=prior++right) : left=right := by
 induction prior with
 | nil => exact eq
 | cons p ps ih => exact ih (List.cons.inj eq).2
private theorem branchHeadsEqual (cap levels : Nat) (prior : List Nat) (remaining a b : Nat)
 (word : List Nat) (left : word∈walk cap levels (prior++[a]) (remaining-a))
 (right : word∈walk cap levels (prior++[b]) (remaining-b)) : a=b := by
 obtain ⟨xs,eqLeft,_,_,_⟩ := originalWalkSound _ _ _ _ word left
 obtain ⟨ys,eqRight,_,_,_⟩ := originalWalkSound _ _ _ _ word right
 have same := eqLeft.symm.trans eqRight
 rw [appendAssociative,appendAssociative] at same
 exact (List.cons.inj (cancelPrefix prior (a::xs) (b::ys) same)).1

theorem originalWalkUnique (cap levels : Nat) (prior : List Nat) (remaining : Nat) :
 distinct (walk cap levels prior remaining)=true := by
 induction levels generalizing prior remaining with
 | zero =>
   change distinct (if remaining≤cap then [prior++[remaining]] else [])=true
   cases decision : (inferInstance : Decidable (remaining≤cap)) with
   | isTrue h => rw [if_pos h];rfl
   | isFalse h => rw [if_neg h];rfl
 | succ levels ih =>
   have branches : ∀ axis : List Nat, distinct axis=true →
     distinct (axis.flatMap (fun count => walk cap levels (prior++[count]) (remaining-count)))=true := by
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
         have same := branchHeadsEqual cap levels prior remaining a b word first branch
         rw [←same] at held
         exact (absentIff _ _).mp parts.1 held
   exact branches (List.range (min cap remaining+1)) (CollectiveRadiationUniqueness.originalRangeUnique _)

theorem originalPreservingOperation (n l : Nat) :
 occupationVectors (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1))) "preserving" =
 .ok (walk (n+1) l [] (n+1)) := rfl
theorem originalAlternatingOperation (n l : Nat) :
 occupationVectors (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1))) "alternating" =
 .ok (walk 1 l [] (n+1)) := rfl
end SFT.Physics.SpinStatisticsOccupationEnumeration
