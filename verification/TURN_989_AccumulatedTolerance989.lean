import SFT.Physics.AccumulatedSeparationTolerance
import SFT.Host.Canonical
open SFT.Physics.AccumulatedSeparationTolerance SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval IO.println (render (.array [
result nv (toleranceWitness (.boolean false)),
result Value.boolean (toleranceIsWitnessed (.boolean false)),
result nv (toleranceWitness (.boolean true)),
result Value.boolean (toleranceIsWitnessed (.boolean true)),
result nv (toleranceWitness (.integer (-5))),
result Value.boolean (toleranceIsWitnessed (.integer (-5))),
result nv (toleranceWitness (.integer (-1))),
result Value.boolean (toleranceIsWitnessed (.integer (-1))),
result nv (toleranceWitness (.integer (0))),
result Value.boolean (toleranceIsWitnessed (.integer (0))),
result nv (toleranceWitness (.integer (1))),
result Value.boolean (toleranceIsWitnessed (.integer (1))),
result nv (toleranceWitness (.integer (2))),
result Value.boolean (toleranceIsWitnessed (.integer (2))),
result nv (toleranceWitness (.integer (3))),
result Value.boolean (toleranceIsWitnessed (.integer (3))),
result nv (toleranceWitness (.integer (5))),
result Value.boolean (toleranceIsWitnessed (.integer (5))),
result nv (toleranceWitness (.integer (7))),
result Value.boolean (toleranceIsWitnessed (.integer (7))),
result nv (toleranceWitness (.integer (11))),
result Value.boolean (toleranceIsWitnessed (.integer (11))),
result nv (toleranceWitness (.integer (127))),
result Value.boolean (toleranceIsWitnessed (.integer (127))),
result nv (toleranceWitness (.integer (1024))),
result Value.boolean (toleranceIsWitnessed (.integer (1024))),
result nv (toleranceWitness (.integer (10000))),
result Value.boolean (toleranceIsWitnessed (.integer (10000))),
result nv (toleranceWitness (.integer (1000000))),
result Value.boolean (toleranceIsWitnessed (.integer (1000000)))]))
