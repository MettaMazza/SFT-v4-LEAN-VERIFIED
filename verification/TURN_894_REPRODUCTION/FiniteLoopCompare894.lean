import SFT.Physics.FiniteLoop
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String Rat) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => fraction r
def main : IO Unit := do
 for n in List.range 17 do
  IO.println (render (showResult (FiniteLoop.finiteLoopSum (.integer (.ofNat n)))))
 for x in ([.integer (-1),.boolean true,.boolean false] : List GeneratorOperations.CountInput) do
  IO.println (render (showResult (FiniteLoop.finiteLoopSum x)))
