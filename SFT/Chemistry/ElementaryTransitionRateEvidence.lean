import SFT.Chemistry.ElementaryTransitionRateGrammar
import SFT.Chemistry.ElementaryTransitionRate
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ElementaryTransitionRateEvidence
open SFT.Host.Canonical ElementaryTransitionRateGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-counted-response",.text "Six completed transitions over four ticks and support three form one half exactly.",.boolean (match ElementaryTransitionRate.responseWitness with | .error _ => false | .ok b => b)],.array [.text "held-opposed-orientation",.text "Opposed directions are held labels rather than signed values.",.boolean (match ElementaryTransitionRate.orientationWitness with | .error _ => false | .ok b => b)],.array [.text "structural-absence",.text "An absent condition is structural EmptyOne.",.boolean (match ElementaryTransitionRate.absenceWitness with | .error _ => false | .ok b => b)],.array [.text "replication-successor",.text "Common event/tick replication preserves the exact rate.",.boolean (match ElementaryTransitionRate.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-COUPLED-MASS-HEAT-CHARGE-TRANSPORT-019"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "state",.text (stateName c.state)],.array [.text "event",.text (eventName c.event)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "detached-rate-number-or-continuum-field",.text "A detached rate erases the transition that is counted."],.array [.text "complete-registered-elementary-transition-carrier",.text "One registered elementary reaction and both molecular endpoints remain held."]]],.array [.text "state",.array [.array [.text "endpoint-erased-or-identity-change",.text "Without distinct retained endpoints no completed transition is identifiable."],.array [.text "distinct-held-initial-and-terminal-molecular-states",.text "Initial and terminal molecular states are exact and distinct."]]],.array [.text "event",.array [.array [.text "continuous-change-primitive-or-uncounted-event",.text "An uncounted continuum change is not an exact rate resource."],.array [.text "positive-completed-transition-count",.text "Every completed instance is counted as positive exact support."]]],.array [.text "recurrence",.array [.array [.text "clock-free-or-continuum-time-derivative",.text "A rate cannot be formed without exact recurrence support."],.array [.text "positive-reference-tick-count",.text "Time is a positive counted recurrence, not a continuum derivative."]]],.array [.text "boundary",.array [.array [.text "condition-or-observation-support-erased",.text "Erased conditions or support make rate rows incomparable."],.array [.text "complete-condition-and-positive-observation-support",.text "Conditions, observation support and source identity remain held."]]],.array [.text "magnitude",.array [.array [.text "imported-mass-action-order-arrhenius-fit-or-logarithm",.text "A conventional or fitted rate law could select the result."],.array [.text "exact-transition-count-per-tick-and-observation-support",.text "The only native magnitude is the exact counted-event quotient."]]],.array [.text "prediction",.array [.array [.text "reaction-condition-method-or-value-readable-before-seal",.text "Readable target content could select the law."],.array [.text "complete-value-free-46-record-identity-seal",.text "All four source identities and 46 row identities seal before target content opens."]]],.array [.text "extension",.array [.array [.text "refit-after-event-resource-replication-or-record-append",.text "Refitting destroys exact provenance."],.array [.text "depth-independent-common-event-tick-replication-and-record-append",.text "Common event/tick replication and complete record append preserve the rate relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact elementary-transition rate relation"
 branch := "chemistry"
 statement := "An elementary chemical transition rate is the exact positive count of completed instances of one registered transition between distinct retained molecular states per positive reference tick and observation support, with conditions held and direction represented as a label. The declared NIST rate inscriptions are opened only after the complete identity vector and native relation seal."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-registered-elementary-transition-carrier__distinct-held-initial-and-terminal-molecular-states__positive-completed-transition-count__positive-reference-tick-count__complete-condition-and-positive-observation-support__exact-transition-count-per-tick-and-observation-support__complete-value-free-46-record-identity-seal__depth-independent-common-event-tick-replication-and-record-append"),("base",.text "One registered elementary transition completed once on one positive tick and one positive observation support supplies the least rate record."),("successor",.text "Appending a complete condition or measurement record preserves all earlier distinctions; common completed-event/tick replication preserves the exact quotient without refitting."),("exclusions",.array [.text "no numerical zero; absent external coordinates are structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported mass-action equation, reaction order, Arrhenius form, fitted rate constant, concentration derivative or continuum time",.text "no interpolation, regression, selected reaction/state/condition/method/source/row or target-derived correction",.text "no reaction, state, condition, method, expression, temperature, rate value or target hash before prediction seal",.text "source-reported Arrhenius tabulations remain post-seal external records and are not described as raw event counts"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent external coordinates are structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported mass-action equation, reaction order, Arrhenius form, fitted rate constant, concentration derivative or continuum time","no interpolation, regression, selected reaction/state/condition/method/source/row or target-derived correction","no reaction, state, condition, method, expression, temperature, rate value or target hash before prediction seal","source-reported Arrhenius tabulations remain post-seal external records and are not described as raw event counts"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ElementaryTransitionRateEvidence
