import SFT.Physics.SpatialStability
import SFT.Physics.AlphaCovers
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.TwoHandDirac
open SFT.Foundation ExactOperations ExactPartCarrier LeptonIntervals
structure Result where
 momentum : Rat
 mass : Rat
 energySquare : Rat

def twoHandDiracSquare : Except String Result := do
 let three ← SpatialStability.spatialDimension
 let binary ← AlphaCovers.binaryCount
 let four := binary*binary
 let five := three+binary
 let momentum ← fromPair (.ofNat three) (.ofNat five)
 let mass ← fromPair (.ofNat four) (.ofNat five)
 let p := asFraction momentum
 let m := asFraction mass
 let energy := add (multiply p p) (multiply m m)
 if !energy.blt (asFraction one) && !(asFraction one).blt energy then
  pure ⟨p,m,energy⟩
 else throw "two-hand Dirac square did not close at the One"

theorem sourceAssembly : twoHandDiracSquare=
 .ok ⟨⟨3,5,by decide,by decide⟩,⟨4,5,by decide,by decide⟩,⟨1,1,by decide,by decide⟩⟩ := by
 unfold twoHandDiracSquare
 rw [SpatialStability.spatialDimensionThree,AlphaCovers.binaryCountTwo]
 rfl

theorem everyReturnedSquare (result : Result) (returned : twoHandDiracSquare=.ok result) :
 add (multiply result.momentum result.momentum) (multiply result.mass result.mass)=asFraction one ∧
 result.energySquare=asFraction one := by
 rw [sourceAssembly] at returned
 cases returned
 exact ⟨rfl,rfl⟩
end SFT.Physics.TwoHandDirac
