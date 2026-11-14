import SFT.Physics.CoulombGauss
import SFT.Physics.LeptonRatios
namespace SFT.Physics.GravityFlux
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier
open LeptonIntervals

def positiveTake : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String (Option Rat)
 | .nonFraction,_ | _,.nonFraction => .error "take requires exact fractions"
 | .fraction whole,.fraction part =>
  if whole.blt part || !zero.blt part then .error "take requires an ordered positive carrier"
  else if !whole.blt part && !part.blt whole then .ok none
  else .ok (some (subtract whole part))

structure Result where
 field : Rat
 flux : Rat
 clockPotential : Rat

def weakGravity : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String Result
 | .nonFraction,_ | _,.nonFraction => .error "gravity carriers must be exact"
 | .fraction source,.fraction radius => do
  if !(zero.blt source && source.blt radius && !(asFraction one).blt radius) then
   throw "weak-field witness requires source below radius"
  let field ← LeptonRatios.divide source (multiply radius radius)
  let quotient ← LeptonRatios.divide source radius
  let potential ← positiveTake (.fraction (asFraction one)) (.fraction quotient)
  match potential with
  | none => .error "weak gravity did not retain source flux"
  | some potential =>
   let flux := multiply (multiply field radius) radius
   if !flux.blt source && !source.blt flux then pure ⟨field,flux,potential⟩
   else throw "weak gravity did not retain source flux"

theorem innerSourceRecord : weakGravity (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩)=
 .ok ⟨⟨2,1,by decide,by decide⟩,⟨1,8,by decide,by decide⟩,⟨1,2,by decide,by decide⟩⟩ := rfl

theorem outerSourceRecord : weakGravity (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩)=
 .ok ⟨⟨1,2,by decide,by decide⟩,⟨1,8,by decide,by decide⟩,⟨3,4,by decide,by decide⟩⟩ := rfl
end SFT.Physics.GravityFlux
