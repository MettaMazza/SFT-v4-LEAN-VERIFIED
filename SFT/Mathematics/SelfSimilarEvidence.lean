import SFT.Mathematics.SelfSimilarControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.SelfSimilarEvidence
open SFT.Host.Canonical SelfSimilarGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "scale",.text (scaleName c.scale)],.array [.text "separation",.text (separationName c.separation)],.array [.text "information",.text (informationName c.information)],.array [.text "power",.text (powerName c.power)],.array [.text "support",.text (supportName c.support)],.array [.text "series",.text (seriesName c.series)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "scale"),("question",.text "scale?"),("choices",.array [.array [.text "continuous-rescale",.text "A continuous scale group is not generated."],.array [.text "fold-doubling",.text "The scale successor is the Fold count."]])],.object [("key",.text "separation"),("question",.text "separation?"),("choices",.array [.array [.text "fitted-lyapunov",.text "A fitted rate is not a theorem."],.array [.text "exact-binary-expansion",.text "Before cast, local separation is multiplied by the Fold count."]])],.object [("key",.text "information"),("question",.text "information?"),("choices",.array [.array [.text "logarithmic-value",.text "A logarithm is outside exact proof arithmetic."],.array [.text "one-closed-label",.text "One Fold merge closes exactly one binary predecessor distinction."]])],.object [("key",.text "power"),("question",.text "power?"),("choices",.array [.array [.text "selected-exponent",.text "A selected exponent is a parameter."],.array [.text "unit-self-similar",.text "Rank doubling and count halving uniquely select the One exponent in the enumerated exponent grammar."]])],.object [("key",.text "support"),("question",.text "support?"),("choices",.array [.array [.text "binary-only",.text "The successor law is not tied to one label count."],.array [.text "m-to-depth",.text "An m-label successor multiplies support by m at every depth."]])],.object [("key",.text "series"),("question",.text "series?"),("choices",.array [.array [.text "irrational-limit",.text "The limit cannot enter as a proof value."],.array [.text "rational-tail-bound",.text "Exact partial sums and a shrinking rational tail prove finiteness."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "finite-table",.text "A depth table lacks a recurrence."],.array [.text "base-successor",.text "Every law carries a structural base and exact successor."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "extra-analytic-function",.text "Logarithm or exponential would add a model."],.array [.text "no-extra-rule",.text "Only exact ratios, counts and recurrences occur."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002"
  title := "Exact self-similarity, chaotic rate and convergent-series laws"
  branch := "mathematics"
  statement := "Fold forces binary local separation expansion, one closed distinction per step, the unique unit exponent under rank doubling, exact m^d support growth, and rational convergence certificates whose tails shrink by a generated factor without importing logarithms or irrational limit values."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-EXACT-RELATIONS-002","SFT-MATH-LIMIT-CONTINUUM-002"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002"),
    ("dependencies",.array [.text "SFT-MATH-EXACT-RELATIONS-002",.text "SFT-MATH-LIMIT-CONTINUUM-002"]),
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
  proofHash := identity (.object [("closure",SelfSimilarControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002"),
    ("base",.text "At depth One an m-labelled successor has m states and one Fold closes one binary distinction."),
    ("successor",.text "Appending one label multiplies support by m; applying one Fold multiplies an uncast local gap by b and closes one predecessor label; one further rational term preserves the tail bound."),
    ("laws",.array (SelfSimilarControls.laws.map Value.text)),
    ("witnesses",.array (SelfSimilarWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.SelfSimilarEvidence
