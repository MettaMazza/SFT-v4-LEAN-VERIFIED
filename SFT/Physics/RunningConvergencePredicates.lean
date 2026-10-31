import SFT.Physics.RunningConvergenceGrammarBase
namespace SFT.Physics.RunningConvergenceGrammar
open RunningConvergence
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

theorem sectorDomainComputed (x : SectorDomain) : sectorDomainIsForced x = (match x with | .c0 => true | .c1 => false | .c2 => false) := by
 cases x
 · unfold sectorDomainIsForced
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold sectorDomainIsForced
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold sectorDomainIsForced
   rw [PrimeSectorLadder.completeLadder]
   rfl

theorem scaleGenerationComputed (x : ScaleGeneration) : scaleGenerationIsForced x = (match x with | .c0 => true | .c1 => false | .c2 => false) := by
 cases x
 · unfold scaleGenerationIsForced
   rfl
 · unfold scaleGenerationIsForced
   rfl
 · unfold scaleGenerationIsForced
   rfl

theorem couplingFormComputed (x : CouplingForm) : couplingFormIsForced x = (match x with | .c0 => true | .c1 => false | .c2 => false) := by
 cases x
 · unfold couplingFormIsForced
   unfold couplingObservation generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold couplingFormIsForced
   unfold couplingObservation generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold couplingFormIsForced
   unfold couplingObservation generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl

theorem successorLawComputed (x : SuccessorLaw) : successorLawIsForced x = (match x with | .c0 => true | .c1 => false | .c2 => false) := by
 cases x
 · unfold successorLawIsForced
   unfold successorObservation
   rw [PrimeSectorLadder.completeLadder]
   unfold couplingSuccessorTake generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold successorLawIsForced
   rfl
 · unfold successorLawIsForced
   rfl

theorem pairGapLawComputed (x : PairGapLaw) : pairGapLawIsForced x = (match x with | .c0 => true | .c1 => false | .c2 => false) := by
 cases x
 · unfold pairGapLawIsForced
   unfold gapObservation generatorPairGap SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold pairGapLawIsForced
   unfold gapObservation generatorPairGap SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold pairGapLawIsForced
   unfold gapObservation generatorPairGap SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl

theorem convergenceLawComputed (x : ConvergenceLaw) : convergenceLawIsForced x = (match x with | .c0 => true | .c1 => false | .c2 => false) := by
 cases x
 · unfold convergenceLawIsForced
   unfold convergenceObservation formalCertificate orderedSectorPairs
   rw [PrimeSectorLadder.completeLadder]
   unfold commonScaleVector couplingShortfall couplingSuccessorTake pairGapSuccessorTake convergenceWitness generatorPairGap generatorIndexedCoupling SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount
   rw [PrimeSectorLadder.completeLadder]
   rfl
 · unfold convergenceLawIsForced
   rfl
 · unfold convergenceLawIsForced
   rfl

theorem physicalTranslationComputed (x : PhysicalTranslation) : physicalTranslationIsForced x = (match x with | .c0 => true | .c1 => false | .c2 => false) := by
 cases x
 · unfold physicalTranslationIsForced
   rfl
 · unfold physicalTranslationIsForced
   rfl
 · unfold physicalTranslationIsForced
   rfl

theorem targetBoundaryComputed (x : TargetBoundary) : targetBoundaryIsForced x = (match x with | .c0 => true | .c1 => false) := by
 cases x
 · unfold targetBoundaryIsForced
   rfl
 · unfold targetBoundaryIsForced
   rfl

theorem extensionComputed (x : Extension) : extensionIsForced x = (match x with | .c0 => true | .c1 => false) := by
 cases x
 · unfold extensionIsForced
   rfl
 · unfold extensionIsForced
   rfl

end SFT.Physics.RunningConvergenceGrammar
