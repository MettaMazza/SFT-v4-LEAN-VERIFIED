import SFT.Computation.NativeClosingDomain
namespace SFT.Computation.NativeCircuit
open SFT.InformationScience.QuantitySupport SFT.InformationScience.CompressionSupport
open NativeClosing SFT.Foundation.CommonRefinement
open SFT.Mathematics.DiscreteObjects

abbrev Edge := Word × Word
def edge (word : Word) : Edge := (word,if word.length>1 then word.tail else SFT.InformationScience.QuantitySupport.emptyOne)
def forcedEdges (depth : Nat) : List Edge := (wordsThroughDepth depth).map edge

def layeredCount : Nat → Nat
 | 0 => 0
 | n+1 => layeredCount n+2^(n+1)

def circuitResources (depth : Nat) : Nat × Nat × Nat :=
 (depth,(words labels depth).length,(forcedEdges depth).length)

theorem layerWidth (depth : Nat) : (words labels depth).length=2^depth := wordsCount labels depth

theorem completeLayerCount (depth : Nat) : (wordsThroughDepth depth).length=layeredCount depth := by
 induction depth with
 | zero => rfl
 | succ n ih =>
   change (wordsThroughDepth n ++ words labels (n+1)).length=layeredCount n+2^(n+1)
   rw [appendLength,ih,layerWidth]

theorem exactResources (depth : Nat) : circuitResources depth=(depth,2^depth,layeredCount depth) := by
 unfold circuitResources forcedEdges
 rw [layerWidth,mapLength,completeLayerCount]

theorem completePopulationDistinct (depth : Nat) : distinct (wordsThroughDepth depth)=true := by
 induction depth with
 | zero => rfl
 | succ n ih =>
   apply appendDistinct
   · exact ih
   · exact wordsDistinct labels rfl (n+1)
   · intro word earlier last
     obtain ⟨width,positive,bound,held⟩ := (shortMembership labels n word).mp earlier
     have firstLength := ((wordCharacterization _ _ _).mp held).1
     have lastLength := ((wordCharacterization _ _ _).mp last).1
     have eq := firstLength.symm.trans lastLength
     rw [eq] at bound
     exact Nat.not_succ_le_self n bound

theorem layeredSourceLowerBound (depth : Nat) (sources : List Word)
 (complete : ∀ word,word∈wordsThroughDepth depth → word∈sources) :
 layeredCount depth≤sources.length := by
 rw [← completeLayerCount]
 exact wordSubsetLength _ _ (completePopulationDistinct depth) complete

theorem inputWidthLowerBound (depth : Nat) (sources : List Word)
 (complete : ∀ word,word∈words labels depth → word∈sources) : 2^depth≤sources.length := by
 rw [← layerWidth]
 exact wordSubsetLength _ _ (wordsDistinct labels rfl depth) complete

theorem edgeSource (word : Word) : (edge word).1=word := rfl

theorem edgesDistinct (depth : Nat) : distinct (forcedEdges depth)=true :=
 SFT.Mathematics.DiscreteObjects.mapDistinct edge
 (fun a b eq => congrArg Prod.fst eq) _ (completePopulationDistinct depth)
end SFT.Computation.NativeCircuit
