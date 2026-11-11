import SFT.Physics.AlphaCovers
import SFT.Physics.QuantumPhysicalExclusion
namespace SFT.Physics.AtomicOrbitCapacity
open GeneratorOperations FoldFirstReturn MechanicalLocation

-- Both counts reuse the source's positive predecessor of generator three.
def binaryCount := AlphaCovers.binaryCount
def boundaryCount := AlphaCovers.binaryCount

def orientationCount : CountInput → Except String Nat
 | .boolean _ => .error "ValueError: orbit rank must be a positive exact count"
 | .integer (.negSucc _) => .error "ValueError: orbit rank must be a positive exact count"
 | .integer (.ofNat 0) => .error "ValueError: orbit rank must be a positive exact count"
 | .integer (.ofNat (n+1)) => do
   let boundary ← boundaryCount
   .ok (1 + boundary*n)

def orbitCapacity (rank : CountInput) : Except String Nat := do
 let binary ← binaryCount
 let orientations ← orientationCount rank
 .ok (binary*orientations)

theorem exactOrientations (n : Nat) : orientationCount (.integer (.ofNat (n+1))) = .ok (1+2*n) := by
 unfold orientationCount boundaryCount
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem exactCapacity (n : Nat) : orbitCapacity (.integer (.ofNat (n+1))) = .ok (2*(1+2*n)) := by
 unfold orbitCapacity binaryCount
 rw [AlphaCovers.binaryCountTwo,exactOrientations]
 rfl

inductive Orientation where
 | central
 | boundaryPair (predecessorStep : Nat) (side : Held)

def orientations : Nat → List Orientation
 | 0 => [.central]
 | n+1 => .boundaryPair n .first :: .boundaryPair n .second :: orientations n

def states : List Orientation → List (Orientation × Held)
 | [] => []
 | o::rest => (o,.first)::(o,.second)::states rest

theorem orientationLength (n : Nat) : (orientations n).length = 1+2*n := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change (orientations n).length+2 = 1+2*(n+1)
   rw [ih,Nat.mul_succ,Nat.add_assoc]

theorem statesLength (os : List Orientation) : (states os).length = 2*os.length := by
 induction os with
 | nil => rfl
 | cons o rest ih =>
   change (states rest).length+2 = 2*(rest.length+1)
   rw [ih,Nat.mul_succ]

theorem generatedCapacity (n : Nat) : (states (orientations n)).length = 2*(1+2*n) := by
 rw [statesLength,orientationLength]

theorem capacitySuccessor (n : Nat) : (states (orientations (n+1))).length =
 (states (orientations n)).length+4 := rfl

theorem baseCapacity : (states (orientations 0)).length = 2 := rfl

theorem priorOrientationRetained (n : Nat) (o : Orientation) (held : o∈orientations n) :
 o∈orientations (n+1) := .tail _ (.tail _ held)

theorem everyOrientationHasBothLabels (os : List Orientation) (o : Orientation) (held : o∈os) :
 (o,Held.first)∈states os ∧ (o,Held.second)∈states os := by
 induction os with
 | nil => cases held
 | cons x rest ih =>
   cases held with
   | head => exact ⟨.head _,.tail _ (.head _)⟩
   | tail _ h =>
     have pair := ih h
     exact ⟨.tail _ (.tail _ pair.1),.tail _ (.tail _ pair.2)⟩

theorem duplicateSameLabelExcluded
 (exchangeOrientation : QuantumPhysicalIdentity.Pair (QuantumPhysicalExclusion.Occupant Held Orientation) → Held)
 (a b : QuantumPhysicalExclusion.Occupant Held Orientation)
 (sameLabel : a.word=b.word) (sameOrientation : a.cell=b.cell) :
 ¬ QuantumPhysicalExclusion.alternating exchangeOrientation ⟨a,b⟩ :=
 QuantumPhysicalExclusion.identicalSameCellExcluded exchangeOrientation a b sameLabel sameOrientation

theorem boundaryStepEarlier (n k : Nat) (side : Held)
 (member : Orientation.boundaryPair k side ∈ orientations n) : k<n := by
 induction n with
 | zero => cases member with | tail _ h => cases h
 | succ n ih =>
   cases member with
   | head => exact Nat.lt_succ_self _
   | tail _ h =>
     cases h with
     | head => exact Nat.lt_succ_self _
     | tail _ h => exact Nat.lt_trans (ih h) (Nat.lt_succ_self n)

theorem centralRetained (n : Nat) : Orientation.central ∈ orientations n := by
 induction n with
 | zero => exact .head _
 | succ n ih => exact .tail _ (.tail _ ih)

theorem everyPredecessorPair (n k : Nat) (side : Held) (before : k<n) :
 Orientation.boundaryPair k side ∈ orientations n := by
 induction n with
 | zero => cases before
 | succ n ih =>
   cases Nat.eq_or_lt_of_le (Nat.le_of_lt_succ before) with
   | inl same =>
     cases same
     cases side with
     | first => exact .head _
     | second => exact .tail _ (.head _)
   | inr earlier => exact .tail _ (.tail _ (ih earlier))

theorem boundaryPairExactly (n k : Nat) (side : Held) :
 Orientation.boundaryPair k side ∈ orientations n ↔ k<n :=
 ⟨boundaryStepEarlier n k side,everyPredecessorPair n k side⟩

theorem orientationsDistinct (n : Nat) : (orientations n).Nodup := by
 induction n with
 | zero => exact .cons (fun _ h => by cases h) .nil
 | succ n ih =>
   apply List.Pairwise.cons
   · intro o member eq
     cases member with
     | head => cases eq
     | tail _ old =>
       cases eq
       exact Nat.lt_irrefl n (boundaryStepEarlier n n .first old)
   · apply List.Pairwise.cons
     · intro o member eq
       cases eq
       exact Nat.lt_irrefl n (boundaryStepEarlier n n .second member)
     · exact ih

theorem stateHasOrientation (os : List Orientation) (state : Orientation × Held)
 (member : state∈states os) : state.1∈os := by
 induction os with
 | nil => cases member
 | cons o rest ih =>
   cases member with
   | head => exact .head _
   | tail _ h =>
     cases h with
     | head => exact .head _
     | tail _ prior => exact .tail _ (ih prior)

theorem statesDistinct (os : List Orientation) (distinct : os.Nodup) : (states os).Nodup := by
 induction distinct with
 | nil => exact .nil
 | @cons o rest fresh distinct ih =>
   apply List.Pairwise.cons
   · intro state member eq
     cases member with
     | head => cases eq
     | tail _ old => exact fresh state.1 (stateHasOrientation rest state old) (congrArg Prod.fst eq)
   · apply List.Pairwise.cons
     · intro state member eq
       exact fresh state.1 (stateHasOrientation rest state member) (congrArg Prod.fst eq)
     · exact ih

theorem generatedStatesDistinct (n : Nat) : (states (orientations n)).Nodup :=
 statesDistinct _ (orientationsDistinct n)

end SFT.Physics.AtomicOrbitCapacity
