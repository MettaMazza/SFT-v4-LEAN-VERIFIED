import SFT.Mathematics.AlgebraicSeparation
import SFT.Host.Canonical
open SFT.Mathematics SFT.Host.Canonical

def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def main : IO Unit := do
 let rows := ([-3,0,1,2,20,21,64] : List Int).map fun n =>
   let b := AlgebraicBalance.squareTwoBracket n
   Value.object [("rounds",.integer n),("lower",fraction b.1),("upper",fraction b.2)]
 IO.println (render (.array rows))
