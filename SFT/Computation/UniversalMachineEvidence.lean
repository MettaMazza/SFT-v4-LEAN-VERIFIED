import SFT.Computation.UniversalMachineControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.UniversalMachineEvidence
open SFT.Host.Canonical UniversalMachineGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "domain",.text (domainName c.domain)],.array [.text "execution",.text (executionName c.execution)],.array [.text "result",.text (resultName c.result)],.array [.text "self_reference",.text (self_referenceName c.self_reference)],.array [.text "totality",.text (totalityName c.totality)],.array [.text "translation",.text (translationName c.translation)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-CBL-UNIVERSAL-MACHINE-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "domain",.text "Which domain coordinate preserves the complete Computability obligation?",.array [.array [.text "sampled-descriptions",.text "sampled-descriptions removes a required exact domain condition."],.array [.text "complete-generated-description-domain",.text "complete-generated-description-domain retains the complete registered domain condition."]]],.array [.text "execution",.text "Which execution coordinate preserves the complete Computability obligation?",.array [.array [.text "verdict-without-run",.text "verdict-without-run removes a required exact execution condition."],.array [.text "exact-recognition-execution-trace",.text "exact-recognition-execution-trace retains the complete registered execution condition."]]],.array [.text "result",.text "Which result coordinate preserves the complete Computability obligation?",.array [.array [.text "implicit-nontermination",.text "implicit-nontermination removes a required exact result condition."],.array [.text "accept-reject-continue-classes",.text "accept-reject-continue-classes retains the complete registered result condition."]]],.array [.text "self_reference",.text "Which self_reference coordinate preserves the complete Computability obligation?",.array [.array [.text "self-reference-excluded",.text "self-reference-excluded removes a required exact self_reference condition."],.array [.text "generated-self-description-support",.text "generated-self-description-support retains the complete registered self_reference condition."]]],.array [.text "totality",.text "Which totality coordinate preserves the complete Computability obligation?",.array [.array [.text "assumed-total-decider",.text "assumed-total-decider removes a required exact totality condition."],.array [.text "explicit-totality-or-partiality-boundary",.text "explicit-totality-or-partiality-boundary retains the complete registered totality condition."]]],.array [.text "translation",.text "Which translation coordinate preserves the complete Computability obligation?",.array [.array [.text "answer-changing-map",.text "answer-changing-map removes a required exact translation condition."],.array [.text "answer-preserving-reduction",.text "answer-preserving-reduction retains the complete registered translation condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Computability obligation?",.array [.array [.text "fixed-depth-table",.text "fixed-depth-table removes a required exact generality condition."],.array [.text "description-successor-certificate",.text "description-successor-certificate retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Computability obligation?",.array [.array [.text "hidden-oracle",.text "hidden-oracle removes a required exact addition condition."],.array [.text "no-undeclared-computational-power",.text "no-undeclared-computational-power retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-CBL-UNIVERSAL-MACHINE-001"
  title := "Fold universal-machine execution law"
  branch := "computation"
  statement := "The forced one machine executing encoded machines kernel retains frozen machine grammar; prefix-free exact descriptions; encoded input; interpreter transition kernel; trace correspondence; halt and output preservation; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-CBL-DEGREES-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-CBL-UNIVERSAL-MACHINE-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-CBL-UNIVERSAL-MACHINE-001"),
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
  proofHash := identity (.object [("closure",UniversalMachineControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-CBL-UNIVERSAL-MACHINE-001"),("base",.text "The structural One supplies one canonical one machine executing encoded machines form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated one machine executing encoded machines form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold universal-machine execution law is required to derive one machine executing encoded machines without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: frozen machine grammar; prefix-free exact descriptions; encoded input; interpreter transition kernel; trace correspondence; halt and output preservation."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "Extends Formal Universality into recognizability boundaries but not an omniscient halting oracle."

def correspondenceTerms : List String := ["universal machine","interpreter"]

end SFT.Computation.UniversalMachineEvidence
