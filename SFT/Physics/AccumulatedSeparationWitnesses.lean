import SFT.Physics.AccumulatedSeparationTolerance
namespace SFT.Physics.AccumulatedSeparationWitnesses
open AccumulatedSeparation AccumulatedSeparationGeneral AccumulatedSeparationLedger AccumulatedSeparationBracket AccumulatedSeparationTolerance
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def checked : Except String Bool → Bool | .ok x => x | .error _ => false
def firstCheck : Bool := match adjacentSectorGap (.integer 1) with
 | .error _ => false
 | .ok a => match adjacentSectorGap (.integer 2) with
   | .error _ => false
   | .ok b => SFT.Mathematics.LimitComputations.equalRat a (VacuumLedgerProofs.natRatio 1 12 (by decide)) && SFT.Mathematics.LimitComputations.equalRat b (VacuumLedgerProofs.natRatio 1 20 (by decide))
def contractionCheck : Bool := (List.range 127).all (fun k => checked (successorIsBelowHalf (.integer (.ofNat (k+2)))))
def envelopeCheck : Bool := (List.range 128).all (fun k => checked (accumulationIsBounded (.integer (.ofNat (k+1))))) &&
 (List.range 127).all (fun k => checked (finiteTailEnvelope (.integer 2) (.integer (.ofNat (k+2)))))
def toleranceCheck : Bool := [1,2,3,5,7,11,127,1024].all (fun d => checked (toleranceIsWitnessed (.integer (.ofNat d))))
def witnesses : List Witness := [⟨"first-two-gaps","The complete first two terms are exactly one-twelfth and one-twentieth.",firstCheck⟩,⟨"strict-successor-contraction","Every checked generated successor after level two is below half its predecessor.",contractionCheck⟩,⟨"finite-partial-envelope","Every checked finite partial accumulation remains inside the exact depth-independent bracket.",envelopeCheck⟩,⟨"constructive-tolerance","Every checked positive rational tolerance receives an exact finite witness.",toleranceCheck⟩]
theorem firstCheckPassed : firstCheck=true := rfl
theorem contractionCheckPassed : contractionCheck=true := by
 unfold contractionCheck
 have each (xs : List Nat) : xs.all (fun k => checked (successorIsBelowHalf (.integer (.ofNat (k+2)))))=true := by
  induction xs with
  | nil => rfl
  | cons k ks ih =>
   change (checked (successorIsBelowHalf (.integer (.ofNat (k+2)))) && ks.all _) = true
   rw [originalEveryHalfContraction]
   exact ih
 exact each _
theorem envelopeCheckPassed : envelopeCheck=true := by
 unfold envelopeCheck
 have partials (xs : List Nat) : xs.all (fun k => checked (accumulationIsBounded (.integer (.ofNat (k+1)))))=true := by
  induction xs with
  | nil => rfl
  | cons k ks ih =>
   change (checked (accumulationIsBounded (.integer (.ofNat (k+1)))) && ks.all _) = true
   rw [originalEveryBracketCheck]
   exact ih
 have tail (xs : List Nat) : xs.all (fun k => checked (finiteTailEnvelope (.integer 2) (.integer (.ofNat (k+2)))))=true := by
  induction xs with
  | nil => rfl
  | cons k ks ih =>
   change (checked (finiteTailEnvelope (.integer 2) (.integer (.ofNat (k+2)))) && ks.all _) = true
   have h := originalEveryFiniteTail 0 k
   change finiteTailEnvelope (.integer 2) (.integer (.ofNat (2+k))) = .ok true at h
   rw [Nat.add_comm k 2, h]
   exact ih
 rw [partials,tail]
 rfl
theorem toleranceCheckPassed : toleranceCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (firstCheck && (contractionCheck && (envelopeCheck && (toleranceCheck && true)))) = true
 rw [firstCheckPassed,contractionCheckPassed,envelopeCheckPassed,toleranceCheckPassed]
 rfl
end SFT.Physics.AccumulatedSeparationWitnesses
