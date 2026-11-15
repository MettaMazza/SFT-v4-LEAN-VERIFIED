import SFT.Physics.RunningConvergence
import SFT.Physics.CommonScaleAxisAlgebra
import SFT.Mathematics.SelfSimilarConvergence
namespace SFT.Physics.AccumulatedSeparation
open GeneratorOperations LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original One-based positive-count guard and repeated binary support.
def binarySupport : CountInput → Except String Nat
 | .boolean _ => .error "level must be a generated positive count"
 | .integer (.negSucc _) => .error "level must be a generated positive count"
 | .integer (.ofNat 0) => .error "level must be a generated positive count"
 | .integer (.ofNat (k+1)) => .ok (RunningConvergence.scaleLoop k 1)
def adjacentSectorGap (level : CountInput) : Except String Rat := do
 let support ← binarySupport level
 pure (natRatio 1 ((support+2)*(support+3)) (Nat.mul_pos (Nat.add_pos_right _ (by decide)) (Nat.add_pos_right _ (by decide))))
-- Append the actual next generated gap in source order.
def accumulate : Nat → Nat → Rat → Except String Rat
 | 0,_,total => .ok total
 | n+1,level,total => do
  let gap ← adjacentSectorGap (.integer (.ofNat level))
  accumulate n (level+1) (add total gap)
def finitePartialAccumulation : CountInput → Except String Rat
 | .boolean _ => .error "partial accumulation requires a positive level"
 | .integer (.negSucc _) => .error "partial accumulation requires a positive level"
 | .integer (.ofNat 0) => .error "partial accumulation requires a positive level"
 | .integer (.ofNat (k+1)) => do
  let first ← adjacentSectorGap (.integer 1)
  accumulate k 2 first
def successorIsBelowHalf : CountInput → Except String Bool
 | .boolean _ => .error "half-contraction begins at the second positive level"
 | .integer (.negSucc _) => .error "half-contraction begins at the second positive level"
 | .integer (.ofNat 0) => .error "half-contraction begins at the second positive level"
 | .integer (.ofNat 1) => .error "half-contraction begins at the second positive level"
 | .integer (.ofNat (k+2)) => do
  let current ← adjacentSectorGap (.integer (.ofNat (k+2)))
  let successor ← adjacentSectorGap (.integer (.ofNat (k+3)))
  pure ((add successor successor).blt current)
def finiteTailEnvelope (start finish : CountInput) : Except String Bool := do
 let a ← match start with
  | .integer (.ofNat (k+2)) => .ok (k+2)
  | .integer (.ofNat 0) | .integer (.ofNat 1) | .integer (.negSucc _) | .boolean _ => .error "tail bounds require positive ordered levels from two"
 let b ← match finish with
  | .integer (.ofNat n) => if n<a then .error "tail bounds require positive ordered levels from two" else .ok n
  | .integer (.negSucc _) | .boolean _ => .error "tail bounds require positive ordered levels from two"
 let first ← adjacentSectorGap (.integer (.ofNat a))
 let tail ← accumulate (b-a) (a+1) first
 pure (tail.blt (add first first))
def accumulationIsBounded (level : CountInput) : Except String Bool := do
 let total ← finitePartialAccumulation level
 pure (!total.blt (natRatio 1 12 (by decide)) && total.blt (natRatio 11 60 (by decide)))
theorem originalSupport (k : Nat) : binarySupport (.integer (.ofNat (k+1)))=.ok (2^k) := by
 change Except.ok (RunningConvergence.scaleLoop k 1)=_
 rw [RunningConvergence.scaleLoopExact,Nat.one_mul]
theorem originalEveryGap (k : Nat) : adjacentSectorGap (.integer (.ofNat (k+1)))=
 .ok (natRatio 1 ((2^k+2)*(2^k+3)) (Nat.mul_pos (Nat.add_pos_right _ (by decide)) (Nat.add_pos_right _ (by decide)))) := by
 unfold adjacentSectorGap
 rw [originalSupport]
 rfl
theorem originalFirstGap : adjacentSectorGap (.integer 1)=.ok (natRatio 1 12 (by decide)) := rfl
theorem originalSecondGap : adjacentSectorGap (.integer 2)=.ok (natRatio 1 20 (by decide)) := rfl
theorem originalFirstAccumulation : finitePartialAccumulation (.integer 1)=.ok (natRatio 1 12 (by decide)) := rfl
theorem originalSecondAccumulation : finitePartialAccumulation (.integer 2)=.ok (natRatio 2 15 (by decide)) := rfl
end SFT.Physics.AccumulatedSeparation
