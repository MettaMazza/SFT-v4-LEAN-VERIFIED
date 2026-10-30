import SFT.Foundation.HalfOneDerivation
import SFT.Physics.GeneratorOperations
namespace SFT.Physics.VacuumSpectrum
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier
open SFT.Foundation.HalfOneDerivation SFT.Physics.GeneratorOperations

/-- Complete binary support, including both candidates before the self-pair test. -/
def binaryParts : List Part := [normalizePart 1 2 (by decide) (by decide),normalizePart 2 2 (by decide) (by decide)]
def selfPairs (p : Part) : Bool :=
 (selfJunction p).numerator == 1 && (selfJunction p).denominator == 1
def floorSurvivors : List Part := binaryParts.filter selfPairs

def vacuumFloor : Except String Part :=
 match floorSurvivors with
 | [] => .error "the complete binary support did not force one vacuum floor"
 | p::tail => match tail with
   | _::_ => .error "the complete binary support did not force one vacuum floor"
   | [] => if p.numerator == 1 && p.denominator == 2 then .ok p
     else .error "the complete binary support did not force one vacuum floor"

theorem forcedVacuumFloor : vacuumFloor = .ok halfOne := rfl

theorem completeFloorSelection : floorSurvivors = [halfOne] := rfl

theorem arbitrarySelfPair (p : Part) :
 ((selfJunction p).numerator = 1 ∧ (selfJunction p).denominator = 1) ↔ p = halfOne := selfJunctionOneIff p

theorem floorSelfAntipodal : complement halfOne = .ok halfOne := complementHalf

theorem floorReturns : foldPart halfOne = SFT.Foundation.ExactOperations.one := halfFoldsToOne

/-- Position i represents source rank i+1, with the original odd numerator. -/
def oddNumerator (i : Nat) : Nat := 2*i+1

theorem sourceNumerator (i : Nat) : 2*(i+1)-1 = oddNumerator i := by
 rw [Nat.mul_add,Nat.mul_one]
 rfl

theorem numeratorPositive (i : Nat) : 0 < oddNumerator i := Nat.zero_lt_succ _

def level (support i : Nat) (hs : 0 < support) : PositiveFraction :=
 normalizePositive (oddNumerator i) (support*2) (numeratorPositive i) (Nat.mul_pos hs (by decide))

def levels (depth : Nat) : List PositiveFraction :=
 (List.range (2^depth)).map (fun i => level (2^depth) i (Nat.pow_pos (by decide)))

def oscillatorLevels : CountInput → Except String (List PositiveFraction)
 | .boolean _ => .error "oscillator depth must be a positive generated count"
 | .integer (.negSucc _) => .error "oscillator depth must be a positive generated count"
 | .integer (.ofNat 0) => .error "oscillator depth must be a positive generated count"
 | .integer (.ofNat (k+1)) => .ok (levels (k+1))

theorem mappedLength {α β : Type} (f : α → β) (xs : List α) :
 (xs.map f).length = xs.length := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg Nat.succ ih

theorem rangeLoopLength (n : Nat) (acc : List Nat) :
 (List.range.loop n acc).length = n+acc.length := by
 induction n generalizing acc with
 | zero => exact (Nat.zero_add _).symm
 | succ n ih =>
  change (List.range.loop n (n::acc)).length = (n+1)+acc.length
  rw [ih]
  exact Nat.add_right_comm n acc.length 1

theorem completeCardinality (depth : Nat) : (levels depth).length = 2^depth := by
 unfold levels
 rw [mappedLength]
 exact (rangeLoopLength (2^depth) []).trans (Nat.add_zero _)

theorem successorCardinality (depth : Nat) : (levels (depth+1)).length = 2*(levels depth).length := by
 rw [completeCardinality,completeCardinality,Nat.pow_succ,Nat.mul_comm]

theorem levelExactValue (support i : Nat) (hs : 0 < support) :
 oddNumerator i * (level support i hs).denominator =
 (level support i hs).numerator * (support*2) :=
 normalizedValuePreserved _ _ _ _

theorem uniformNumeratorSpacing (i : Nat) : oddNumerator (i+1) = oddNumerator i + 2 := by
 unfold oddNumerator
 rw [Nat.mul_add,Nat.mul_one]

theorem denominatorSuccessor (depth : Nat) : (2^(depth+1))*2 = (2^depth*2)*2 := by rw [Nat.pow_succ]

def pairs (xs : List PositiveFraction) := xs.map (fun p => (p.numerator,p.denominator))
theorem depthOne : pairs (levels 1) = [(1,4),(3,4)] := rfl
theorem depthTwo : pairs (levels 2) = [(1,8),(3,8),(5,8),(7,8)] := rfl

theorem zeroRejected : oscillatorLevels (.integer 0) = .error "oscillator depth must be a positive generated count" := rfl

theorem booleanRejected (b : Bool) : oscillatorLevels (.boolean b) = .error "oscillator depth must be a positive generated count" := rfl
theorem numeratorInjective (i j : Nat) (h : oddNumerator i = oddNumerator j) : i = j := by
 have same : 2*i = 2*j := Nat.succ.inj h
 exact Nat.eq_of_mul_eq_mul_left (by decide : 0 < 2) same

theorem completePositionBound (support i : Nat) (inside : i < support) : oddNumerator i < support*2 := by
 have h := Nat.mul_le_mul_left 2 (Nat.succ_le_of_lt inside)
 change 2*(i+1) ≤ 2*support at h
 rw [Nat.mul_add,Nat.mul_one] at h
 have strict : 2*i+1 < 2*i+2 := Nat.lt_succ_self _
 have result := Nat.lt_of_lt_of_le strict h
 rw [Nat.mul_comm 2 support] at result
 exact result

theorem everyLevelIsPart (support i : Nat) (hs : 0 < support) (inside : i < support) :
 (level support i hs).numerator ≤ (level support i hs).denominator :=
 normalizedThroughOne _ _ _ _ (Nat.le_of_lt (completePositionBound support i inside))

theorem levelInjective (support i j : Nat) (hs : 0 < support)
 (same : level support i hs = level support j hs) : i = j := by
 have hi := levelExactValue support i hs
 have hj := levelExactValue support j hs
 rw [same] at hi
 have multiplied := hi.trans hj.symm
 have numerators := Nat.eq_of_mul_eq_mul_right
  (Nat.pos_of_ne_zero (level support j hs).denominatorNonzero) multiplied
 exact numeratorInjective i j numerators

theorem successorLowerHalfSpacing (i : Nat) :
 oddNumerator (2*i)+1 = 2*oddNumerator i := by
 unfold oddNumerator
 rw [Nat.mul_add,Nat.mul_one,Nat.add_assoc]

theorem successorUpperHalfSpacing (i : Nat) :
 oddNumerator (2*i+1) = 2*oddNumerator i+1 := rfl

end SFT.Physics.VacuumSpectrum
