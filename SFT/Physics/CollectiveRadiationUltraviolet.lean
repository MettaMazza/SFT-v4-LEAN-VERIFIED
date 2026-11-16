import SFT.Physics.CollectiveRadiationCensus
import SFT.Foundation.FractionReduction
import SFT.Physics.MassRatioFamily
namespace SFT.Physics.CollectiveRadiationUltraviolet
open CollectiveRadiation CollectiveRadiationCensus SFT.Foundation.FractionReduction

theorem originalAboveSupportCoordinate (costs word : List Nat) (total index : Nat)
 (trace : CoordinateTrace (costs.map (fun c => List.range (total/c+1))) word)
 (above : total < occupationAt costs index) : occupationAt word index=0 := by
 induction costs generalizing word index with
 | nil => exact False.elim (Nat.not_lt_zero total above)
 | cons cost costs ih =>
   cases trace with
   | cons held tail =>
     cases index with
     | zero =>
       change total < cost at above
       have positive := Nat.lt_of_le_of_lt (Nat.zero_le total) above
       dsimp only at held
       rw [divisionBelow total cost positive above] at held
       change _ ∈ [0] at held
       cases held with
       | head => rfl
       | tail _ impossible => cases impossible
     | succ index => exact ih _ index tail above

theorem originalEveryAboveSupportModeEmpty (costs word : List Nat) (total index : Nat)
 (held : word ∈ completeWords costs total)
 (above : total < occupationAt costs index) : occupationAt word index=0 :=
 originalAboveSupportCoordinate costs word total index ((originalCompleteCensus costs word total).mp held).1 above

theorem originalEmptyModeSum (words : List (List Nat)) (index : Nat)
 (empty : ∀ w, w ∈ words → occupationAt w index=0) :
 words.foldl (fun total word => total+occupationAt word index) 0=0 := by
 induction words with
 | nil => rfl
 | cons w words ih =>
   change words.foldl (fun total word => total+occupationAt word index) (0+occupationAt w index)=0
   rw [empty w (List.Mem.head _)]
   exact ih (fun w h => empty w (List.Mem.tail _ h))

theorem originalAboveSupportMeanEmpty (costs : List Nat) (total index : Nat)
 (above : total<occupationAt costs index) (nonempty : completeWords costs total ≠ []) :
 LeptonRatios.divide
 (VacuumLedgerProofs.wholeRatio ((completeWords costs total).foldl (fun sum word => sum+occupationAt word index) 0))
 (VacuumLedgerProofs.wholeRatio (completeWords costs total).length)=.ok LeptonIntervals.zero := by
 have positive : 0<(completeWords costs total).length := by
   cases h : completeWords costs total with
   | nil => exact False.elim (nonempty h)
   | cons w ws => exact Nat.zero_lt_succ _
 rw [originalEmptyModeSum _ index (fun w h => originalEveryAboveSupportModeEmpty costs w total index h above)]
 rw [MassRatioFamily.wholeDivision 0 _ positive]
 apply congrArg Except.ok
 change VacuumLedgerProofs.natRatio 0 _ positive=VacuumLedgerProofs.natRatio 0 1 (by decide)
 apply VacuumLedgerProofs.natRatioCongruence
 rw [Nat.zero_mul,Nat.zero_mul]
end SFT.Physics.CollectiveRadiationUltraviolet
