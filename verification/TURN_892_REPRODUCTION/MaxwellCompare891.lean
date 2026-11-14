import SFT.Physics.MaxwellCurvature
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String MaxwellCurvature.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("dimension",.integer (.ofNat r.dimension)),("spatial_curvature",.integer (.ofNat r.spatialCurvature)),("temporal_curvature",.integer (.ofNat r.temporalCurvature)),("total_ratio",fraction r.totalRatio),("speed_square",fraction r.speedSquare)]
def main : IO Unit := do
 for dimension in ([.integer 2,.integer 3,.integer 0,.integer 1,.integer 4,.integer (-1),.boolean true,.boolean false] : List GeneratorOperations.CountInput) do
  IO.println (render (showResult (MaxwellCurvature.maxwellClosure dimension)))
