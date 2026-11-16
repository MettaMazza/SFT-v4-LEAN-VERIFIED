import SFT.Physics.QuantumSupportWalsh
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- The original inner census fold, without changing its guards or returned counts.
def step (input : CountInput) (counts : Nat × Nat) (selected : List Word) : Except String (Nat × Nat) := do
 let c ← walshSupportCertificate input selected
 if !c.parsevalIdentity || !c.supportBound || !c.unitFreeBound || !c.squaredBound then
  throw "Walsh support census found a failed bound"
 pure (counts.1+1,counts.2+if c.supportProduct==c.branchCount then 1 else 0)
def offset (t s : Nat) : Except String (Nat × Nat) → Except String (Nat × Nat)
 | .error e => .error e
 | .ok (a,b) => .ok (a+t,b+s)
theorem stepOffset (input : CountInput) (a b t s : Nat) (selected : List Word) :
 step input (a+t,b+s) selected = offset t s (step input (a,b) selected) := by
 unfold step
 cases h : walshSupportCertificate input selected with
 | error e => rfl
 | ok c =>
  change (if !c.parsevalIdentity || !c.supportBound || !c.unitFreeBound || !c.squaredBound then Except.error (α := Nat × Nat) "Walsh support census found a failed bound" else Except.ok (ε := String) ((a+t)+1,(b+s)+(if c.supportProduct==c.branchCount then 1 else 0))) = offset t s (if !c.parsevalIdentity || !c.supportBound || !c.unitFreeBound || !c.squaredBound then Except.error "Walsh support census found a failed bound" else Except.ok (a+1,b+(if c.supportProduct==c.branchCount then 1 else 0)))
  split
  · rename_i hc
    rfl
  · rename_i hc
    change Except.ok ((a+t)+1,(b+s)+(if c.supportProduct==c.branchCount then 1 else 0)) = Except.ok ((a+1)+t,(b+(if c.supportProduct==c.branchCount then 1 else 0))+s)
    have ht : (a+t)+1=(a+1)+t := by
      rw [Nat.add_assoc,Nat.add_comm t 1,←Nat.add_assoc]
    have hs : (b+s)+(if c.supportProduct==c.branchCount then 1 else 0)=(b+(if c.supportProduct==c.branchCount then 1 else 0))+s := by
      rw [Nat.add_assoc,Nat.add_comm s (if c.supportProduct==c.branchCount then 1 else 0),←Nat.add_assoc]
    rw [ht,hs]

theorem foldOffset (input : CountInput) (xs : List (List Word)) (a b t s : Nat) :
 xs.foldlM (step input) (a+t,b+s) = offset t s (xs.foldlM (step input) (a,b)) := by
 induction xs generalizing a b with
 | nil => rfl
 | cons x xs ih =>
  change (do let p ← step input (a+t,b+s) x; xs.foldlM (step input) p) = offset t s (do let p ← step input (a,b) x; xs.foldlM (step input) p)
  rw [stepOffset]
  cases h : step input (a,b) x with
  | error e => rfl
  | ok p => exact ih p.1 p.2
theorem foldAppend (input : CountInput) (xs ys : List (List Word)) (p : Nat × Nat) :
 (xs++ys).foldlM (step input) p = (do let q ← xs.foldlM (step input) p; ys.foldlM (step input) q) := by
 induction xs generalizing p with
 | nil => rfl
 | cons x xs ih =>
  change (do let q ← step input p x; (xs++ys).foldlM (step input) q) = (do let q ← (do let v ← step input p x; xs.foldlM (step input) v); ys.foldlM (step input) q)
  cases h : step input p x with
  | error e => rfl
  | ok q => exact ih q
theorem foldFromZero (input : CountInput) (xs : List (List Word)) (n k a b : Nat)
 (h : xs.foldlM (step input) (0,0) = .ok (n,k)) :
 xs.foldlM (step input) (a,b) = .ok (n+a,k+b) := by
 have eq := foldOffset input xs 0 0 a b
 rw [Nat.zero_add,Nat.zero_add] at eq
 rw [eq,h]
 rfl
def batch (size start : Nat) : List (List Word) := ((combinations size (words 4)).drop start).take 256
end SFT.Physics.QuantumSupportWalshBatch
