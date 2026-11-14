import SFT.Physics.CoulombGauss
open SFT.Physics SFT.Host.Canonical SFT.Foundation.ExactOperations
open FoldFirstReturn
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String CoulombGauss.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("field",fraction (BoundaryGrowth.asFraction r.field)),("flux",fraction (BoundaryGrowth.asFraction r.flux)),("retained_potential",fraction r.retainedPotential)]
def main : IO Unit := do
 let source : Rat := ⟨1,8,by decide,by decide⟩
 let radii : List Input := [.fraction ⟨1,4,by decide,by decide⟩,.fraction ⟨1,2,by decide,by decide⟩,
  .fraction ⟨1,1,by decide,by decide⟩,.fraction ⟨1,8,by decide,by decide⟩,
  .fraction ⟨1,16,by decide,by decide⟩,.fraction ⟨2,1,by decide,by decide⟩,
  .fraction ⟨0,1,by decide,by decide⟩,.fraction ⟨-1,1,by decide,by decide⟩,.nonFraction]
 for radius in radii do IO.println (render (showResult (CoulombGauss.coulombGaussClosure source radius)))
 for source in ([⟨0,1,by decide,by decide⟩,⟨-1,8,by decide,by decide⟩] : List Rat) do
  IO.println (render (showResult (CoulombGauss.coulombGaussClosure source (.fraction ⟨1,2,by decide,by decide⟩))))
