import SFT.Chemistry.EliminationAdditionResults.Same
import SFT.Chemistry.EliminationAdditionResults.Adjacent
import SFT.Chemistry.EliminationAdditionResults.Nonadjacent
import SFT.Chemistry.EliminationAdditionResults.Successor
namespace SFT.Chemistry.EliminationWitnessProofs
open SFT.Physics.CapabilityValues AdditionCarrier EliminationAdditionResults
set_option maxRecDepth 20000
set_option maxHeartbeats 0
def inverse (a : AdditionTransform.Result) : Elimination.Result :=
 ⟨a.reactionIdentity,a.terminal,a.source,a.sourceComponentCount,a.newAdjacencies,a.newBondCount,
 a.reducedMultiplicitySupports,a.reducedLayerCount,a.componentSiteClasses,a.relocatedSupports⟩
theorem same : Elimination.transform Same.expected.reactionIdentity Same.expected.terminal Same.expected.source = .ok (inverse Same.expected) := by
 unfold Elimination.transform
 rw [Same.transformResult]
 rfl
theorem adjacent : Elimination.transform Adjacent.expected.reactionIdentity Adjacent.expected.terminal Adjacent.expected.source = .ok (inverse Adjacent.expected) := by
 unfold Elimination.transform
 rw [Adjacent.transformResult]
 rfl
theorem nonadjacent : Elimination.transform Nonadjacent.expected.reactionIdentity Nonadjacent.expected.terminal Nonadjacent.expected.source = .ok (inverse Nonadjacent.expected) := by
 unfold Elimination.transform
 rw [Nonadjacent.transformResult]
 rfl
theorem extended : Elimination.transform Successor.expected.reactionIdentity Successor.expected.terminal Successor.expected.source = .ok (inverse Successor.expected) := by
 unfold Elimination.transform
 rw [Successor.transformResult]
 rfl
private theorem atomFamily : nonblank "addition-atom-occurrence" = true := rfl
private theorem supportFamily : nonblank "addition-held-support" = true := rfl
private theorem anchorLabel : nonblank "elim-nonadjacent-middle" = true := rfl
private theorem freshAtomLabel : nonblank "elim-successor-atom" = true := rfl
private theorem freshSupportLabel : nonblank "elim-successor-support" = true := rfl
private def anchor : HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-middle",atomFamily,anchorLabel⟩
private def freshAtom : HeldLabel := ⟨"addition-atom-occurrence","elim-successor-atom",atomFamily,freshAtomLabel⟩
private def freshSupport : HeldLabel := ⟨"addition-held-support","elim-successor-support",supportFamily,freshSupportLabel⟩
theorem successorPassed : Elimination.extend (inverse Nonadjacent.expected) anchor freshAtom freshSupport = .ok true := by
 unfold Elimination.extend
 conv => lhs; whnf
 erw [extended]
 rfl
theorem invalidInverseRejected : Elimination.transform Adjacent.expected.reactionIdentity Adjacent.expected.terminal Adjacent.expected.terminal = .error "two or more complete source carriers must become one product" := by
 unfold Elimination.transform AdditionTransform.transform
 change (do
  let inverse ← AdditionTransform.transform Adjacent.expected.reactionIdentity EliminationWitnessGraphs.AdjacentTerminal.sourceSame EliminationWitnessGraphs.AdjacentTerminal.sourceSame
  if !AdditionTransform.sameLabels inverse.source.atoms Adjacent.expected.terminal.atoms || !AdditionTransform.sameSupport (supports inverse.source) (supports Adjacent.expected.terminal) then throw "elimination must retain every atom and held support occurrence"
  pure (⟨Adjacent.expected.reactionIdentity,Adjacent.expected.terminal,Adjacent.expected.terminal,inverse.sourceComponentCount,inverse.newAdjacencies,inverse.newBondCount,inverse.reducedMultiplicitySupports,inverse.reducedLayerCount,inverse.componentSiteClasses,inverse.relocatedSupports⟩ : Elimination.Result)) = _
 unfold AdditionTransform.transform
 rw [EliminationWitnessGraphs.AdjacentTerminal.sourceOrderedComponents,EliminationWitnessGraphs.AdjacentTerminal.sourceSameComponents]
 rfl
theorem operationalWitnesses : Elimination.witnesses = .ok [true,true,true,true,true,true,true,true] := by
 unfold Elimination.witnesses
 rw [Same.result]
 try dsimp only
 rw [Adjacent.result]
 try dsimp only
 rw [Nonadjacent.result]
 try dsimp only
 conv => lhs; whnf
 rw [same]
 try dsimp only
 conv => lhs; whnf
 rw [adjacent]
 try dsimp only
 conv => lhs; whnf
 rw [nonadjacent]
 conv => lhs; whnf
 erw [successorPassed]
 change (pure [true,true,true,true,true,true,(match Elimination.transform Adjacent.expected.reactionIdentity Adjacent.expected.terminal Adjacent.expected.terminal with | .error _ => true | .ok _ => false),true] : Except String (List Bool)) = _
 rw [invalidInverseRejected]
 rfl
#print axioms same
#print axioms adjacent
#print axioms nonadjacent
#print axioms extended
#print axioms successorPassed
#print axioms invalidInverseRejected
#print axioms operationalWitnesses
end SFT.Chemistry.EliminationWitnessProofs
