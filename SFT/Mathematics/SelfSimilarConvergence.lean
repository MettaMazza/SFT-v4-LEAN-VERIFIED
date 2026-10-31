import SFT.Foundation.FoldAssembly
import SFT.Mathematics.LocalSeparation
import SFT.Mathematics.DyadicClosure
import SFT.Mathematics.LimitComputations
namespace SFT.Mathematics.SelfSimilarConvergence
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open SFT.Physics.LeptonIntervals

def supportCount (labels : Nat) : Nat → Nat
 | 0 => 1
 | depth+1 => supportCount labels depth * labels

theorem completeSupport (labels depth : Nat) : supportCount labels depth = labels^depth := by
 induction depth with
 | zero => rfl
 | succ depth ih => change supportCount labels depth * labels = labels^depth*labels; rw [ih]

theorem supportSuccessor (labels depth : Nat) : supportCount labels (depth+1) = supportCount labels depth * labels := rfl

theorem supportBase (labels : Nat) : supportCount labels 1 = labels := Nat.one_mul labels

theorem localSeparationDoubles (p : LocalSeparation.HeldPair) :
 ((p.upper-p.lower)+(p.upper-p.lower))*(LocalSeparation.uncastTransport p).denominator =
 (LocalSeparation.uncastTransport p).numerator*p.denominator := LocalSeparation.transportValue p

def exponentCandidates : List Nat := [1,2,3,4]
def unitExponentSurvivors : List Nat := exponentCandidates.filter (fun e => 2^e == 2)
theorem originalExponentCensus : unitExponentSurvivors = [1] := rfl

def gapDenominator (depth : Nat) : Nat := (2+2^depth)*(3+2^depth)
def gap (depth : Nat) : Rat := normalize 1 (gapDenominator depth)
 (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _))

theorem scaleStrictlyIncreases (depth : Nat) : 2^depth < 2^(depth+1) := by
 rw [Nat.pow_succ, Nat.mul_succ, Nat.mul_one]
 exact Nat.lt_add_of_pos_right (Nat.pow_pos (by decide))

theorem denominatorStrictlyIncreases (depth : Nat) : gapDenominator depth < gapDenominator (depth+1) := by
 unfold gapDenominator
 have h := scaleStrictlyIncreases depth
 have l := Nat.add_lt_add_left h 2
 have r := Nat.add_lt_add_left h 3
 exact Nat.lt_trans (Nat.mul_lt_mul_of_pos_right l (Nat.add_pos_left (by decide) _))
   (Nat.mul_lt_mul_of_pos_left r (Nat.add_pos_left (by decide) _))

theorem geometricMajorant (depth : Nat) : 2^depth ≤ gapDenominator depth := by
 unfold gapDenominator
 have one : 1 ≤ 3+2^depth := Nat.le_trans (by decide : 1≤3) (Nat.le_add_right 3 _)
 exact Nat.le_trans (Nat.le_add_left _ _) (Nat.le_mul_of_pos_right _ one)

-- The complete finite binary geometric ledger, including its positive remainder.
def majorantWeight (count : Nat) : Nat := 2 * DyadicClosure.total (DyadicClosure.weights count)
def tailBudgetDenominator (depth count : Nat) : Nat := 2^depth * 2^count

theorem mulLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [← mulAssoc, Nat.mul_comm a b, mulAssoc]

theorem finiteTailLedger (depth count : Nat) :
 (majorantWeight count + 2) * 2^depth = 2 * tailBudgetDenominator depth count := by
 unfold majorantWeight tailBudgetDenominator
 have h : 2 * DyadicClosure.total (DyadicClosure.weights count) + 2 = 2 * 2^count := by
  rw [← Nat.mul_succ]
  exact congrArg (fun n => 2*n) (DyadicClosure.completeLedger count)
 rw [h]
 rw [mulAssoc, Nat.mul_comm (2^count) (2^depth)]

theorem positiveTailRemains (count : Nat) : majorantWeight count < 2 * 2^count := by
 have h := finiteTailLedger 0 count
 change (majorantWeight count+2)*1 = 2*(1*2^count) at h
 rw [Nat.mul_one,Nat.one_mul] at h
 rw [← h]
 exact Nat.lt_add_of_pos_right (by decide)

theorem tailDenominatorDoubles (depth count : Nat) :
 tailBudgetDenominator depth (count+1) = tailBudgetDenominator depth count * 2 := by
 unfold tailBudgetDenominator
 rw [Nat.pow_succ]
 exact (mulAssoc _ _ _).symm

def elevenTermSum : Rat := ((List.range 11).map gap).foldl add zero

def originalGapWitness : Bool := (List.range 14).all (fun d => decide (gapDenominator d < gapDenominator (d+1)))
def originalBracketWitness : Bool := elevenTermSum.num * 60 < 11 * Int.ofNat elevenTermSum.den

theorem originalGapWitnessPassed : originalGapWitness = true := rfl
set_option maxRecDepth 20000 in
set_option maxHeartbeats 2000000 in
theorem originalBracketWitnessPassed : originalBracketWitness = true := rfl

-- Source partial sums as exact numerator/denominator ledgers. The empty
-- accumulator is host bookkeeping; every nonempty term is strictly positive.
def partialLedger (depth : Nat) : Nat → Nat × Nat
 | 0 => (0,1)
 | count+1 =>
   let previous := partialLedger depth count
   let denominator := gapDenominator (depth+count)
   (previous.1*denominator+previous.2,previous.2*denominator)

theorem addMul (a b c : Nat) : (a+b)*c=a*c+b*c := by
 rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]

theorem budgetStep (n q a b d : Nat) (majorant : a ≤ d)
 (previous : n*a+2*q ≤ 2*b*q) :
 (n*d+q)*(a*2)+2*(q*d) ≤ 2*(b*2)*(q*d) := by
 have bound := Nat.mul_le_mul_left 2 (Nat.mul_le_mul_left q majorant)
 calc
  (n*d+q)*(a*2)+2*(q*d) = (n*a)*(2*d)+(2*(q*a)+2*(q*d)) := by
   conv => lhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
   all_goals (conv => rhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm])
  _ ≤ (n*a)*(2*d)+(2*(q*d)+2*(q*d)) := Nat.add_le_add_left (Nat.add_le_add_right bound _) _
  _ = (n*a+2*q)*(2*d) := by
   rw [← SFT.Foundation.FoldCastLaws.twoTimes (2*(q*d)),addMul]
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm]
   all_goals (conv => rhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm])
  _ ≤ (2*b*q)*(2*d) := Nat.mul_le_mul_right (2*d) previous
  _ = 2*(b*2)*(q*d) := by
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm]
   all_goals (conv => rhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm])

theorem scaleComposition (depth count : Nat) : 2^(depth+count)=2^depth*2^count := by
 induction count with
 | zero => exact (Nat.mul_one _).symm
 | succ count ih =>
   rw [Nat.add_succ,Nat.pow_succ,ih,Nat.pow_succ]
   exact mulAssoc _ _ _

theorem completePartialSumBudget (depth count : Nat) :
 (partialLedger depth count).1*(2^depth*2^count)+2*(partialLedger depth count).2 ≤
 2*(2^count)*(partialLedger depth count).2 := by
 induction count with
 | zero => change 0*(2^depth*1)+2 ≤ 2; rw [Nat.zero_mul,Nat.zero_add]; exact Nat.le_refl _
 | succ count ih =>
   change ((partialLedger depth count).1*gapDenominator (depth+count)+(partialLedger depth count).2)*
     (2^depth*2^(count+1))+2*((partialLedger depth count).2*gapDenominator (depth+count)) ≤
     2*(2^(count+1))*((partialLedger depth count).2*gapDenominator (depth+count))
   rw [Nat.pow_succ, ← mulAssoc (2^depth) (2^count) 2]
   apply budgetStep _ _ _ _ _ _ ih
   rw [← scaleComposition]
   exact geometricMajorant _

theorem ledgerDenominatorPositive (depth count : Nat) : 0 < (partialLedger depth count).2 := by
 induction count with
 | zero => exact Nat.zero_lt_succ _
 | succ count ih =>
   exact Nat.mul_pos ih (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _))

theorem everyFiniteTailBound (depth count : Nat) :
 (partialLedger depth count).1 * 2^depth < 2*(partialLedger depth count).2 := by
 have h := completePartialSumBudget depth count
 have positive := Nat.mul_pos (by decide : 0<2) (ledgerDenominatorPositive depth count)
 have strict := Nat.lt_of_lt_of_le (Nat.lt_add_of_pos_right positive) h
 have rearranged :
 ((partialLedger depth count).1 * 2^depth)*2^count <
 (2*(partialLedger depth count).2)*2^count := by
  rw [← mulAssoc (partialLedger depth count).1 (2^depth) (2^count)] at strict
  have eq : 2*(2^count)*(partialLedger depth count).2 = (2*(partialLedger depth count).2)*2^count := by
   rw [mulAssoc, Nat.mul_comm (2^count) (partialLedger depth count).2, ← mulAssoc]
  rw [eq] at strict
  exact strict
 exact Nat.lt_of_not_ge (fun opposite =>
   Nat.not_le_of_gt rearranged (Nat.mul_le_mul_right (2^count) opposite))


theorem oneClosedBinaryDistinction (word : SFT.Foundation.FoldAssembly.Word) :
 SFT.Foundation.FoldAssembly.appendLabel word "held-a" ≠ SFT.Foundation.FoldAssembly.appendLabel word "held-b" ∧
 SFT.Foundation.FoldAssembly.returnWord (SFT.Foundation.FoldAssembly.appendLabel word "held-a") = some word ∧
 SFT.Foundation.FoldAssembly.returnWord (SFT.Foundation.FoldAssembly.appendLabel word "held-b") = some word :=
 ⟨SFT.Foundation.FoldAssembly.branchesDistinct word,SFT.Foundation.FoldAssembly.bothBranchesReturn word⟩

theorem exactlyOneLabelClosed (word : SFT.Foundation.FoldAssembly.Word) (label : String) :
 (SFT.Foundation.FoldAssembly.appendLabel word label).length=word.length+1 :=
 SFT.Foundation.FoldAssembly.appendLabelLength word label

def originalLocalWitness : Bool := LimitComputations.equalRat
 (multiply (normalize 2 1 (by decide)) (normalize 2 35 (by decide))) (normalize 4 35 (by decide))
def originalSupportWitness : Bool := ([1,2,3] : List Nat).map (supportCount 3) == [3,9,27]
def originalExponentWitness : Bool := unitExponentSurvivors == [1]
theorem originalLocalWitnessPassed : originalLocalWitness = true := rfl
theorem originalSupportWitnessPassed : originalSupportWitness = true := rfl
theorem originalExponentWitnessPassed : originalExponentWitness = true := rfl

set_option maxRecDepth 20000 in
set_option maxHeartbeats 2000000 in
theorem originalSumMatchesLedger : elevenTermSum =
 normalize (.ofNat (partialLedger 0 11).1) (partialLedger 0 11).2 (ledgerDenominatorPositive 0 11) := rfl
end SFT.Mathematics.SelfSimilarConvergence
