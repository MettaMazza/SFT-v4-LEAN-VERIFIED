import SFT.Physics.NuclearResidualForce
namespace SFT.Physics.NuclearResidualForceEntryWitnesses
open NuclearResidualForce LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def neutralCheck : Bool := match neutralCompositeExchange with
 | .error _ => false
 | .ok value => value.leadingExternalLabel.isEmpty
def residualCheck : Bool := match residualBoundarySupport with
 | .error _ => false
 | .ok value => match FoldFirstReturn.checkedFold (.fraction value) with
  | .error _ => false
  | .ok first => match FoldFirstReturn.checkedFold (.fraction (SFT.Foundation.ExactPartCarrier.asFraction first)) with
   | .error _ => false
   | .ok second => value==normalize 1 4 (by decide) && SFT.Foundation.ExactPartCarrier.asFraction second==wholeRatio 1
def orderCheck : Bool := (List.range 127).all (fun n => match inverseMassOrder (.fraction (normalize (.ofNat (n+1)) 17 (by decide))) (.fraction (normalize (.ofNat (n+2)) 17 (by decide))) with
 | .error _ => false
 | .ok result => result)
def capacityCheck : Bool := match finiteBoundaryCapacity with
 | .error _ => false
 | .ok n => n==3
def witnesses : List Witness := [⟨"neutral-leading-closure","A complete colour composite retains no separately observable leading external colour label.",neutralCheck⟩,⟨"quarter-residual","Two forced half-One boundary acts give exact quarter-One support and two-Fold return.",residualCheck⟩,⟨"range-order","Every tested positive heavier carrier has the shorter exact reciprocal scale.",orderCheck⟩,⟨"finite-saturation","One closed composite has the finite complete generator-three boundary capacity.",capacityCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.NuclearResidualForceEntryWitnesses
