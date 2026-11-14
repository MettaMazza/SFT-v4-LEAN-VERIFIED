import SFT.Physics.RedshiftEquivalence
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String RedshiftEquivalence.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("gravitational_redshift",fraction r.gravitationalRedshift),("accelerated_doppler",fraction r.acceleratedDoppler)]
def main : IO Unit := do
 let inputs : List (FoldFirstReturn.Input × FoldFirstReturn.Input) :=
  [(.fraction ⟨1,8,by decide,by decide⟩,.fraction ⟨1,4,by decide,by decide⟩),
   (.fraction ⟨1,8,by decide,by decide⟩,.fraction ⟨1,2,by decide,by decide⟩),
   (.fraction ⟨1,8,by decide,by decide⟩,.fraction ⟨1,1,by decide,by decide⟩),
   (.fraction ⟨1,8,by decide,by decide⟩,.fraction ⟨2,1,by decide,by decide⟩),
   (.fraction ⟨1,2,by decide,by decide⟩,.fraction ⟨1,2,by decide,by decide⟩),
   (.fraction ⟨0,1,by decide,by decide⟩,.fraction ⟨1,2,by decide,by decide⟩),
   (.nonFraction,.fraction ⟨1,2,by decide,by decide⟩),
   (.fraction ⟨1,8,by decide,by decide⟩,.nonFraction)]
 for (source,radius) in inputs do IO.println (render (showResult (RedshiftEquivalence.redshiftEquivalence source radius)))
