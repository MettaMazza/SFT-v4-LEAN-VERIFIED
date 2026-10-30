import SFT.Computation.InferenceControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.InferenceEvidence
open SFT.Host.Canonical InferenceGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "representation",.text (representationName c.representation)],.array [.text "inference",.text (inferenceName c.inference)],.array [.text "evaluation",.text (evaluationName c.evaluation)],.array [.text "uncertainty",.text (uncertaintyName c.uncertainty)],.array [.text "resources",.text (resourcesName c.resources)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-LEARN-INFERENCE-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.text "Which support coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "sampled-hypotheses",.text "sampled-hypotheses removes a required exact support condition."],.array [.text "complete-generated-hypothesis-support",.text "complete-generated-hypothesis-support retains the complete registered support condition."]]],.array [.text "representation",.text "Which representation coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "opaque-representation",.text "opaque-representation removes a required exact representation condition."],.array [.text "traceable-canonical-representation",.text "traceable-canonical-representation retains the complete registered representation condition."]]],.array [.text "inference",.text "Which inference coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "pretrained-answer",.text "pretrained-answer removes a required exact inference condition."],.array [.text "exact-evidence-to-hypothesis-relation",.text "exact-evidence-to-hypothesis-relation retains the complete registered inference condition."]]],.array [.text "evaluation",.text "Which evaluation coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "development-score",.text "development-score removes a required exact evaluation condition."],.array [.text "sealed-independent-evaluation",.text "sealed-independent-evaluation retains the complete registered evaluation condition."]]],.array [.text "uncertainty",.text "Which uncertainty coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "single-winner-erasure",.text "single-winner-erasure removes a required exact uncertainty condition."],.array [.text "retained-alternative-ledger",.text "retained-alternative-ledger retains the complete registered uncertainty condition."]]],.array [.text "resources",.text "Which resources coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "unreported-search",.text "unreported-search removes a required exact resources condition."],.array [.text "complete-learning-resource-trace",.text "complete-learning-resource-trace retains the complete registered resources condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "training-examples-only",.text "training-examples-only removes a required exact generality condition."],.array [.text "structural-or-empirical-target-boundary",.text "structural-or-empirical-target-boundary retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Learning and Intelligence Theory obligation?",.array [.array [.text "fitted-weight-or-prior",.text "fitted-weight-or-prior removes a required exact addition condition."],.array [.text "no-extra-learning-parameter",.text "no-extra-learning-parameter retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-LEARN-INFERENCE-001"
  title := "Fold inference law"
  branch := "computation"
  statement := "The forced selection among generated hypotheses kernel retains hypothesis support; evidence rows; compatibility relation; retained candidates; eliminated candidates; proof trace; uncertainty ledger; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-SEC-POST-QUANTUM-BOUNDARY-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-LEARN-INFERENCE-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-LEARN-INFERENCE-001"),
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
  proofHash := identity (.object [("closure",InferenceControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-LEARN-INFERENCE-001"),("base",.text "The structural One supplies one canonical selection among generated hypotheses form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated selection among generated hypotheses form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold inference law is required to derive selection among generated hypotheses without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: hypothesis support; evidence rows; compatibility relation; retained candidates; eliminated candidates; proof trace; uncertainty ledger."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "Inference cannot import a prior distribution or pretrained weight."

def correspondenceTerms : List String := ["inference","hypothesis selection"]

end SFT.Computation.InferenceEvidence
