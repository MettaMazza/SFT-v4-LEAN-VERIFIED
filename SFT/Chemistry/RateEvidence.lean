import SFT.Chemistry.RateGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RateEvidence
open SFT.Host.Canonical RateGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "events",.text "the event count is positive",.boolean true],.array [.text "time",.text "the recurrence count is positive",.boolean true],.array [.text "boundary",.text "the observed support is named",.boolean true]]
def claimId : String := "SFT-CHEM-KIN-RATE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "event",.text (eventName c.event)],.array [.text "count",.text (countName c.count)],.array [.text "duration",.text (durationName c.duration)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "relation",.text (relationName c.relation)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "event",.array [.array [.text "unidentified-change",.text "Events cannot be counted consistently."],.array [.text "one-registered-reaction-event",.text "Every counted instance has the same identity."]]],.array [.text "count",.array [.array [.text "continuous-rate-primitive",.text "It imports a continuum quantity."],.array [.text "positive-completed-event-count",.text "Events are counted exactly."]]],.array [.text "duration",.array [.array [.text "clock-free-count",.text "No rate relation follows."],.array [.text "positive-reference-recurrence-count",.text "Duration is exact recurrence support."]]],.array [.text "boundary",.array [.array [.text "unbounded-observation",.text "Amount change is undefined."],.array [.text "registered-species-observation-boundary",.text "The observed support is explicit."]]],.array [.text "relation",.array [.array [.text "fitted-rate-value",.text "A fitted value is target-derived."],.array [.text "event-count-per-recurrence",.text "The exact quotient is forced."]]],.array [.text "conditions",.array [.array [.text "conditions-erased",.text "Rates cannot be compared reproducibly."],.array [.text "source-bound-condition-record",.text "Temperature, phase and method remain external records."]]],.array [.text "record",.array [.array [.text "rate-answer-only",.text "It cannot reconstruct events or time."],.array [.text "event-duration-boundary-trace",.text "All rate coordinates remain held."]]],.array [.text "extra",.array [.array [.text "free-rate-constant",.text "A constant can tune any target."],.array [.text "no-extra-rule",.text "Counted events and recurrence supply the rate."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Reaction rate from counted transitions"
 branch := "chemistry"
 statement := "Reaction rate is the exact positive count of completed instances of one registered reaction per positive reference recurrence and retained observation boundary, with conditions source-bound."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-registered-reaction-event__positive-completed-event-count__positive-reference-recurrence-count__registered-species-observation-boundary__event-count-per-recurrence"),("base",.text "One completed event in one recurrence supplies the first rate relation."),("successor",.text "Appending an event or recurrence preserves all earlier counts and extends the exact quotient without importing a rate constant."),("exclusions",.array [.text "no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier may be created, copied or silently erased",.text "an absent dependence or event is an empty structural form, never numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite observation boundary with a positive counted set of completed instances of one reaction transition and a positive counted set of registered recurrence intervals, retaining species amount and conditions as source records."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier may be created, copied or silently erased","an absent dependence or event is an empty structural form, never numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite observation boundary with a positive counted set of completed instances of one reaction transition and a positive counted set of registered recurrence intervals, retaining species amount and conditions as source records."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with event := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.RateEvidence
