import SFT.Physics.MassRatioFamily
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.MassRatioFamily SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def result (r : Result) : Value := .object [("support",.integer (.ofNat r.support)),("light",fraction r.light),("central",fraction r.central),("heavy",fraction r.heavy),("heavy_over_light",fraction r.heavyOverLight)]
#eval do
 let values : List GeneratorOperations.CountInput := [.boolean false,.boolean true,.integer (-2),.integer 0,.integer 1,.integer 2,.integer 3,.integer 4,.integer 5,.integer 7,.integer 12]
 let rows := values.map fun v => match massRatioFamily v with
  | .error e => Value.object [("error",.text e)]
  | .ok r => result r
 IO.println (render (.array rows))
