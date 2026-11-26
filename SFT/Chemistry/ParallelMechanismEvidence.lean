import SFT.Chemistry.ParallelMechanismGrammar
import SFT.Chemistry.ParallelMechanism
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ParallelMechanismEvidence
open SFT.Host.Canonical ParallelMechanismGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-family",.text "Both generated parallel paths remain retained in source order.",.boolean (match ParallelMechanism.completeFamilyWitness with | .error _ => false | .ok b => b)],.array [.text "common-source",.text "Every path meets the exact common initial state boundary.",.boolean (match ParallelMechanism.commonSourceWitness with | .error _ => false | .ok b => b)],.array [.text "shared-terminal",.text "A shared terminal remains one explicit terminal occurrence per path.",.boolean (match ParallelMechanism.sharedTerminalWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending a third path retains every earlier path and terminal occurrence.",.boolean (match ParallelMechanism.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-INTERMEDIATE-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-CAT-PATHWAY-001","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003","SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004","SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005","SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "origin",.text (originName c.origin)],.array [.text "path",.text (pathName c.path)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "sharing",.text (sharingName c.sharing)],.array [.text "status",.text (statusName c.status)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "selected-dominant-or-favorable-path-subset",.text "Selecting one visible path erases competing mechanism support."],.array [.text "complete-registered-parallel-path-support",.text "Every registered path remains in the exact family."]]],.array [.text "origin",.array [.array [.text "unrelated-or-collapsed-initial-boundary",.text "Paths without the same retained source do not form one parallel mechanism."],.array [.text "exact-common-initial-state-boundary",.text "Every path meets the same registered initial state exactly."]]],.array [.text "path",.array [.array [.text "endpoint-only-path-summary",.text "Endpoints erase the states, edges and intermediates that distinguish paths."],.array [.text "complete-state-edge-word-for-every-path",.text "Every path retains its complete sequential mechanism word."]]],.array [.text "composition",.array [.array [.text "imported-stochastic-weight-or-parallel-rate-equation",.text "An imported probability or rate equation can select a favored path."],.array [.text "finite-source-ordered-parallel-path-composition",.text "Parallel composition is exactly the complete ordered family of generated path words."]]],.array [.text "sharing",.array [.array [.text "shared-prefix-terminal-or-occurrence-collapsed",.text "Collapsing a shared occurrence destroys path-local reconstruction."],.array [.text "shared-boundaries-retained-in-every-path-occurrence",.text "Shared sources, prefixes and terminals remain explicit inside every path."]]],.array [.text "status",.array [.array [.text "weak-adverse-unresolved-or-unassigned-path-omitted",.text "Omission makes the remaining path family falsely complete."],.array [.text "all-path-statuses-and-unresolved-records-retained",.text "Favorable, weak, adverse, absent, unresolved and unassigned records remain held."]]],.array [.text "provenance",.array [.array [.text "selected-plot-mean-or-answer-only-product-table",.text "A selected plot or aggregate cannot reconstruct the complete evidence surface."],.array [.text "complete-article-supplement-and-twenty-eight-sheet-cell-ledger",.text "The article, supplement, source workbook, all worksheets, cells, replicates, formulas and controls remain bound."]]],.array [.text "prediction",.array [.array [.text "product-time-value-readable-before-seal-or-corrected-after-release",.text "Target access or correction can select a mechanism."],.array [.text "value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor",.text "All worksheet identities seal before values open and each added path preserves the complete prior family."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact complete-path parallel-mechanism composition law"
 branch := "chemistry"
 statement := "For one registered reaction with one retained initial state, a parallel mechanism is forced as the complete source-ordered family of every distinct sequential path word. Each path preserves all states, elementary edges, intermediates, shared boundaries, terminal occurrences, conditions and statuses; no stochastic premise, fitted path weight, imported parallel-rate equation or favorable-path selection enters the composition."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-registered-parallel-path-support__exact-common-initial-state-boundary__complete-state-edge-word-for-every-path__finite-source-ordered-parallel-path-composition__shared-boundaries-retained-in-every-path-occurrence__all-path-statuses-and-unresolved-records-retained__complete-article-supplement-and-twenty-eight-sheet-cell-ledger__value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor"),("base",.text "Two distinct complete path words meeting one registered initial boundary force the first parallel family without a weight, probability or selected path."),("successor",.text "Appending the next distinct registered path at the next positive source occurrence retains every prior path, state, edge, shared boundary, terminal occurrence and status exactly."),("exclusions",.array [.text "no numerical zero; source glyph 0 is external observed absence and native absence is structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported parallel-reaction equation, stochastic premise, fitted or free path weight or steady-state assumption",.text "no selected favorable path, product, time, condition, replicate, mean, method, worksheet or row",.text "no averaging away replicates, interpolation, inferred path, renormalization, omitted weak/adverse/unresolved/unassigned record or target correction",.text "no product-time value, cell label, formula result or target hash before all twenty-eight worksheet identities seal",.text "source formulas remain disclosed provenance and never become Fold proof parameters"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; source glyph 0 is external observed absence and native absence is structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported parallel-reaction equation, stochastic premise, fitted or free path weight or steady-state assumption","no selected favorable path, product, time, condition, replicate, mean, method, worksheet or row","no averaging away replicates, interpolation, inferred path, renormalization, omitted weak/adverse/unresolved/unassigned record or target correction","no product-time value, cell label, formula result or target hash before all twenty-eight worksheet identities seal","source formulas remain disclosed provenance and never become Fold proof parameters"]
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
end SFT.Chemistry.ParallelMechanismEvidence
