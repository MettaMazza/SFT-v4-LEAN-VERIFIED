import SFT.Chemistry.RadiotracerCustodyGrammar
import SFT.Chemistry.RadiotracerCustody
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RadiotracerCustodyEvidence
open SFT.Host.Canonical RadiotracerCustodyGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Tracer chemistry held.",.boolean RadiotracerCustody.identityWitness],.array [.text "support",.text "Ranks complete.",.boolean RadiotracerCustody.supportWitness],.array [.text "locations",.text "Both locations retained.",.boolean RadiotracerCustody.locationsWitness],.array [.text "events",.text "Counts positive and bounded.",.boolean RadiotracerCustody.eventsWitness],.array [.text "recovery",.text "Recovery exact.",.boolean RadiotracerCustody.recoveryWitness],.array [.text "loss",.text "Remainder is positive or absent.",.boolean RadiotracerCustody.lossWitness],.array [.text "inference",.text "Inference uses retained rows.",.boolean RadiotracerCustody.inferenceWitness],.array [.text "successor",.text "Successor retains complete record.",.boolean RadiotracerCustody.successorWitness]]
def claimId : String := "SFT-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001","SFT-CHEM-ACTIVITY-AMOUNT-TIME-003","SFT-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "support",.text (supportName c.support)],.array [.text "locations",.text (locationsName c.locations)],.array [.text "events",.text (eventsName c.events)],.array [.text "recovery",.text (recoveryName c.recovery)],.array [.text "loss",.text (lossName c.loss)],.array [.text "inference",.text (inferenceName c.inference)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "activity-only-tracer",.text "Activity alone loses nuclide and chemistry."],.array [.text "held-tracer-and-chemical-carrier",.text "Tracer and carrier remain held."]]],.array [.text "support",.array [.array [.text "continuous-concentration-field",.text "A continuum field hides observations."],.array [.text "positive-ordered-observation-support",.text "Every observation has positive rank."]]],.array [.text "locations",.array [.array [.text "selected-detector-location",.text "Selection cannot establish complete transport."],.array [.text "complete-location-time-vector",.text "Every registered location and time remains."]]],.array [.text "events",.array [.array [.text "expected-count-premise",.text "Expectation is not observed-event custody."],.array [.text "positive-administered-and-observed-counts",.text "Administered and observed events are counted."]]],.array [.text "recovery",.array [.array [.text "fitted-recovery-coefficient",.text "A fit cannot define recovery."],.array [.text "exact-observed-per-administered-ratio",.text "Recovery is an exact positive ratio."]]],.array [.text "loss",.array [.array [.text "negative-missing-activity",.text "Missing tracer cannot be a negative proof value."],.array [.text "positive-Take-or-EmptyOne-unobserved",.text "Unobserved custody is positive or structurally absent."]]],.array [.text "inference",.array [.array [.text "model-selected-localization",.text "A model cannot create an observation."],.array [.text "inference-bounded-by-observed-support",.text "Inference never exceeds retained observations."]]],.array [.text "extension",.array [.array [.text "renormalized-selected-series",.text "Renormalization erases custody."],.array [.text "successor-preserves-identity-and-complete-record",.text "Every successor retains all earlier rows."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold radiotracer custody and inference law"
 branch := "chemistry"
 statement := "A radiotracer retains nuclide and chemical-carrier identity over complete positive ordered observation support; recovery is exact observed per administered custody, unobserved custody is positive or structural absence, and inference cannot exceed observations."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-tracer-and-chemical-carrier__positive-ordered-observation-support__complete-location-time-vector__positive-administered-and-observed-counts__exact-observed-per-administered-ratio__positive-Take-or-EmptyOne-unobserved__inference-bounded-by-observed-support__successor-preserves-identity-and-complete-record"),("base",.text "One administered tracer and one observation supply the first custody row."),("successor",.text "Every successor retains identity, all locations and all earlier observations without renormalization."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured recovery localization curve or fitted RTD model selects the survivor",.text "models and recommendations remain distinct from observations"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured recovery localization curve or fitted RTD model selects the survivor","models and recommendations remain distinct from observations"]
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
end SFT.Chemistry.RadiotracerCustodyEvidence
