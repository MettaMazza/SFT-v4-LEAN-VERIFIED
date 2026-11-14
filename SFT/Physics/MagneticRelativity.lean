import SFT.Physics.LeptonIntervals
import SFT.Physics.FieldMagnetic
namespace SFT.Physics.MagneticRelativity
open SFT.Foundation ExactOperations ExactPartCarrier
open LeptonIntervals
structure Result where
 speedSquare : Rat
 electricRemainder : Rat
 foldedRemainder : Rat

def magneticRelativisticFactor : FoldFirstReturn.Input → Except String Result
 | .nonFraction => .error "speed must be an exact positive sub-One carrier"
 | .fraction speed => do
   if !(zero.blt speed && speed.blt (asFraction one)) then
    throw "speed must be an exact positive sub-One carrier"
   let square := multiply speed speed
   let correction := subtract (asFraction one) square
   let correctionPart ← fromPair correction.num (.ofNat correction.den)
   let squarePart ← fromPair square.num (.ofNat square.den)
   let folded := asFraction (foldPart correctionPart)
   let complementary := subtract (asFraction one) (asFraction (foldPart squarePart))
   if !folded.blt complementary && !complementary.blt folded then
    pure ⟨square,correction,folded⟩
   else throw "magnetic correction does not commute with the Fold"

theorem halfSpeedSource : magneticRelativisticFactor (.fraction ⟨1,2,by decide,by decide⟩)=
 .ok ⟨⟨1,4,by decide,by decide⟩,⟨3,4,by decide,by decide⟩,⟨1,2,by decide,by decide⟩⟩ := rfl

theorem thirdSpeedSource : magneticRelativisticFactor (.fraction ⟨1,3,by decide,by decide⟩)=
 .ok ⟨⟨1,9,by decide,by decide⟩,⟨8,9,by decide,by decide⟩,⟨7,9,by decide,by decide⟩⟩ := rfl
end SFT.Physics.MagneticRelativity
