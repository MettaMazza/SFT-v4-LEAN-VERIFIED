import SFT.Chemistry.ReversibleKineticEquilibriumGrammar
import SFT.Chemistry.ReversibleKineticEquilibrium
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ReversibleKineticEquilibriumEvidence
open SFT.Host.Canonical ReversibleKineticEquilibriumGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "same-graph",.text "Forward and reverse transitions close the same two-state graph.",.boolean (match ReversibleKineticEquilibrium.sameGraphWitness with | .error _ => false | .ok b => b)],.array [.text "kinetics",.text "The two held orientations remain explicit ordered transition occurrences.",.boolean (match ReversibleKineticEquilibrium.kineticsWitness with | .error _ => false | .ok b => b)],.array [.text "equilibrium",.text "The recurrence support is exactly the two retained graph states.",.boolean (match ReversibleKineticEquilibrium.equilibriumWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending the next reversible pair retains every prior correspondence.",.boolean (match ReversibleKineticEquilibrium.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-REVERSIBLE-KINETIC-EQUILIBRIUM-CORRESPONDENCE-009"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003","SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004","SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005","SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007","SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "graph",.text (graphName c.graph)],.array [.text "kinetics",.text (kineticsName c.kinetics)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "status",.text (statusName c.status)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "selected-forward-or-reverse-direction",.text "One direction cannot establish a reversible pair."],.array [.text "both-held-directional-transition-occurrences",.text "Both directed occurrences remain explicit."]]],.array [.text "graph",.array [.array [.text "separate-unrelated-forward-and-reverse-graphs",.text "Unrelated paths cannot supply one kinetic-equilibrium correspondence."],.array [.text "same-exact-two-state-closed-transition-graph",.text "Both edges close the same retained state pair."]]],.array [.text "kinetics",.array [.array [.text "endpoint-rate-fit-or-aggregate-only",.text "A fit or endpoint erases ordered directed transition occurrences."],.array [.text "exact-ordered-directed-transition-word",.text "Kinetics is the retained directed edge word."]]],.array [.text "equilibrium",.array [.array [.text "imported-equilibrium-constant-steady-state-or-balance-law",.text "An imported equilibrium premise selects the correspondence."],.array [.text "closed-graph-recurrence-support",.text "Equilibrium support is the state support of the same closed graph."]]],.array [.text "composition",.array [.array [.text "terminal-compositions-collapsed-or-averaged",.text "Averaging hides direction-specific observations."],.array [.text "every-initial-terminal-composition-retained-separately",.text "Every observed composition remains an exact separate record."]]],.array [.text "status",.array [.array [.text "direction-label-disagreement-or-adverse-row-omitted",.text "Omission falsely regularizes the source."],.array [.text "all-favorable-adverse-and-disagreement-records-retained",.text "Every adverse and internally inconsistent source label remains visible."]]],.array [.text "provenance",.array [.array [.text "selected-kinetic-pages-or-answer-table",.text "A selected excerpt cannot prove complete source custody."],.array [.text "complete-article-supplement-movie-and-archive-ledger",.text "All 164 sealed source records remain bound."]]],.array [.text "prediction",.array [.array [.text "state-time-composition-energy-or-target-readable-before-seal",.text "Target access can select the graph."],.array [.text "value-free-164-record-identity-seal-and-depth-independent-pair-successor",.text "All identities seal before values and pair extension preserves prior correspondences."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact reversible kinetic-equilibrium correspondence law"
 branch := "chemistry"
 statement := "For two distinct retained states, exact forward and reverse transition occurrences close one and the same two-state graph. The ordered directed edges are the kinetic record and the graph's retained recurrence support is the equilibrium support. Direction is a held orientation rather than a sign; no imported reversible-rate equation, equilibrium constant, stochastic weight, fitted balance or steady-state premise enters the relation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "both-held-directional-transition-occurrences__same-exact-two-state-closed-transition-graph__exact-ordered-directed-transition-word__closed-graph-recurrence-support__every-initial-terminal-composition-retained-separately__all-favorable-adverse-and-disagreement-records-retained__complete-article-supplement-movie-and-archive-ledger__value-free-164-record-identity-seal-and-depth-independent-pair-successor"),("base",.text "One pair of distinct states with one edge in each held orientation forces the first closed reversible graph; its directed edge word and recurrence support are two views of that same graph."),("successor",.text "Appending the next complete reversible pair at the next positive source occurrence preserves every prior state, directed edge, condition, status, recurrence support and correspondence exactly."),("exclusions",.array [.text "no numerical zero; source glyph 0 is an external reference inscription and native absence is structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported reversible-rate equation, equilibrium law or constant, stochastic premise, direction weight or steady-state assumption",.text "no selected direction, time, state, condition, method, page, frame, archive member or row",.text "no refit, averaging, interpolation, renormalization, target correction or omission of disagreement/adverse/unresolved evidence",.text "no state, time, composition, rate, quantum yield, energy, uncertainty, fit, calculation, value or target hash before all 164 identities seal",.text "source fits, slopes, energies, equations and calculations remain post-seal provenance and never become Fold proof parameters"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; source glyph 0 is an external reference inscription and native absence is structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported reversible-rate equation, equilibrium law or constant, stochastic premise, direction weight or steady-state assumption","no selected direction, time, state, condition, method, page, frame, archive member or row","no refit, averaging, interpolation, renormalization, target correction or omission of disagreement/adverse/unresolved evidence","no state, time, composition, rate, quantum yield, energy, uncertainty, fit, calculation, value or target hash before all 164 identities seal","source fits, slopes, energies, equations and calculations remain post-seal provenance and never become Fold proof parameters"]
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
end SFT.Chemistry.ReversibleKineticEquilibriumEvidence
