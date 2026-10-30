import SFT.Physics.PlanckHierarchy
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.PrimeSectorLadder
open GeneratorOperations PlanckHierarchy LeptonIntervals
set_option maxRecDepth 20000

/-- The original complete range(2,value), tested by quotient reconstruction. -/
def properDivisors (value : Nat) : List Nat :=
 (List.range (value-2)).map (fun i => i+2)

def primeNat (value : Nat) : Bool :=
 if value ≤ 1 then false
 else (properDivisors value).all (fun divisor => !((value/divisor)*divisor == value))

def isPrimeCount : CountInput → Bool
 | .boolean _ => false
 | .integer (.negSucc _) => false
 | .integer (.ofNat n) => primeNat n

def primeSectorLadder : Except String (List Nat) := do
 let ceiling ← upperCoverDepth
 .ok (((List.range (ceiling-1)).map (fun i => i+2)).filter primeNat)

def mediatorCount : CountInput → Except String Nat
 | .boolean _ => .error "mediator count requires a generated prime sector"
 | .integer (.negSucc _) => .error "mediator count requires a generated prime sector"
 | .integer (.ofNat sector) => do
   let sectors ← primeSectorLadder
   if sectors.contains sector then positivePredecessor (.integer (.ofNat (sector*sector)))
   else .error "mediator count requires a generated prime sector"

def sectorCoupling : CountInput → Except String Rat
 | .boolean _ => .error "coupling requires a generated prime sector"
 | .integer (.negSucc _) => .error "coupling requires a generated prime sector"
 | .integer (.ofNat 0) => .error "coupling requires a generated prime sector"
 | .integer (.ofNat (sector+1)) => do
   let sectors ← primeSectorLadder
   if sectors.contains (sector+1) then do
     let retained ← positivePredecessor (.integer (.ofNat (sector+1)))
     .ok (normalize (.ofNat retained) (sector+1) (Nat.zero_lt_succ _))
   else .error "coupling requires a generated prime sector"

theorem completeLadder : primeSectorLadder = .ok [2,3,5,7] := by
 unfold primeSectorLadder
 rw [forcedUpperDepth]
 rfl

theorem completeTests : ([2,3,4,5,6,7] : List Nat).map primeNat =
 [true,true,false,true,false,true] := rfl

theorem nextPrimeExcluded : primeNat 11 = true ∧ mediatorCount (.integer 11) =
 .error "mediator count requires a generated prime sector" := by
 constructor
 · rfl
 · unfold mediatorCount
   rw [completeLadder]
   rfl

def mediatorRecord : Except String (List Nat) := do
 let sectors ← primeSectorLadder
 sectors.mapM (fun p => mediatorCount (.integer (.ofNat p)))

def couplingRecord : Except String (List (Int × Nat)) := do
 let sectors ← primeSectorLadder
 sectors.mapM (fun p => do
   let q ← sectorCoupling (.integer (.ofNat p))
   .ok (q.num,q.den))

theorem exactMediators : mediatorRecord = .ok [3,8,24,48] := by
 unfold mediatorRecord
 rw [completeLadder]
 rfl

theorem exactCouplings : couplingRecord = .ok [(1,2),(2,3),(4,5),(6,7)] := by
 unfold couplingRecord
 rw [completeLadder]
 rfl

theorem booleanPrimeRejected (b : Bool) : isPrimeCount (.boolean b) = false := rfl

theorem booleanSectorRejected (b : Bool) : mediatorCount (.boolean b) =
 .error "mediator count requires a generated prime sector" := rfl

end SFT.Physics.PrimeSectorLadder
