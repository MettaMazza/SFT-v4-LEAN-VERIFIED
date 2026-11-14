import SFT.Physics.NeutrinoMeasurementRoots
import SFT.Host.Canonical
open SFT.Physics.NeutrinoMeasurementRoots SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let rows ← ([("lightest",lightestSquare),("middle",middleSquare),("heavy",heavySquare)] : List (String × Rat)).mapM fun (item : String × Rat) => do
  let (l,u) ← IO.ofExcept (sqrtRefined item.2)
  pure (item.1,Value.array [fraction l,fraction u])
 IO.println (render (.object rows))
