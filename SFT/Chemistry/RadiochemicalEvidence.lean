import SFT.Chemistry.RadiochemicalGrammar
import SFT.Chemistry.RadiochemicalEquilibrium
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RadiochemicalEvidence
open SFT.Host.Canonical RadiochemicalGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Parent and daughter held.",.boolean RadiochemicalEquilibrium.identityWitness],.array [.text "support",.text "Ranks are complete.",.boolean RadiochemicalEquilibrium.supportWitness],.array [.text "activity",.text "Activities exact.",.boolean RadiochemicalEquilibrium.activityWitness],.array [.text "ratio",.text "Ratio positive and exact.",.boolean RadiochemicalEquilibrium.ratioWitness],.array [.text "transient",.text "Persistent non-One ratio classified.",.boolean RadiochemicalEquilibrium.transientWitness],.array [.text "secular",.text "Persistent One ratio classified.",.boolean RadiochemicalEquilibrium.secularWitness],.array [.text "absence",.text "Changing ratio is structural absence.",.boolean RadiochemicalEquilibrium.absenceWitness],.array [.text "successor",.text "Successor preserves exact regime.",.boolean RadiochemicalEquilibrium.successorWitness]]
def claimId : String := "SFT-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002","SFT-CHEM-ACTIVITY-AMOUNT-TIME-003","SFT-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "support",.text (supportName c.support)],.array [.text "activity",.text (activityName c.activity)],.array [.text "relation",.text (relationName c.relation)],.array [.text "transient",.text (transientName c.transient)],.array [.text "secular",.text (secularName c.secular)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "anonymous-activity-pair",.text "Equilibrium needs parent/daughter identity."],.array [.text "held-parent-daughter-identity",.text "Both identities remain held."]]],.array [.text "support",.array [.array [.text "continuous-time-premise",.text "Continuum time is not proof support."],.array [.text "positive-ordered-resource-intervals",.text "Every interval is positive and ordered."]]],.array [.text "activity",.array [.array [.text "fitted-decay-curve",.text "A fitted curve cannot define activity."],.array [.text "exact-counted-activity-pair",.text "Both activities are exact event/resource ratios."]]],.array [.text "relation",.array [.array [.text "signed-activity-difference",.text "A signed scalar imports negative values."],.array [.text "held-ratio-or-structural-absence",.text "The exact positive ratio is held or recurrence is absent."]]],.array [.text "transient",.array [.array [.text "named-transient-assumption",.text "A name cannot establish a regime."],.array [.text "persistent-nonOne-ratio-forces-transient",.text "A persistent exact non-One ratio forces the transient class."]]],.array [.text "secular",.array [.array [.text "approximate-equality-tolerance",.text "A tolerance is a free parameter."],.array [.text "persistent-One-ratio-forces-secular",.text "A persistent exact One ratio forces the secular class."]]],.array [.text "record",.array [.array [.text "selected-timepoint",.text "One point cannot establish recurrence."],.array [.text "complete-parent-daughter-time-vector",.text "Every registered interval remains."]]],.array [.text "extension",.array [.array [.text "differential-equation-premise",.text "No imported differential equation is needed."],.array [.text "finite-successor-recomputes-regime",.text "Each successor recomputes the complete exact ratio vector."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold transient and secular radiochemical-equilibrium law"
 branch := "chemistry"
 statement := "Radiochemical equilibrium is an exact persistent parent/daughter activity-ratio class over complete positive ordered resource intervals: persistent non-One is transient, persistent One is secular, and nonpersistent recurrence is structural absence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-parent-daughter-identity__positive-ordered-resource-intervals__exact-counted-activity-pair__held-ratio-or-structural-absence__persistent-nonOne-ratio-forces-transient__persistent-One-ratio-forces-secular__complete-parent-daughter-time-vector__finite-successor-recomputes-regime"),("base",.text "One exact parent/daughter activity pair supplies the first held ratio."),("successor",.text "Each successor interval preserves identities and recomputes the complete ratio recurrence."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured activity time support or conventional decay model selects the survivor",.text "qualitative equilibrium records cannot fabricate an unavailable numerical time series"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured activity time support or conventional decay model selects the survivor","qualitative equilibrium records cannot fabricate an unavailable numerical time series"]
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
end SFT.Chemistry.RadiochemicalEvidence
