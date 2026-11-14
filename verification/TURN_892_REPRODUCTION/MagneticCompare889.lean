import SFT.Physics.MagneticRelativity
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String MagneticRelativity.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("speed_square",fraction r.speedSquare),("electric_remainder",fraction r.electricRemainder),("folded_remainder",fraction r.foldedRemainder)]
def main : IO Unit := do
 let speeds : List FoldFirstReturn.Input := [.fraction ⟨1,2,by decide,by decide⟩,.fraction ⟨1,3,by decide,by decide⟩,
 .fraction ⟨2,3,by decide,by decide⟩,.fraction ⟨3,4,by decide,by decide⟩,
 .fraction ⟨7,10,by decide,by decide⟩,.fraction ⟨71,100,by decide,by decide⟩,
 .fraction ⟨1,1,by decide,by decide⟩,.fraction ⟨2,1,by decide,by decide⟩,
 .fraction ⟨0,1,by decide,by decide⟩,.fraction ⟨-1,1,by decide,by decide⟩,.nonFraction]
 for speed in speeds do IO.println (render (showResult (MagneticRelativity.magneticRelativisticFactor speed)))
