import SFT.Physics.ScatteringPartitionPathControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ScatteringPartitionPathEvidence
open SFT.Host.Canonical ScatteringPartitionPathGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "geometry",.text (geometryName c.geometry)],.array [.text "outcomes",.text (outcomesName c.outcomes)],.array [.text "exclusivity",.text (exclusivityName c.exclusivity)],.array [.text "measure",.text (measureName c.measure)],.array [.text "section",.text (sectionName c.«section»)],.array [.text "density",.text (densityName c.density)],.array [.text "path",.text (pathName c.path)],.array [.text "cause",.text (causeName c.cause)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "geometry"),("question",.text "Which target geometry is claimed?"),("choices",.array [.array [.text "arbitrary-scatterer",.text "Arbitrary geometry does not force equal outcome cells."],.array [.text "registered-one-target-Fold-geometry",.text "The claim is restricted to the generated two-fibre target."]])],.object [("key",.text "outcomes"),("question",.text "Which outcomes are retained?"),("choices",.array [.array [.text "sampled-or-omitted-channel",.text "An omitted channel cannot establish certainty."],.array [.text "complete-scatter-pass-pair",.text "Scatter and pass exhaust the registered outcome support."]])],.object [("key",.text "exclusivity"),("question",.text "May both outcomes occur for one held event?"),("choices",.array [.array [.text "overlapping-outcome-cells",.text "Overlap double-counts one event."],.array [.text "mutually-exclusive-held-labels",.text "Each event retains exactly one distinguishable outcome label."]])],.object [("key",.text "measure"),("question",.text "What fixes the half shares?"),("choices",.array [.array [.text "assumed-equal-probability",.text "An assumed probability imports the answer."],.array [.text "equipotent-two-cell-support",.text "Complete symmetry-related one-cell supports each carry one of two equal parts."]])],.object [("key",.text "section"),("question",.text "What is cross section?"),("choices",.array [.array [.text "fitted-dimensional-number",.text "A fitted number is not the structural measure."],.array [.text "successful-over-incident-support",.text "The exact positive support ratio is generated from counted cells."]])],.object [("key",.text "density"),("question",.text "How do targets compose?"),("choices",.array [.array [.text "density-omitted",.text "Omitting density makes reciprocal path dimensionally incomplete."],.array [.text "positive-density-times-section",.text "Each positive target carrier contributes its registered section."]])],.object [("key",.text "path"),("question",.text "What fixes mean free path?"),("choices",.array [.array [.text "selected-path-length",.text "A selected length has no encounter trace."],.array [.text "reciprocal-encounter-support",.text "The path carrier is exactly One divided by density times section."]])],.object [("key",.text "cause"),("question",.text "Does the support fraction add randomness?"),("choices",.array [.array [.text "stochastic-transition-oracle",.text "A random cause is not supplied by deterministic Fold structure."],.array [.text "deterministic-held-outcomes",.text "Fractions measure complete labelled support while every outcome trace remains exact."]])],.object [("key",.text "extension"),("question",.text "May another correction enter?"),("choices",.array [.array [.text "free-geometry-or-correction",.text "A free correction defeats zero-parameter closure."],.array [.text "no-extra-rule",.text "The two fibres, counts, product and reciprocal exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-SCATTERING-PARTITION-PATH-TERMINAL-017"
  title := "Exact two-fibre scattering partition and reciprocal mean free path"
  branch := "physics"
  statement := "For the registered one-target Fold geometry, the complete mutually exclusive outcome support is the equipotent pair scatter/pass, so each cell carries half-One and the pair reassembles the One.  Cross section is the exact positive successful support relative to incident support.  At positive target-number density n, encounter support per path is n times the section and the exact mean-free-path carrier is its reciprocal.  At unit density, section One gives path One and section half-One gives path two; increasing section strictly shortens path.  The partition is an exact support measure over held deterministic outcomes, not a random transition cause."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-MATH-PROBABILITY-STATISTICS-001", "SFT-INFO-SYMBOL-DISTINCTION-001", "SFT-INFO-CLASSICAL-PROBABILISTIC-001", "SFT-PHYS-MATTER-SCATTERING-001", "SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-SCATTERING-PARTITION-PATH-TERMINAL-017",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-SCATTERING-PARTITION-PATH-TERMINAL-017",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.array [ScatteringPartitionPathControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity ScatteringPartitionPathControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.ScatteringPartitionPathEvidence
