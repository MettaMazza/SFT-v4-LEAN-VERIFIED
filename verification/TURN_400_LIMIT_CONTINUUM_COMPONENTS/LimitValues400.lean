import SFT.Mathematics.LimitComputations
open SFT.Mathematics.LimitComputations
def emit (tag : String) (k : Nat) (x : Rat) : IO Unit :=
 IO.println s!"{tag}\t{k}\t{x.num}\t{x.den}"
def main : IO Unit := do
 for i in List.range 14 do emit "rung" (i+1) (spacing (i+1))
 for i in List.range 10 do
  match quadratic (i+1) with
  | .ok x => emit "quadratic" (i+1) x
  | .error e => throw (IO.userError e)
 for i in List.range 9 do
  match cubic (i+1) with
  | .ok x => emit "cubic" (i+1) x
  | .error e => throw (IO.userError e)
  emit "error" (i+1) (cubicError (i+1))
  emit "next-error-doubled" (i+1) (SFT.Physics.LeptonIntervals.multiply (cubicError (i+2)) (whole 2))
 for i in List.range 5 do emit "term" (i+1) (spacing (i+1))
 emit "ledger" 5 (ledger 5)
 IO.println s!"witnesses\t{finiteRungs}\t{quadraticWitness}\t{cubicWitness}\t{closureWitness}"
