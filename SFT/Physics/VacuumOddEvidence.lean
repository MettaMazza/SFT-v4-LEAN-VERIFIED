import SFT.Physics.VacuumOddControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.VacuumOddEvidence
open SFT.Host.Canonical VacuumOddGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "dependency",.text (dependencyName c.dependency)],.array [.text "relation",.text (relationName c.relation)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the result?"),("choices",.array [.array [.text "borrowed-vacuum-number",.text "A borrowed vacuum number has no Fold trace."],.array [.text "generated-exact-Fold-carrier",.text "Every carrier is regenerated from admitted exact Fold support."]])],.object [("key",.text "dependency"),("question",.text "How are dependencies obtained?"),("choices",.array [.array [.text "asserted-prior-answer",.text "An asserted prior answer is an unregistered premise."],.array [.text "admitted-V3-dependency-trace",.text "Every dependency reaches the premise-free root theorem through admitted V3 claims."]])],.object [("key",.text "relation"),("question",.text "Which relation is retained?"),("choices",.array [.array [.text "dead-ground-or-finite-prefix-only",.text "The alternative loses a required carrier or imports an extra law."],.array [.text "odd-denominator-first-return-without-empty-state",.text "Odd support shares no binary factor, and finite exact residues force a return before any repeated non-source state can persist."]])],.object [("key",.text "enumeration"),("question",.text "Are alternatives complete?"),("choices",.array [.array [.text "selected-candidate-neighbourhood",.text "A selected neighbourhood cannot establish uniqueness."],.array [.text "complete-registered-product",.text "Every choice occurs with every choice on all other axes."]])],.object [("key",.text "minimality"),("question",.text "Are predecessor forms controlled?"),("choices",.array [.array [.text "survivor-without-lower-controls",.text "A bare survivor does not prove the required carriers are minimal."],.array [.text "all-omitted-carrier-forms-rejected",.text "Each omitted carrier has a named constructive failure."]])],.object [("key",.text "measurement"),("question",.text "May observation choose the law?"),("choices",.array [.array [.text "target-visible-before-seal",.text "Target access before sealing reverses the scientific direction."],.array [.text "exact-result-sealed-before-comparison",.text "The fraction, census and trace seal before external comparison."]])],.object [("key",.text "record"),("question",.text "What evidence is retained?"),("choices",.array [.array [.text "answer-only-record",.text "An answer alone cannot reproduce the source and transfer ledger."],.array [.text "complete-source-transfer-control-record",.text "Source, transfer, reservoir, controls and complete census remain held."]])],.object [("key",.text "extension"),("question",.text "May another selector be added?"),("choices",.array [.array [.text "free-extra-rule",.text "An added selector is a free parameter."],.array [.text "no-extra-rule",.text "The admitted carriers and exact relation exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-VACUUM-ODD-RECURRENCE-003"
  title := "Perpetually live odd-denominator vacuum recurrence"
  branch := "physics"
  statement := "For every generated odd denominator beyond the One, pairing a positive residue with the binary Fold cannot acquire the denominator's factor and therefore cannot reach structural absence. The finite positive residue support forces a first return, so each such vacuum mode remains on an exact live cycle."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003", "SFT-FOUNDATION-FOLD-001", "SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-MATH-DYNAMICAL-SYSTEMS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-VACUUM-ODD-RECURRENCE-003",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-VACUUM-ODD-RECURRENCE-003",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [VacuumOddControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity VacuumOddControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.VacuumOddEvidence
