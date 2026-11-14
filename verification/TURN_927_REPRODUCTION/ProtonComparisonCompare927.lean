import SFT.Physics.ProtonComparison
import SFT.Host.Canonical
open SFT.Physics.ProtonComparison SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let (l,u) ← IO.ofExcept protonRatioInterval
 IO.println (render (.array [fraction l,fraction u]))
