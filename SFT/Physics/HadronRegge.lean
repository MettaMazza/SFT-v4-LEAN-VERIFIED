import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.RunningConvergence
namespace SFT.Physics.HadronRegge
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
inductive CountArgument where
 | count (value : CountInput)
 | nonInteger
def positiveCount (message : String) : CountArgument → Except String Nat
 | .count (.integer (.ofNat (n+1))) => .ok (n+1)
 | .count (.integer (.ofNat 0)) => .error message
 | .count (.integer (.negSucc _)) => .error message
 | .count (.boolean _) => .error message
 | .nonInteger => .error message
-- Lexicographic product order matches itertools.product.
def orderedWords (labels : List Nat) : Nat → List (List Nat)
 | 0 => [[]]
 | n+1 => labels.flatMap (fun label => (orderedWords labels n).map (List.cons label))
def lightFlavourWords (width : CountArgument) : Except String (List (List Nat)) := do
 let width ← positiveCount "word width must be a positive whole" width
 let colour ← FoldFirstReturn.generatorPeriod
 pure (orderedWords ((List.range colour).map (fun n => n+1)) width)
structure MesonPartition where
 orderedSupport : Nat
 predecessorMultiplet : Nat
 invariantSinglet : Nat
def mesonMultipletPartition : Except String MesonPartition := do
 let flavours ← FoldFirstReturn.generatorPeriod
 let binary ← AlphaCovers.binaryCount
 let total := (← lightFlavourWords (.count (.integer (.ofNat binary)))).length
 let octet ← positivePredecessor (.integer (.ofNat total))
 let expected ← AlphaCovers.positivePower (.integer (.ofNat flavours)) (.integer (.ofNat binary))
 if total != expected || octet+1 != total then throw "complete meson flavour support did not close"
 pure ⟨total,octet,1⟩
-- Retaining a label leaves that label and its successors available at the next place.
def symmetricWords (labels : List Nat) : Nat → List (List Nat)
 | 0 => [[]]
 | n+1 => labels.zipIdx |>.flatMap (fun (label,i) => (symmetricWords (labels.drop i) n).map (List.cons label))
def symmetricBaryonWords : Except String (List (List Nat)) := do
 let colour ← FoldFirstReturn.generatorPeriod
 pure (symmetricWords ((List.range colour).map (fun n => n+1)) colour)
structure BaryonPartition where
 orderedSupport : Nat
 symmetric : Nat
 mixedFirstHand : Nat
 mixedSecondHand : Nat
 antisymmetric : Nat
def baryonMultipletPartition : Except String BaryonPartition := do
 let colour ← FoldFirstReturn.generatorPeriod
 let total := (← lightFlavourWords (.count (.integer (.ofNat colour)))).length
 let symmetric := (← symmetricBaryonWords).length
 let mixed := total-symmetric-1
 let hands ← AlphaCovers.binaryCount
 if mixed<1 || mixed%hands != 0 then throw "mixed exchange support did not split into complete Fold hands"
 let hand := mixed/hands
 if symmetric+hand+hand+1 != total then throw "complete baryon symmetry support did not close"
 pure ⟨total,symmetric,hand,hand,1⟩
def normalizedReggeSquaredSupport (rank : CountArgument) : Except String Rat := do
 let rank ← positiveCount "spin rank must be a positive whole" rank
 if rank==1 then pure (wholeRatio 1) else
  let previous ← positivePredecessor (.integer (.ofNat rank))
  pure (add (wholeRatio 1) (wholeRatio previous))
def positiveCarrier (message : String) : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error message
 | .fraction value => if !zero.blt value then .error message else .ok value
def affineReggeCarrier (anchor tube : FoldFirstReturn.Input) (rank : CountArgument) : Except String Rat := do
 let anchor ← positiveCarrier "anchor carrier must be exact and positive" anchor
 let tube ← positiveCarrier "tube-step carrier must be exact and positive" tube
 let rank ← positiveCount "spin rank must be a positive whole" rank
 if rank==1 then pure anchor else
  let previous ← positivePredecessor (.integer (.ofNat rank))
  pure (add anchor (multiply (wholeRatio previous) tube))
def reggeStep (anchor tube : FoldFirstReturn.Input) (rank : CountArgument) : Except String Rat := do
 let current ← affineReggeCarrier anchor tube rank
 let n ← positiveCount "spin rank must be a positive whole" rank
 let successor ← affineReggeCarrier anchor tube (.count (.integer (.ofNat (n+1))))
 let step := subtract successor current
 if !zero.blt step then throw "Regge successor failed positivity"
 pure step
def trajectoryMultiplicity (depth : CountArgument) : Except String Nat := do
 let depth ← positiveCount "trajectory depth must be a positive whole" depth
 let binary ← AlphaCovers.binaryCount
 AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat depth))
theorem mesonPartition : mesonMultipletPartition=.ok ⟨9,8,1⟩ := rfl
theorem baryonPartition : baryonMultipletPartition=.ok ⟨27,10,8,8,1⟩ := rfl
theorem allSymmetricWords : symmetricBaryonWords=.ok [[1,1,1],[1,1,2],[1,1,3],[1,2,2],[1,2,3],[1,3,3],[2,2,2],[2,2,3],[2,3,3],[3,3,3]] := rfl
end SFT.Physics.HadronRegge
