import SFT.InformationScience.EntropyControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.EntropyEvidence
open SFT.Host.Canonical EntropyGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "weights",.text (weightsName c.weights)],.array [.text "unresolved",.text (unresolvedName c.unresolved)],.array [.text "entropy",.text (entropyName c.entropy)],.array [.text "refinement",.text (refinementName c.refinement)],.array [.text "cause",.text (causeName c.cause)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "support"),("question",.text "What fixes possible microstates?"),("choices",.array [.array [.text "partial-microstate-support",.text "Omission changes observation classes and uncertainty."],.array [.text "complete-deterministic-support",.text "Every registered microstate occurs once."]])],.object [("key",.text "partition"),("question",.text "What fixes observation uncertainty?"),("choices",.array [.array [.text "overlapping-or-partial-classes",.text "Overlap or omission does not partition exact support."],.array [.text "total-disjoint-observation-classes",.text "Every microstate belongs to exactly one observed class."]])],.object [("key",.text "weights"),("question",.text "What fixes class weight?"),("choices",.array [.array [.text "floating-probability",.text "A floating propensity imports precision and stochastic cause."],.array [.text "exact-class-whole-part",.text "The class count is retained relative to complete support count."]])],.object [("key",.text "unresolved"),("question",.text "What fixes uncertainty inside a class?"),("choices",.array [.array [.text "scalar-uncertainty-score",.text "A scalar score erases which distinctions are unavailable."],.array [.text "complete-within-class-pairs",.text "Every pair of distinct class microstates is retained once."]])],.object [("key",.text "entropy"),("question",.text "What represents total entropy?"),("choices",.array [.array [.text "logarithmic-expectation",.text "Logarithms and real expectations import forbidden proof values."],.array [.text "weighted-class-distinction-ledger",.text "Every class retains exact part, members and unresolved distinctions."]])],.object [("key",.text "refinement"),("question",.text "How does resolution order uncertainty?"),("choices",.array [.array [.text "assumed-more-information",.text "A name does not prove one observation separates every fine class."],.array [.text "class-containment-witness",.text "Every fine class lies inside one coarse class and its closed-pair set is contained."]])],.object [("key",.text "cause"),("question",.text "Does entropy require random dynamics?"),("choices",.array [.array [.text "ontic-random-source",.text "A stochastic source is neither generated nor required."],.array [.text "deterministic-support-observation",.text "Uncertainty comes from distinctions closed by observation over deterministic support."]])],.object [("key",.text "generality"),("question",.text "What closes every finite support?"),("choices",.array [.array [.text "sampled-distributions",.text "Examples cannot establish a fresh microstate class update."],.array [.text "microstate-successor",.text "A fresh state extends exactly one class and its new within-class pairs."]])],.object [("key",.text "addition"),("question",.text "Is another entropy convention added?"),("choices",.array [.array [.text "extra-log-base-or-prior",.text "A chosen log base or prior is a free parameter."],.array [.text "no-extra-entropy-convention",.text "The exact ledger follows only from support and observation."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-ENTROPY-UNCERTAINTY-001"
  title := "Exact entropy and uncertainty from deterministic observation classes"
  branch := "information_science"
  statement := "Uncertainty is the complete ledger of deterministic microstate distinctions closed inside each exact observation class. Entropy is the provenance-retaining family of those classes, their exact positive support parts, microstate traces and unresolved-pair ledgers; singleton certainty uses structural empty One. Refining observation can only remove closed pairs, while coarsening can only add them. No stochastic cause, logarithm, numerical zero or floating expectation enters the law."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-ENTROPY-UNCERTAINTY-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-ENTROPY-UNCERTAINTY-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-PART-EQUIVALENCE-001",.text "SFT-MATH-PROBABILITY-STATISTICS-001",.text "SFT-INFO-SYMBOL-DISTINCTION-001",.text "SFT-INFO-QUANTITY-001"]),
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
  proofHash := identity (.object [("closure",EntropyControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-ENTROPY-UNCERTAINTY-001"),
    ("base",.text "One deterministic microstate forms one exact whole class with structural empty-One uncertainty."),
    ("successor",.text "Adding one fresh microstate assigns it to one retained observation image, updates that class's exact part and adds exactly one unresolved pair with every prior member of the same class; other classes remain unchanged."),
    ("laws",.array (EntropyControls.laws.map Value.text)),
    ("witnesses",.array (EntropyWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Entropy and uncertainty must be reconstructed without treating randomness or real logarithms as premises. Exact observation classes already contain the complete unresolved information."

def derivation : String := "Mathematical probability supplies exact support parts; symbol distinction supplies observation classes; information quantity supplies retained/closed ledgers. Nine axes force an entropy object that preserves every class, part and unavailable distinction."

def check : String := "Execute all 512 entropy kernels, verify fine, prefix and total-coarsening ledgers, exact parts and refinement monotonicity, run adverse controls and independently regenerate the candidate product."

def limitations : String := "This theorem closes exact finite entropy and uncertainty. Conventional scalar Shannon entropies are post-seal summaries only and require a separately declared correspondence map."

def correspondenceTerms : List String := ["entropy","uncertainty","partition entropy","resolution","deterministic ensemble"]

end SFT.InformationScience.EntropyEvidence
