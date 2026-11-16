import SFT.Physics.CollectiveRadiationCensus
import SFT.Mathematics.OrbitCyclotomic
import SFT.Foundation.FractionReduction
namespace SFT.Physics.CollectiveRadiationCompleteness
open CollectiveRadiation CollectiveRadiationCensus SFT.Foundation.FractionReduction

theorem originalEnergyAccumulator (costs word : List Nat) (acc : Nat) :
 (costs.zip word).foldl (fun total (c,n) => total+c*n) acc = acc+wordEnergy costs word := by
 induction costs generalizing word acc with
 | nil => exact (Nat.add_zero acc).symm
 | cons c costs ih =>
   cases word with
   | nil => exact (Nat.add_zero acc).symm
   | cons n word =>
     change (costs.zip word).foldl (fun total (c,n) => total+c*n) (acc+c*n)=
       acc+(costs.zip word).foldl (fun total (c,n) => total+c*n) (0+c*n)
     rw [ih,ih,Nat.zero_add,Nat.add_assoc]

theorem originalEnergySuccessor (cost count : Nat) (costs word : List Nat) :
 wordEnergy (cost::costs) (count::word)=cost*count+wordEnergy costs word := by
 change (costs.zip word).foldl (fun total (c,n) => total+c*n) (0+cost*count)=_
 rw [originalEnergyAccumulator,Nat.zero_add]

theorem originalOccupationLimitForced (cost count total : Nat) (hc : 0<cost)
 (held : cost*count≤total) : count≤total/cost := by
 induction count generalizing total with
 | zero => exact Nat.zero_le _
 | succ count ih =>
   rw [Nat.mul_succ] at held
   have enough : cost≤total := Nat.le_trans (Nat.le_add_left cost (cost*count)) held
   have rest := Nat.sub_le_sub_right held cost
   rw [SFT.Foundation.ExactCast.addSubtract] at rest
   rw [divisionRemoves total cost hc enough]
   exact Nat.succ_le_succ (ih (total-cost) rest)

theorem originalBoundedWordTrace (costs word : List Nat) (total : Nat)
 (positive : ∀ c, c ∈ costs → 0<c) (length : word.length=costs.length)
 (energy : wordEnergy costs word≤total) :
 CoordinateTrace (costs.map (fun c => List.range (total/c+1))) word := by
 induction costs generalizing word with
 | nil =>
   cases word with
   | nil => exact .nil
   | cons _ _ => cases length
 | cons cost costs ih =>
   cases word with
   | nil => cases length
   | cons count word =>
     rw [originalEnergySuccessor] at energy
     have head := Nat.le_trans (Nat.le_add_right (cost*count) (wordEnergy costs word)) energy
     have tail := Nat.le_trans (Nat.le_add_left (wordEnergy costs word) (cost*count)) energy
     apply CoordinateTrace.cons
     · exact (SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mpr
         (Nat.lt_succ_of_le (originalOccupationLimitForced cost count total (positive cost (List.Mem.head _)) head))
     · exact ih word (fun c h => positive c (List.Mem.tail _ h)) (Nat.succ.inj length) tail

theorem originalEveryEnergyWordGenerated (costs word : List Nat) (total : Nat)
 (positive : ∀ c, c ∈ costs → 0<c) (length : word.length=costs.length)
 (energy : wordEnergy costs word=total) : word ∈ completeWords costs total :=
 (originalCompleteCensus costs word total).mpr
 ⟨originalBoundedWordTrace costs word total positive length (Nat.le_of_eq energy),energy⟩

theorem originalFullEnergyCensus (costs word : List Nat) (total : Nat)
 (positive : ∀ c, c ∈ costs → 0<c) :
 word ∈ completeWords costs total ↔ word.length=costs.length ∧ wordEnergy costs word=total := by
 constructor
 · intro held
   exact ⟨originalCoordinateCount costs word total held,originalEnergyPreserved costs word total held⟩
 · intro h
   exact originalEveryEnergyWordGenerated costs word total positive h.1 h.2
end SFT.Physics.CollectiveRadiationCompleteness
