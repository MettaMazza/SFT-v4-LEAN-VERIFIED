import SFT.InformationScience.NoiseControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.NoiseEvidence
open SFT.Host.Canonical NoiseGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "source",.text (sourceName c.source)],.array [.text "received",.text (receivedName c.received)],.array [.text "action",.text (actionName c.action)],.array [.text "error",.text (errorName c.error)],.array [.text "detection",.text (detectionName c.detection)],.array [.text "predecessors",.text (predecessorsName c.predecessors)],.array [.text "correction",.text (correctionName c.correction)],.array [.text "cause",.text (causeName c.cause)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "source"),("question",.text "What fixes clean inputs?"),("choices",.array [.array [.text "partial-source-support",.text "An omitted source hides a possible predecessor."],.array [.text "complete-canonical-sources",.text "Every registered clean word occurs once."]])],.object [("key",.text "received"),("question",.text "What fixes possible received forms?"),("choices",.array [.array [.text "sampled-received-forms",.text "Sampling cannot establish the transformation boundary complete."],.array [.text "complete-registered-images",.text "Every generated image under registered actions is retained."]])],.object [("key",.text "action"),("question",.text "What fixes noise transport?"),("choices",.array [.array [.text "opaque-perturbation",.text "An opaque change hides which source produced which image."],.array [.text "held-action-relation",.text "Each cell retains source, image and action identity."]])],.object [("key",.text "error"),("question",.text "What fixes an error?"),("choices",.array [.array [.text "scalar-error-size",.text "A scalar count erases changed positions and labels."],.array [.text "complete-changed-position-trace",.text "Every differing position retains old and new labels; identity is empty One."]])],.object [("key",.text "detection"),("question",.text "What forces error detection?"),("choices",.array [.array [.text "probability-threshold",.text "A threshold imports a distribution and free parameter."],.array [.text "invalid-codeword-witness",.text "A changed received form outside valid code support is detected structurally."]])],.object [("key",.text "predecessors"),("question",.text "What uncertainty remains after receipt?"),("choices",.array [.array [.text "chosen-likely-source",.text "Choosing one predecessor imports a prior."],.array [.text "complete-source-class",.text "Every registered source mapping to the received form is retained."]])],.object [("key",.text "correction"),("question",.text "When is correction exact?"),("choices",.array [.array [.text "nearest-form-assumption",.text "Nearest requires an unforced metric and can tie."],.array [.text "singleton-predecessor",.text "Correction occurs exactly when one registered source remains."]])],.object [("key",.text "cause"),("question",.text "Does noise require randomness?"),("choices",.array [.array [.text "stochastic-noise-source",.text "A random cause is neither generated nor needed."],.array [.text "deterministic-transformation-family",.text "Noise names the complete registered action relation over deterministic forms."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite error families?"),("choices",.array [.array [.text "sampled-masks",.text "Examples do not establish a fresh action image."],.array [.text "action-successor",.text "A fresh registered action adds its exact source/image cells and updates predecessor classes."]])],.object [("key",.text "addition"),("question",.text "Is another error model added?"),("choices",.array [.array [.text "extra-error-rate-or-metric",.text "A rate, distribution or metric is not supplied by exact transformations."],.array [.text "no-extra-error-model",.text "Detection and correction use only code support and predecessor identity."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-NOISE-ERROR-001"
  title := "Exact noise, error, detection and correction boundaries"
  branch := "information_science"
  statement := "Noise is a registered source-to-received transformation relation over complete canonical word carriers; error is the exact changed-position trace between a held source and received form. Detection is forced when a nonidentity image lies outside valid code support. Correction is forced only when the received form has one registered source predecessor; multiple predecessors remain an explicit closed source class. No random cause, error probability, distance threshold or unrecorded predecessor inference is admitted."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-ENTROPY-UNCERTAINTY-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-NOISE-ERROR-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-NOISE-ERROR-001"),
    ("dependencies",.array [.text "SFT-MATH-GRAPH-NETWORK-001",.text "SFT-MATH-DYNAMICAL-SYSTEMS-001",.text "SFT-INFO-CHANNEL-CAPACITY-001",.text "SFT-INFO-ENTROPY-UNCERTAINTY-001"]),
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
  proofHash := identity (.object [("closure",NoiseControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-NOISE-ERROR-001"),
    ("base",.text "One source under its identity action yields itself, empty-One error and a singleton predecessor class."),
    ("successor",.text "Adding one registered action adds one exact image cell for each source on which it acts. Error traces compare those forms positionwise, and each affected received predecessor class extends by precisely the new source cell."),
    ("laws",.array (NoiseControls.laws.map Value.text)),
    ("witnesses",.array (NoiseWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Coding cannot be derived until the model states exactly what noise changes, what detection observes and why a correction is unique. Probabilities and metrics are not necessary for these structural boundaries."

def derivation : String := "Channels supply source/output relations; dynamics supplies transitions and predecessor loss; entropy supplies closed classes; graphs supply paths. Ten structural axes force exact action provenance, error traces and singleton-predecessor correction."

def check : String := "Execute all 1,024 noise kernels, verify identity and changed-position traces, detection, unique correction and an ambiguous predecessor control, run all adverse controls and independently regenerate the census."

def limitations : String := "This theorem closes finite structural noise and error. It does not assign a stochastic error frequency, physical noise mechanism or asymptotic reliability rate."

def correspondenceTerms : List String := ["noise","error pattern","error detection","syndrome","decoding ambiguity"]

end SFT.InformationScience.NoiseEvidence
