import SFT.Mathematics.OptimizationControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.OptimizationEvidence
open SFT.Host.Canonical OptimizationGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "candidates",.text (candidatesName c.candidates)],.array [.text "feasibility",.text (feasibilityName c.feasibility)],.array [.text "preference",.text (preferenceName c.preference)],.array [.text "solution",.text (solutionName c.solution)],.array [.text "ties",.text (tiesName c.ties)],.array [.text "constraints",.text (constraintsName c.constraints)],.array [.text "decomposition",.text (decompositionName c.decomposition)],.array [.text "approximation",.text (approximationName c.approximation)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "candidates"),("question",.text "What fixes the search domain?"),("choices",.array [.array [.text "sampled-candidates",.text "Sampling cannot prove that a better generated candidate was not omitted."],.array [.text "complete-canonical-candidates",.text "Every registered candidate form occurs once."]])],.object [("key",.text "feasibility"),("question",.text "What fixes feasibility?"),("choices",.array [.array [.text "implicit-constraint",.text "An implicit constraint has no candidate-level check trace."],.array [.text "source-bound-verdicts",.text "Every candidate receives one exact verdict from each registered constraint."]])],.object [("key",.text "preference"),("question",.text "What fixes better-than?"),("choices",.array [.array [.text "floating-score",.text "A floating score imports scale and precision choices."],.array [.text "witnessed-order-relation",.text "Every preference is an exact retained candidate pair."]])],.object [("key",.text "solution"),("question",.text "What fixes an optimum?"),("choices",.array [.array [.text "first-found",.text "First-found depends on traversal presentation."],.array [.text "complete-undominated-selection",.text "Every feasible candidate is compared and all undominated forms are retained."]])],.object [("key",.text "ties"),("question",.text "How are equal or incomparable optima treated?"),("choices",.array [.array [.text "silent-tie-break",.text "A silent tie-break adds a free preference."],.array [.text "retained-equivalence-class",.text "All jointly optimal or incomparable surviving forms remain explicit."]])],.object [("key",.text "constraints"),("question",.text "How are constraints admitted?"),("choices",.array [.array [.text "penalty-parameter",.text "A tunable penalty is a free parameter and can select the answer."],.array [.text "exact-membership-predicate",.text "Each constraint is a source-bound exact allowed-form relation."]])],.object [("key",.text "decomposition"),("question",.text "When may a problem decompose?"),("choices",.array [.array [.text "assumed-separability",.text "Shared constraints can invalidate separate optima."],.array [.text "exact-interface-factorization",.text "Subproblems compose only when all shared interface relations are retained."]])],.object [("key",.text "approximation"),("question",.text "What fixes an approximation guarantee?"),("choices",.array [.array [.text "decimal-error",.text "A decimal error imports rounding and a scale."],.array [.text "exact-positive-part-bound",.text "The candidate/optimum relation is a generated exact part certificate."]])],.object [("key",.text "addition"),("question",.text "Is another objective supplied?"),("choices",.array [.array [.text "extra-objective-or-tie-rule",.text "An added score or tie rule is not forced by the instance."],.array [.text "no-extra-objective",.text "Only registered feasibility and preference relations select solutions."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-OPTIMIZATION-001"
  title := "Exact finite optimization and retained optima"
  branch := "mathematics"
  statement := "An admitted optimization problem is a complete canonical candidate carrier, a source-bound exact feasibility relation and a witnessed preference relation. Solutions are the complete undominated held selection; uniqueness is claimed only for a singleton, while ties and incomparable Pareto alternatives remain explicit. Constraints, decomposition and approximation are exact trace relations without floating objectives, negative penalties or free tuning parameters."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-OPTIMIZATION-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-OPTIMIZATION-001"),
    ("dependencies",.array [.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-GRAPH-NETWORK-001",.text "SFT-MATH-ORDER-LATTICE-001"]),
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
  proofHash := identity (.object [("closure",OptimizationControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-OPTIMIZATION-001"),
    ("base",.text "A One-candidate feasible carrier has that candidate as its unique complete undominated selection."),
    ("successor",.text "Adding one fresh candidate generates its feasibility verdicts and every preference pair with prior feasible forms. It is either eliminated by a retained dominator, eliminates witnessed dominated forms, or joins the retained optimal class; no prior optimum is silently discarded."),
    ("laws",.array (OptimizationControls.laws.map Value.text)),
    ("witnesses",.array (OptimizationWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Search and decision require lawful selection among alternatives. Exact dominance and tie retention prevent a familiar score, tolerance or traversal order from selecting the result."

def derivation : String := "Orders supply witnessed preference and incomparability; graphs supply search relations and decomposable interfaces; exact arithmetic supplies part bounds. Nine choices force the complete undominated kernel."

def check : String := "Execute all 512 kernels, verify feasibility coverage, unique and tied optima, exact constraints, Pareto incomparability and exact approximation, then independently regenerate the candidate census."

def limitations : String := "This closes exact finite optimization structure. Complexity of finding the complete frontier and laws for particular objective families belong to the algorithms and complexity branches."

def correspondenceTerms : List String := ["feasible set","objective","optimum","Pareto frontier","constraint","approximation ratio"]

end SFT.Mathematics.OptimizationEvidence
