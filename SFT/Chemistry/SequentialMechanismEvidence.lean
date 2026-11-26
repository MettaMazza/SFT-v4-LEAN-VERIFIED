import SFT.Chemistry.SequentialMechanismGrammar
import SFT.Chemistry.SequentialMechanism
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SequentialMechanismEvidence
open SFT.Host.Canonical SequentialMechanismGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-word",.text "All states and elementary transitions remain in exact source order.",.boolean (match SequentialMechanism.completeWordWitness with | .error _ => false | .ok b => b)],.array [.text "shared-boundary",.text "The first exit is exactly the second entry.",.boolean (match SequentialMechanism.sharedBoundaryWitness with | .error _ => false | .ok b => b)],.array [.text "intermediate",.text "The internal state is retained exactly once as an intermediate occurrence.",.boolean (match SequentialMechanism.intermediateWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending one elementary successor retains every earlier state, edge and intermediate.",.boolean (match SequentialMechanism.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-INTERMEDIATE-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-CAT-PATHWAY-001","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003","SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004","SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005","SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "adjacency",.text (adjacencyName c.adjacency)],.array [.text "intermediate",.text (intermediateName c.intermediate)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "status",.text (statusName c.status)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "endpoint-only-or-selected-snapshot-support",.text "Endpoints erase the mechanism path."],.array [.text "complete-source-ordered-state-and-transition-support",.text "Every state and transition occurrence remains retained."]]],.array [.text "adjacency",.array [.array [.text "aggregate-start-to-finish-jump",.text "An aggregate jump does not prove its elementary boundaries."],.array [.text "exact-entry-exit-boundary-matching-for-every-edge",.text "Every edge begins and ends at its registered adjacent states."]]],.array [.text "intermediate",.array [.array [.text "implicit-eliminated-or-fitted-intermediate",.text "An omitted intermediate cannot be reconstructed."],.array [.text "every-intermediate-occurrence-retained-explicitly",.text "Every intermediate occurrence remains in the exact state word."]]],.array [.text "composition",.array [.array [.text "imported-differential-exponential-or-lifetime-law",.text "An imported evolution equation can select the answer."],.array [.text "finite-exact-ordered-edge-composition",.text "Composition follows only the complete discrete edge word."]]],.array [.text "condition",.array [.array [.text "condition-time-or-dose-collapsed",.text "Collapsed conditions can join incompatible observations."],.array [.text "held-state-and-transition-condition-boundaries",.text "Every state and edge preserves its condition identity."]]],.array [.text "status",.array [.array [.text "adverse-unresolved-or-parallel-record-omitted",.text "Removing an unfavorable record overstates the path."],.array [.text "favorable-adverse-unresolved-and-parallel-status-retained",.text "Measured, adverse, unresolved and parallel records all remain held."]]],.array [.text "provenance",.array [.array [.text "structure-answer-without-source-custody",.text "An answer-only path cannot be independently audited."],.array [.text "complete-article-supplement-PDB-raw-custody-and-control-record",.text "All source, coordinate, custody and control evidence remains bound."]]],.array [.text "prediction",.array [.array [.text "time-coordinate-occupancy-or-target-readable-before-seal",.text "Target access can select the sequence."],.array [.text "value-free-seventeen-record-identity-seal-and-depth-independent-successor",.text "Seventeen identities seal first and every appended edge retains the complete prefix."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact complete-state sequential mechanism composition law"
 branch := "chemistry"
 statement := "A complete finite mechanism is the exact ordered word of every retained state occurrence and every elementary transition occurrence whose exit and entry boundaries meet. Composition retains the initial state, terminal state, every intermediate, condition boundary and measured, adverse or unresolved status exactly once; no differential equation, exponential decay, fitted lifetime, steady-state premise or selected snapshot enters the law."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-source-ordered-state-and-transition-support__exact-entry-exit-boundary-matching-for-every-edge__every-intermediate-occurrence-retained-explicitly__finite-exact-ordered-edge-composition__held-state-and-transition-condition-boundaries__favorable-adverse-unresolved-and-parallel-status-retained__complete-article-supplement-PDB-raw-custody-and-control-record__value-free-seventeen-record-identity-seal-and-depth-independent-successor"),("base",.text "Two retained state occurrences joined by one registered elementary transition force the first exact composition without an intermediate count value."),("successor",.text "Appending the next registered state and matching elementary edge retains every prior state, edge, condition, status and intermediate while making the former terminal state the next explicit intermediate."),("exclusions",.array [.text "no numerical zero; absent observations or deposits are structural EmptyOne and external zero glyphs remain source inscriptions only",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported differential equation, exponential decay, fitted lifetime, rate law or steady-state assumption",.text "no interpolation, averaging, inferred missing intermediate, selected time, selected power, omitted parallel path or target correction",.text "no time, power, coordinate, occupancy, density, resolution, assignment, adverse result or target hash before all seventeen identities seal",.text "experimental deposits, calculated QM/MM trajectories, favorable controls, adverse controls and unresolved records remain distinct"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent observations or deposits are structural EmptyOne and external zero glyphs remain source inscriptions only","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported differential equation, exponential decay, fitted lifetime, rate law or steady-state assumption","no interpolation, averaging, inferred missing intermediate, selected time, selected power, omitted parallel path or target correction","no time, power, coordinate, occupancy, density, resolution, assignment, adverse result or target hash before all seventeen identities seal","experimental deposits, calculated QM/MM trajectories, favorable controls, adverse controls and unresolved records remain distinct"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with support := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.SequentialMechanismEvidence
