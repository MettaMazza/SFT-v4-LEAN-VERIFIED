import SFT.Mathematics.OrbitOrderIdentity
namespace SFT.Mathematics.OrbitNumberWitnesses
open OrbitOrderIdentity
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000

/-- Bounded replay only for the original finite witness census. None records
an unfinished replay and fails the witness; it is not a new scientific outcome. -/
def orderReplay (q : Nat) : Nat → Nat → Nat → Option Nat
 | 0,residue,count => if residue == 1 then some count else none
 | fuel+1,residue,count => if residue == 1 then some count
   else orderReplay q fuel ((residue*2)%q) (count+1)

def orderWitness (q : Nat) : Option Nat := orderReplay q q (2%q) 1

def orbitReplay (q : Nat) : Nat → Nat → List Nat → Option (List Nat)
 | 0,current,seen => if seen.contains current then some seen else none
 | fuel+1,current,seen => if seen.contains current then some seen
   else orbitReplay q fuel (foldRank current q) (seen++[current])

def orbitWitness (p q : Nat) : Option (List Nat) := orbitReplay q q p []

def orderExamples : Bool :=
 ([3,5,7,9,11] : List Nat).map orderWitness == [some 2,some 4,some 3,some 6,some 10]

def reducedRanksAt (q : Nat) : Bool :=
 (List.range (q-1)).all fun i =>
  let p := i+1
  if Nat.gcd p q == 1 then
   match orbitWitness p q with
   | none => false
   | some trace => match orderWitness q with
     | none => false
     | some order => trace.length == order
  else true

def allReducedRanks : Bool := (List.range 49).all (fun i => reducedRanksAt (2*i+3))

def primeDivision : Bool :=
 ([3,5,7,11,13,17,19,23,29,31] : List Nat).all fun p =>
  match orderWitness p with
  | none => false
  | some order => (p-1)%order == 0

def orbitTiling : Bool :=
 match orderWitness 73 with
 | none => false
 | some order => ((List.range 72).filter (fun i => Nat.gcd (i+1) 73 == 1)).length / order == 8


end SFT.Mathematics.OrbitNumberWitnesses
