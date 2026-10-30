import SFT.Physics.QuarkChannelsControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.QuarkChannelsEvidence
open SFT.Host.Canonical QuarkChannelsGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "dependency",.text (dependencyName c.dependency)],.array [.text "relation",.text (relationName c.relation)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the law?"),("choices",.array [.array [.text "imported-parameter-table",.text "A table has no Fold provenance."],.array [.text "generated-exact-carrier",.text "The carrier is regenerated from admitted exact support."]])],.object [("key",.text "dependency"),("question",.text "How are prerequisites supplied?"),("choices",.array [.array [.text "prior-answer-premise",.text "A prior result cannot select V3."],.array [.text "admitted-root-trace",.text "Every dependency has an engine path to the theorem."]])],.object [("key",.text "relation"),("question",.text "Which relation survives?"),("choices",.array [.array [.text "asserted-quark-coefficients",.text "The alternative loses a forced count, type or retained distinction."],.array [.text "channel-count-cross-locked-with-Fold-product",.text "Two independent constructions return every invariant."]])],.object [("key",.text "enumeration"),("question",.text "Is the grammar exhausted?"),("choices",.array [.array [.text "selected-subset",.text "A subset cannot establish uniqueness."],.array [.text "complete-product",.text "All registered coordinate combinations are generated."]])],.object [("key",.text "minimality"),("question",.text "Are alternatives controlled?"),("choices",.array [.array [.text "uncontrolled-shortcut",.text "A shortcut may hide a free choice."],.array [.text "every-omission-rejected",.text "Each removed carrier fails constructively."]])],.object [("key",.text "measurement"),("question",.text "When may data enter?"),("choices",.array [.array [.text "target-visible-before-seal",.text "That reverses empirical direction."],.array [.text "seal-before-comparison",.text "The formal object seals before external translation."]])],.object [("key",.text "record"),("question",.text "What is retained?"),("choices",.array [.array [.text "answer-only",.text "An answer cannot reproduce the result."],.array [.text "full-polynomial-trace-census-controls",.text "Counts, equations, rational enclosures, census and hostile controls remain held."]])],.object [("key",.text "extension"),("question",.text "May another selector enter?"),("choices",.array [.array [.text "free-extra-rule",.text "An added selector is a parameter."],.array [.text "no-extra-rule",.text "The declared typed grammar is exhausted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-MATTER-QUARK-INVARIANTS-003"
  title := "Quark channel invariants and cover depths"
  branch := "physics"
  statement := "Complete colour, hand and electroweak channel counts independently cross-lock with exact Fold products, forcing up pair sum 1/12, down pair sum 1/8 and least binary cover depths seven and five."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-MATTER-QUARK-INVARIANTS-003",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-MATTER-QUARK-INVARIANTS-003",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [QuarkChannelsControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity QuarkChannelsControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.QuarkChannelsEvidence
