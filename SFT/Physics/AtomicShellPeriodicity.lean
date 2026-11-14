import SFT.Physics.AtomicOrbitCapacity
import SFT.Physics.AtomicBoundary
namespace SFT.Physics.AtomicShellPeriodicity
open GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
inductive Input where
 | count (value : CountInput)
 | nonInteger

def sumCapacities : Nat → Except String Nat
 | 0 => .ok 0
 | n+1 => do
  let prior ← sumCapacities n
  let next ← AtomicOrbitCapacity.orbitCapacity (.integer (.ofNat (n+1)))
  pure (prior+next)
def shellCapacity : Input → Except String Nat
 | .count (.integer (.ofNat (n+1))) => sumCapacities (n+1)
 | .nonInteger => .error "principal shell rank must be a positive whole count"
 | .count (.boolean _) => .error "principal shell rank must be a positive whole count"
 | .count (.integer (.negSucc _)) => .error "principal shell rank must be a positive whole count"
 | .count (.integer (.ofNat 0)) => .error "principal shell rank must be a positive whole count"
def coverRow (cover : Nat) : List (Nat × Nat) :=
 ((List.range (cover-1)).map (fun n => n+1)).filterMap (fun principal =>
  let orbit := cover-principal
  if orbit≤principal then some (principal,orbit) else none)
def coverRows : Nat → List (Nat × Nat)
 | 0 => []
 | n+1 => coverRows n ++ coverRow (n+2)
def generatedSubshellOrder : Input → Except String (List (Nat × Nat))
 | .count (.integer (.ofNat (n+2))) => .ok (coverRows (n+1))
 | .nonInteger => .error "cover rank must extend the One"
 | .count (.boolean _) => .error "cover rank must extend the One"
 | .count (.integer (.negSucc _)) => .error "cover rank must extend the One"
 | .count (.integer (.ofNat 0)) => .error "cover rank must extend the One"
 | .count (.integer (.ofNat 1)) => .error "cover rank must extend the One"
def closureWalk (wanted accumulated : Nat) (held : List Nat) : List (Nat × Nat) → Except String (List Nat)
 | [] => .error "requested closure prefix exceeds the admitted atomic carrier"
 | (principal,orbit)::rest => do
  let capacity ← AtomicOrbitCapacity.orbitCapacity (.integer (.ofNat orbit))
  let accumulated := accumulated+capacity
  if (principal==1 && orbit==1) || orbit==2 then
   let closures := held++[accumulated]
   if closures.length==wanted then pure closures else closureWalk wanted accumulated closures rest
  else closureWalk wanted accumulated held rest
def generatedPeriodClosures : Input → Except String (List Nat)
 | .count (.integer (.ofNat (n+1))) => do
  let endpoint ← AtomicBoundary.atomicEndpoint
  let order ← generatedSubshellOrder (.count (.integer (.ofNat (2*endpoint))))
  closureWalk (n+1) 0 [] order
 | .nonInteger => .error "closure prefix length must be positive"
 | .count (.boolean _) => .error "closure prefix length must be positive"
 | .count (.integer (.negSucc _)) => .error "closure prefix length must be positive"
 | .count (.integer (.ofNat 0)) => .error "closure prefix length must be positive"
def widthWalk (prior : Nat) : List Nat → List Nat
 | [] => []
 | closure::rest => (closure-prior)::widthWalk closure rest
def generatedPeriodWidths (length : Input) : Except String (List Nat) := do
 pure (widthWalk 0 (← generatedPeriodClosures length))
theorem shellSum (n : Nat) : sumCapacities n = .ok (2*n*n) := by
 induction n with
 | zero => rfl
 | succ n ih =>
  unfold sumCapacities
  rw [ih,AtomicOrbitCapacity.exactCapacity]
  change Except.ok (2*n*n+2*(1+2*n)) = Except.ok (2*(n+1)*(n+1))
  apply congrArg Except.ok
  rw [Nat.mul_add 2 1 (2*n),Nat.mul_one,Nat.two_mul (2*n)]
  rw [Nat.mul_add 2 n 1,Nat.mul_one,Nat.mul_add (2*n+2) n 1,Nat.mul_one]
  rw [Nat.mul_comm (2*n+2) n,Nat.mul_add n (2*n) 2,Nat.mul_comm n (2*n),Nat.mul_comm n 2]
  rw [Nat.add_assoc (2*n*n) (2*n) (2*n+2)]
  rw [Nat.add_comm 2 (2*n+2*n),Nat.add_assoc (2*n) (2*n) 2]

theorem everyPositiveShell (n : Nat) : shellCapacity (.count (.integer (.ofNat (n+1))))=.ok (2*(n+1)*(n+1)) := shellSum (n+1)
theorem priorCoverRetained (n : Nat) : coverRows (n+1)=coverRows n++coverRow (n+2) := rfl
theorem shellBooleanRejected (b : Bool) : shellCapacity (.count (.boolean b))=.error "principal shell rank must be a positive whole count" := rfl
theorem firstFour : [shellCapacity (.count (.integer 1)),shellCapacity (.count (.integer 2)),shellCapacity (.count (.integer 3)),shellCapacity (.count (.integer 4))]=[.ok 2,.ok 8,.ok 18,.ok 32] := rfl
theorem firstSevenClosures : generatedPeriodClosures (.count (.integer 7))=.ok [2,10,18,36,54,86,118] := rfl
theorem firstSevenWidths : generatedPeriodWidths (.count (.integer 7))=.ok [2,8,8,18,18,32,32] := rfl
end SFT.Physics.AtomicShellPeriodicity
