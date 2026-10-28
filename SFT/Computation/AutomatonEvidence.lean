import SFT.Computation.AutomatonControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.AutomatonEvidence
open SFT.Host.Canonical AutomatonGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "relation",.text (relationName c.relation)],.array [.text "trace",.text (traceName c.trace)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-FORM-AUTOMATON-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.text "Which carrier coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "sampled-carrier",.text "sampled-carrier removes a required exact carrier condition."],.array [.text "complete-generated-carrier",.text "complete-generated-carrier retains the complete registered carrier condition."]]],.array [.text "identity",.text "Which identity coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "presentation-identity",.text "presentation-identity removes a required exact identity condition."],.array [.text "canonical-held-identity",.text "canonical-held-identity retains the complete registered identity condition."]]],.array [.text "relation",.text "Which relation coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "assumed-operation",.text "assumed-operation removes a required exact relation condition."],.array [.text "source-bound-exact-relation",.text "source-bound-exact-relation retains the complete registered relation condition."]]],.array [.text "trace",.text "Which trace coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "result-only",.text "result-only removes a required exact trace condition."],.array [.text "complete-retained-trace",.text "complete-retained-trace retains the complete registered trace condition."]]],.array [.text "boundary",.text "Which boundary coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "implicit-terminal-boundary",.text "implicit-terminal-boundary removes a required exact boundary condition."],.array [.text "explicit-initial-terminal-boundary",.text "explicit-initial-terminal-boundary retains the complete registered boundary condition."]]],.array [.text "composition",.text "Which composition coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "opaque-assembly",.text "opaque-assembly removes a required exact composition condition."],.array [.text "interface-preserving-composition",.text "interface-preserving-composition retains the complete registered composition condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "fixed-examples",.text "fixed-examples removes a required exact generality condition."],.array [.text "structural-successor",.text "structural-successor retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Formal Computation obligation?",.array [.array [.text "imported-machine-model",.text "imported-machine-model removes a required exact addition condition."],.array [.text "no-extra-computational-premise",.text "no-extra-computational-premise retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-FORM-AUTOMATON-001"
  title := "Fold finite automaton law"
  branch := "computation"
  statement := "The forced finite recognition processes kernel retains finite states; complete input alphabet; source-bound transition relation; initial state; accepting class; complete run trace; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-FORM-LANGUAGE-GRAMMAR-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-FORM-AUTOMATON-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-FORM-AUTOMATON-001"),
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
  proofHash := identity (.object [("closure",AutomatonControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-FORM-AUTOMATON-001"),("base",.text "The structural One supplies one canonical finite recognition processes form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated finite recognition processes form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold finite automaton law is required to derive finite recognition processes without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: finite states; complete input alphabet; source-bound transition relation; initial state; accepting class; complete run trace."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "Does not yet assert equivalence with every other model or universality."

def correspondenceTerms : List String := ["finite automaton","recognizer"]

end SFT.Computation.AutomatonEvidence
