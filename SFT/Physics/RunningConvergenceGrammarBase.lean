import SFT.Physics.RunningConvergence
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.RunningConvergenceGrammar
open SFT.Foundation SFT.Physics.RunningConvergence
set_option maxRecDepth 20000

inductive SectorDomain where
 | c0 | c1 | c2

def sectorDomainName : SectorDomain → String
 | .c0 => "complete-prime-sectors-through-seven"
 | .c1 => "selected-familiar-sectors-only"
 | .c2 => "free-sector-appended-beyond-ceiling"

inductive ScaleGeneration where
 | c0 | c1 | c2

def scaleGenerationName : ScaleGeneration → String
 | .c0 => "One-base-binary-depth-successor"
 | .c1 => "imported-linear-scale-grid"
 | .c2 => "target-assigned-continuous-scale"

inductive CouplingForm where
 | c0 | c1 | c2

def couplingFormName : CouplingForm → String
 | .c0 => "holding-share-of-sector-plus-support"
 | .c1 => "fixed-bare-sector-share"
 | .c2 => "target-assigned-running-value"

inductive SuccessorLaw where
 | c0 | c1 | c2

def successorLawName : SuccessorLaw → String
 | .c0 => "binary-support-successor-raises-holding-share"
 | .c1 => "binary-support-successor-lowers-holding-share"
 | .c2 => "support-independent-holding-share"

inductive PairGapLaw where
 | c0 | c1 | c2

def pairGapLawName : PairGapLaw → String
 | .c0 => "exact-generator-gap-over-paired-sources"
 | .c1 => "constant-sector-gap"
 | .c2 => "target-assigned-gap"

inductive ConvergenceLaw where
 | c0 | c1 | c2

def convergenceLawName : ConvergenceLaw → String
 | .c0 => "finite-positive-epsilon-witness-for-every-pair"
 | .c1 => "completed-infinity-as-proof-value"
 | .c2 => "visual-approach-without-certificate"

inductive PhysicalTranslation where
 | c0 | c1 | c2

def physicalTranslationName : PhysicalTranslation → String
 | .c0 => "carrier-specific-self-source-range-and-screening-exposure"
 | .c1 => "one-imported-energy-sign-for-every-carrier"
 | .c2 => "measurement-selected-coordinate-direction"

inductive TargetBoundary where
 | c0 | c1

def targetBoundaryName : TargetBoundary → String
 | .c0 => "sealed-before-release"
 | .c1 => "readable-before-seal"

inductive Extension where
 | c0 | c1

def extensionName : Extension → String
 | .c0 => "empty-extension"
 | .c1 => "free-running-correction"

structure Candidate where
 sectorDomain : SectorDomain
 scaleGeneration : ScaleGeneration
 couplingForm : CouplingForm
 successorLaw : SuccessorLaw
 pairGapLaw : PairGapLaw
 convergenceLaw : ConvergenceLaw
 physicalTranslation : PhysicalTranslation
 targetBoundary : TargetBoundary
 extension : Extension

def sourceFields (c : Candidate) : List String := [sectorDomainName c.sectorDomain,scaleGenerationName c.scaleGeneration,couplingFormName c.couplingForm,successorLawName c.successorLaw,pairGapLawName c.pairGapLaw,convergenceLawName c.convergenceLaw,physicalTranslationName c.physicalTranslation,targetBoundaryName c.targetBoundary,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "sectors=" (sectorDomainName c.sectorDomain),SFT.Host.Text.append "scale=" (scaleGenerationName c.scaleGeneration),SFT.Host.Text.append "coupling=" (couplingFormName c.couplingForm),SFT.Host.Text.append "successor=" (successorLawName c.successorLaw),SFT.Host.Text.append "gap=" (pairGapLawName c.pairGapLaw),SFT.Host.Text.append "convergence=" (convergenceLawName c.convergenceLaw),SFT.Host.Text.append "translation=" (physicalTranslationName c.physicalTranslation),SFT.Host.Text.append "target=" (targetBoundaryName c.targetBoundary),SFT.Host.Text.append "extension=" (extensionName c.extension)]

def candidates : List Candidate :=
 ([SectorDomain.c0,SectorDomain.c1,SectorDomain.c2]).flatMap fun sectorDomain =>
 ([ScaleGeneration.c0,ScaleGeneration.c1,ScaleGeneration.c2]).flatMap fun scaleGeneration =>
 ([CouplingForm.c0,CouplingForm.c1,CouplingForm.c2]).flatMap fun couplingForm =>
 ([SuccessorLaw.c0,SuccessorLaw.c1,SuccessorLaw.c2]).flatMap fun successorLaw =>
 ([PairGapLaw.c0,PairGapLaw.c1,PairGapLaw.c2]).flatMap fun pairGapLaw =>
 ([ConvergenceLaw.c0,ConvergenceLaw.c1,ConvergenceLaw.c2]).flatMap fun convergenceLaw =>
 ([PhysicalTranslation.c0,PhysicalTranslation.c1,PhysicalTranslation.c2]).flatMap fun physicalTranslation =>
 ([TargetBoundary.c0,TargetBoundary.c1]).flatMap fun targetBoundary =>
 ([Extension.c0,Extension.c1]).map fun extension =>
 ⟨sectorDomain,scaleGeneration,couplingForm,successorLaw,pairGapLaw,convergenceLaw,physicalTranslation,targetBoundary,extension⟩

def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩

def generationRule : String := "Generate the complete product of every closed or selected sector domain, every binary, linear or target-assigned scale carrier, every holding-share, fixed or target-assigned coupling form, every successor direction, every exact, constant or target-assigned pair-gap law, every constructive, completed-infinity or visual convergence form, every carrier-specific, universal-sign or measurement-selected physical translation, both target-custody states and both extension states."
def grammarBoundary : String := "The complete independently forced prime-sector ladder two, three, five and seven; every generated finite positive depth level with One base and binary successor; exact positive rational holding shares, shortfalls, successor takes and ordered pair gaps; every finite positive tolerance denominator; the already forced self-source-range and screening-exposure translation classes; sealed or exposed targets; and empty or free extension. No completed infinity, continuum scale or numerical null state is admitted."

set_option maxRecDepth 100000 in
set_option maxHeartbeats 4000000 in
theorem generatedCardinality : candidates.length = 8748 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
 cases c with
 | mk sectorDomain scaleGeneration couplingForm successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension =>
  have hsectorDomain : sectorDomain ∈ [SectorDomain.c0,SectorDomain.c1,SectorDomain.c2] := by
   cases sectorDomain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have hscaleGeneration : scaleGeneration ∈ [ScaleGeneration.c0,ScaleGeneration.c1,ScaleGeneration.c2] := by
   cases scaleGeneration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have hcouplingForm : couplingForm ∈ [CouplingForm.c0,CouplingForm.c1,CouplingForm.c2] := by
   cases couplingForm <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have hsuccessorLaw : successorLaw ∈ [SuccessorLaw.c0,SuccessorLaw.c1,SuccessorLaw.c2] := by
   cases successorLaw <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have hpairGapLaw : pairGapLaw ∈ [PairGapLaw.c0,PairGapLaw.c1,PairGapLaw.c2] := by
   cases pairGapLaw <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have hconvergenceLaw : convergenceLaw ∈ [ConvergenceLaw.c0,ConvergenceLaw.c1,ConvergenceLaw.c2] := by
   cases convergenceLaw <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have hphysicalTranslation : physicalTranslation ∈ [PhysicalTranslation.c0,PhysicalTranslation.c1,PhysicalTranslation.c2] := by
   cases physicalTranslation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have htargetBoundary : targetBoundary ∈ [TargetBoundary.c0,TargetBoundary.c1] := by
   cases targetBoundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  have hextension : extension ∈ [Extension.c0,Extension.c1] := by
   cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
  unfold candidates
  apply CommonRefinement.memFlatMap _ _ sectorDomain _ hsectorDomain
  apply CommonRefinement.memFlatMap _ _ scaleGeneration _ hscaleGeneration
  apply CommonRefinement.memFlatMap _ _ couplingForm _ hcouplingForm
  apply CommonRefinement.memFlatMap _ _ successorLaw _ hsuccessorLaw
  apply CommonRefinement.memFlatMap _ _ pairGapLaw _ hpairGapLaw
  apply CommonRefinement.memFlatMap _ _ convergenceLaw _ hconvergenceLaw
  apply CommonRefinement.memFlatMap _ _ physicalTranslation _ hphysicalTranslation
  apply CommonRefinement.memFlatMap _ _ targetBoundary _ htargetBoundary
  exact Count.TraceDerivation.memMap _ extension _ hextension

def sameRat (x y : Rat) : Bool := (@decide (x.num=y.num) (Int.decEq x.num y.num)) && x.den==y.den

def supportObservation : Except String (List Nat) := ([1,2,3,4] : List Nat).mapM (fun n => generatedScaleSupport (.integer (.ofNat n)))
def couplingObservation : Except String Rat := generatorIndexedCoupling (.integer 2) (.integer 3)
def gapObservation : Except String Rat := generatorPairGap (.integer 2) (.integer 3) (.integer 3)
def successorObservation : Except String Bool := do
 let sectors ← PrimeSectorLadder.primeSectorLadder
 let takes ← sectors.flatMapM fun p => ([1,2,3,4] : List Nat).mapM fun n => couplingSuccessorTake (.integer (.ofNat p)) (.integer (.ofNat n))
 pure (takes.all (fun q => @decide (1 ≤ q.num) (Int.decLe 1 q.num)))
def convergenceObservation : Except String Bool := do
 let c ← formalCertificate
 pure (c.convergenceWitnesses.all (fun w => w.gapBelowTolerance && w.binarySupportReachesRequiredBound))
def physicalObservation : Bool :=
 carrierTranslationRecord.singleCommonFoldAxis && !carrierTranslationRecord.universalImportedEnergySignRequired && !carrierTranslationRecord.measurementSelectsOrientation

def sectorDomainIsForced (choice : SectorDomain) : Bool :=
 match PrimeSectorLadder.primeSectorLadder with
 | .error _ => false
 | .ok observed => observed == (match choice with | .c0 => [2,3,5,7] | .c1 => [2,3] | .c2 => [2,3,5,7,11])
def scaleGenerationIsForced (choice : ScaleGeneration) : Bool :=
 match supportObservation with
 | .error _ => false
 | .ok observed => observed == (match choice with | .c0 => [1,2,4,8] | .c1 => [1,2,3,4] | .c2 => [1,1,1,1])
def couplingFormIsForced (choice : CouplingForm) : Bool :=
 match couplingObservation with
 | .error _ => false
 | .ok observed => sameRat observed (match choice with
   | .c0 => LeptonIntervals.normalize 5 6 (by decide)
   | .c1 => LeptonIntervals.normalize 1 2 (by decide)
   | .c2 => LeptonIntervals.normalize 127 128 (by decide))
def successorLawIsForced : SuccessorLaw → Bool
 | .c0 => match successorObservation with | .ok b => b | .error _ => false
 | .c1 => false
 | .c2 => false
def pairGapLawIsForced (choice : PairGapLaw) : Bool :=
 match gapObservation with
 | .error _ => false
 | .ok observed => sameRat observed (match choice with
   | .c0 => LeptonIntervals.normalize 1 42 (by decide)
   | .c1 => LeptonIntervals.normalize 1 6 (by decide)
   | .c2 => LeptonIntervals.normalize 1 128 (by decide))
def convergenceLawIsForced : ConvergenceLaw → Bool
 | .c0 => match convergenceObservation with | .ok b => b | .error _ => false
 | .c1 => false
 | .c2 => false
def physicalTranslationIsForced : PhysicalTranslation → Bool
 | .c0 => physicalObservation
 | .c1 => false
 | .c2 => false
def targetBoundaryIsForced : TargetBoundary → Bool
 | .c0 => true
 | .c1 => false
def extensionIsForced : Extension → Bool
 | .c0 => true
 | .c1 => false

def candidateFacts (c : Candidate) : List (String × Bool) := [("sector_domain",sectorDomainIsForced c.sectorDomain),("scale_generation",scaleGenerationIsForced c.scaleGeneration),("coupling_form",couplingFormIsForced c.couplingForm),("successor_law",successorLawIsForced c.successorLaw),("pair_gap_law",pairGapLawIsForced c.pairGapLaw),("convergence_law",convergenceLawIsForced c.convergenceLaw),("physical_translation",physicalTranslationIsForced c.physicalTranslation),("target_boundary",targetBoundaryIsForced c.targetBoundary),("extension",extensionIsForced c.extension)]
def survives (c : Candidate) : Bool := (candidateFacts c).all (fun kv => kv.2)
def decisionReason (c : Candidate) : String :=
 let failures := ((candidateFacts c).filter (fun kv => !kv.2)).map Prod.fst
 if failures.isEmpty then "The complete prime-sector ladder shares the One-base binary support successor. Its one-predecessor shortfall forces (p+R-1)/(p+R), makes every finite sector share rise, makes every ordered pair gap shrink with the exact paired-source denominator, and supplies a finite positive witness below every generated tolerance without a completed infinity or measurement-selected correction."
 else SFT.Host.Text.append "Rejected by computed Fold predicates: " (SFT.Host.Text.append (SFT.Host.Text.intercalate ", " failures) ".")

end SFT.Physics.RunningConvergenceGrammar
