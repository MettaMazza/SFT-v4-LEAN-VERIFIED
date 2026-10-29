import SFT.Foundation.FoldAssembly
import SFT.Foundation.FoldDynamics
namespace SFT.Physics.GeneratorThreeDerivation
open SFT.Foundation SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.FoldDynamics SFT.Foundation.FractionReduction

-- The host recursion includes its initial One; the source public operation
-- accepts positive depth only.
def supportCount : Nat → Nat
 | 0 => 1
 | depth+1 => supportCount depth + supportCount depth

theorem supportPositive (depth : Nat) : 0 < supportCount depth := by
  induction depth with
  | zero => exact Nat.zero_lt_succ _
  | succ depth ih => exact Nat.add_pos_left ih _

theorem extensionCount (words : List FoldAssembly.Word) :
    (FoldAssembly.extend words).length = words.length + words.length := by
  induction words with
  | nil => rfl
  | cons word tail ih =>
    change ((word ++ ["held-a"]) :: (word ++ ["held-b"]) :: FoldAssembly.extend tail).length = _
    change (FoldAssembly.extend tail).length + 2 = (tail.length+1)+(tail.length+1)
    rw [ih]
    rw [Nat.add_succ,Nat.succ_add]
    exact congrArg Nat.succ (Nat.add_assoc _ _ 1)

theorem completeSupportCount (depth : Nat) :
    (FoldAssembly.supportAfterExtensions depth).length = supportCount depth := by
  induction depth with
  | zero => rfl
  | succ depth ih =>
    change (FoldAssembly.extend (FoldAssembly.supportAfterExtensions depth)).length = _
    rw [extensionCount,ih]
    rfl

theorem positiveSupportBeyondOne (depth : Nat) (positive : 0 < depth) : 1 < supportCount depth := by
  cases depth with
  | zero => cases positive
  | succ depth => exact Nat.add_le_add (supportPositive depth) (supportPositive depth)

def supportPredecessor (depth : Nat) : Nat := (supportCount depth).pred

theorem predecessorPositive (depth : Nat) (positive : 0 < depth) : 0 < supportPredecessor depth :=
  by
  have bound := positiveSupportBeyondOne depth positive
  unfold supportPredecessor
  cases value : supportCount depth with
  | zero => rw [value] at bound; cases bound
  | succ n =>
    cases n with
    | zero => rw [value] at bound; exact False.elim (Nat.lt_irrefl 1 bound)
    | succ n => exact Nat.zero_lt_succ _

theorem predecessorSuccessor (depth : Nat) : supportPredecessor depth + 1 = supportCount depth :=
  Nat.succ_pred_eq_of_pos (supportPositive depth)

theorem predecessorUnique (depth candidate : Nat) (successor : candidate+1 = supportCount depth) :
    candidate = supportPredecessor depth :=
  Nat.succ.inj (successor.trans (predecessorSuccessor depth).symm)

def unitPart (depth : Nat) (positive : 0 < depth) : Part :=
  normalizePart 1 (supportPredecessor depth) (Nat.zero_lt_succ _) (predecessorPositive depth positive)

def seventh : Part := normalizePart 1 7 (by decide) (by decide)
def twoSevenths : Part := normalizePart 2 7 (by decide) (by decide)
def fourSevenths : Part := normalizePart 4 7 (by decide) (by decide)

theorem depthTwoSupport : supportCount 2 = 4 := rfl
theorem depthThreeSupport : supportCount 3 = 8 := rfl
theorem depthTwoUnit : unitPart 2 (by decide) = third := by apply partEquality <;> rfl
theorem depthThreeUnit : unitPart 3 (by decide) = seventh := by apply partEquality <;> rfl

theorem firstSeventhStep : foldPart seventh = twoSevenths := by apply partEquality <;> rfl
theorem secondSeventhStep : foldPart twoSevenths = fourSevenths := by apply partEquality <;> rfl
theorem thirdSeventhStep : foldPart fourSevenths = seventh := by apply partEquality <;> rfl

-- A row is the state after the transition, as in first_return_trace.
inductive Steps : Part → List Part → Prop where
 | identity (source : Part) : Steps source []
 | next (source : Part) (rest : List Part) (tail : Steps (foldPart source) rest) :
     Steps source (foldPart source :: rest)

def FirstReturn (source : Part) (trace : List Part) : Prop :=
  ∃ before, trace = before ++ [source] ∧ Steps source trace ∧
    ∀ state, state ∈ before → state ≠ source

def binaryTrace : List Part := [twoThirds,third]
def ternaryTrace : List Part := [twoSevenths,fourSevenths,seventh]

theorem binarySteps : Steps third binaryTrace := by
  have tail : Steps twoThirds [third] := by
    rw [← twoThirdsFoldsToThird]
    exact .next _ _ (.identity _)
  change Steps third [twoThirds,third]
  rw [← thirdFoldsToTwoThirds] at tail ⊢
  exact .next _ _ tail

theorem ternarySteps : Steps seventh ternaryTrace := by
  have last : Steps fourSevenths [seventh] := by
    rw [← thirdSeventhStep]
    exact .next _ _ (.identity _)
  have tail : Steps twoSevenths [fourSevenths,seventh] := by
    rw [← secondSeventhStep] at last ⊢
    exact .next _ _ last
  change Steps seventh [twoSevenths,fourSevenths,seventh]
  rw [← firstSeventhStep] at tail ⊢
  exact .next _ _ tail

theorem binaryFirstReturn : FirstReturn third binaryTrace := by
  refine ⟨[twoThirds],rfl,binarySteps,?_⟩
  intro state held
  cases held with
  | head => exact fun same => thirdAndTwoThirdsDistinct same.symm
  | tail _ h => cases h

theorem ternaryFirstReturn : FirstReturn seventh ternaryTrace := by
  refine ⟨[twoSevenths,fourSevenths],rfl,ternarySteps,?_⟩
  intro state held same
  have equalNumerator := congrArg Part.numerator same
  cases held with
  | head => exact (by decide : ¬ (2:Nat) = 1) equalNumerator
  | tail _ held => cases held with
    | head => exact (by decide : ¬ (4:Nat) = 1) equalNumerator
    | tail _ h => cases h

theorem binaryReturnLength : binaryTrace.length = 2 := rfl
theorem ternaryReturnLength : ternaryTrace.length = binaryTrace.length + 1 := rfl

theorem leastDistinctSuccessor (count : Nat) (later : binaryTrace.length < count) :
    ternaryTrace.length ≤ count := later

theorem uniqueLeastSuccessor (count : Nat) (later : binaryTrace.length < count)
    (least : ∀ other, binaryTrace.length < other → count ≤ other) : count = ternaryTrace.length :=
  Nat.le_antisymm (least 3 (by decide)) (leastDistinctSuccessor count later)

theorem laterCountNonminimal (count : Nat) (later : ternaryTrace.length < count) :
    ∃ witness, binaryTrace.length < witness ∧ witness < count := ⟨3,by decide,later⟩

theorem generatorThree :
    FirstReturn (unitPart 2 (by decide)) binaryTrace ∧
    FirstReturn (unitPart 3 (by decide)) ternaryTrace ∧
    ternaryTrace.length = 3 ∧
    ∀ count, binaryTrace.length < count → ternaryTrace.length ≤ count := by
  rw [depthTwoUnit,depthThreeUnit]
  exact ⟨binaryFirstReturn,ternaryFirstReturn,rfl,leastDistinctSuccessor⟩

end SFT.Physics.GeneratorThreeDerivation
