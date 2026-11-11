import SFT.Physics.AtomicOrbitCapacity
import SFT.Physics.ColourCouplingDerivation
namespace SFT.Physics.NuclearClosure
open GeneratorOperations SFT.Foundation.ExactOperations

-- Exact cross multiplication of colour_coupling * angular / binary < One.
def belowGap (coupling : PositiveFraction) (binary angular : Nat) : Bool :=
 coupling.numerator*angular < coupling.denominator*binary

def thresholdScan (coupling : PositiveFraction) (binary : Nat) : Nat → Nat → Except String Nat
 | _,0 => .error "internal termination certificate exhausted"
 | angular,fuel+1 =>
   if belowGap coupling binary angular then thresholdScan coupling binary (angular+1) fuel
   else .ok angular

def spinOrbitThreshold : Except String Nat := do
 let coupling ← ColourCouplingDerivation.colourCoupling
 let binary ← ColourCouplingDerivation.binaryCount
 let generator ← FoldFirstReturn.generatorPeriod
 thresholdScan coupling binary 1 generator

theorem thresholdThree : spinOrbitThreshold = .ok 3 := by
 unfold spinOrbitThreshold
 rw [ColourCouplingDerivation.forcedFromFoldAndGenerator,
     ColourCouplingDerivation.binaryCountTwo,FoldFirstReturn.generatorPeriodThree]
 rfl

theorem firstBelow : belowGap ColourCouplingDerivation.value 2 1 = true := rfl
theorem secondBelow : belowGap ColourCouplingDerivation.value 2 2 = true := rfl
theorem thirdReaches : belowGap ColourCouplingDerivation.value 2 3 = false := rfl

def oscillatorClosure : CountInput → Except String Nat
 | .boolean _ => .error "ValueError: shell rank must be a positive exact count"
 | .integer (.negSucc _) => .error "ValueError: shell rank must be a positive exact count"
 | .integer (.ofNat 0) => .error "ValueError: shell rank must be a positive exact count"
 | .integer (.ofNat (n+1)) => do
   let generator ← FoldFirstReturn.generatorPeriod
   let count := (n+1)*(n+2)*(n+3)
   if count % generator != 0 then .error "ValueError: three-direction composition count did not close exactly"
   else .ok (count/generator)

def nuclearClosure : CountInput → Except String Nat
 | .boolean _ => .error "ValueError: shell rank must be a positive exact count"
 | .integer (.negSucc _) => .error "ValueError: shell rank must be a positive exact count"
 | .integer (.ofNat 0) => .error "ValueError: shell rank must be a positive exact count"
 | .integer (.ofNat (n+1)) => do
   let threshold ← spinOrbitThreshold
   if n+1 ≤ threshold then oscillatorClosure (.integer (.ofNat (n+1)))
   else
     let previous ← oscillatorClosure (.integer (.ofNat n))
     let binary ← ColourCouplingDerivation.binaryCount
     .ok (previous+binary*(n+1))

def closurePrefix : CountInput → Except String (List Nat)
 | .boolean _ => .error "ValueError: closure prefix requires a positive exact length"
 | .integer (.negSucc _) => .error "ValueError: closure prefix requires a positive exact length"
 | .integer (.ofNat 0) => .error "ValueError: closure prefix requires a positive exact length"
 | .integer (.ofNat (n+1)) => ((List.range (n+1)).map (fun k => k+1)).mapM (fun k => nuclearClosure (.integer (.ofNat k)))

theorem exactFirstEight : closurePrefix (.integer 8) = .ok [2,8,20,28,50,82,126,184] := by
 unfold closurePrefix nuclearClosure
 rw [thresholdThree]
 rfl
theorem beforeThreshold (n : Nat) (before : n+1≤3) :
 nuclearClosure (.integer (.ofNat (n+1))) = oscillatorClosure (.integer (.ofNat (n+1))) := by
 unfold nuclearClosure
 rw [thresholdThree]
 change (if n+1≤3 then _ else _) = _
 rw [ite_eq_left before]

theorem afterThreshold (n : Nat) (after : 3<n+1) :
 nuclearClosure (.integer (.ofNat (n+1))) = (do
   let prior ← oscillatorClosure (.integer (.ofNat n))
   .ok (prior+2*(n+1))) := by
 unfold nuclearClosure
 rw [thresholdThree]
 change (if n+1≤3 then _ else _) = _
 rw [ite_eq_right (Nat.not_le_of_lt after)]
 rw [ColourCouplingDerivation.binaryCountTwo]
 rfl

theorem oscillatorExpression (n : Nat) :
 oscillatorClosure (.integer (.ofNat (n+1))) =
 (if (n+1)*(n+2)*(n+3) % 3 != 0 then .error "ValueError: three-direction composition count did not close exactly"
 else .ok ((n+1)*(n+2)*(n+3)/3)) := by
 unfold oscillatorClosure
 rw [FoldFirstReturn.generatorPeriodThree]
 rfl

theorem everyEarlierPositiveBelow (n : Nat) (positive : 0<n) (earlier : n<3) :
 belowGap ColourCouplingDerivation.value 2 n = true := by
 cases n with
 | zero => cases positive
 | succ n => cases n with
   | zero => rfl
   | succ n => cases n with
     | zero => rfl
     | succ n => exact False.elim (Nat.not_lt_of_ge
         (Nat.succ_le_succ (Nat.succ_le_succ (Nat.succ_le_succ (Nat.zero_le n)))) earlier)

theorem everyLaterReaches (n : Nat) (after : 3≤n) :
 belowGap ColourCouplingDerivation.value 2 n = false := by
 change decide (2*n<3*2)=false
 exact decide_eq_false (Nat.not_lt_of_ge (Nat.mul_le_mul_left 2 after))

end SFT.Physics.NuclearClosure
