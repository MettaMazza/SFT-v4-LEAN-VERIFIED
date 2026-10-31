import SFT.Physics.ColourCouplingControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ColourCouplingEvidence
open SFT.Host.Canonical ColourCouplingGrammar

def candidateRecord (c : Candidate) : SFT.Host.Canonical.Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "numerator",.text (numeratorName c.numerator)],.array [.text "denominator",.text (denominatorName c.denominator)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "normalization",.text (normalizationName c.normalization)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : SFT.Host.Canonical.Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "Which interaction carrier is used?"),("choices",.array [.array [.text "free-colour-count",.text "A free carrier count is a parameter."],.array [.text "generator-three-carrier",.text "The independent generator-three law supplies the complete carrier."]])],.object [("key",.text "numerator"),("question",.text "What support participates?"),("choices",.array [.array [.text "selected-single-label",.text "One label omits half the Fold distinction."],.array [.text "both-Fold-labels",.text "The complete Fold distinction has two held labels."]])],.object [("key",.text "denominator"),("question",.text "What normalizes the support?"),("choices",.array [.array [.text "external-normalization",.text "External normalization is fitted."],.array [.text "complete-generator-support",.text "Every carrier class is counted once."]])],.object [("key",.text "orientation"),("question",.text "Is label orientation retained?"),("choices",.array [.array [.text "labels-collapsed",.text "Collapse loses the interaction distinction."],.array [.text "labels-held-through-carrier",.text "Both labels remain distinguishable through transport."]])],.object [("key",.text "normalization"),("question",.text "Which exact ratio follows?"),("choices",.array [.array [.text "reciprocal-or-unscaled-count",.text "Those forms reverse roles or omit normalization."],.array [.text "two-over-three",.text "Complete participating labels over complete carrier classes is 2/3."]])],.object [("key",.text "target"),("question",.text "May nuclear closures select the ratio?"),("choices",.array [.array [.text "magic-list-visible",.text "A closure list would fit the coupling."],.array [.text "closures-inaccessible-until-seal",.text "The ratio seals before any closure is generated or observed."]])],.object [("key",.text "extension"),("question",.text "May another strength be added?"),("choices",.array [.array [.text "extra-coupling-rule",.text "An added strength is a free parameter."],.array [.text "no-extra-rule",.text "Label and carrier counts exhaust the normalized ratio."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"
  title := "Exact colour-sector Fold coupling"
  branch := "physics"
  statement := "The complete two-label Fold distinction transported over the generator-three carrier forces the exact positive coupling ratio two-thirds, with no measured or fitted interaction strength."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-FOLD-ASSEMBLY-001", "SFT-PHYS-FIELD-INTERACTION-CLASSES-001", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : SFT.Host.Canonical.Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := identity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : SFT.Host.Canonical.Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := identity (.array [.text "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001",.array ((registrationData "").dependencies.map SFT.Host.Canonical.Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : SFT.Host.Canonical.Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.array [ColourCouplingControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity ColourCouplingControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : SFT.Host.Canonical.Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.ColourCouplingEvidence
