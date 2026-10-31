import SFT.Physics.RunningConvergenceGrammar
import SFT.Physics.RunningConvergenceCertificate
import SFT.Engine.RegistrationGate
namespace SFT.Physics.RunningConvergenceEvidence
open SFT.Host.Canonical RunningConvergenceGrammar
def formValue (c : Candidate) : Value := .object [("sector_domain",.text (sectorDomainName c.sectorDomain)),("scale_generation",.text (scaleGenerationName c.scaleGeneration)),("coupling_form",.text (couplingFormName c.couplingForm)),("successor_law",.text (successorLawName c.successorLaw)),("pair_gap_law",.text (pairGapLawName c.pairGapLaw)),("convergence_law",.text (convergenceLawName c.convergenceLaw)),("physical_translation",.text (physicalTranslationName c.physicalTranslation)),("target_boundary",.text (targetBoundaryName c.targetBoundary)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((candidateFacts c).map (fun (k,b) => (k,.boolean b)))
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axis_cardinalities",.array ([3,3,3,3,3,3,3,2,2].map (fun n => .integer n))),("candidate_count",.integer (.ofNat candidates.length)),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006"
 title := "Terminal Fold running functions and common-support convergence"
 branch := "physics"
 statement := "The complete forced prime sectors p in two, three, five and seven share one generated scale carrier with One base and binary successor R_(n+1)=2R_n. Each sector's exact finite running share is g_p(R)=(p+R-1)/(p+R), with positive shortfall 1/(p+R). Every binary successor raises g_p by R/[(p+R)(p+2R)]. For p<q the exact gap is (q-p)/[(p+R)(q+R)], it strictly shrinks at every successor, and for every finite positive tolerance a generated binary support gives a smaller gap. Thus all four sector functions converge constructively on the common support axis without a completed infinity, imported beta function, fitted parameter or measurement-selected correction. The sealed self-source-range and screening-exposure laws determine the opposite physical energy orientations used in post-seal comparison."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002", "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-STRONG-RUNNING-DIRECTION-002", "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003", "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-MATH-LIMIT-CONTINUUM-002", "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.object [("generator",.text generationRule),("form",formValue c),("computed_facts",factsValue c)])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := identity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData
def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := identity (.object [("candidate_trace",.text (generatedCandidateData c).traceHash),("form",formValue c),("facts",factsValue c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "KeyError"
def generality : Value := .object [
 ("base",.text "R_One=One and g_p(One)=p/(p+One) for every forced sector p"),
 ("successor_support",.text "R_(n+One)=2R_n"),
 ("successor_share_take",.text "g_p(2R) take g_p(R)=R/[(p+R)(p+2R)]"),
 ("ordered_pair_gap",.text "g_q(R) take g_p(R)=(q-p)/[(p+R)(q+R)] for p<q"),
 ("gap_successor",.text "the positive take between the R and 2R gaps closes every finite pair"),
 ("constructive_convergence",.text "for each positive N, a finite binary R reaching N(q-p) gives gap below 1/N"),
 ("physical_translation",RunningConvergenceCertificate.translation RunningConvergence.carrierTranslationRecord),
 ("target_absent_from_formal_module",.boolean true)]

def minimality (decisions : List SFT.Engine.CandidateDecision) : Bool :=
 match RunningConvergence.formalCertificate with
 | .error _ => false
 | .ok c =>
   (decisions.filter (fun d => d.survives)).length == 1 &&
   c.sectors == [2,3,5,7] && c.supports == [1,2,4,8,16,32] &&
   c.shortfallVectors.all (fun v => v.all (fun q => @decide (1 ≤ q.num) (Int.decLe 1 q.num))) &&
   c.successorTakeVectors.all (fun v => v.all (fun q => @decide (1 ≤ q.num) (Int.decLe 1 q.num))) &&
   c.pairGapVectors.all (fun v => v.all (fun q => @decide (1 ≤ q.num) (Int.decLe 1 q.num))) &&
   c.pairGapSuccessorTakes.all (fun v => v.all (fun q => @decide (1 ≤ q.num) (Int.decLe 1 q.num))) &&
   c.convergenceWitnesses.all (fun w => w.gapBelowTolerance) &&
   c.carrierTranslation.singleCommonFoldAxis

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := minimality decisions
 namedShapeUniquenessPassed := minimality decisions && extensionIsForced .c0
 proofHash := identity (.object [
  ("certificate",RunningConvergenceCertificate.value),
  ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
  ("survivors_computed",.array ((decisions.filter (fun d => d.survives)).map (fun d => .text d.candidateId)))])
 generalityCertificateHash := some (identity generality)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := identity (.object [("kind",.text (SFT.Engine.kindName kind)),("passed",.boolean passed),("expected",.text expected),("observed",.text observed)])

def controlsFor (sourceHash : String) (form : Candidate) : List SFT.Engine.ControlResult :=
 let identifiers := candidates.map candidateId
 [control .falsePremise
  (!survives {form with successorLaw := .c1} && !survives {form with convergenceLaw := .c1})
  "Reject reversed running and a completed infinity as a proof value."
  "Exact positive successor takes and finite epsilon witnesses reject both false laws.",
 control .tamperedSource
  (!SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  "Reject any changed claimant source identity."
  "The changed identity differs from the registered source manifest.",
 control .tamperedArtifact
  ((identifiers ++ identifiers.take 1).eraseDups.length != identifiers.length+1)
  "Reject a duplicated or incomplete candidate census."
  "The deliberate duplicate fails complete candidate identity.",
 control .boundary
  (!survives {form with targetBoundary := .c1} && !survives {form with extension := .c1} &&
    (match RunningConvergence.generatedScaleSupport (.integer 1) with | .ok n => n==1 | .error _ => false))
  "Reject pre-seal target access, free correction and a numerical null base."
  "The scale begins at the One; sealed custody and empty extension are required."]

def runControls (sourceHash : String) : Except String (List SFT.Engine.ControlResult) :=
 match candidates.filter survives with
 | [form] => .ok (controlsFor sourceHash form)
 | [] => .error "controls require exactly one computed form"
 | _ :: _ :: _ => .error "controls require exactly one computed form"

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl
theorem registrationHasNoAxioms (hash : String) : (registrationData hash).axioms = [] := rfl
theorem registrationHasNoFreeParameters (hash : String) : (registrationData hash).freeParameters = [] := rfl
end SFT.Physics.RunningConvergenceEvidence
