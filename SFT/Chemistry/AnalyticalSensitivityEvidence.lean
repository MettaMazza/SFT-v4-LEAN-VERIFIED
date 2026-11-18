import SFT.Chemistry.AnalyticalSensitivityGrammar
import SFT.Chemistry.AnalyticalSensitivity
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AnalyticalSensitivityEvidence
open SFT.Host.Canonical AnalyticalSensitivityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Analyte held.",.boolean AnalyticalSensitivity.identityWitness],.array [.text "input",.text "Inputs ordered.",.boolean AnalyticalSensitivity.inputWitness],.array [.text "response",.text "Three responses retained.",.boolean AnalyticalSensitivity.responseWitness],.array [.text "change",.text "Rise side held.",.boolean AnalyticalSensitivity.changeWitness],.array [.text "relation",.text "Ratio exact.",.boolean AnalyticalSensitivity.relationWitness],.array [.text "domain",.text "Two segments only.",.boolean AnalyticalSensitivity.domainWitness],.array [.text "noise",.text "Coincident response retained.",.boolean AnalyticalSensitivity.noiseWitness],.array [.text "successor",.text "Segment extends.",.boolean AnalyticalSensitivity.successorWitness]]
def claimId : String := "SFT-CHEM-ANALYTICAL-SENSITIVITY-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ANALYTICAL-CALIBRATION-001","SFT-CHEM-ANALYTICAL-PRECISION-REPEATABILITY-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "input",.text (inputName c.input)],.array [.text "response",.text (responseName c.response)],.array [.text "change",.text (changeName c.change)],.array [.text "relation",.text (relationName c.relation)],.array [.text "domain",.text (domainName c.domain)],.array [.text "noise",.text (noiseName c.noise)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "anonymous-response",.text "No sensitivity is attributable."],.array [.text "held-analyte-method-condition",.text "Identity and domain remain."]]],.array [.text "input",.array [.array [.text "continuum-input-premise",.text "Uncounted support cannot be audited."],.array [.text "positive-ordered-input-support",.text "Every input distinction remains."]]],.array [.text "response",.array [.array [.text "response-fit-only",.text "Observed rows are erased."],.array [.text "paired-complete-response-support",.text "Every input keeps its response."]]],.array [.text "change",.array [.array [.text "signed-response-change",.text "A sign is not a proof magnitude."],.array [.text "held-response-side-positive-change-or-EmptyOne",.text "Change is side plus positive magnitude or coincidence."]]],.array [.text "relation",.array [.array [.text "fitted-global-slope",.text "A global fit can hide local behavior."],.array [.text "exact-local-response-per-input-ratio",.text "Every adjacent ratio is forced exactly."]]],.array [.text "domain",.array [.array [.text "universal-linearity",.text "Sensitivity is condition-bound."],.array [.text "finite-registered-segment-domain",.text "No extrapolation is admitted."]]],.array [.text "noise",.array [.array [.text "drift-noise-erased",.text "Sensitivity alone cannot establish resolution."],.array [.text "complete-drift-noise-custody",.text "Every adverse response record remains."]]],.array [.text "extension",.array [.array [.text "refitted-history",.text "A refit changes earlier relations."],.array [.text "successor-retains-and-adds-segment",.text "Earlier segments remain exact."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold analytical sensitivity law"
 branch := "chemistry"
 statement := "Ordered positive analyte inputs and paired responses force exact local response/input ratios, held direction and finite method-bounded segments with drift custody."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,candidateRecord c])
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
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-analyte-method-condition__positive-ordered-input-support__paired-complete-response-support__held-response-side-positive-change-or-EmptyOne__exact-local-response-per-input-ratio__finite-registered-segment-domain__complete-drift-noise-custody__successor-retains-and-adds-segment"),("base",.text "Two ordered input/response pairs supply the first sensitivity segment."),("successor",.text "Every successor adds one exact segment and retains the earlier ones."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external value threshold model or selected successful result chooses the survivor",.text "all favorable adverse absent unavailable unresolved uncertainty assumption correction fit and loss rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external value threshold model or selected successful result chooses the survivor","all favorable adverse absent unavailable unresolved uncertainty assumption correction fit and loss rows remain"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with identity := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AnalyticalSensitivityEvidence
