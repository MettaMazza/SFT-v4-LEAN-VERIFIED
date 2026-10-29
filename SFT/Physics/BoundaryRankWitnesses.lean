import SFT.Physics.BoundaryGrowth
namespace SFT.Physics.BoundaryRankWitnesses
open BoundarySupport BoundaryGrowth SpatialStability
structure Witness where
 name : String
 statement : String
 passed : Bool

def rankCheck : Bool := match boundaryRank with
 | .error _ => false
 | .ok rank => match spatialDimension with
   | .error _ => false
   | .ok dimension => rank == 2 && rank + 1 == dimension

def doubleCheck : Bool := match boundaryGrowth (.fraction (asFraction two)) with
 | .error _ => false
 | .ok part => part.numerator == 4 && part.denominator == 1

def tripleCheck : Bool := match boundaryGrowth (.fraction (asFraction three)) with
 | .error _ => false
 | .ok part => part.numerator == 9 && part.denominator == 1

def witnesses : List Witness := [⟨"positive-predecessor-rank","Rank two followed by one held normal reassembles three-space.",rankCheck⟩,⟨"double-scale","Doubling each boundary coordinate produces four exact pair cells.",doubleCheck⟩,⟨"triple-scale","Tripling each boundary coordinate produces nine exact pair cells.",tripleCheck⟩]

theorem rankCheckPassed : rankCheck = true := by
 unfold rankCheck
 rw [boundaryRankTwo,spatialDimensionThree]
 rfl

theorem doubleCheckPassed : doubleCheck = true := rfl

theorem tripleCheckPassed : tripleCheck = true := rfl

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (rankCheck && (doubleCheck && (tripleCheck && true))) = true
 rw [rankCheckPassed,doubleCheckPassed,tripleCheckPassed]
 rfl
end SFT.Physics.BoundaryRankWitnesses
