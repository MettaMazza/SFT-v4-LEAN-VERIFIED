import SFT.Physics.GeneratorThreeControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.GeneratorThreeEvidence
open SFT.Host.Canonical GeneratorThreeGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "action",.text (actionName c.action)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "binary",.text (binaryName c.binary)],.array [.text "successor",.text (successorName c.successor)],.array [.text "unit",.text (unitName c.unit)],.array [.text "orbit",.text (orbitName c.orbit)],.array [.text "order",.text (orderName c.order)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the generator?"),("choices",.array [.array [.text "borrowed-integer-name",.text "A borrowed numeral has no Fold recurrence trace."],.array [.text "exact-positive-period-trace",.text "A generator is the complete positive transition count of a first return."]])],.object [("key",.text "action"),("question",.text "What advances the part?"),("choices",.array [.array [.text "imported-modular-map",.text "An imported modular operation is not the admitted Fold."],.array [.text "double-and-cast-complete-One",.text "The two Fold fibres pair the part and cast out only a completed whole."]])],.object [("key",.text "recurrence"),("question",.text "What closes a period?"),("choices",.array [.array [.text "repeated-value-without-first-return",.text "A repeated value can hide an earlier return."],.array [.text "complete-first-return-orbit",.text "Every transition is retained through the first return to the source part."]])],.object [("key",.text "binary"),("question",.text "What anchors the first generator?"),("choices",.array [.array [.text "asserted-binary-count",.text "Naming two does not derive its recurrence."],.array [.text "depth-two-unit-part-period",.text "The predecessor of complete depth-two support gives the unit third whose Fold period is exactly two."]])],.object [("key",.text "successor"),("question",.text "Which distinct period follows binary?"),("choices",.array [.array [.text "selected-later-period",.text "A later period is not minimal."],.array [.text "least-distinct-positive-successor",.text "Positive-count succession leaves no count between two and three."]])],.object [("key",.text "unit"),("question",.text "How is the witness part made?"),("choices",.array [.array [.text "target-denominator",.text "A denominator read from an answer is target input."],.array [.text "support-predecessor-unit-part",.text "The denominator is the positive predecessor of complete Fold-word support at the candidate period."]])],.object [("key",.text "orbit"),("question",.text "What evidence is retained?"),("choices",.array [.array [.text "period-label-only",.text "A label cannot reproduce the return."],.array [.text "all-Fold-transitions-held",.text "The orbit one-seventh, two-sevenths, four-sevenths, one-seventh is retained exactly."]])],.object [("key",.text "order"),("question",.text "How is minimality closed?"),("choices",.array [.array [.text "bounded-denominator-search",.text "A denominator bound does not close later candidates."],.array [.text "positive-count-discreteness-plus-existence",.text "The successor of two is three and an exact period-three witness exists."]])],.object [("key",.text "measurement"),("question",.text "May observation select the generator?"),("choices",.array [.array [.text "measurement-selected-period",.text "Measurement-to-derivation flow violates the admitted boundary."],.array [.text "derivation-before-measurement",.text "The generator is sealed before any physical correspondence is opened."]])],.object [("key",.text "extension"),("question",.text "Is another generator rule added?"),("choices",.array [.array [.text "extra-generator-rule",.text "An extra selector is a free parameter."],.array [.text "no-extra-rule",.text "Fold support, positive succession and first return supply the complete construction."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-STRUCT-GENERATOR-THREE-001"
  title := "The second structural Fold generator is three"
  branch := "physics"
  statement := "The exact Fold period spectrum forces its second distinct nonidentity generator to be the positive count three: the binary generator is the first-return period of the unit part whose denominator is the positive predecessor of depth-two Fold support, and the least distinct successor period is witnessed by the corresponding depth-three unit part returning in exactly three Fold transitions."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-FOLD-ASSEMBLY-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-STRUCT-GENERATOR-THREE-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-STRUCT-GENERATOR-THREE-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [GeneratorThreeControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity GeneratorThreeControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.GeneratorThreeEvidence
