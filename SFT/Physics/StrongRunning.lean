import SFT.Physics.ColourCouplingDerivation
namespace SFT.Physics.StrongRunning
open GeneratorOperations

-- lineage_particle_laws.py: self_sourced_level_count, retaining the bare row
-- and exactly one binary_count() addition at each successor.
def sourceCount : Nat → Nat
 | 0 => 1
 | k+1 => sourceCount k + 2

def sourceLoop : Nat → Except String Nat
 | 0 => .ok 1
 | k+1 => do
   let previous ← sourceLoop k
   let pair ← ColourCouplingDerivation.binaryCount
   pure (previous + pair)

theorem loopCorrespondence (k : Nat) : sourceLoop k = .ok (sourceCount k) := by
 induction k with
 | zero => rfl
 | succ k ih =>
   unfold sourceLoop
   rw [ih, ColourCouplingDerivation.binaryCountTwo]
   rfl

theorem exactCount (k : Nat) : sourceCount k = 1 + 2*k := by
 induction k with
 | zero => rfl
 | succ k ih =>
   change sourceCount k + 2 = 1 + 2*(k+1)
   rw [ih, Nat.mul_succ, Nat.add_assoc]

theorem exactSuccessor (k : Nat) : sourceCount (k+1) = sourceCount k + 2 := rfl

theorem strictGrowth (k : Nat) : sourceCount k < sourceCount (k+1) :=
 Nat.lt_add_of_pos_right (by decide)

theorem positiveAtEveryLevel (k : Nat) : 0 < sourceCount k := by
 rw [exactCount]
 exact Nat.lt_of_lt_of_le (by decide : 0 < 1) (Nat.le_add_right 1 _)

def selfSourcedLevelCount : CountInput → Except String Nat
 | .boolean _ => .error "running witness requires a positive generated level"
 | .integer (.negSucc _) => .error "running witness requires a positive generated level"
 | .integer (.ofNat 0) => .error "running witness requires a positive generated level"
 | .integer (.ofNat (k+1)) => sourceLoop k

def colourPrefix (length : Nat) : List Nat := (List.range length).map sourceCount
def neutralPrefix (length : Nat) : List Nat := (List.range length).map (fun _ => 1)

def colourRunningPrefix : CountInput → Except String (List Nat)
 | .boolean _ => .error "running prefix requires a positive generated length"
 | .integer (.negSucc _) => .error "running prefix requires a positive generated length"
 | .integer (.ofNat 0) => .error "running prefix requires a positive generated length"
 | .integer (.ofNat (k+1)) => .ok (colourPrefix (k+1))

def neutralRunningPrefix : CountInput → Except String (List Nat)
 | .boolean _ => .error "running prefix requires a positive generated length"
 | .integer (.negSucc _) => .error "running prefix requires a positive generated length"
 | .integer (.ofNat 0) => .error "running prefix requires a positive generated length"
 | .integer (.ofNat (k+1)) => .ok (neutralPrefix (k+1))

theorem publicLevelExact (k : Nat) : selfSourcedLevelCount (.integer (.ofNat (k+1))) = .ok (1+2*k) := by
 change sourceLoop k = _
 rw [loopCorrespondence, exactCount]

theorem completeColourPrefix (length : Nat) : colourPrefix length = (List.range length).map (fun k => 1+2*k) := by
 unfold colourPrefix
 induction List.range length with
 | nil => rfl
 | cons k ks ih =>
   change sourceCount k :: ks.map sourceCount = (1+2*k) :: ks.map (fun k => 1+2*k)
   rw [exactCount, ih]

theorem mappedOne (xs : List Nat) (k : Nat) : k ∈ xs.map (fun _ => 1) → k = 1 := by
 induction xs with
 | nil => intro h; cases h
 | cons a rest ih =>
   intro h
   cases h with
   | head => rfl
   | tail _ tail => exact ih tail

theorem neutralEveryLevel (length k : Nat) (member : k ∈ neutralPrefix length) : k = 1 :=
 mappedOne (List.range length) k member

theorem colourFour : colourPrefix 4 = [1,3,5,7] := rfl
theorem neutralSeven : neutralPrefix 7 = [1,1,1,1,1,1,1] := rfl
theorem bareSource : sourceCount 0 = 1 := rfl
theorem levelZeroRejected : selfSourcedLevelCount (.integer 0) = .error "running witness requires a positive generated level" := rfl
theorem levelBooleanRejected (b : Bool) : selfSourcedLevelCount (.boolean b) = .error "running witness requires a positive generated level" := rfl
theorem levelNegativeRejected (k : Nat) : selfSourcedLevelCount (.integer (.negSucc k)) = .error "running witness requires a positive generated level" := rfl
end SFT.Physics.StrongRunning
