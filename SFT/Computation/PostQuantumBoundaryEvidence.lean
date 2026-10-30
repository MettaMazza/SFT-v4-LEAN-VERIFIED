import SFT.Computation.PostQuantumBoundaryControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.PostQuantumBoundaryEvidence
open SFT.Host.Canonical PostQuantumBoundaryGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "adversary",.text (adversaryName c.adversary)],.array [.text "interaction",.text (interactionName c.interaction)],.array [.text "observation",.text (observationName c.observation)],.array [.text "security",.text (securityName c.security)],.array [.text "resources",.text (resourcesName c.resources)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-SEC-POST-QUANTUM-BOUNDARY-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.text "Which support coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "sampled-messages-or-keys",.text "sampled-messages-or-keys removes a required exact support condition."],.array [.text "complete-generated-challenge-support",.text "complete-generated-challenge-support retains the complete registered support condition."]]],.array [.text "adversary",.text "Which adversary coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "undefined-adversary",.text "undefined-adversary removes a required exact adversary condition."],.array [.text "exact-adversary-process-grammar",.text "exact-adversary-process-grammar retains the complete registered adversary condition."]]],.array [.text "interaction",.text "Which interaction coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "outcome-only",.text "outcome-only removes a required exact interaction condition."],.array [.text "complete-interaction-trace",.text "complete-interaction-trace retains the complete registered interaction condition."]]],.array [.text "observation",.text "Which observation coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "implicit-leakage",.text "implicit-leakage removes a required exact observation condition."],.array [.text "exact-adversary-observation",.text "exact-adversary-observation retains the complete registered observation condition."]]],.array [.text "security",.text "Which security coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "informal-security",.text "informal-security removes a required exact security condition."],.array [.text "retained-closed-distinction-property",.text "retained-closed-distinction-property retains the complete registered security condition."]]],.array [.text "resources",.text "Which resources coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "unbounded-claim",.text "unbounded-claim removes a required exact resources condition."],.array [.text "declared-information-or-resource-bound",.text "declared-information-or-resource-bound retains the complete registered resources condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "challenge-examples",.text "challenge-examples removes a required exact generality condition."],.array [.text "support-successor-certificate",.text "support-successor-certificate retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Cryptography and Computational Security obligation?",.array [.array [.text "imported-hardness-assumption",.text "imported-hardness-assumption removes a required exact addition condition."],.array [.text "no-extra-security-premise",.text "no-extra-security-premise retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-SEC-POST-QUANTUM-BOUNDARY-001"
  title := "Fold post-quantum security-boundary law"
  branch := "computation"
  statement := "The forced classical claims under an enlarged adversary interface kernel retains classical scheme; declared quantum-capable oracle interface; query and resource ledger; reduction dependencies; failure boundary; migration correspondence; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-SEC-SECURITY-DEFINITION-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-SEC-POST-QUANTUM-BOUNDARY-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-SEC-POST-QUANTUM-BOUNDARY-001"),
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
  proofHash := identity (.object [("closure",PostQuantumBoundaryControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-SEC-POST-QUANTUM-BOUNDARY-001"),("base",.text "The structural One supplies one canonical classical claims under an enlarged adversary interface form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated classical claims under an enlarged adversary interface form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold post-quantum security-boundary law is required to derive classical claims under an enlarged adversary interface without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: classical scheme; declared quantum-capable oracle interface; query and resource ledger; reduction dependencies; failure boundary; migration correspondence."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "No quantum operation is derived here; operational quantum adversaries wait for the Quantum Computation branch."

def correspondenceTerms : List String := ["post-quantum cryptography","quantum adversary"]

end SFT.Computation.PostQuantumBoundaryEvidence
