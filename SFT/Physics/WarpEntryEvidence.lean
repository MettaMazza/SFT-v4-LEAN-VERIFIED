import SFT.Foundation.AdmissionControls
import SFT.Physics.WarpEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.WarpEntryEvidence
open SFT.Host.Canonical WarpEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "dependency",.text (dependencyName c.dependency)],.array [.text "relation",.text (relationName c.relation)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the law?"),("choices",.array [.array [.text "imported-spacetime-object",.text "The object has no generated Fold provenance."],.array [.text "generated-exact-Fold-carrier",.text "Every carrier is regenerated from exact admitted support."]])],.object [("key",.text "dependency"),("question",.text "How are prerequisites obtained?"),("choices",.array [.array [.text "asserted-prior-answer",.text "A prior answer is not a V3 premise."],.array [.text "admitted-V3-root-trace",.text "Every dependency has an engine receipt to the root theorem."]])],.object [("key",.text "relation"),("question",.text "Which relation survives?"),("choices",.array [.array [.text "negative-energy-bubble-or-open-work-ledger",.text "The alternative loses conservation, causality or a required record."],.array [.text "positive-conserved-support-redistribution-with-return-ledger",.text "Closed transfer and restoration preserve every source distinction without a forbidden magnitude."]])],.object [("key",.text "enumeration"),("question",.text "Are forms exhausted?"),("choices",.array [.array [.text "selected-neighbourhood",.text "A selected neighbourhood cannot prove uniqueness."],.array [.text "complete-registered-product",.text "Every axis choice occurs with every other choice."]])],.object [("key",.text "minimality"),("question",.text "Are missing carriers controlled?"),("choices",.array [.array [.text "uncontrolled-omission",.text "An omitted carrier may silently choose the answer."],.array [.text "every-omission-rejected",.text "Each required carrier has a constructive omission failure."]])],.object [("key",.text "measurement"),("question",.text "Can observation choose the result?"),("choices",.array [.array [.text "target-visible-before-seal",.text "Target access reverses the empirical direction."],.array [.text "formal-result-sealed-first",.text "External comparison occurs only after the formal seal."]])],.object [("key",.text "record"),("question",.text "What is retained?"),("choices",.array [.array [.text "answer-only",.text "An answer cannot reproduce its causal/source ledger."],.array [.text "complete-causal-source-control-record",.text "Causal paths, sources, exact arithmetic, census and controls remain held."]])],.object [("key",.text "extension"),("question",.text "Can another selector be added?"),("choices",.array [.array [.text "free-extra-rule",.text "An extra selector is a free parameter."],.array [.text "no-extra-rule",.text "The declared grammar closes without another choice."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003"
  title := "Warp-support admissibility boundary"
  branch := "physics"
  statement := "A propagation-support redistribution is admissible only as a positive conserved transfer whose destination carrier equals the source carrier and whose apparatus/source return ledger is complete; negative energy and unrecorded net work are not generated."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [WarpEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity WarpEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.WarpEntryEvidence
