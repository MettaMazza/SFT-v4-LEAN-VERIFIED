import SFT.Mathematics.ExactRelationsControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.ExactRelationsEvidence
open SFT.Host.Canonical ExactRelationsGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "relation",.text (relationName c.relation)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "threshold",.text (thresholdName c.threshold)],.array [.text "transport",.text (transportName c.transport)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "provenance"),("question",.text "provenance?"),("choices",.array [.array [.text "borrowed-field",.text "A borrowed field imports the result."],.array [.text "generated-parts",.text "Both terms retain generated part provenance."]])],.object [("key",.text "relation"),("question",.text "relation?"),("choices",.array [.array [.text "rounded-scalar",.text "Rounding destroys exact identity."],.array [.text "exact-ratio",.text "Common refinement forces the positive ratio."]])],.object [("key",.text "orientation"),("question",.text "orientation?"),("choices",.array [.array [.text "signed-gap",.text "Signed magnitude is outside the domain."],.array [.text "held-shorter-gap",.text "A held side records orientation and the shorter positive part records separation."]])],.object [("key",.text "threshold"),("question",.text "threshold?"),("choices",.array [.array [.text "selected-angle",.text "A selected angle adds a parameter."],.array [.text "unique-complement",.text "The m-fold complement is the unique (m less One)-of-m part."]])],.object [("key",.text "transport"),("question",.text "transport?"),("choices",.array [.array [.text "fitted-rate",.text "A fitted rate is not derived."],.array [.text "fold-factor",.text "One Fold transports an uncast local gap by the generated fibre count."]])],.object [("key",.text "composition"),("question",.text "composition?"),("choices",.array [.array [.text "sampled-return",.text "Sampling cannot prove joint return."],.array [.text "least-common-return",.text "The least common multiple is the first shared return."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "fixed-table",.text "A fixed table has no successor certificate."],.array [.text "finite-family-induction",.text "Adding one cycle composes its period by one further least-common return."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "extra-rule",.text "An extra rule violates zero-parameter closure."],.array [.text "no-extra-rule",.text "Only admitted part and cycle operations occur."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-EXACT-RELATIONS-002"
  title := "Exact ratio, separation, reciprocal, threshold and cycle composition"
  branch := "mathematics"
  statement := "Exact generated relations force positive ratios, shorter-part separation, reciprocal return to the One, the unique m-fold holding complement, local Fold separation transport, telescoping relative views, and least-common-return composition for every supplied finite family of exact cycles."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-EXACT-RELATIONS-002"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-EXACT-RELATIONS-002"),
    ("dependencies",.array [.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-DYNAMICAL-SYSTEMS-001"]),
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
  proofHash := identity (.object [("closure",ExactRelationsControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-EXACT-RELATIONS-002"),
    ("base",.text "One exact cycle returns after its own generated period."),
    ("successor",.text "Composing one more positive finite cycle replaces the current joint period by its least common return with the new period."),
    ("laws",.array (ExactRelationsControls.laws.map Value.text)),
    ("witnesses",.array (ExactRelationsWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.ExactRelationsEvidence
