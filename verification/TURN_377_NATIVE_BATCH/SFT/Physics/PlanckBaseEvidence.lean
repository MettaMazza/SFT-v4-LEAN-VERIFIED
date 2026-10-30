import SFT.Physics.PlanckBaseControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.PlanckBaseEvidence
open SFT.Host.Canonical PlanckBaseGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "dependency",.text (dependencyName c.dependency)],.array [.text "relation",.text (relationName c.relation)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the result?"),("choices",.array [.array [.text "borrowed-physical-label",.text "A borrowed label has no Fold trace."],.array [.text "generated-exact-carrier",.text "The carrier is assembled only from admitted exact Fold objects."]])],.object [("key",.text "dependency"),("question",.text "How are upstream values obtained?"),("choices",.array [.array [.text "asserted-input-values",.text "Asserted values are parameters."],.array [.text "admitted-dependency-trace",.text "Every upstream count or part is recomputed from admitted dependencies."]])],.object [("key",.text "relation"),("question",.text "Which relation is retained?"),("choices",.array [.array [.text "formed-irrational-root-or-fitted-hierarchy",.text "The alternative loses a required distinction or adds an unforced rule."],.array [.text "depth-seven-support-predecessor-at-half-One",.text "The independently counted depth, complete support and positive predecessor force exponent 127/2 and exact square 2^127."]])],.object [("key",.text "enumeration"),("question",.text "Are alternatives complete?"),("choices",.array [.array [.text "selected-neighbourhood",.text "A selected neighbourhood cannot prove uniqueness."],.array [.text "complete-registered-product",.text "Every declared coordinate occurs with every coordinate on every other axis."]])],.object [("key",.text "minimality"),("question",.text "How is minimality checked?"),("choices",.array [.array [.text "survivor-without-predecessor-controls",.text "A survivor alone does not exclude a shorter form."],.array [.text "all-predecessor-forms-rejected",.text "Each predecessor or omitted-coordinate form has a constructive rejection."]])],.object [("key",.text "measurement"),("question",.text "May a measurement choose the law?"),("choices",.array [.array [.text "target-visible-before-seal",.text "Target access reverses empirical direction."],.array [.text "derivation-sealed-before-comparison",.text "The exact result and candidate census seal before observation opens."]])],.object [("key",.text "record"),("question",.text "What evidence is retained?"),("choices",.array [.array [.text "answer-only-record",.text "An answer alone cannot reproduce the derivation."],.array [.text "complete-trace-controls-and-census",.text "The dependency trace, decisions, controls and exact result remain reproducible."]])],.object [("key",.text "extension"),("question",.text "May an extra rule be added?"),("choices",.array [.array [.text "free-extra-rule",.text "An extra selector is a parameter."],.array [.text "no-extra-rule",.text "The registered Fold dependencies exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002"
  title := "Squared proton-to-Planck hierarchy"
  branch := "physics"
  statement := "Generator-three successor volume has least binary cover depth seven. Complete binary support at that depth contains 128 states and its unique positive predecessor contains 127 massive positions. The half-One gravity carrier therefore makes the unsquared exponent 127/2; no irrational root is formed, and the exact forced comparison object is the squared hierarchy 2^127."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [PlanckBaseControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity PlanckBaseControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.PlanckBaseEvidence
