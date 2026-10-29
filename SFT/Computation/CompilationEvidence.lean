import SFT.Computation.CompilationControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.CompilationEvidence
open SFT.Host.Canonical CompilationGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "syntax",.text (syntaxName c.syntaxAxis)],.array [.text "binding",.text (bindingName c.binding)],.array [.text "relation",.text (relationName c.relation)],.array [.text "evaluation",.text (evaluationName c.evaluation)],.array [.text "equivalence",.text (equivalenceName c.equivalence)],.array [.text "proof",.text (proofName c.proof)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-SEM-COMPILATION-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "syntax",.text "Which syntax coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "partial-or-ambiguous-syntax",.text "partial-or-ambiguous-syntax removes a required exact syntax condition."],.array [.text "complete-generated-syntax",.text "complete-generated-syntax retains the complete registered syntax condition."]]],.array [.text "binding",.text "Which binding coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "presentation-name",.text "presentation-name removes a required exact binding condition."],.array [.text "canonical-held-binding",.text "canonical-held-binding retains the complete registered binding condition."]]],.array [.text "relation",.text "Which relation coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "informal-meaning",.text "informal-meaning removes a required exact relation condition."],.array [.text "exact-semantic-relation",.text "exact-semantic-relation retains the complete registered relation condition."]]],.array [.text "evaluation",.text "Which evaluation coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "result-only",.text "result-only removes a required exact evaluation condition."],.array [.text "complete-evaluation-trace",.text "complete-evaluation-trace retains the complete registered evaluation condition."]]],.array [.text "equivalence",.text "Which equivalence coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "visual-equivalence",.text "visual-equivalence removes a required exact equivalence condition."],.array [.text "observation-bound-equivalence",.text "observation-bound-equivalence retains the complete registered equivalence condition."]]],.array [.text "proof",.text "Which proof coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "test-only",.text "test-only removes a required exact proof condition."],.array [.text "machine-checkable-proof-object",.text "machine-checkable-proof-object retains the complete registered proof condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "sample-programs",.text "sample-programs removes a required exact generality condition."],.array [.text "syntax-successor-certificate",.text "syntax-successor-certificate retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Semantics and Mathematical Programming Theory obligation?",.array [.array [.text "imported-language-semantics",.text "imported-language-semantics removes a required exact addition condition."],.array [.text "no-extra-semantic-premise",.text "no-extra-semantic-premise retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-SEM-COMPILATION-001"
  title := "Fold semantics-preserving compilation law"
  branch := "computation"
  statement := "The forced translation between executable languages kernel retains source and target grammars; total compiler relation; source evaluation; target evaluation; result correspondence; failure rejection; overhead ledger; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-SEM-TRANSFORMATION-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-SEM-COMPILATION-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-SEM-COMPILATION-001"),
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
  proofHash := identity (.object [("closure",CompilationControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-SEM-COMPILATION-001"),("base",.text "The structural One supplies one canonical translation between executable languages form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated translation between executable languages form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold semantics-preserving compilation law is required to derive translation between executable languages without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: source and target grammars; total compiler relation; source evaluation; target evaluation; result correspondence; failure rejection; overhead ledger."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "Applies only to the two frozen language grammars and declared runtime interface."

def correspondenceTerms : List String := ["compiler correctness","compilation"]

end SFT.Computation.CompilationEvidence
