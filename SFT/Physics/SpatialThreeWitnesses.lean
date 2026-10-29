import SFT.Physics.SpatialStability
namespace SFT.Physics.SpatialThreeWitnesses
open SpatialStability FoldFirstReturn
structure Witness where
 name : String
 statement : String
 passed : Bool

def windowCheck : Bool := match stableSpatialCounts (.integer (.ofNat 2)) with
 | .ok counts => counts == [3]
 | .error _ => false

def crosslockCheck : Bool := match spatialDimension with
 | .error _ => false
 | .ok dimension => match generatorPeriod with
   | .error _ => false
   | .ok generator => dimension == generator && generator == 3

def boundaryCheck : Bool := match stableSpatialCounts (.integer (.ofNat 2)) with
 | .ok counts => !(counts.contains 2) && !(counts.contains 4)
 | .error _ => false

def witnesses : List Witness := [⟨"complete-window","The complete positive stability window between two and four contains only three.",windowCheck⟩,⟨"generator-crosslock","The stability member equals the separately forced generator-three count.",crosslockCheck⟩,⟨"boundary-controls","Both Fold boundary counts are excluded from the open stability window.",boundaryCheck⟩]

theorem windowCheckPassed : windowCheck = true := rfl

theorem crosslockCheckPassed : crosslockCheck = true := by
 unfold crosslockCheck
 rw [spatialDimensionThree,generatorPeriodThree]
 rfl

theorem boundaryCheckPassed : boundaryCheck = true := rfl

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (windowCheck && (crosslockCheck && (boundaryCheck && true))) = true
 rw [windowCheckPassed,crosslockCheckPassed,boundaryCheckPassed]
 rfl
end SFT.Physics.SpatialThreeWitnesses
