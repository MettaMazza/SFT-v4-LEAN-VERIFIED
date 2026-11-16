import SFT.Physics.SpinStatisticsOccupationBounds
import SFT.Physics.ThermalEquilibriumPaired
import SFT.Host.SHA256Chunks
namespace SFT.Physics.SpinStatisticsOccupationCounts
open SpinStatisticsCondensation ThermalEquilibriumResponse ThermalEquilibriumPaired
open SFT.Foundation.CommonRefinement SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem chooseZero (l : Nat) : binomial l 0=1 := by
 have h := originalSplitMultiplicity 0 l
 rw [Nat.zero_add] at h
 exact h
private theorem chooseAll (n : Nat) : binomial n n=1 := by
 have h := originalSplitMultiplicity n 0
 rw [Nat.add_zero] at h
 rw [h]
 cases n <;> rfl
-- The factorial quotient already proved for043 supplies the original Pascal step.
theorem originalPascalStep (n l : Nat) :
 binomial ((n+1)+(l+1)) (n+1)=binomial (n+(l+1)) n+binomial ((n+1)+l) (n+1) := by
 rw [originalSplitMultiplicity,originalSplitMultiplicity,originalSplitMultiplicity]
 rfl
private theorem foldMapped (xs : List Nat) (f : Nat→Nat) (g : Nat→Nat→Nat) (acc : Nat) :
 (xs.map f).foldr g acc=xs.foldr (fun x a => g (f x) a) acc := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (g (f x)) ih
private theorem foldEqual (xs : List Nat) (f g : Nat→Nat) (same : ∀ c∈xs,f c=g c) :
 xs.foldr (fun c total => f c+total) 0=xs.foldr (fun c total => g c+total) 0 := by
 induction xs with
 | nil => rfl
 | cons c cs ih =>
   change f c+cs.foldr _ 0=g c+cs.foldr _ 0
   rw [same c (.head cs),ih (fun d hd => same d (.tail c hd))]
private theorem countSum (n l : Nat) :
 (List.range (n+1)).foldr (fun c total => binomial (n-c+l) (n-c)+total) 0 = binomial (n+(l+1)) n := by
 induction n with
 | zero =>
   change binomial (0+l) 0+0=binomial (0+(l+1)) 0
   rw [Nat.zero_add,Nat.zero_add,chooseZero,chooseZero]
 | succ n ih =>
   rw [SFT.Host.SHA256Chunks.rangeShift,List.foldr_cons,foldMapped]
   change binomial (n+1-0+l) (n+1-0)+
     (List.range (n+1)).foldr (fun c total => binomial (n+1-(c+1)+l) (n+1-(c+1))+total) 0 = _
   have shifted : (List.range (n+1)).foldr (fun c total => binomial (n+1-(c+1)+l) (n+1-(c+1))+total) 0 =
     (List.range (n+1)).foldr (fun c total => binomial (n-c+l) (n-c)+total) 0 := by
     apply foldEqual
     intro c _
     rw [Nat.succ_sub_succ_eq_sub]
   rw [shifted,ih,Nat.sub_zero,originalPascalStep,Nat.add_comm (binomial (n+1+l) (n+1))]
private theorem minRight (cap n : Nat) (bound : n≤cap) : min cap n=n := by
 rw [Nat.min_def]
 split
 · rename_i h
   exact Nat.le_antisymm h bound
 · rfl
private theorem flatMapLength (xs : List Nat) (f : Nat→List (List Nat)) :
 (xs.flatMap f).length=xs.foldr (fun c total => (f c).length+total) 0 := by
 induction xs with
 | nil => rfl
 | cons c cs ih =>
   change (f c++cs.flatMap f).length=_
   rw [appendLength,ih]
   rfl
-- Original recursion, arbitrary prefix, with the population-forced preserving cap.
theorem originalPreservingCount (levels cap : Nat) (prior : List Nat) (particles : Nat)
 (bound : particles≤cap) : (walk cap levels prior particles).length=binomial (particles+levels) particles := by
 induction levels generalizing prior particles with
 | zero =>
   change (if particles≤cap then [prior++[particles]] else []).length=_
   rw [if_pos bound,Nat.add_zero,chooseAll]
   rfl
 | succ levels ih =>
   change ((List.range (min cap particles+1)).flatMap
     (fun c => walk cap levels (prior++[c]) (particles-c))).length=_
   rw [minRight cap particles bound,flatMapLength]
   have converted : (List.range (particles+1)).foldr
       (fun c total => (walk cap levels (prior++[c]) (particles-c)).length+total) 0 =
     (List.range (particles+1)).foldr (fun c total => binomial (particles-c+levels) (particles-c)+total) 0 := by
     apply foldEqual
     intro c _
     exact ih (prior++[c]) (particles-c) (Nat.le_trans (Nat.sub_le _ _) bound)
   rw [converted,countSum]

theorem originalBosonCensusCount (n l : Nat) :
 (walk (n+1) l [] (n+1)).length=binomial ((n+1)+l) (n+1) :=
 originalPreservingCount l (n+1) [] (n+1) (Nat.le_refl _)
private theorem zeroPopulation (levels : Nat) (prior : List Nat) :
 (walk 1 levels prior 0).length=1 := by
 induction levels generalizing prior with
 | zero => rfl
 | succ levels ih =>
   change ((walk 1 levels (prior++[0]) 0)++[]).length=1
   rw [appendLength,List.length_nil,Nat.add_zero]
   exact ih _
private theorem sumAccumulator (counts : List Nat) (acc : Nat) :
 counts.foldl Nat.add acc=acc+counts.foldl Nat.add 0 := by
 induction counts generalizing acc with
 | nil => exact (Nat.add_zero acc).symm
 | cons c cs ih =>
   change cs.foldl Nat.add (acc+c)=acc+cs.foldl Nat.add (0+c)
   rw [ih (acc+c),ih (0+c),Nat.zero_add,Nat.add_assoc]
private theorem cappedSum (word : List Nat) (capped : ∀ c∈word,c≤1) : word.foldl Nat.add 0≤word.length := by
 induction word with
 | nil => exact Nat.le_refl _
 | cons c cs ih =>
   change cs.foldl Nat.add (0+c)≤cs.length+1
   rw [sumAccumulator,Nat.zero_add]
   have bound := Nat.add_le_add (capped c (.head cs)) (ih (fun d hd => capped d (.tail c hd)))
   rw [Nat.add_comm 1] at bound
   exact bound
private theorem overfull (levels particles : Nat) (prior : List Nat) (tooMany : levels+1<particles) :
 walk 1 levels prior particles=[] := by
 cases eq : walk 1 levels prior particles with
 | nil => rfl
 | cons word rest =>
   have held : word∈walk 1 levels prior particles := by rw [eq];exact .head _
   obtain ⟨suffix,_,length,total,capped⟩ := SpinStatisticsOccupationEnumeration.originalWalkSound 1 levels prior particles word held
   have bound := cappedSum suffix capped
   rw [length,total] at bound
   exact False.elim (Nat.not_le_of_gt tooMany bound)
private theorem alternatingStep (levels n : Nat) (prior : List Nat) :
 (walk 1 (levels+1) prior (n+1)).length=
 (walk 1 levels (prior++[0]) (n+1)).length+(walk 1 levels (prior++[1]) n).length := by
 have minimum : min 1 (n+1)=1 := by
   rw [Nat.min_def,if_pos (Nat.succ_le_succ (Nat.zero_le n))]
 change ((List.range (min 1 (n+1)+1)).flatMap (fun c => walk 1 levels (prior++[c]) (n+1-c))).length=_
 rw [minimum]
 change (walk 1 levels (prior++[0]) (n+1)++(walk 1 levels (prior++[1]) n++[])).length=_
 rw [appendLength,appendLength,List.length_nil,Nat.add_zero]
 rfl
-- A positive population with b empty levels; all source boundary cases retained.
theorem originalAlternatingCount (n b : Nat) (prior : List Nat) :
 (walk 1 (n+b) prior (n+1)).length=binomial ((n+1)+b) (n+1) := by
 induction n generalizing b prior with
 | zero =>
   induction b generalizing prior with
   | zero => rfl
   | succ b ih =>
     rw [Nat.zero_add]
     change (walk 1 (b+1) prior 1).length=binomial (1+(b+1)) 1
     rw [Nat.zero_add] at ih
     rw [alternatingStep,zeroPopulation,ih]
     have pascal := originalPascalStep 0 b
     rw [Nat.zero_add,chooseZero] at pascal
     rw [pascal,Nat.add_comm]
 | succ n ih =>
   induction b generalizing prior with
   | zero =>
     change (walk 1 (n+1) prior (n+2)).length=binomial (n+2) (n+2)
     rw [alternatingStep,overfull n (n+2) _ (Nat.lt_succ_self _)]
     change 0+(walk 1 n (prior++[1]) (n+1)).length=_
     have held := ih 0 (prior++[1])
     rw [Nat.add_zero,Nat.add_zero] at held
     rw [held,chooseAll,chooseAll]
   | succ b ib =>
     have level : (n+1)+(b+1)=((n+1)+b)+1 := rfl
     rw [level,alternatingStep,ib]
     have tail := ih (b+1) (prior++[1])
     have eq : n+(b+1)=n+1+b := (Nat.succ_add n b).symm
     rw [eq] at tail
     rw [tail]
     have pascal := originalPascalStep (n+1) b
     rw [pascal,Nat.add_comm]
theorem originalEveryOccupationCensus (n l : Nat) :
 (occupationCensus (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1)))).map Census.complete=.ok true := by
 change Except.ok (((walk (n+1) l [] (n+1)).length==binomial ((n+1)+l) (n+1)) &&
   ((walk 1 l [] (n+1)).length==(if n+1≤l+1 then binomial (l+1) (n+1) else 0)))=.ok true
 rw [originalBosonCensusCount,naturalEqualityReflexive]
 cases decision : (inferInstance : Decidable (n+1≤l+1)) with
 | isTrue bound =>
   rw [if_pos bound]
   have lower : n≤l := Nat.le_of_succ_le_succ bound
   have gap : n+(l-n)=l := (Nat.add_comm _ _).trans (subtractAdd l n lower)
   have held := originalAlternatingCount n (l-n) []
   have upper : (n+1)+(l-n)=l+1 := (Nat.succ_add _ _).trans (congrArg Nat.succ gap)
   rw [gap,upper] at held
   rw [held,naturalEqualityReflexive]
   rfl
 | isFalse bound =>
   rw [if_neg bound,SpinStatisticsOccupationBounds.originalOverfullAlternatingEmpty
     (n+1) l (Nat.lt_of_not_ge bound)]
   rfl
end SFT.Physics.SpinStatisticsOccupationCounts
