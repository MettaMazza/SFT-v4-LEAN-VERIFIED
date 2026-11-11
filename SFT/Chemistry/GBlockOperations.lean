import SFT.Physics.AtomicOrbitCapacity
import SFT.Physics.AtomicBoundary
import SFT.Physics.NuclearClosure
namespace SFT.Chemistry.GBlockOperations
open SFT.Physics SFT.Physics.GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

structure OccupiedSubshell where
 principalRank : Nat
 orbitRank : Nat
 occupied : Nat
 capacity : Nat
 deriving Repr

def positiveInput : CountInput → Option Nat
 | .boolean _ => none
 | .integer (.negSucc _) => none
 | .integer (.ofNat 0) => none
 | .integer (.ofNat (n+1)) => some (n+1)

def occupiedSubshell (principal orbit occupied capacity : CountInput) : Except String OccupiedSubshell := do
 let coordinates := [positiveInput principal,positiveInput orbit,positiveInput occupied,positiveInput capacity]
 if coordinates.any Option.isNone then .error "ValueError: occupied subshell coordinates must be positive exact counts"
 else
   let p := (positiveInput principal).getD 0
   let o := (positiveInput orbit).getD 0
   let n := (positiveInput occupied).getD 0
   let c := (positiveInput capacity).getD 0
   if o > p || n > c then .error "ValueError: occupied subshell lies outside its generated support"
   else .ok ⟨p,o,n,c⟩

def coverCells (cover : Nat) : List (Nat × Nat) :=
 ((List.range cover).filter (fun p => 0 < p && cover-p ≤ p)).map (fun p => (p,cover-p))

def orderThrough : Nat → List (Nat × Nat)
 | 0 => []
 | n+1 => orderThrough n ++ coverCells (n+1)

def generatedSubshellOrder : CountInput → Except String (List (Nat × Nat))
 | .boolean _ => .error "ValueError: cover rank must extend the One"
 | .integer (.negSucc _) => .error "ValueError: cover rank must extend the One"
 | .integer (.ofNat 0) => .error "ValueError: cover rank must extend the One"
 | .integer (.ofNat 1) => .error "ValueError: cover rank must extend the One"
 | .integer (.ofNat (n+2)) => .ok (orderThrough (n+2))

def endpointSupport : Except String (List (Nat × Nat)) := do
 let endpoint ← AtomicBoundary.atomicEndpoint
 generatedSubshellOrder (.integer (.ofNat (2*endpoint)))

def fillOn : List (Nat × Nat) → Nat → Except String (List OccupiedSubshell)
 | [], _ => .error "ValueError: atomic support did not close within the admitted endpoint carrier"
 | (p,o)::rest, remaining => do
   let capacity ← AtomicOrbitCapacity.orbitCapacity (.integer (.ofNat o))
   let occupied := if remaining > capacity then capacity else remaining
   let row ← occupiedSubshell (.integer (.ofNat p)) (.integer (.ofNat o))
     (.integer (.ofNat occupied)) (.integer (.ofNat capacity))
   if remaining-occupied == 0 then .ok [row]
   else do
     let later ← fillOn rest (remaining-occupied)
     .ok (row::later)

def fillConfiguration (atomicNumber : CountInput) : Except String (List OccupiedSubshell) :=
 match positiveInput atomicNumber with
 | none => .error "ValueError: atomic number must be a positive exact count"
 | some n => do
   let cells ← endpointSupport
   fillOn cells n

-- Lookup coordinates have no positive-count guard in V3; Python True compares as One.
def matchesCoordinate (n : Nat) : CountInput → Bool
 | .boolean b => if b then n == 1 else n == 0
 | .integer (.ofNat k) => n == k
 | .integer (.negSucc _) => false

def occupationIn : List OccupiedSubshell → CountInput → CountInput → List Nat
 | [], _, _ => []
 | row::rest, p, o =>
   if matchesCoordinate row.principalRank p && matchesCoordinate row.orbitRank o then [row.occupied]
   else occupationIn rest p o

def subshellOccupation (atomicNumber principal orbit : CountInput) : Except String (List Nat) := do
 let rows ← fillConfiguration atomicNumber
 .ok (occupationIn rows principal orbit)

def nobleOn : List (Nat × Nat) → Nat → Nat → Except String (List Nat)
 | [], _, _ => .error "ValueError: requested noble-closure prefix exceeded the atomic carrier"
 | (p,o)::rest, total, remaining => do
   let capacity ← AtomicOrbitCapacity.orbitCapacity (.integer (.ofNat o))
   let next := total+capacity
   if (p == 1 && o == 1) || o == 2 then
     if remaining == 1 then .ok [next]
     else do
       let later ← nobleOn rest next (remaining-1)
       .ok (next::later)
   else nobleOn rest next remaining

def nobleClosures (length : CountInput) : Except String (List Nat) :=
 match positiveInput length with
 | none => .error "ValueError: noble closure prefix requires a positive length"
 | some n => do
   let cells ← endpointSupport
   nobleOn cells 0 n

def firstOn : List Nat → CountInput → CountInput → Except String Nat
 | [], _, _ => .error "ValueError: subshell does not open before the admitted atomic endpoint"
 | n::rest, p, o => do
   let rows ← subshellOccupation (.integer (.ofNat n)) p o
   if !rows.isEmpty then .ok n else firstOn rest p o

def firstOccupiedCoordinate (principal orbit : CountInput) : Except String Nat := do
 let endpoint ← AtomicBoundary.atomicEndpoint
 firstOn ((List.range endpoint).map (fun n => n+1)) principal orbit

theorem coverSuccessor (n : Nat) : orderThrough (n+1) = orderThrough n ++ coverCells (n+1) := rfl

theorem baseOrder : generatedSubshellOrder (.integer 2) = .ok [(1,1)] := rfl

theorem earlierCellsRetained (n : Nat) (cell : Nat × Nat) (held : cell ∈ orderThrough n) :
 cell ∈ orderThrough (n+1) := List.mem_append_left _ held

theorem capacityFromExistingDerivation (n : Nat) :
 AtomicOrbitCapacity.orbitCapacity (.integer (.ofNat (n+1))) = .ok (2*(1+2*n)) :=
 AtomicOrbitCapacity.exactCapacity n
end SFT.Chemistry.GBlockOperations
