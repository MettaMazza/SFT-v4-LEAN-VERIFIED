import SFT.Physics.MagneticRelativity
namespace SFT.Physics.LorentzTransfer
open SFT.Foundation ExactOperations ExactPartCarrier
open LeptonIntervals
structure Result where
 retainedForce : Rat
 motionShare : Rat
 sourceForce : Rat

def lorentzTransfer : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String Result
 | .nonFraction,_ => .error "electric force must be exact and positive"
 | .fraction force,speed => do
   if !zero.blt force then throw "electric force must be exact and positive"
   let factor ← MagneticRelativity.magneticRelativisticFactor speed
   let retained := multiply force factor.electricRemainder
   let motion := multiply force factor.speedSquare
   let returned := add retained motion
   if !returned.blt force && !force.blt returned then pure ⟨retained,motion,force⟩
   else throw "Lorentz transfer did not conserve the source force"

theorem originalSourceRecord : lorentzTransfer (.fraction ⟨1,4,by decide,by decide⟩)
 (.fraction ⟨1,2,by decide,by decide⟩)=.ok
 ⟨⟨3,16,by decide,by decide⟩,⟨1,16,by decide,by decide⟩,⟨1,4,by decide,by decide⟩⟩ := by
 unfold lorentzTransfer
 dsimp only
 rw [MagneticRelativity.halfSpeedSource]
 rfl

theorem originalSourceRecomposition :
 add (⟨3,16,by decide,by decide⟩ : Rat) ⟨1,16,by decide,by decide⟩=⟨1,4,by decide,by decide⟩ := rfl
end SFT.Physics.LorentzTransfer
