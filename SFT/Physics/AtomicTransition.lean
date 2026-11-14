import SFT.Physics.CubicAtomicSupport
namespace SFT.Physics.AtomicTransition
structure Selection where
 orbitalStep : Nat
 magneticOrientations : Nat
 completeSpatialOrientations : Nat
 carrierConserved : Bool
 oneStepRequired : Bool
def transitionSelection : Except String Selection := do
 let binary ← AlphaCovers.binaryCount
 let cubic ← CubicAtomicSupport.cubicCoordination
 pure ⟨1,binary,cubic,true,true⟩
theorem completeSourceRecord : transitionSelection=.ok ⟨1,2,6,true,true⟩ := rfl
end SFT.Physics.AtomicTransition
