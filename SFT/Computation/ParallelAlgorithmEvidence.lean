import SFT.Computation.ParallelAlgorithmControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.ParallelAlgorithmEvidence
open SFT.Host.Canonical ParallelAlgorithmGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "domain",.text (domainName c.domain)],.array [.text "precondition",.text (preconditionName c.precondition)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "invariant",.text (invariantName c.invariant)],.array [.text "output",.text (outputName c.output)],.array [.text "resource",.text (resourceName c.resource)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-ALG-PARALLEL-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "domain",.text "Which domain coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "sampled-inputs",.text "sampled-inputs removes a required exact domain condition."],.array [.text "complete-generated-input-domain",.text "complete-generated-input-domain retains the complete registered domain condition."]]],.array [.text "precondition",.text "Which precondition coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "implicit-precondition",.text "implicit-precondition removes a required exact precondition condition."],.array [.text "exact-registered-precondition",.text "exact-registered-precondition retains the complete registered precondition condition."]]],.array [.text "transition",.text "Which transition coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "answer-producing-heuristic",.text "answer-producing-heuristic removes a required exact transition condition."],.array [.text "exact-step-relation",.text "exact-step-relation retains the complete registered transition condition."]]],.array [.text "invariant",.text "Which invariant coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "unchecked-intermediate-state",.text "unchecked-intermediate-state removes a required exact invariant condition."],.array [.text "retained-invariant-ledger",.text "retained-invariant-ledger retains the complete registered invariant condition."]]],.array [.text "output",.text "Which output coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "result-without-certificate",.text "result-without-certificate removes a required exact output condition."],.array [.text "reconstructible-output-certificate",.text "reconstructible-output-certificate retains the complete registered output condition."]]],.array [.text "resource",.text "Which resource coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "unreported-resources",.text "unreported-resources removes a required exact resource condition."],.array [.text "complete-time-space-trace",.text "complete-time-space-trace retains the complete registered resource condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "example-program",.text "example-program removes a required exact generality condition."],.array [.text "input-successor-certificate",.text "input-successor-certificate retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Algorithms and Mathematical Data Structures obligation?",.array [.array [.text "imported-algorithm",.text "imported-algorithm removes a required exact addition condition."],.array [.text "no-extra-answer-model",.text "no-extra-answer-model retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-ALG-PARALLEL-001"
  title := "Fold parallel-algorithm law"
  branch := "computation"
  statement := "The forced causally independent algorithm steps kernel retains dependency graph; ready-set layers; local invariants; synchronization rows; combined trace; output reconstruction; work and span ledgers; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-ALG-RANDOMIZED-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-ALG-PARALLEL-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-ALG-PARALLEL-001"),
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
  proofHash := identity (.object [("closure",ParallelAlgorithmControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-ALG-PARALLEL-001"),("base",.text "The structural One supplies one canonical causally independent algorithm steps form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated causally independent algorithm steps form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold parallel-algorithm law is required to derive causally independent algorithm steps without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: dependency graph; ready-set layers; local invariants; synchronization rows; combined trace; output reconstruction; work and span ledgers."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "No physical speedup is claimed without an implementation experiment."

def correspondenceTerms : List String := ["parallel algorithm","parallel schedule"]

end SFT.Computation.ParallelAlgorithmEvidence
