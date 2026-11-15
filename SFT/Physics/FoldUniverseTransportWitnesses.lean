import SFT.Physics.FoldUniverseTransport
namespace SFT.Physics.FoldUniverseTransportWitnesses
open FoldUniverseTransport
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def pairs : List (Nat × Nat) := [(3,5),(3,7),(5,7)]
def censusCheck : Bool := pairs.all fun (l,r) =>
 match crtComponentCensus (.integer (.ofNat l)) (.integer (.ofNat r)) with
 | .error _ => false
 | .ok c => c.bijection && c.foldCommutes
def periodCheck : Bool := pairs.all fun (l,r) =>
 match compositePeriod (.integer (.ofNat l)) (.integer (.ofNat r)) with
 | .error _ => false
 | .ok p => p.matchesSource
def denominatorCheck : Bool := ([3,5,7,15,21,35] : List Nat).all fun d =>
 match denominatorTrace (.integer 1) (.integer (.ofNat d)) (.integer 12) with
 | .error _ => false
 | .ok trace => trace.length==12 && trace.all (fun v => SFT.Mathematics.LimitComputations.equalInt v (.ofNat d))
def steeringCheck : Bool := pairs.all fun (l,r) =>
 match targetTrajectoryIndependentOfSource (.integer (.ofNat l)) (.integer (.ofNat r)) (.integer 1) (.integer 12) with
 | .error _ => false
 | .ok b => b
def witnesses : List Witness := [⟨"complete-CRT-censuses","The complete unit-residue maps for three-by-five, three-by-seven and five-by-seven are bijective and Fold-commuting.",censusCheck⟩,⟨"period-law","Composite periods equal the least common multiple of component periods for every registered coprime pair.",periodCheck⟩,⟨"denominator-preservation","Every tested native trajectory retains its source denominator.",denominatorCheck⟩,⟨"no-steering","Every target trajectory is independent of the paired source residue once the target initial state is fixed.",steeringCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.FoldUniverseTransportWitnesses
