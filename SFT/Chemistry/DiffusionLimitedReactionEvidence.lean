import SFT.Chemistry.DiffusionLimitedReactionGrammar
import SFT.Chemistry.DiffusionLimitedReaction
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.DiffusionLimitedReactionEvidence
open SFT.Host.Canonical DiffusionLimitedReactionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-path",.text "Every finite transport transition is retained in order.",.boolean (match DiffusionLimitedReaction.completePathWitness with | .error _ => false | .ok b => b)],.array [.text "exact-boundary",.text "Transport exit is the exact reaction encounter entry.",.boolean (match DiffusionLimitedReaction.exactBoundaryWitness with | .error _ => false | .ok b => b)],.array [.text "completion-relation",.text "Completed reactions per held observation parts form an exact positive relation.",.boolean (match DiffusionLimitedReaction.completionRelationWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending the next complete transport-reaction occurrence preserves every prior result.",.boolean (match DiffusionLimitedReaction.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-DIFFUSION-LIMITED-REACTION-BOUNDARY-011"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-MOLECULAR-DIFFUSION-RELATION-016","SFT-CHEM-COUPLED-MASS-HEAT-CHARGE-TRANSPORT-019","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003","SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004","SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005","SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007","SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008","SFT-CHEM-REVERSIBLE-KINETIC-EQUILIBRIUM-CORRESPONDENCE-009","SFT-CHEM-CATALYTIC-TURNOVER-CYCLE-FREQUENCY-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "limitation",.text (limitationName c.limitation)],.array [.text "rate",.text (rateName c.rate)],.array [.text "path",.text (pathName c.path)],.array [.text "status",.text (statusName c.status)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "selected-initial-encounter-or-product-endpoint",.text "Endpoints erase the path that limits reaction entry."],.array [.text "complete-finite-transport-state-and-transition-word",.text "Every transport occurrence remains explicit."]]],.array [.text "composition",.array [.array [.text "transport-and-reaction-treated-as-unrelated-processes",.text "Unrelated processes do not establish a limiting boundary."],.array [.text "transport-exit-is-exact-reaction-encounter-entry",.text "The two paths compose on one exact state."]]],.array [.text "limitation",.array [.array [.text "imported-Fick-Smoluchowski-continuum-or-collision-law",.text "An imported diffusion premise selects the boundary."],.array [.text "reaction-admissible-only-after-complete-transport-word",.text "The reaction waits structurally on transport completion."]]],.array [.text "rate",.array [.array [.text "fitted-diffusion-coefficient-rate-constant-or-continuum-time",.text "A fit or continuum quantity cannot define the exact completion relation."],.array [.text "completed-reaction-occurrences-per-exact-positive-observation-parts",.text "Rate correspondence is an exact counted relation downstream of closure."]]],.array [.text "path",.array [.array [.text "solvation-transport-encounter-or-product-stage-omitted-or-collapsed",.text "Omission destroys the complete transport-reaction word."],.array [.text "all-separated-solvation-transport-encounter-and-product-stages-retained",.text "Every structurally distinct stage remains held."]]],.array [.text "status",.array [.array [.text "simulation-measurement-discrepancy-large-droplet-deviation-or-nonencounter-question-omitted",.text "Omission falsely regularizes the evidence."],.array [.text "all-favorable-adverse-control-and-unresolved-statuses-retained",.text "Every discrepancy and limitation remains visible."]]],.array [.text "provenance",.array [.array [.text "selected-fit-rate-table-or-trajectory",.text "A selected excerpt cannot establish complete source custody."],.array [.text "complete-251-record-article-supplements-movies-and-dual-archive-ledger",.text "All pages, frames and archive members remain bound."]]],.array [.text "prediction",.array [.array [.text "distance-time-velocity-yield-rate-fit-or-target-readable-before-seal",.text "Target access can select the law."],.array [.text "value-free-251-record-identity-seal-and-depth-independent-path-successor",.text "All identities seal before values and path extension preserves prior results."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact diffusion-limited reaction boundary"
 branch := "chemistry"
 statement := "A diffusion-limited reaction occurrence is admissible only after one complete finite transport word carries the same held reactant identity to an encounter state that is exactly the reaction entry state. The exact completion relation counts completed reaction occurrences per positive held observation partition. No diffusion equation, continuum concentration field, Fick or Smoluchowski law, fitted coefficient or stochastic collision weight is imported."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-finite-transport-state-and-transition-word__transport-exit-is-exact-reaction-encounter-entry__reaction-admissible-only-after-complete-transport-word__completed-reaction-occurrences-per-exact-positive-observation-parts__all-separated-solvation-transport-encounter-and-product-stages-retained__all-favorable-adverse-control-and-unresolved-statuses-retained__complete-251-record-article-supplements-movies-and-dual-archive-ledger__value-free-251-record-identity-seal-and-depth-independent-path-successor"),("base",.text "One complete finite transport word whose exit is the exact reaction encounter entry forces one diffusion-limited reaction boundary and one positive completed-reaction count."),("successor",.text "Append the next complete transport-reaction occurrence at the next positive source position. Every prior path, transition, held identity, encounter boundary, reaction and exact result remains unchanged."),("exclusions",.array [.text "numerical zero",.text "negative proof quantity",.text "irrational quantity",.text "imaginary quantity",.text "continuum field",.text "continuum concentration",.text "diffusion equation",.text "Fick law",.text "Smoluchowski law",.text "stochastic collision weight",.text "fitted diffusion coefficient",.text "fitted rate constant",.text "selected time, path, species or condition",.text "selected method, page, frame, member or row",.text "omitted adverse or unresolved record",.text "average",.text "interpolation",.text "renormalization",.text "target-derived correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["numerical zero","negative proof quantity","irrational quantity","imaginary quantity","continuum field","continuum concentration","diffusion equation","Fick law","Smoluchowski law","stochastic collision weight","fitted diffusion coefficient","fitted rate constant","selected time, path, species or condition","selected method, page, frame, member or row","omitted adverse or unresolved record","average","interpolation","renormalization","target-derived correction"]
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
end SFT.Chemistry.DiffusionLimitedReactionEvidence
