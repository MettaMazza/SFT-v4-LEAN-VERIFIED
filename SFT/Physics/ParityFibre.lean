import SFT.Physics.ElectroweakMixing
namespace SFT.Physics.ParityFibre
open SFT.Foundation ExactPartCarrier ExactOperations ElectroweakMixing

structure Fibre where
 leftHeld : Part
 image : Part
 rightHeld : Part

def heldFibre : Except String Fibre := do
 let preimages ← halfOnePreimages
 match preimages with
 | [] => .error "ValueError: not enough values to unpack (expected 2, got 0)"
 | lower::rest => match rest with
  | [] => .error "ValueError: not enough values to unpack (expected 2, got 1)"
  | upper::rest => match rest with
   | _::_ => .error "ValueError: too many values to unpack (expected 2)"
   | [] => do
    let image ← halfOne
    .ok ⟨lower,image,upper⟩

theorem sourceAssembly : heldFibre=.ok ⟨quarter,HalfOneDerivation.halfOne,threeQuarters⟩ := by
 unfold heldFibre;rw [nativeFibre,nativeHalf];rfl

theorem commonImage : foldPart quarter=HalfOneDerivation.halfOne ∧
 foldPart threeQuarters=HalfOneDerivation.halfOne := ⟨quarterReturn,threeQuarterReturn⟩

theorem oppositeSides : quarter.numerator*HalfOneDerivation.halfOne.denominator <
 HalfOneDerivation.halfOne.numerator*quarter.denominator ∧
 HalfOneDerivation.halfOne.numerator*threeQuarters.denominator <
 threeQuarters.numerator*HalfOneDerivation.halfOne.denominator := by decide

def channelParts (lower upper : Bool) : List Part :=
 (if lower then [quarter] else []) ++ (if upper then [threeQuarters] else [])

theorem everyRestriction (lower upper : Bool) :
 channelParts lower upper=[] ∨ channelParts lower upper=[quarter] ∨
 channelParts lower upper=[threeQuarters] ∨ channelParts lower upper=[quarter,threeQuarters] := by
 cases lower <;> cases upper
 · exact .inl rfl
 · exact .inr (.inr (.inl rfl))
 · exact .inr (.inl rfl)
 · exact .inr (.inr (.inr rfl))

def parityTransform (lower upper : Bool) : List Part := channelParts upper lower

theorem oneSideAsymmetric (lower upper : Bool) (different : lower≠upper) :
 channelParts lower upper≠parityTransform lower upper := by
 cases lower <;> cases upper
 · exact False.elim (different rfl)
 · intro same;exact distinctChannels ((List.cons.inj same).1.symm)
 · intro same;exact distinctChannels (List.cons.inj same).1
 · exact False.elim (different rfl)

theorem pairedPreserved : parityTransform true true=channelParts true true := rfl

theorem everyNonemptyChannel (lower upper : Bool) (nonempty : channelParts lower upper≠[]) :
 (lower=true ∧ upper=true) ∨ lower≠upper := by
 cases lower <;> cases upper
 · exact False.elim (nonempty rfl)
 · exact .inr (by decide)
 · exact .inr (by decide)
 · exact .inl ⟨rfl,rfl⟩
end SFT.Physics.ParityFibre
