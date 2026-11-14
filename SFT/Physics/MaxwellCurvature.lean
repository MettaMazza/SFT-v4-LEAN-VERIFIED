import SFT.Physics.BoundarySupport
import SFT.Physics.SpatialStability
import SFT.Physics.AlphaCovers
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.MaxwellCurvature
open SFT.Foundation ExactOperations ExactPartCarrier
open GeneratorOperations LeptonIntervals VacuumLedgerProofs
structure Result where
 dimension : Nat
 spatialCurvature : Nat
 temporalCurvature : Nat
 totalRatio : Rat
 speedSquare : Rat

def maxwellClosure (input : CountInput) : Except String Result := do
 let planar ← BoundarySupport.boundaryRank
 let space ← SpatialStability.spatialDimension
 let dimension ← match input with
  | .boolean _ => .error "Maxwell witness is registered only for forced planar and three-space support"
  | .integer (.negSucc _) => .error "Maxwell witness is registered only for forced planar and three-space support"
  | .integer (.ofNat n) =>
    if n==planar || n==space then .ok n
    else .error "Maxwell witness is registered only for forced planar and three-space support"
 let perAxis ← AlphaCovers.binaryCount
 let spatial := perAxis*dimension
 let temporal ← AlphaCovers.binaryCount
 let total ← LeptonRatios.divide (wholeRatio spatial) (wholeRatio temporal)
 let speed ← LeptonRatios.divide (wholeRatio spatial) (wholeRatio (dimension*temporal))
 let dim := wholeRatio dimension
 if !total.blt dim && !dim.blt total && !speed.blt (asFraction one) && !(asFraction one).blt speed then
  pure ⟨dimension,spatial,temporal,total,speed⟩
 else throw "Maxwell curvature did not close at the One speed"

def planarRecord : Result := ⟨2,4,2,⟨2,1,by decide,by decide⟩,⟨1,1,by decide,by decide⟩⟩
def spatialRecord : Result := ⟨3,6,2,⟨3,1,by decide,by decide⟩,⟨1,1,by decide,by decide⟩⟩

theorem planarSource : maxwellClosure (.integer 2)=.ok planarRecord := by
 unfold maxwellClosure
 rw [BoundarySupport.boundaryRankTwo,SpatialStability.spatialDimensionThree,AlphaCovers.binaryCountTwo]
 rfl

theorem spatialSource : maxwellClosure (.integer 3)=.ok spatialRecord := by
 unfold maxwellClosure
 rw [BoundarySupport.boundaryRankTwo,SpatialStability.spatialDimensionThree,AlphaCovers.binaryCountTwo]
 rfl

theorem exactAcceptedDomain (input : CountInput) (result : Result)
 (returned : maxwellClosure input=.ok result) :
 (input=.integer 2 ∧ result=planarRecord) ∨ (input=.integer 3 ∧ result=spatialRecord) := by
 unfold maxwellClosure at returned
 rw [BoundarySupport.boundaryRankTwo,SpatialStability.spatialDimensionThree,AlphaCovers.binaryCountTwo] at returned
 cases input with
 | boolean b => cases returned
 | integer n =>
  cases n with
  | negSucc n => cases returned
  | ofNat n =>
   cases n with
   | zero => cases returned
   | succ n =>
    cases n with
    | zero => cases returned
    | succ n =>
     cases n with
     | zero => exact Or.inl ⟨rfl,(Except.ok.inj returned).symm⟩
     | succ n =>
      cases n with
      | zero => exact Or.inr ⟨rfl,(Except.ok.inj returned).symm⟩
      | succ n => cases returned

theorem everyReturnedOneSpeed (input : CountInput) (result : Result)
 (returned : maxwellClosure input=.ok result) : result.speedSquare=asFraction one := by
 cases exactAcceptedDomain input result returned with
 | inl h => rw [h.2];rfl
 | inr h => rw [h.2];rfl
end SFT.Physics.MaxwellCurvature
