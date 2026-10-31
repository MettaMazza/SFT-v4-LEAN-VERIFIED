import SFT.Physics.RunningConvergencePredicates
namespace SFT.Physics.RunningConvergenceGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 12000000
theorem uniqueCensus10 (successorLaw : SuccessorLaw) (pairGapLaw : PairGapLaw) (convergenceLaw : ConvergenceLaw) (physicalTranslation : PhysicalTranslation) (targetBoundary : TargetBoundary) (extension : Extension) : survives ⟨.c1,.c0,.c1,successorLaw,pairGapLaw,convergenceLaw,physicalTranslation,targetBoundary,extension⟩ = true ↔ (⟨.c1,.c0,.c1,successorLaw,pairGapLaw,convergenceLaw,physicalTranslation,targetBoundary,extension⟩ : Candidate) = survivor := by
 unfold survives candidateFacts
 simp only [sectorDomainComputed,scaleGenerationComputed,couplingFormComputed,successorLawComputed,pairGapLawComputed,convergenceLawComputed,physicalTranslationComputed,targetBoundaryComputed,extensionComputed]
 cases successorLaw <;> cases pairGapLaw <;> cases convergenceLaw <;> cases physicalTranslation <;> cases targetBoundary <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.RunningConvergenceGrammar
