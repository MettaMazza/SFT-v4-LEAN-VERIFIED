import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Foundation.AdmissionEvidence
open SFT.Host.Canonical AdmissionGrammar

def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generator",.text generationRule),("boundary",.text grammarBoundary),("domains",.array [.array [.text "registration-incomplete",.text "registration-root-bound"],.array [.text "axiom-or-parameter-present",.text "no-axiom-zero-parameter"],.array [.text "census-selected",.text "census-complete"],.array [.text "survivor-not-unique",.text "survivor-unique"],.array [.text "form-open",.text "form-closed"],.array [.text "controls-incomplete",.text "controls-complete"],.array [.text "validation-self-only",.text "validation-independent"],.array [.text "measurement-before-seal",.text "measurement-after-seal-when-required"],.array [.text "failure-discarded",.text "every-receipt-preserved"],.array [.text "dependency-before-admission",.text "dependency-after-model-admission"],.array [.text "no-extra",.text "has-extra"]]),("candidates",.array (candidates.map candidateRecord)),("gate_order",.array [.text "registration",.text "enumeration",.text "forcing",.text "form closure",.text "controls",.text "seal",.text "independent validation",.text "post-seal empirical validation when registered",.text "model admission",.text "immutable receipt"])]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-FOUNDATION-ADMISSION-ENFORCEMENT-001"
 title := "Single fail-closed SFT admission law"
 branch := "foundation"
 statement := "The unique admissible route from a proposed law to model authority is root- and source-bound, axiom-free and zero-parameter; it completely enumerates its declared candidate grammar, leaves one survivor, closes its form, passes all adverse controls and implementation-distinct validation, opens measurements only after sealing when empirical, preserves every disposition receipt, and permits dependency use only after model admission."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-FOUNDATION-DERIVATION-TRACE-001"]
 axioms := []
 freeParameters := []
 provenance := [.constitutionalRelation]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := AdmissionControls.admissionIdentity (.object [("generator",.text generationRule),("record",candidateRecord c)])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := AdmissionControls.admissionIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := AdmissionControls.admissionIdentity (.object [("record",candidateRecord c),("survives",.boolean (survives c)),
    ("reason",.text (decisionReason c))])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error (SFT.Host.Text.append "KeyError: " candidate.candidateId)

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := AdmissionControls.admissionIdentity (.object [("closure",AdmissionControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (AdmissionControls.admissionIdentity (.object [("branch_and_host_independent_gate_relation",.boolean true),("closure",AdmissionControls.closureValue)]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Foundation.AdmissionEvidence
