import SFT.Physics.ElectroweakMixing
namespace SFT.Physics.DiracG
open SFT.Foundation ExactPartCarrier ExactOperations

def factor : Except String Nat := do
 let coupling ← ElectroweakMixing.halfOne
 let ratio := normalizePositive coupling.denominator coupling.numerator
  (denominatorPositive coupling) coupling.positive
 if ratio.denominator==1 then .ok ratio.numerator
 else .error "the bare gyromagnetic carrier did not close as a whole count"

theorem sourceAssembly : factor=.ok 2 := by
 unfold factor;rw [ElectroweakMixing.nativeHalf];rfl

theorem binaryLock : factor=AlphaCovers.binaryCount := sourceAssembly.trans AlphaCovers.binaryCountTwo.symm
theorem twoPartsReassemble :
 (FoldDynamics.sumParts HalfOneDerivation.halfOne HalfOneDerivation.halfOne).numerator=
 (FoldDynamics.sumParts HalfOneDerivation.halfOne HalfOneDerivation.halfOne).denominator := rfl
end SFT.Physics.DiracG
