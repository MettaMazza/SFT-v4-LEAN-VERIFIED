import SFT.InformationScience.ChannelControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.ChannelEvidence
open SFT.Host.Canonical ChannelGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "inputs",.text (inputsName c.inputs)],.array [.text "outputs",.text (outputsName c.outputs)],.array [.text "relation",.text (relationName c.relation)],.array [.text "totality",.text (totalityName c.totality)],.array [.text "confusability",.text (confusabilityName c.confusability)],.array [.text "codes",.text (codesName c.codes)],.array [.text "capacity",.text (capacityName c.capacity)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "inputs"),("question",.text "What fixes channel inputs?"),("choices",.array [.array [.text "partial-input-carrier",.text "An omitted input changes possible messages and capacity."],.array [.text "complete-canonical-inputs",.text "Every registered input occurs once."]])],.object [("key",.text "outputs"),("question",.text "What fixes channel outputs?"),("choices",.array [.array [.text "partial-output-carrier",.text "An omitted output hides a possible transport image."],.array [.text "complete-canonical-outputs",.text "Every registered output occurs once."]])],.object [("key",.text "relation"),("question",.text "What fixes transport?"),("choices",.array [.array [.text "opaque-channel-box",.text "An opaque box hides source-to-output alternatives."],.array [.text "held-transport-relation",.text "Every possible source/output pair is retained."]])],.object [("key",.text "totality"),("question",.text "What ensures every input can pass?"),("choices",.array [.array [.text "missing-input-row",.text "An input without an output is outside the claimed channel action."],.array [.text "nonempty-output-support-per-input",.text "Every input has at least one retained image."]])],.object [("key",.text "confusability"),("question",.text "When can inputs be confused?"),("choices",.array [.array [.text "probability-threshold",.text "A threshold imports a distribution and free scale."],.array [.text "overlapping-output-support",.text "Confusability is exact shared output membership."]])],.object [("key",.text "codes"),("question",.text "What makes a zero-error code?"),("choices",.array [.array [.text "sampled-input-set",.text "Sampling cannot establish every pair separated."],.array [.text "pairwise-disjoint-output-selection",.text "Every selected input pair has disjoint output support."]])],.object [("key",.text "capacity"),("question",.text "What fixes channel capacity?"),("choices",.array [.array [.text "logarithmic-rate",.text "A real logarithmic rate imports scale and asymptotic assumptions."],.array [.text "complete-greatest-code-family",.text "Every input selection is generated and all maximum distinguishable ties survive."]])],.object [("key",.text "composition"),("question",.text "How do channels compose?"),("choices",.array [.array [.text "endpoint-guess",.text "Endpoints alone omit the shared interface path."],.array [.text "exact-relational-paths",.text "Every source-to-middle and middle-to-target path generates one composite cell."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite carriers?"),("choices",.array [.array [.text "sampled-channels",.text "Examples do not establish a fresh input relation."],.array [.text "carrier-successor",.text "A fresh input adds its complete output support and all new confusability pairs."]])],.object [("key",.text "addition"),("question",.text "Is another channel model added?"),("choices",.array [.array [.text "extra-transition-probability",.text "A probability law is not supplied by the transport relation."],.array [.text "no-extra-channel-model",.text "Capacity follows only from exact relation and distinguishability."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-CHANNEL-CAPACITY-001"
  title := "Exact finite channels, confusability and capacity"
  branch := "information_science"
  statement := "An admitted channel is a complete canonical input carrier, complete output carrier and held source-bound transport relation giving every input at least one output. Inputs are confusable exactly when their output supports overlap. A zero-error code is a held input selection with pairwise disjoint output supports. Exact channel capacity is the complete family of greatest-cardinality distinguishable codes, with all ties retained; composition is relational path composition at an equal interface."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-CHANNEL-CAPACITY-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-CHANNEL-CAPACITY-001"),
    ("dependencies",.array [.text "SFT-MATH-GRAPH-NETWORK-001",.text "SFT-MATH-COMBINATORICS-001",.text "SFT-MATH-OPTIMIZATION-001",.text "SFT-INFO-ENCODING-DECODING-001",.text "SFT-INFO-QUANTITY-001"]),
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
  proofHash := identity (.object [("closure",ChannelControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-CHANNEL-CAPACITY-001"),
    ("base",.text "One input with one nonempty output support forms a one-member distinguishable code family."),
    ("successor",.text "Adding one fresh input adds its exact output support and one confusability decision with every prior input. Every prior code either extends by the fresh input when all supports are disjoint or remains unchanged."),
    ("laws",.array (ChannelControls.laws.map Value.text)),
    ("witnesses",.array (ChannelWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Capacity must follow from which source distinctions a channel can preserve, not from a borrowed probabilistic rate formula. Complete finite transport and confusability make that boundary exact."

def derivation : String := "Graphs supply relations and paths; encoding supplies messages and codewords; combinatorics exhausts selections; optimization retains all greatest codes; information quantity supplies exact distinction meaning. Ten axes force the finite zero-error channel and capacity family."

def check : String := "Execute all 1,024 channel kernels, compare clean and merged channels, retain tied capacities, test a false code and exact composition, run adverse controls and independently regenerate the census."

def limitations : String := "This theorem closes finite zero-error structural capacity. Probabilistic error rates and asymptotic coding theorems require separately generated finite evidence and cannot be imported here."

def correspondenceTerms : List String := ["communication channel","confusability graph","zero-error code","channel capacity","channel composition"]

end SFT.InformationScience.ChannelEvidence
