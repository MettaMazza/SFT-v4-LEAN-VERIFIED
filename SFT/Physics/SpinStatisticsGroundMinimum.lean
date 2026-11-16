import SFT.Physics.SpinStatisticsOccupationWeights
import SFT.Physics.CollectiveRadiationCompleteness
namespace SFT.Physics.SpinStatisticsGroundMinimum
open SpinStatisticsCondensation CollectiveRadiation CollectiveRadiationCompleteness
open SFT.Foundation.FractionReduction SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- The original indexed total throw, with its starting index exposed for induction.
def moment (offset : Nat) (word : List Nat) : Nat :=
 wordEnergy ((List.range word.length).map (fun i => offset+i)) word
private theorem mapCompose (xs : List Nat) (f g : Nat→Nat) :
 (xs.map f).map g=xs.map (fun x => g (f x)) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons _) ih
private theorem costsSuccessor (offset levels : Nat) :
 (List.range (levels+1)).map (fun i => offset+i)=
 offset::(List.range levels).map (fun i => (offset+1)+i) := by
 rw [SFT.Host.SHA256Chunks.rangeShift,List.map_cons,mapCompose]
 have functions : ∀ xs : List Nat,
   xs.map (fun i => offset+Nat.succ i)=xs.map (fun i => (offset+1)+i) := by
   intro xs
   induction xs with
   | nil => rfl
   | cons x xs ih =>
     have same : offset+(x+1)=(offset+1)+x := by
       rw [Nat.add_assoc,Nat.add_comm 1 x]
     exact (congrArg (fun v => v::xs.map (fun i => offset+Nat.succ i)) same).trans (congrArg (List.cons _) ih)
 rw [functions]
 rfl
theorem originalMomentSuccessor (offset c : Nat) (cs : List Nat) :
 moment offset (c::cs)=offset*c+moment (offset+1) cs := by
 unfold moment
 rw [List.length_cons,costsSuccessor,originalEnergySuccessor]
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
theorem originalOffsetDifference (offset : Nat) (word : List Nat) :
 moment (offset+1) word=word.foldl Nat.add 0+moment offset word := by
 induction word generalizing offset with
 | nil => rfl
 | cons c cs ih =>
   rw [originalMomentSuccessor,originalMomentSuccessor,ih (offset+1),sumHead,Nat.succ_mul]
   rw [Nat.add_comm (offset*c) c,Nat.add_assoc c (offset*c)]
   rw [←Nat.add_assoc (offset*c) (cs.foldl Nat.add 0),Nat.add_comm (offset*c) (cs.foldl Nat.add 0),Nat.add_assoc]
   exact (Nat.add_assoc _ _ _).symm
private theorem totalIsMoment (word : List Nat) : totalThrow word=moment 1 word := by
 unfold totalThrow moment
 have costs : ∀ xs : List Nat, xs.map (fun i => i+1)=xs.map (fun i => 1+i) := by
   intro xs
   induction xs with
   | nil => rfl
   | cons x xs ih => exact (congrArg (fun v => v::xs.map (fun i => i+1)) (Nat.add_comm x 1)).trans (congrArg (List.cons _) ih)
 rw [costs]
theorem originalThrowLowerBound (word : List Nat) : word.foldl Nat.add 0≤totalThrow word := by
 rw [totalIsMoment]
 have identity := originalOffsetDifference 0 word
 change moment 1 word=_ at identity
 rw [identity]
 exact Nat.le_add_right _ _
private theorem zeroSum (word : List Nat) (zero : word.foldl Nat.add 0=0) :
 word=List.replicate word.length 0 := by
 induction word with
 | nil => rfl
 | cons c cs ih =>
   rw [sumHead] at zero
   have hc : c=0 := Nat.eq_zero_of_le_zero (zero ▸ Nat.le_add_right c (cs.foldl Nat.add 0))
   have hs : cs.foldl Nat.add 0=0 := Nat.eq_zero_of_le_zero (calc
     cs.foldl Nat.add 0≤c+cs.foldl Nat.add 0 := Nat.le_add_left _ _
     _=0 := zero)
   change c::cs=0::List.replicate cs.length 0
   rw [hc]
   exact congrArg (List.cons 0) (ih hs)
-- Equality in the original indexed throw forces every excited cell empty.
theorem originalMinimumWord (c : Nat) (cs : List Nat)
 (minimum : totalThrow (c::cs)=(c::cs).foldl Nat.add 0) :
 c::cs=groundWord ((c::cs).foldl Nat.add 0) (c::cs).length := by
 rw [totalIsMoment,originalMomentSuccessor,originalOffsetDifference 1 cs,Nat.one_mul,sumHead] at minimum
 have remainder : moment 1 cs=0 := by
   have h := congrArg (fun k => k-(c+cs.foldl Nat.add 0)) minimum
   rw [←Nat.add_assoc,Nat.add_comm (c+cs.foldl Nat.add 0) (moment 1 cs),SFT.Foundation.ExactCast.addSubtract,Nat.sub_self] at h
   exact h
 have sumzero : cs.foldl Nat.add 0=0 := by
   have bound := originalThrowLowerBound cs
   rw [totalIsMoment,remainder] at bound
   exact Nat.eq_zero_of_le_zero bound
 have empty := zeroSum cs sumzero
 unfold groundWord
 rw [sumHead,sumzero,Nat.add_zero]
 exact congrArg (List.cons c) empty
private theorem emptyCellSum (n : Nat) : (List.replicate n 0).foldl Nat.add 0=0 := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change (0::List.replicate n 0).foldl Nat.add 0=0
   rw [sumHead,ih]
private theorem emptyCellThrow (offset n : Nat) : moment offset (List.replicate n 0)=0 := by
 induction n generalizing offset with
 | zero => rfl
 | succ n ih =>
   change moment offset (0::List.replicate n 0)=0
   rw [originalMomentSuccessor,Nat.mul_zero,ih]
private theorem emptyCellLength (n : Nat) : (List.replicate n 0).length=n := by
 induction n with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ ih

theorem originalGroundAttains (particles levels : Nat) :
 totalThrow (groundWord particles (levels+1))=particles := by
 change totalThrow (particles::List.replicate levels 0)=particles
 rw [totalIsMoment,originalMomentSuccessor,Nat.one_mul,emptyCellThrow,Nat.add_zero]
theorem originalGroundGenerated (particles levels : Nat) :
 groundWord particles (levels+1)∈walk particles levels [] particles := by
 apply (SpinStatisticsOccupationBounds.originalPreservingComplete particles levels _).mpr
 constructor
 · change (List.replicate levels 0).length+1=levels+1
   rw [emptyCellLength]
 · change (particles::List.replicate levels 0).foldl Nat.add 0=particles
   rw [sumHead,emptyCellSum,Nat.add_zero]

theorem originalExcitedThrowStrict (particles levels : Nat) (word : List Nat)
 (generated : word∈walk particles levels [] particles)
 (excited : word≠groundWord particles (levels+1)) : particles<totalThrow word := by
 have conditions := (SpinStatisticsOccupationBounds.originalPreservingComplete particles levels word).mp generated
 have bound := originalThrowLowerBound word
 rw [conditions.2] at bound
 cases Nat.lt_or_eq_of_le bound with
 | inl strict => exact strict
 | inr same =>
   have minimum : totalThrow word=word.foldl Nat.add 0 := same.symm.trans conditions.2.symm
   cases word with
   | nil => exact False.elim (Nat.noConfusion conditions.1)
   | cons c cs =>
     have ground := originalMinimumWord c cs minimum
     rw [conditions.1,conditions.2] at ground
     exact False.elim (excited ground)
end SFT.Physics.SpinStatisticsGroundMinimum
