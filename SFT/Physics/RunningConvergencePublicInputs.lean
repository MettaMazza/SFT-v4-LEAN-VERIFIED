import SFT.Physics.RunningConvergencePredicates
namespace SFT.Physics.RunningConvergencePublicInputs
open RunningConvergenceGrammar

def sectorDomainIsForced (value : String) : Except String Bool :=
 match ([SectorDomain.c0,SectorDomain.c1,SectorDomain.c2]).find? (fun c => SFT.Host.Text.equal (sectorDomainName c) value) with
 | some c => .ok (RunningConvergenceGrammar.sectorDomainIsForced c)
 | none => .error "candidate names an ungenerated sector domain"

theorem sectorDomainUnknownRejected : sectorDomainIsForced "not-a-generated-choice" = .error "candidate names an ungenerated sector domain" := rfl
theorem sectorDomainGeneratedPreserved (c : SectorDomain) : sectorDomainIsForced (sectorDomainName c) = .ok (RunningConvergenceGrammar.sectorDomainIsForced c) := by
 cases c <;> rfl

def scaleGenerationIsForced (value : String) : Except String Bool :=
 match ([ScaleGeneration.c0,ScaleGeneration.c1,ScaleGeneration.c2]).find? (fun c => SFT.Host.Text.equal (scaleGenerationName c) value) with
 | some c => .ok (RunningConvergenceGrammar.scaleGenerationIsForced c)
 | none => .error "candidate names an ungenerated scale law"

theorem scaleGenerationUnknownRejected : scaleGenerationIsForced "not-a-generated-choice" = .error "candidate names an ungenerated scale law" := rfl
theorem scaleGenerationGeneratedPreserved (c : ScaleGeneration) : scaleGenerationIsForced (scaleGenerationName c) = .ok (RunningConvergenceGrammar.scaleGenerationIsForced c) := by
 cases c <;> rfl

def couplingFormIsForced (value : String) : Except String Bool :=
 match ([CouplingForm.c0,CouplingForm.c1,CouplingForm.c2]).find? (fun c => SFT.Host.Text.equal (couplingFormName c) value) with
 | some c => .ok (RunningConvergenceGrammar.couplingFormIsForced c)
 | none => .error "candidate names an ungenerated coupling form"

theorem couplingFormUnknownRejected : couplingFormIsForced "not-a-generated-choice" = .error "candidate names an ungenerated coupling form" := rfl
theorem couplingFormGeneratedPreserved (c : CouplingForm) : couplingFormIsForced (couplingFormName c) = .ok (RunningConvergenceGrammar.couplingFormIsForced c) := by
 cases c <;> rfl

def successorLawIsForced (value : String) : Except String Bool :=
 match ([SuccessorLaw.c0,SuccessorLaw.c1,SuccessorLaw.c2]).find? (fun c => SFT.Host.Text.equal (successorLawName c) value) with
 | some c => .ok (RunningConvergenceGrammar.successorLawIsForced c)
 | none => .error "candidate names an ungenerated successor law"

theorem successorLawUnknownRejected : successorLawIsForced "not-a-generated-choice" = .error "candidate names an ungenerated successor law" := rfl
theorem successorLawGeneratedPreserved (c : SuccessorLaw) : successorLawIsForced (successorLawName c) = .ok (RunningConvergenceGrammar.successorLawIsForced c) := by
 cases c <;> rfl

def pairGapLawIsForced (value : String) : Except String Bool :=
 match ([PairGapLaw.c0,PairGapLaw.c1,PairGapLaw.c2]).find? (fun c => SFT.Host.Text.equal (pairGapLawName c) value) with
 | some c => .ok (RunningConvergenceGrammar.pairGapLawIsForced c)
 | none => .error "candidate names an ungenerated pair-gap law"

theorem pairGapLawUnknownRejected : pairGapLawIsForced "not-a-generated-choice" = .error "candidate names an ungenerated pair-gap law" := rfl
theorem pairGapLawGeneratedPreserved (c : PairGapLaw) : pairGapLawIsForced (pairGapLawName c) = .ok (RunningConvergenceGrammar.pairGapLawIsForced c) := by
 cases c <;> rfl

def convergenceLawIsForced (value : String) : Except String Bool :=
 match ([ConvergenceLaw.c0,ConvergenceLaw.c1,ConvergenceLaw.c2]).find? (fun c => SFT.Host.Text.equal (convergenceLawName c) value) with
 | some c => .ok (RunningConvergenceGrammar.convergenceLawIsForced c)
 | none => .error "candidate names an ungenerated convergence law"

theorem convergenceLawUnknownRejected : convergenceLawIsForced "not-a-generated-choice" = .error "candidate names an ungenerated convergence law" := rfl
theorem convergenceLawGeneratedPreserved (c : ConvergenceLaw) : convergenceLawIsForced (convergenceLawName c) = .ok (RunningConvergenceGrammar.convergenceLawIsForced c) := by
 cases c <;> rfl

def physicalTranslationIsForced (value : String) : Except String Bool :=
 match ([PhysicalTranslation.c0,PhysicalTranslation.c1,PhysicalTranslation.c2]).find? (fun c => SFT.Host.Text.equal (physicalTranslationName c) value) with
 | some c => .ok (RunningConvergenceGrammar.physicalTranslationIsForced c)
 | none => .error "candidate names an ungenerated physical translation"

theorem physicalTranslationUnknownRejected : physicalTranslationIsForced "not-a-generated-choice" = .error "candidate names an ungenerated physical translation" := rfl
theorem physicalTranslationGeneratedPreserved (c : PhysicalTranslation) : physicalTranslationIsForced (physicalTranslationName c) = .ok (RunningConvergenceGrammar.physicalTranslationIsForced c) := by
 cases c <;> rfl

def targetBoundaryIsForced (value : String) : Except String Bool :=
 match ([TargetBoundary.c0,TargetBoundary.c1]).find? (fun c => SFT.Host.Text.equal (targetBoundaryName c) value) with
 | some c => .ok (RunningConvergenceGrammar.targetBoundaryIsForced c)
 | none => .error "candidate names an ungenerated target boundary"

theorem targetBoundaryUnknownRejected : targetBoundaryIsForced "not-a-generated-choice" = .error "candidate names an ungenerated target boundary" := rfl
theorem targetBoundaryGeneratedPreserved (c : TargetBoundary) : targetBoundaryIsForced (targetBoundaryName c) = .ok (RunningConvergenceGrammar.targetBoundaryIsForced c) := by
 cases c <;> rfl

def extensionIsForced (value : String) : Except String Bool :=
 match ([Extension.c0,Extension.c1]).find? (fun c => SFT.Host.Text.equal (extensionName c) value) with
 | some c => .ok (RunningConvergenceGrammar.extensionIsForced c)
 | none => .error "candidate names an ungenerated extension"

theorem extensionUnknownRejected : extensionIsForced "not-a-generated-choice" = .error "candidate names an ungenerated extension" := rfl
theorem extensionGeneratedPreserved (c : Extension) : extensionIsForced (extensionName c) = .ok (RunningConvergenceGrammar.extensionIsForced c) := by
 cases c <;> rfl
end SFT.Physics.RunningConvergencePublicInputs
