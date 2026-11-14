import SFT.Foundation.AdmissionControls
import SFT.Physics.CoulombControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CoulombEvidence
open SFT.Host.Canonical CoulombGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "dependency",.text (dependencyName c.dependency)],.array [.text "relation",.text (relationName c.relation)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the result?"),("choices",.array [.array [.text "imported-continuum-object",.text "The object lacks a generated Fold support trace."],.array [.text "generated-exact-Fold-carrier",.text "Every carrier is an exact admitted Fold count, part, word or held label."]])],.object [("key",.text "dependency"),("question",.text "How are prerequisites obtained?"),("choices",.array [.array [.text "asserted-prior-result",.text "A prior answer cannot act as a V3 premise."],.array [.text "admitted-V3-dependency-chain",.text "Every dependency has an engine receipt back to the root theorem."]])],.object [("key",.text "relation"),("question",.text "Which relation survives?"),("choices",.array [.array [.text "imported-Coulomb-profile-or-free-exponent",.text "The alternative loses a required conservation or recurrence record."],.array [.text "held-charge-over-rank-two-boundary-with-source-return",.text "Boundary rank two and conservation fix both field dilution and Gauss source reconstruction."]])],.object [("key",.text "enumeration"),("question",.text "Are alternatives exhausted?"),("choices",.array [.array [.text "selected-neighbourhood",.text "A selected candidate neighbourhood cannot prove uniqueness."],.array [.text "complete-registered-product",.text "Every registered axis choice occurs with every other choice."]])],.object [("key",.text "minimality"),("question",.text "Are omissions tested?"),("choices",.array [.array [.text "uncontrolled-omission",.text "A missing carrier could silently select the answer."],.array [.text "every-omission-rejected",.text "Each omitted carrier has a named failure condition."]])],.object [("key",.text "measurement"),("question",.text "Can observation select the law?"),("choices",.array [.array [.text "target-visible-before-seal",.text "Target access would reverse the empirical direction."],.array [.text "formal-result-sealed-first",.text "The exact formal result is sealed before any comparison."]])],.object [("key",.text "record"),("question",.text "What is retained?"),("choices",.array [.array [.text "answer-only",.text "An answer without trace cannot be independently reproduced."],.array [.text "complete-trace-and-controls",.text "The exact trace, census, decisions and hostile controls remain held."]])],.object [("key",.text "extension"),("question",.text "May an extra selector be added?"),("choices",.array [.array [.text "free-extra-rule",.text "An added selector is a free parameter."],.array [.text "no-extra-rule",.text "The registered grammar is exhausted without another choice."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003"
  title := "Charge, Coulomb potential and Gauss closure"
  branch := "physics"
  statement := "A conserved held charge distributed over the forced rank-two boundary yields exact inverse-square response; multiplying by complete boundary growth reconstructs the source at every generated radius."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003", "SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001", "SFT-PHYS-FIELD-INVERSE-SQUARE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := SFT.Foundation.AdmissionControls.admissionIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [CoulombControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity CoulombControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.CoulombEvidence
