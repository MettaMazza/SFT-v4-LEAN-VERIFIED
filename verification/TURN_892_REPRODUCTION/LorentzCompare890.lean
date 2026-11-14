import SFT.Physics.LorentzTransfer
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String LorentzTransfer.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("retained_force",fraction r.retainedForce),("motion_share",fraction r.motionShare),("source_force",fraction r.sourceForce)]
def main : IO Unit := do
 let half : FoldFirstReturn.Input := .fraction ⟨1,2,by decide,by decide⟩
 let quarter : FoldFirstReturn.Input := .fraction ⟨1,4,by decide,by decide⟩
 let forces : List FoldFirstReturn.Input := [quarter,.fraction ⟨3,1,by decide,by decide⟩,.fraction ⟨0,1,by decide,by decide⟩,.fraction ⟨-1,1,by decide,by decide⟩,.nonFraction]
 for force in forces do IO.println (render (showResult (LorentzTransfer.lorentzTransfer force half)))
 let speeds : List FoldFirstReturn.Input := [.fraction ⟨1,3,by decide,by decide⟩,.fraction ⟨3,4,by decide,by decide⟩,.fraction ⟨1,1,by decide,by decide⟩,.fraction ⟨0,1,by decide,by decide⟩,.nonFraction]
 for speed in speeds do IO.println (render (showResult (LorentzTransfer.lorentzTransfer quarter speed)))
