import SFT.Physics.TwoHandDirac
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def main : IO Unit := do
 let r ← IO.ofExcept TwoHandDirac.twoHandDiracSquare
 IO.println (render (.object [("momentum",fraction r.momentum),("mass",fraction r.mass),("energy_square",fraction r.energySquare)]))
