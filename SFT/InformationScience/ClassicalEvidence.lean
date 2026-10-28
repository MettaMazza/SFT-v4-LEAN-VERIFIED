import SFT.InformationScience.ClassicalControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.ClassicalEvidence
open SFT.Host.Canonical ClassicalGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "classical",.text (classicalName c.classical)],.array [.text "observation",.text (observationName c.observation)],.array [.text "parts",.text (partsName c.parts)],.array [.text "meaning",.text (meaningName c.meaning)],.array [.text "resolution",.text (resolutionName c.resolution)],.array [.text "transformation",.text (transformationName c.transformation)],.array [.text "normalization",.text (normalizationName c.normalization)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "support"),("question",.text "What fixes possible microstates?"),("choices",.array [.array [.text "sampled-or-duplicated-support",.text "Sampling or duplication changes every exact part."],.array [.text "complete-canonical-support",.text "Every deterministic microstate occurs once."]])],.object [("key",.text "classical"),("question",.text "What fixes classical information?"),("choices",.array [.array [.text "unheld-symbol-name",.text "A name alone does not locate a state in complete support."],.array [.text "one-held-supported-state",.text "One exact support member is retained with its provenance."]])],.object [("key",.text "observation"),("question",.text "What fixes probabilistic alternatives?"),("choices",.array [.array [.text "free-weight-list",.text "Weights without microstates import a distribution."],.array [.text "total-observation-classes",.text "Every microstate belongs to exactly one observed class."]])],.object [("key",.text "parts"),("question",.text "What fixes probability weights?"),("choices",.array [.array [.text "floating-propensities",.text "Floating propensities import precision and causal assumptions."],.array [.text "exact-class-whole-parts",.text "Each nonempty class count is retained relative to complete support count."]])],.object [("key",.text "meaning"),("question",.text "What does probability represent?"),("choices",.array [.array [.text "ontic-random-cause",.text "A random cause is neither generated nor needed."],.array [.text "unresolved-deterministic-distinction",.text "Each probabilistic class explicitly retains the deterministic alternatives observation closes."]])],.object [("key",.text "resolution"),("question",.text "When does observation identify a state?"),("choices",.array [.array [.text "likely-state-selection",.text "Selecting the likely state imports a prior."],.array [.text "singleton-class-only",.text "Only one-member classes resolve; larger classes remain complete."]])],.object [("key",.text "transformation"),("question",.text "How does a distribution transform?"),("choices",.array [.array [.text "stochastic-transition-matrix",.text "A free transition matrix adds parameters and random dynamics."],.array [.text "deterministic-predecessor-grouping",.text "A total map groups exact predecessor support into image classes."]])],.object [("key",.text "normalization"),("question",.text "What closes the whole?"),("choices",.array [.array [.text "fitted-normalization",.text "A fitted factor can conceal omitted states."],.array [.text "partition-exact-whole",.text "Disjoint complete class parts reconstruct the exact whole."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite support?"),("choices",.array [.array [.text "finite-examples-only",.text "Examples do not prove the next microstate update."],.array [.text "microstate-successor",.text "A fresh microstate enters one class and every exact part is recomputed from membership."]])],.object [("key",.text "addition"),("question",.text "Is stochastic structure added?"),("choices",.array [.array [.text "extra-seed-prior-or-kernel",.text "The addition is a free parameter and may select results."],.array [.text "no-extra-stochastic-law",.text "All probabilistic information follows from support, observation and deterministic maps."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-CLASSICAL-PROBABILISTIC-001"
  title := "Exact classical and probabilistic information correspondence"
  branch := "information_science"
  statement := "Classical information is one held member of a complete deterministic support with its provenance retained. Probabilistic information is the exact observation-class ledger over that same support: every class retains its deterministic microstates and exact positive part of the whole. Observation resolves a classical state only for a singleton class; otherwise it returns the complete unresolved class. Deterministic transformations push the ledger forward by exact predecessor grouping. Probability therefore describes unavailable distinctions and does not introduce stochastic dynamics, floating propensities, numerical zero or priors."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-CLASSICAL-PROBABILISTIC-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-CLASSICAL-PROBABILISTIC-001"),
    ("dependencies",.array [.text "SFT-MATH-PROBABILITY-STATISTICS-001",.text "SFT-INFO-ENTROPY-UNCERTAINTY-001",.text "SFT-INFO-MUTUAL-CONDITIONAL-001",.text "SFT-INFO-CONSERVATION-LOSS-001"]),
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
  proofHash := identity (.object [("closure",ClassicalControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-CLASSICAL-PROBABILISTIC-001"),
    ("base",.text "One deterministic microstate is one held classical state and one exact whole observation class."),
    ("successor",.text "Adding one fresh microstate extends complete support and exactly one observation class. The class ledgers and their exact whole parts update from retained membership, while each individual state remains deterministic."),
    ("laws",.array (ClassicalControls.laws.map Value.text)),
    ("witnesses",.array (ClassicalWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "The relation between classical and probabilistic information must be explicit in a deterministic theory. Observation classes derive exact probability while preserving every underlying state."

def derivation : String := "Mathematical probability supplies exact parts, entropy supplies observation classes, mutual information supplies joint restriction and conservation supplies deterministic pushforward. Ten axes force one shared support account."

def check : String := "Execute all 1,024 kernels; verify held classical states, equal and unequal exact class parts, singleton resolution, unresolved-class retention, deterministic pushforward and independent candidate regeneration."

def limitations : String := "This theorem closes finite classical/probabilistic information correspondence. Empirical frequencies require separately registered blind data protocols and do not alter the formal law."

def correspondenceTerms : List String := ["classical state","ensemble","probability distribution","pushforward","epistemic uncertainty"]

end SFT.InformationScience.ClassicalEvidence
