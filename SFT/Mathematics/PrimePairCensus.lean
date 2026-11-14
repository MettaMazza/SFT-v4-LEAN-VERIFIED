import SFT.Mathematics.OrbitCyclotomic
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

-- Exact original trial-division loop, with the source square-bound guard.
def trial (n d : Nat) : Nat → Bool
 | 0 => true
 | fuel+1 => if d*d≤n then
     if n%d==0 then false else trial n (d+1) fuel
   else true

-- The structural counter is derived from n. It cannot end while the source
-- square-bound guard holds: the retained invariant is n<d+fuel.
theorem exhaustionOutsideSquare (n d : Nat) (positive : 2≤d) (past : n<d) :
 ¬d*d≤n := by
 have dp : 1≤d := Nat.le_trans (by decide : 1≤2) positive
 have size : d≤d*d := by
   have h := Nat.mul_le_mul_left d dp
   rw [Nat.mul_one] at h
   exact h
 exact Nat.not_le_of_gt (Nat.lt_of_lt_of_le past size)

theorem sourceLoopStep (n d fuel : Nat) (positive : 2≤d) (capacity : n<d+fuel) :
 trial n d fuel = if d*d≤n then
   (if n%d==0 then false else trial n (d+1) (fuel-1)) else true := by
 cases fuel with
 | zero =>
   have outside := exhaustionOutsideSquare n d positive capacity
   rw [ite_eq_right outside]
   rfl
 | succ fuel => rfl

theorem successorCapacity (n d fuel : Nat) (capacity : n<d+(fuel+1)) :
 n<(d+1)+fuel := by
 rw [Nat.add_right_comm d 1 fuel]
 exact capacity

def isPrime (n : Nat) : Bool := if n<2 then false else trial n 2 n

theorem originalCapacity (n : Nat) : n<2+n := Nat.lt_add_of_pos_left (by decide)

def isPrimeInteger : Int → Bool
 | .ofNat n => isPrime n
 | .negSucc _ => false

def generatedSplits (even left : Nat) : Nat → List (Nat × Nat)
 | 0 => []
 | count+1 => (left,even-left)::generatedSplits even (left+1) count

def complements (even : Nat) : List (Nat × Nat) := generatedSplits even 2 (even-2)

def pairSearch (even left : Nat) : Nat → Option (Nat × Nat)
 | 0 => none
 | fuel+1 =>
   if isPrime left && isPrime (even-left) then some (left,even-left)
   else pairSearch even (left+1) fuel

def goldbachPair (even : Nat) : Option (Nat × Nat) := pairSearch even 2 (even-2)

def primePairs (even : Nat) : List (Nat × Nat) :=
 (complements even).filter (fun p => isPrime p.1 && isPrime p.2)

def unorderedCount (even : Nat) : Nat :=
 (primePairs even).filter (fun p => p.1≤p.2) |>.length

def twinPairs (bound : Nat) : List (Nat × Nat) :=
 ((List.range (bound-4)).map (fun i => i+3)).filterMap
  (fun p => if isPrime p && isPrime (p+2) then some (p,p+2) else none)

def evenAt (i : Nat) := 4+2*i

def censusBlock (start count : Nat) : List (Nat × Option (Nat × Nat)) :=
 (List.range count).map (fun i => let n := evenAt (start+i); (n,goldbachPair n))

def blockPassed (start count : Nat) : Bool :=
 (censusBlock start count).all (fun row => row.2.isSome)

theorem firstEven : evenAt 0=4 := rfl

theorem nextEven (i : Nat) : evenAt (i+1)=evenAt i+2 := by
 unfold evenAt
 rw [Nat.mul_succ,Nat.add_assoc]

theorem firstPair : goldbachPair 4=some (2,2) := by decide

theorem twelveCount : unorderedCount 12=1 := by decide

theorem hundredCount : unorderedCount 100=6 := by decide

end SFT.Mathematics.PrimePairCensus
