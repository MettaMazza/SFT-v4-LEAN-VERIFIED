import SFT.Physics.SpinStatisticsCondensation
import SFT.Physics.QuantumPhysicalNoSignalling
namespace SFT.Physics.QuantumSupportPreparation
open LeptonIntervals VacuumLedgerProofs GeneratorOperations SpinStatisticsCondensation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev Word := List String
def held : String := "held"
def returned : String := "returned"
def words : Nat → List Word
 | 0 => [[]]
 | n+1 => [held,returned].flatMap (fun label => (words n).map (List.cons label))
def binaryWords (depth : CountInput) : Except String (List Word) := do
 pure (words (← positiveWhole depth "binary depth"))
structure Preparation where
 branchCount : Nat
 depth : Nat
 trace : List Nat
 branchUnit : Rat
def preparationDepth (branchCount : CountInput) : Except String Preparation := do
 let target ← positiveWhole branchCount "branch count"
 let d := AlphaCovers.coverDepth target
 if target<2 || 2^d != target then
  throw "binary measurement depth requires a complete nontrivial power-of-two preparation"
 let unit ← LeptonRatios.divide (wholeRatio 1) (wholeRatio target)
 pure ⟨target,d,(List.range d).map (fun i => 2^(i+1)),unit⟩
structure Partition where
 depth : Nat
 branchCount : Nat
 branchUnit : Rat
 classSizes : List Nat
 classWeights : List Rat
 weightsSumToOne : Bool
 maximalResolution : Bool
def measurementPartition (depth : CountInput) (classSizes : List CountInput) : Except String Partition := do
 let ws ← binaryWords depth
 let sizes ← classSizes.mapM (fun v => positiveWhole v "measurement class size")
 if sizes.foldl Nat.add 0 != ws.length then
  throw "measurement classes must partition complete prepared support"
 let weights ← sizes.mapM (fun n => LeptonRatios.divide (wholeRatio n) (wholeRatio ws.length))
 let preparation ← preparationDepth (.integer (.ofNat ws.length))
 let unit ← LeptonRatios.divide (wholeRatio 1) (wholeRatio ws.length)
 pure ⟨preparation.depth,ws.length,unit,sizes,weights,
  VelocityComposition.ratEqual (weights.foldl add zero) (wholeRatio 1),sizes.all (fun n => n==1)⟩
def walshPhase (point mode : Word) : Except String String := do
 if point.length != mode.length || point.isEmpty then
  throw "Walsh phase requires equal nonempty binary words"
 let flips := ((point.zip mode).filter (fun (a,b) => a==returned && b==returned)).length
 pure (if flips%2==0 then held else returned)
def imbalance (heldCount returnedCount : Nat) : Option Nat :=
 if heldCount==returnedCount then none
 else some (if heldCount>returnedCount then heldCount-returnedCount else returnedCount-heldCount)
def magnitude : Option Nat → Nat
 | none => 0
 | some n => n
theorem originalEightBranchPreparation : preparationDepth (.integer 8)=.ok ⟨8,3,[2,4,8],normalize 1 8 (by decide)⟩ := rfl
theorem originalNontrivialGuard : preparationDepth (.integer 1)=.error "binary measurement depth requires a complete nontrivial power-of-two preparation" := rfl
theorem originalNonDyadicGuard : preparationDepth (.integer 6)=.error "binary measurement depth requires a complete nontrivial power-of-two preparation" := rfl
end SFT.Physics.QuantumSupportPreparation
