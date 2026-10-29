import SFT.Physics.LeptonTake
import SFT.InformationScience.CompressionSupport
namespace SFT.Physics.LeptonSupport
open GeneratorOperations FoldFirstReturn SFT.Foundation
open SFT.InformationScience.QuantitySupport SFT.InformationScience.CompressionSupport
set_option maxRecDepth 20000

def colourLabels : List String := ["colour-a","colour-b","colour-c"]

def colourSupport (depth : Nat) : List (List String) := words colourLabels depth

theorem colourSupportCount (depth : Nat) : (colourSupport depth).length = 3^depth :=
 wordsCount colourLabels depth

theorem colourSupportComplete (depth : Nat) (word : List String) :
 word ∈ colourSupport depth ↔ word.length = depth ∧ ∀ label, label ∈ word → label ∈ colourLabels :=
 wordCharacterization colourLabels depth word

theorem colourSupportDistinct (depth : Nat) :
 SFT.Mathematics.DiscreteObjects.distinct (colourSupport depth) = true :=
 wordsDistinct colourLabels rfl depth

def doubledSupport : List (Bool × List String) :=
 (colourSupport 5).map (fun word => (false,word)) ++ (colourSupport 5).map (fun word => (true,word))

theorem completeDoubleCount : doubledSupport.length = 486 := by
 unfold doubledSupport
 rw [CommonRefinement.appendLength,CommonRefinement.mapLength,CommonRefinement.mapLength,colourSupportCount]

def leadingDenominator : Except String Nat := do
 let colour ← generatorPeriod
 positivePredecessor (.integer (.ofNat ((colour^colour)*colour*colour+(colour^colour)*colour*colour)))

theorem denominator485 : leadingDenominator = .ok 485 := by
 unfold leadingDenominator
 rw [generatorPeriodThree]
 rfl

theorem supportReassembly : 485+1 = doubledSupport.length := by
 rw [completeDoubleCount]

theorem predecessorUnique (candidate : Nat) (reassembles : candidate+1 = doubledSupport.length) : candidate = 485 := by
 rw [completeDoubleCount] at reassembles
 exact Nat.succ.inj reassembles

theorem originalSupportExpression : (3^3)*3*3+(3^3)*3*3 = doubledSupport.length := by
 rw [completeDoubleCount]

theorem nativeLeadingDerivation : leadingDenominator = .ok 485 ∧ 485+1 = doubledSupport.length ∧
 ∀ candidate, candidate+1 = doubledSupport.length → candidate = 485 :=
 ⟨denominator485,supportReassembly,predecessorUnique⟩
end SFT.Physics.LeptonSupport
