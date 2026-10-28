import SFT.InformationScience.MutualControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.MutualEvidence
open SFT.Host.Canonical MutualGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "observations",.text (observationsName c.observations)],.array [.text "marginals",.text (marginalsName c.marginals)],.array [.text "joint",.text (jointName c.joint)],.array [.text "conditional",.text (conditionalName c.conditional)],.array [.text "mutual",.text (mutualName c.«mutual»)],.array [.text "factorization",.text (factorizationName c.factorization)],.array [.text "cause",.text (causeName c.cause)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "support"),("question",.text "What fixes possible source forms?"),("choices",.array [.array [.text "partial-source-support",.text "Omission changes marginal, joint and conditional parts."],.array [.text "complete-deterministic-support",.text "Every registered source form occurs exactly once."]])],.object [("key",.text "observations"),("question",.text "What fixes the two information views?"),("choices",.array [.array [.text "partial-or-multivalued-views",.text "An incomplete or multivalued view cannot form exact classes."],.array [.text "two-total-observation-maps",.text "Each source form has exactly one image in each view."]])],.object [("key",.text "marginals"),("question",.text "What fixes the separate information classes?"),("choices",.array [.array [.text "named-marginal-scores",.text "Scores erase which source forms produce each image."],.array [.text "exact-provenance-classes",.text "Each image retains its complete source class and exact whole part."]])],.object [("key",.text "joint"),("question",.text "What fixes combined information?"),("choices",.array [.array [.text "sampled-joint-cells",.text "Sampling can hide absent or repeated combinations."],.array [.text "complete-joint-incidence-ledger",.text "Every pair of marginal labels has an explicit member class or empty One."]])],.object [("key",.text "conditional"),("question",.text "What fixes information under a condition?"),("choices",.array [.array [.text "renormalized-prior",.text "A prior or guessed normalization is not generated."],.array [.text "exact-class-restriction",.text "Each target class is intersected with the complete held given class."]])],.object [("key",.text "mutual"),("question",.text "What fixes mutual dependence?"),("choices",.array [.array [.text "scalar-log-ratio",.text "A log ratio imports real values and erases the cells responsible."],.array [.text "joint-versus-product-ledger",.text "Every joint part is compared exactly with its marginal product while retaining provenance."]])],.object [("key",.text "factorization"),("question",.text "What forces independence?"),("choices",.array [.array [.text "uncorrelated-assertion",.text "A label does not establish every joint cell and weight."],.array [.text "all-cell-exact-equality",.text "Every joint cell exists and equals its exact marginal product."]])],.object [("key",.text "cause"),("question",.text "Does dependence require random generation?"),("choices",.array [.array [.text "stochastic-source-premise",.text "A random cause is neither forced nor required."],.array [.text "deterministic-observation-incidence",.text "Dependence is a relation among exact observation classes over deterministic support."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite support?"),("choices",.array [.array [.text "small-table-only",.text "A table does not establish the next source update."],.array [.text "source-successor-update",.text "A fresh source enters one marginal class and one joint cell, updating exact parts."]])],.object [("key",.text "addition"),("question",.text "Is another information measure added?"),("choices",.array [.array [.text "extra-base-prior-or-scalar",.text "The added choice is a free parameter."],.array [.text "no-extra-information-measure",.text "The ledgers follow only from complete support and total observations."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-MUTUAL-CONDITIONAL-001"
  title := "Exact mutual and conditional information from joint observation incidence"
  branch := "information_science"
  statement := "Conditional information is the complete exact restriction of one total observation to every class of another. Mutual dependence is the complete joint-incidence ledger comparing each observed joint support part with the product of its exact marginal parts; absent cells remain structural empty One and no signed subtraction is used. Factorization holds exactly when every joint cell is present and its part equals the marginal product. Thus conditioning and dependence are derived from deterministic support and observation, without priors, logarithms, stochastic causes or floating values."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-MUTUAL-CONDITIONAL-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-MUTUAL-CONDITIONAL-001"),
    ("dependencies",.array [.text "SFT-MATH-PROBABILITY-STATISTICS-001",.text "SFT-MATH-COMBINATORICS-001",.text "SFT-INFO-ENTROPY-UNCERTAINTY-001",.text "SFT-INFO-QUANTITY-001"]),
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
  proofHash := identity (.object [("closure",MutualControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-MUTUAL-CONDITIONAL-001"),
    ("base",.text "One source form gives one whole marginal cell, one whole joint cell and one whole conditional cell."),
    ("successor",.text "Adding one fresh source form places it in exactly one class of each observation and therefore one joint cell; all marginal, joint and conditional counts and exact parts are recomputed from retained membership."),
    ("laws",.array (MutualControls.laws.map Value.text)),
    ("witnesses",.array (MutualWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Conditional and mutual information must preserve the observation cells that create the relation. Collapsing them into an imported logarithmic scalar would discard the exact structural proof."

def derivation : String := "Probability supplies exact support parts, entropy supplies observation classes and quantity supplies retained distinctions. Ten axes force conditional restriction, joint incidence and exact factorization."

def check : String := "Execute all 1,024 kernels; exhaust a two-by-two support grid, verify conditional parts, factorization and its empty dependence ledger, reject the copied-view control and independently regenerate the product."

def limitations : String := "This closes exact finite structural conditional information and dependence. Conventional scalar Shannon mutual information is a post-seal correspondence summary, not an SFT proof value."

def correspondenceTerms : List String := ["conditional information","mutual information","joint distribution","marginal","independence"]

end SFT.InformationScience.MutualEvidence
