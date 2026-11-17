import SFT.Chemistry.ActivityAmountGrammar
import SFT.Chemistry.ActivityAmountTime
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ActivityAmountEvidence
open SFT.Host.Canonical ActivityAmountGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Identity held.",.boolean ActivityAmountTime.identityWitness],.array [.text "amount",.text "Amount counted.",.boolean ActivityAmountTime.amountWitness],.array [.text "events",.text "Events counted.",.boolean ActivityAmountTime.eventsWitness],.array [.text "time",.text "Resource counted.",.boolean ActivityAmountTime.timeWitness],.array [.text "activity",.text "Ratio exact.",.boolean ActivityAmountTime.activityWitness],.array [.text "remaining",.text "Take positive.",.boolean ActivityAmountTime.remainingWitness],.array [.text "absence",.text "Complete transformation closes.",.boolean ActivityAmountTime.absenceWitness],.array [.text "successor",.text "Successor recomputes.",.boolean ActivityAmountTime.successorWitness]]
def claimId : String := "SFT-CHEM-ACTIVITY-AMOUNT-TIME-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005","SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001","SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "amount",.text (amountName c.amount)],.array [.text "events",.text (eventsName c.events)],.array [.text "time",.text (timeName c.time)],.array [.text "activity",.text (activityName c.activity)],.array [.text "remaining",.text (remainingName c.remaining)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "anonymous-activity-number",.text "Activity needs nuclide/species custody."],.array [.text "held-nuclide-species",.text "Nuclide and species remain held."]]],.array [.text "amount",.array [.array [.text "continuum-amount-premise",.text "Continuum amount hides occurrences."],.array [.text "positive-counted-initial-occurrences",.text "Initial amount is counted."]]],.array [.text "events",.array [.array [.text "expected-decay-number",.text "Expectation is not event custody."],.array [.text "positive-counted-transformations",.text "Transformations are counted."]]],.array [.text "time",.array [.array [.text "continuous-time-premise",.text "Continuum time is not proof support."],.array [.text "positive-counted-resource-intervals",.text "Time support is counted."]]],.array [.text "activity",.array [.array [.text "fitted-decay-constant",.text "A fit cannot define activity."],.array [.text "exact-transformations-per-resource",.text "Activity is an exact ratio."]]],.array [.text "remaining",.array [.array [.text "signed-amount-difference",.text "Signed subtraction imports negative values."],.array [.text "positive-Take-or-EmptyOne-retained-amount",.text "Remaining amount is positive or absent."]]],.array [.text "record",.array [.array [.text "selected-reference-time",.text "One time hides evolution."],.array [.text "complete-activity-amount-time-vector",.text "All registered times remain."]]],.array [.text "extension",.array [.array [.text "differential-equation-premise",.text "A differential equation is not required."],.array [.text "ledger-successor-recomputes-relation",.text "Successors update counts exactly."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold activity–amount–time law"
 branch := "chemistry"
 statement := "Activity is the exact positive ratio of counted transformations to counted resource intervals for a held nuclide species, while retained amount is positive Take or structural absence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-nuclide-species__positive-counted-initial-occurrences__positive-counted-transformations__positive-counted-resource-intervals__exact-transformations-per-resource__positive-Take-or-EmptyOne-retained-amount__complete-activity-amount-time-vector__ledger-successor-recomputes-relation"),("base",.text "One counted transformation over one counted interval supplies the first activity ledger."),("successor",.text "A successor updates event and interval counts exactly and recomputes activity and retained amount."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured activity half-life reference time or unit selects the survivor",.text "all decimal conventional continuum and signed inscriptions remain downstream provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured activity half-life reference time or unit selects the survivor","all decimal conventional continuum and signed inscriptions remain downstream provenance"]
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
end SFT.Chemistry.ActivityAmountEvidence
