import SFT.Physics.ScatteringPartitionPathGeneral
namespace SFT.Physics.ScatteringPartitionPathWitnesses
open ScatteringPartitionPath
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def checked : Except String Bool → Bool | .ok x => x | .error _ => false
def partitionCheck : Bool := match twoFibreOutcomeMeasure ["scatter","pass"] with
 | .error _ => false
 | .ok pair => SFT.Mathematics.LimitComputations.equalRat pair.1 half && SFT.Mathematics.LimitComputations.equalRat pair.2 half && checked (partitionIsComplete ["scatter","pass"])
def unitCheck : Bool := match meanFreePath (.fraction one) (.fraction one) with
 | .error _ => false
 | .ok x => SFT.Mathematics.LimitComputations.equalRat x one
def halfCheck : Bool := match meanFreePath (.fraction one) (.fraction half) with
 | .error _ => false
 | .ok x => SFT.Mathematics.LimitComputations.equalRat x (LeptonIntervals.normalize 2 1 (by decide))
def inverseCheck : Bool := checked (largerSectionShortensPath (.fraction (LeptonIntervals.normalize 3 2 (by decide))) (.fraction (LeptonIntervals.normalize 1 4 (by decide))) (.fraction half))
def countedCheck : Bool := match crossSection (.integer 1) (.integer 2) with
 | .error _ => false
 | .ok x => SFT.Mathematics.LimitComputations.equalRat x half
def witnesses : List Witness := [⟨"complete-partition","The two equipotent outcome cells are half-One each and reassemble the One.",partitionCheck⟩,⟨"v2-unit-section","At unit density and section One, mean free path is One.",unitCheck⟩,⟨"v2-half-section","At unit density and section half-One, mean free path is two.",halfCheck⟩,⟨"inverse-order","Every larger positive registered section has the shorter exact path.",inverseCheck⟩,⟨"counted-section","One successful cell among two incident cells is half-One.",countedCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ScatteringPartitionPathWitnesses
