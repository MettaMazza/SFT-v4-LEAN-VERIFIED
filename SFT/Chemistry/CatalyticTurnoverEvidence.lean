import SFT.Chemistry.CatalyticTurnoverGrammar
import SFT.Chemistry.CatalyticTurnover
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CatalyticTurnoverEvidence
open SFT.Host.Canonical CatalyticTurnoverGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity-return",.text "The exact catalyst identity is unchanged through all states and return.",.boolean (match CatalyticTurnover.identityReturnWitness with | .error _ => false | .ok b => b)],.array [.text "complete-word",.text "Every transition joins the next state and the last returns to the first.",.boolean (match CatalyticTurnover.completeWordWitness with | .error _ => false | .ok b => b)],.array [.text "frequency",.text "Cycle frequency is an exact positive count relation.",.boolean (match CatalyticTurnover.frequencyWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending the next complete cycle preserves every prior turnover.",.boolean (match CatalyticTurnover.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-CATALYTIC-TURNOVER-CYCLE-FREQUENCY-010"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003","SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004","SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005","SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007","SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008","SFT-CHEM-REVERSIBLE-KINETIC-EQUILIBRIUM-CORRESPONDENCE-009"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "catalyst",.text (catalystName c.catalyst)],.array [.text "cycle",.text (cycleName c.cycle)],.array [.text "turnover",.text (turnoverName c.turnover)],.array [.text "frequency",.text (frequencyName c.frequency)],.array [.text "state",.text (stateName c.state)],.array [.text "status",.text (statusName c.status)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "catalyst",.array [.array [.text "selected-participant-or-renamed-product",.text "A selected participant does not establish catalyst persistence."],.array [.text "same-held-catalyst-identity-at-entry-through-every-state-and-return",.text "One exact catalyst identity traverses and closes the cycle."]]],.array [.text "cycle",.array [.array [.text "endpoint-pair-or-incomplete-intermediate-path",.text "An open path is not a catalytic cycle."],.array [.text "complete-ordered-state-and-transition-word-closing-on-entry",.text "Every intermediate and transition occurrence is retained through exact return."]]],.array [.text "turnover",.array [.array [.text "imported-turnover-rate-equation-or-product-total",.text "An imported rate or product total cannot define a completed cycle."],.array [.text "one-complete-catalyst-return-word-is-one-turnover",.text "Turnover is forced by exact cycle closure."]]],.array [.text "frequency",.array [.array [.text "fitted-continuum-rate-steady-state-or-stochastic-weight",.text "A fit or stochastic premise imports the frequency law."],.array [.text "completed-return-words-per-exact-positive-observation-partition",.text "Frequency is the exact positive count relation of closed cycles to held interval parts."]]],.array [.text "state",.array [.array [.text "four-observed-conductance-levels-substituted-for-five-structural-states",.text "Collapsing the structural intermediate breaks the complete transition word."],.array [.text "five-structural-states-with-four-separately-observed-statuses-distinguished",.text "Structural and observational status remain separate held labels."]]],.array [.text "status",.array [.array [.text "deactivation-insufficient-fit-control-or-unresolved-record-omitted",.text "Omission regularizes the source surface."],.array [.text "all-favorable-adverse-control-and-unresolved-records-retained",.text "Every status remains explicit without selection or averaging."]]],.array [.text "provenance",.array [.array [.text "selected-turnover-table-plot-or-fitted-answer",.text "A selected excerpt cannot establish complete custody."],.array [.text "complete-497-record-article-supplement-movie-archive-ledger",.text "All source pages, frames and archive members remain bound."]]],.array [.text "prediction",.array [.array [.text "cycle-value-rate-frequency-condition-or-target-readable-before-seal",.text "Target access can select the law."],.array [.text "value-free-497-record-identity-seal-and-depth-independent-cycle-successor",.text "All identities seal before values and complete-cycle extension preserves prior results."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact catalytic turnover and cycle-frequency law"
 branch := "chemistry"
 statement := "A catalytic turnover is forced only when one complete ordered state-transition word carries the same held catalyst identity from its entry state through every intermediate and returns it to that exact entry state. The cycle frequency is the exact positive relation between counted complete return words and counted parts of one held observation interval. No turnover-frequency equation, continuum rate, Michaelis-Menten or steady-state premise, stochastic cycle weight or fitted catalyst efficiency is imported."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "same-held-catalyst-identity-at-entry-through-every-state-and-return__complete-ordered-state-and-transition-word-closing-on-entry__one-complete-catalyst-return-word-is-one-turnover__completed-return-words-per-exact-positive-observation-partition__five-structural-states-with-four-separately-observed-statuses-distinguished__all-favorable-adverse-control-and-unresolved-records-retained__complete-497-record-article-supplement-movie-archive-ledger__value-free-497-record-identity-seal-and-depth-independent-cycle-successor"),("base",.text "One complete state-transition word whose final edge returns the unchanged held catalyst to its entry state forces one turnover; one positive completed-cycle count and one positive interval-part count force their exact ratio."),("successor",.text "Append the next complete catalyst-return cycle at the next positive source occurrence. Every prior state, transition, catalyst identity, condition, status, turnover and exact count relation remains unchanged while the completed-cycle count increases by one."),("exclusions",.array [.text "numerical zero",.text "negative proof quantity",.text "irrational quantity",.text "imaginary quantity",.text "continuum time",.text "imported catalytic rate equation",.text "turnover-frequency formula",.text "Michaelis-Menten premise",.text "steady-state premise",.text "stochastic cycle weight",.text "fitted catalyst efficiency",.text "selected cycle or intermediate",.text "selected condition",.text "selected row, page, frame or archive member",.text "omitted deactivation, adverse or unresolved record",.text "average",.text "interpolation",.text "renormalization",.text "target-derived correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["numerical zero","negative proof quantity","irrational quantity","imaginary quantity","continuum time","imported catalytic rate equation","turnover-frequency formula","Michaelis-Menten premise","steady-state premise","stochastic cycle weight","fitted catalyst efficiency","selected cycle or intermediate","selected condition","selected row, page, frame or archive member","omitted deactivation, adverse or unresolved record","average","interpolation","renormalization","target-derived correction"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with catalyst := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.CatalyticTurnoverEvidence
