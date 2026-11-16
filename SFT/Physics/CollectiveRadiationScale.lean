import SFT.Physics.CollectiveRadiationCensus
import SFT.Foundation.FractionReduction
namespace SFT.Physics.CollectiveRadiationScale
open CollectiveRadiation SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

theorem originalScaledCostLimit (scale cost total : Nat) (hs : 0<scale) (hc : 0<cost) :
 (scale*total)/(scale*cost)=total/cost := by
 induction total using Nat.strongRecOn with
 | ind total ih =>
   cases Nat.le_total cost total with
   | inl h =>
     rw [divisionRemoves (scale*total) (scale*cost) (Nat.mul_pos hs hc) (Nat.mul_le_mul_left scale h),
       mulSubtract,divisionRemoves total cost hc h]
     exact congrArg Nat.succ (ih (total-cost) (Nat.sub_lt (Nat.lt_of_lt_of_le hc h) hc))
   | inr h =>
     cases Nat.eq_or_lt_of_le h with
     | inl equal =>
       cases equal
       rw [divisionSelf (scale*cost) (Nat.mul_pos hs hc),divisionSelf cost hc]
     | inr below =>
       rw [divisionBelow total cost hc below,
        divisionBelow (scale*total) (scale*cost) (Nat.mul_pos hs hc) (Nat.mul_lt_mul_of_pos_left below hs)]

theorem originalScaledEnergyFold (scale : Nat) (costs word : List Nat) (acc : Nat) :
 (((costs.map (fun c => scale*c)).zip word).foldl (fun total (c,n) => total+c*n) (scale*acc)) =
 scale*((costs.zip word).foldl (fun total (c,n) => total+c*n) acc) := by
 induction costs generalizing word acc with
 | nil => rfl
 | cons c costs ih =>
   cases word with
   | nil => rfl
   | cons n word =>
     change (((costs.map (fun c => scale*c)).zip word).foldl (fun total (c,n) => total+c*n) (scale*acc+(scale*c)*n)) = _
     rw [mulAssoc,← Nat.mul_add]
     exact ih word (acc+c*n)

theorem originalScaledEnergy (scale : Nat) (costs word : List Nat) :
 wordEnergy (costs.map (fun c => scale*c)) word=scale*wordEnergy costs word :=
 originalScaledEnergyFold scale costs word 0

theorem originalScaledAxes (scale total : Nat) (costs : List Nat) (hs : 0<scale)
 (positive : ∀ c, c ∈ costs → 0<c) :
 (costs.map (fun c => scale*c)).map (fun c => List.range (scale*total/c+1)) =
 costs.map (fun c => List.range (total/c+1)) := by
 induction costs with
 | nil => rfl
 | cons c costs ih =>
   change List.range (scale*total/(scale*c)+1)::((costs.map (fun c => scale*c)).map (fun c => List.range (scale*total/c+1))) = _
   rw [originalScaledCostLimit scale c total hs (positive c (List.Mem.head _))]
   exact congrArg (List.cons (List.range (total/c+1))) (ih (fun c h => positive c (List.Mem.tail _ h)))

theorem originalScaledEnergyDecision (scale total : Nat) (costs word : List Nat) (hs : 0<scale) :
 (wordEnergy (costs.map (fun c => scale*c)) word == scale*total) = (wordEnergy costs word == total) := by
 rw [originalScaledEnergy]
 cases h : (wordEnergy costs word == total) with
 | true =>
   rw [Nat.eq_of_beq_eq_true h]
   exact SFT.Foundation.CommonRefinement.naturalEqualityReflexive _
 | false =>
   cases q : (scale*wordEnergy costs word == scale*total) with
   | false => rfl
   | true =>
     have e := congrArg (fun n => n/scale) (Nat.eq_of_beq_eq_true q)
     rw [divisionMultiple scale _ hs,divisionMultiple scale _ hs] at e
     have impossible : (wordEnergy costs word == total)=true := by
       rw [e]; exact SFT.Foundation.CommonRefinement.naturalEqualityReflexive _
     rw [h] at impossible
     cases impossible

theorem originalScaledWordSelection (scale total : Nat) (costs : List Nat) (words : List (List Nat)) (hs : 0<scale) :
 words.filter (fun word => wordEnergy (costs.map (fun c => scale*c)) word == scale*total) =
 words.filter (fun word => wordEnergy costs word == total) := by
 induction words with
 | nil => rfl
 | cons word words ih =>
   have eq := originalScaledEnergyDecision scale total costs word hs
   cases h : (wordEnergy costs word == total) with
   | true =>
     have scaled : (wordEnergy (costs.map (fun c => scale*c)) word == scale*total)=true := eq.trans h
     rw [List.filter_cons_of_pos (p := fun word => wordEnergy (costs.map (fun c => scale*c)) word == scale*total) scaled,List.filter_cons_of_pos (p := fun word => wordEnergy costs word == total) h]
     exact congrArg (List.cons word) ih
   | false =>
     have scaled : (wordEnergy (costs.map (fun c => scale*c)) word == scale*total)=false := eq.trans h
     rw [List.filter_cons_of_neg (p := fun word => wordEnergy (costs.map (fun c => scale*c)) word == scale*total) (by rw [scaled]; intro impossible; cases impossible),
       List.filter_cons_of_neg (p := fun word => wordEnergy costs word == total) (by rw [h]; intro impossible; cases impossible)]
     exact ih

theorem originalCompleteScaleCovariance (scale total : Nat) (costs : List Nat) (hs : 0<scale)
 (positive : ∀ c, c ∈ costs → 0<c) :
 completeWords (costs.map (fun c => scale*c)) (scale*total) = completeWords costs total := by
 unfold completeWords
 rw [originalScaledAxes scale total costs hs positive]
 exact originalScaledWordSelection scale total costs _ hs
end SFT.Physics.CollectiveRadiationScale
