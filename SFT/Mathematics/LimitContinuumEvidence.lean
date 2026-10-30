import SFT.Mathematics.LimitContinuumControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.LimitContinuumEvidence
open SFT.Host.Canonical LimitContinuumGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "object",.text (objectName c.object)],.array [.text "successor",.text (successorName c.successor)],.array [.text "refinement",.text (refinementName c.refinement)],.array [.text "convergence",.text (convergenceName c.convergence)],.array [.text "continuum",.text (continuumName c.continuum)],.array [.text "cardinality",.text (cardinalityName c.cardinality)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "object"),("question",.text "object?"),("choices",.array [.array [.text "completed-infinity",.text "A completed unbounded totality is not generated."],.array [.text "finite-stage",.text "Every admitted stage has a complete finite trace."]])],.object [("key",.text "successor"),("question",.text "successor?"),("choices",.array [.array [.text "largest-stage",.text "No generated rule supplies a largest finite stage."],.array [.text "always-next",.text "Appending one Fold supplies the next finite stage."]])],.object [("key",.text "refinement"),("question",.text "refinement?"),("choices",.array [.array [.text "vanishing-zero",.text "Numerical zero is outside the domain."],.array [.text "positive-rung",.text "Every refinement remains a positive exact part."]])],.object [("key",.text "convergence"),("question",.text "convergence?"),("choices",.array [.array [.text "limit-as-value",.text "An ungenerated limit cannot enter as a value."],.array [.text "nested-rational-bounds",.text "Exact nested rational bounds certify approach and error."]])],.object [("key",.text "continuum"),("question",.text "continuum?"),("choices",.array [.array [.text "ambient-real-line",.text "An ambient continuum imports forbidden objects."],.array [.text "unbounded-process-boundary",.text "The continuum is correspondence for an unbounded refinement process."]])],.object [("key",.text "cardinality"),("question",.text "cardinality?"),("choices",.array [.array [.text "completed-comparison",.text "Cardinality of a nonobject has no SFT witness."],.array [.text "finite-bound-count",.text "Every reached bound has an exact generated count."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "fixed-depth",.text "One fixed depth does not close the successor law."],.array [.text "base-successor",.text "The positive-rung property is preserved by every next finite refinement."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "extra-limit-rule",.text "A limit oracle adds an axiom."],.array [.text "no-extra-rule",.text "Only exact parts, bounds and successor traces occur."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-LIMIT-CONTINUUM-002"
  title := "Potential infinity, exact refinement and the continuum boundary"
  branch := "mathematics"
  statement := "Every generated rung is a finite exact positive part with a counted successor; refinement can continue without a greatest finite depth, exact rational sequences can carry monotone bounds and convergence certificates, and no completed infinity, unbounded denominator or continuum is admitted as a proof object."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-LIMIT-CONTINUUM-002"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-LIMIT-CONTINUUM-002"),
    ("dependencies",.array [.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-ORDER-LATTICE-001"]),
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
  proofHash := identity (.object [("closure",LimitContinuumControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-LIMIT-CONTINUUM-002"),
    ("base",.text "The One is the complete finite base and its first refinement is a positive exact part."),
    ("successor",.text "Appending one generated Fold depth replaces a positive one-of-b^k rung by the positive one-of-b^(k+1) rung and records one additional return step."),
    ("laws",.array (LimitContinuumControls.laws.map Value.text)),
    ("witnesses",.array (LimitContinuumWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.LimitContinuumEvidence
