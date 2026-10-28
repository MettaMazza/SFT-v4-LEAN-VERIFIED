import SFT.Mathematics.ProbabilityControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.ProbabilityEvidence
open SFT.Host.Canonical ProbabilityGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "event",.text (eventName c.event)],.array [.text "weight",.text (weightName c.weight)],.array [.text "uncertainty",.text (uncertaintyName c.uncertainty)],.array [.text "conditioning",.text (conditioningName c.conditioning)],.array [.text "independence",.text (independenceName c.independence)],.array [.text "statistics",.text (statisticsName c.statistics)],.array [.text "empirical",.text (empiricalName c.empirical)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "support"),("question",.text "What fixes possible microstates?"),("choices",.array [.array [.text "sampled-or-partial-support",.text "A partial support silently changes every derived weight."],.array [.text "complete-generated-support",.text "Every registered deterministic microstate occurs once."]])],.object [("key",.text "event"),("question",.text "What fixes an event?"),("choices",.array [.array [.text "named-outcome",.text "A name without retained membership does not identify support."],.array [.text "held-support-selection",.text "An event is a duplicate-free held selection of exact support."]])],.object [("key",.text "weight"),("question",.text "What fixes probability quantity?"),("choices",.array [.array [.text "floating-propensity",.text "A floating propensity imports precision and a stochastic cause."],.array [.text "exact-held-whole-part",.text "Weight is the exact held count over the complete support count."]])],.object [("key",.text "uncertainty"),("question",.text "What produces uncertainty?"),("choices",.array [.array [.text "ontic-random-cause",.text "A causal random source is neither generated nor required."],.array [.text "closed-observation-distinction",.text "Uncertainty records which deterministic microstate distinctions observation does not retain."]])],.object [("key",.text "conditioning"),("question",.text "What fixes conditional weight?"),("choices",.array [.array [.text "renormalized-guess",.text "A guessed renormalization can omit common support."],.array [.text "exact-common-refinement",.text "Restrict to the complete held condition and count its exact event intersection."]])],.object [("key",.text "independence"),("question",.text "What fixes independence?"),("choices",.array [.array [.text "uncorrelated-assertion",.text "An assertion does not prove factorized joint support."],.array [.text "pair-cell-factorization",.text "Complete joint support is the exact product and event weights multiply by bijection."]])],.object [("key",.text "statistics"),("question",.text "What fixes a statistic?"),("choices",.array [.array [.text "opaque-estimator",.text "An opaque scalar erases source rows and tie structure."],.array [.text "provenance-retaining-summary",.text "Every summary is recomputable from the complete finite trace and retains ties."]])],.object [("key",.text "empirical"),("question",.text "How may measured rows test a law?"),("choices",.array [.array [.text "target-informed-fit",.text "Using target rows during derivation allows them to select the law."],.array [.text "post-seal-blind-check",.text "Natural measurements enter only after formal sealing under registered isolation."]])],.object [("key",.text "addition"),("question",.text "Is a stochastic law added?"),("choices",.array [.array [.text "extra-random-parameter",.text "A seed distribution or prior is a free parameter."],.array [.text "no-extra-random-parameter",.text "All weights follow from support and observation without stochastic dynamics."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-PROBABILITY-STATISTICS-001"
  title := "Exact finite probability and statistics from Fold observation"
  branch := "mathematics"
  statement := "Probability is an exact held-support/whole-support part relation over a complete deterministic generated microstate support; uncertainty records distinctions closed by an observation class and is not a causal random premise. Conditional weight is exact common-refinement restriction, independence is complete pair-cell factorization, and statistics are provenance-retaining finite trace summaries. The empty event is empty One, never numerical zero."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-PROBABILITY-STATISTICS-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-PROBABILITY-STATISTICS-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-PART-EQUIVALENCE-001",.text "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-COMBINATORICS-001"]),
    ("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])

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
  proofHash := identity (.object [("closure",ProbabilityControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-PROBABILITY-STATISTICS-001"),
    ("base",.text "A One-state support has whole certainty; its held-empty event is represented by empty One."),
    ("successor",.text "Adding one fresh microstate extends whole support once and either extends or leaves each held event. Exact parts, observation classes, intersections and summaries update from that retained membership without a prior."),
    ("laws",.array (ProbabilityControls.laws.map Value.text)),
    ("witnesses",.array (ProbabilityWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Prediction and experiment require uncertainty and statistics, but a superdeterministic Fold model cannot import stochastic dynamics. Exact observation classes supply the required epistemic structure."

def derivation : String := "Parts supply exact held/whole quantities; combinatorics supplies complete support; the measurement boundary isolates data. Nine structural choices force the observation-support account without a prior."

def check : String := "Execute all 512 kernels, verify exact event and conditional parts, an empty-One control, joint-support factorization, tied summaries and observation classes, then independently regenerate the census."

def limitations : String := "This closes exact finite probability and descriptive statistics. Inferential claims about natural data remain empirical claims and require preregistered blind validation through the empirical engine."

def correspondenceTerms : List String := ["probability space","conditional probability","independence","random variable","statistic","sampling"]

end SFT.Mathematics.ProbabilityEvidence
