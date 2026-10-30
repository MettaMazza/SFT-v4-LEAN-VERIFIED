import SFT.Physics.PrimeSectorLadder
open SFT.Physics.PrimeSectorLadder

def main : IO Unit := do
 match primeSectorLadder,mediatorRecord,couplingRecord with
 | .ok ps,.ok ms,.ok cs =>
   IO.println (reprStr ps)
   IO.println (reprStr ms)
   IO.println (reprStr cs)
   IO.println (reprStr ((List.range 34).map (fun n => if primeNat n then 1 else 0)))
 | _,_,_ => throw (IO.userError "source ladder construction failed")
