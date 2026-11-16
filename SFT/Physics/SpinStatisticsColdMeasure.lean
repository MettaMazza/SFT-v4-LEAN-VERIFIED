import SFT.Physics.SpinStatisticsColdScores
namespace SFT.Physics.SpinStatisticsColdMeasure
open SpinStatisticsCondensation SpinStatisticsOccupationWeights SpinStatisticsGroundMinimum
open SpinStatisticsColdScores LeptonIntervals VacuumLedgerProofs
open SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- Aliases for the exact positive-domain source enumeration and its generated ground.
def words (particles levels : Nat) : List (List Nat) := walk particles (levels+1) [] particles
def ground (particles levels : Nat) : List Nat := groundWord particles (levels+2)
theorem originalGroundMember (particles levels : Nat) : ground particles levels∈words particles levels :=
 originalGroundGenerated particles (levels+1)
theorem originalWordsNonempty (particles levels : Nat) : words particles levels≠[] := by
 intro empty
 have held := originalGroundMember particles levels
 rw [empty] at held
 cases held
private theorem wordEquality (word : List Nat) : (word==word)=true := by
 induction word with
 | nil => rfl
 | cons c cs ih =>
   change ((c==c)&&(cs==cs))=true
   rw [naturalEqualityReflexive,ih]
   rfl
private theorem equalWords (left right : List Nat) (same : (left==right)=true) : left=right := by
 induction left generalizing right with
 | nil => cases right with
   | nil => rfl
   | cons c cs => cases same
 | cons c cs ih => cases right with
   | nil => cases same
   | cons d ds =>
     change ((c==d)&&(cs==ds))=true at same
     cases h : c==d with
     | false => rw [h] at same;cases same
     | true =>
       rw [h] at same
       have head := Nat.eq_of_beq_eq_true h
       cases head
       exact congrArg (List.cons c) (ih ds same)
theorem originalLookupGeneratedWeight (target : List Nat) (forms : List (List Nat))
 (weight : List Nat→Rat) (present : target∈forms) :
 lookupGround target (forms.map (fun word => (word,weight word)))=weight target := by
 induction forms with
 | nil => cases present
 | cons word rest ih =>
   change (if word==target then weight word else lookupGround target (rest.map (fun word => (word,weight word))))=_
   cases decision : word==target with
   | true =>
     have eq := equalWords word target decision
     cases eq
     rfl
   | false =>
     apply ih
     cases present with
     | head => have same := wordEquality target;rw [decision] at same;cases same
     | tail _ h => exact h

def denominator (particles levels depth : Nat) : Nat :=
 total (ThermalEquilibriumWeights.originalCounts levels) depth (words particles levels)
theorem originalDenominatorPositive (particles levels depth : Nat) : 0<denominator particles levels depth :=
 originalTotalPositive (levels+2) depth (words particles levels) (originalWordsNonempty particles levels)

theorem originalGroundShareOperation (p l d : Nat) :
 groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat (d+1))) =
 .ok (natRatio (score (ThermalEquilibriumWeights.originalCounts l) (d+1) (ground (p+1) l))
   (denominator (p+1) l (d+1)) (originalDenominatorPositive (p+1) l (d+1))) := by
 have generated : occupationVectors (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving"=
   .ok (words (p+1) l) := rfl
 have assembled := originalWeightAssembly p (l+1) d "preserving" (words (p+1) l) generated (originalWordsNonempty (p+1) l)
 unfold groundShare
 rw [assembled]
 change Except.ok (lookupGround (ground (p+1) l) ((words (p+1) l).map (fun word =>
   (word,natRatio (score (ThermalEquilibriumWeights.originalCounts l) (d+1) word)
     (denominator (p+1) l (d+1)) (originalDenominatorPositive (p+1) l (d+1))))))=_
 rw [originalLookupGeneratedWeight _ _ _ (originalGroundMember (p+1) l)]
end SFT.Physics.SpinStatisticsColdMeasure
