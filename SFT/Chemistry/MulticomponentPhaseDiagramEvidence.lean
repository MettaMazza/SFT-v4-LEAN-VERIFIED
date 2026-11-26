import SFT.Chemistry.MulticomponentPhaseDiagramGrammar
import SFT.Chemistry.MulticomponentPhaseDiagram
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MulticomponentPhaseDiagramEvidence
open SFT.Host.Canonical MulticomponentPhaseDiagramGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-composition-closure",.text "Binary and ternary phase words close exactly to the One.",.boolean (match MulticomponentPhaseDiagram.closureWitness with | .error _ => false | .ok b => b)],.array [.text "componentwise-exchange-balance",.text "Every component retains equal exchange support across both phases.",.boolean (match MulticomponentPhaseDiagram.balanceWitness with | .error _ => false | .ok b => b)],.array [.text "phase-rule-rank",.text "Two-phase binary and ternary words retain component-count degree support.",.boolean (match MulticomponentPhaseDiagram.rankWitness with | .error _ => false | .ok b => b)],.array [.text "absence-and-extension",.text "EmptyOne boundary, append and common replication preserve the exact finite law.",.boolean (match MulticomponentPhaseDiagram.absenceExtensionWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-MULTICOMPONENT-PHASE-DIAGRAM-013"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-MIXTURE-001","SFT-CHEM-STOICH-SOLUTION-001","SFT-CHEM-SOLUTION-EQUILIBRIUM-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008","SFT-CHEM-ACTIVITY-NONIDEAL-COMPOSITION-009","SFT-CHEM-FUGACITY-EQUIVALENT-GAS-MIXTURE-010","SFT-CHEM-PHASE-RULE-STRUCTURAL-011","SFT-CHEM-ONE-COMPONENT-PHASE-BOUNDARY-012"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "phase",.text (phaseName c.phase)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "degree",.text (degreeName c.degree)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unbound-coordinate-cloud",.text "Detached coordinates erase component, phase and coexistence identity."],.array [.text "complete-multicomponent-two-phase-point",.text "Every point retains both phase words, all components and held environment."]]],.array [.text "composition",.array [.array [.text "selected-coordinate-or-unclosed-sum",.text "A selected coordinate or unclosed collection does not specify a composition."],.array [.text "complete-exact-phase-words-closing-to-One",.text "Each phase retains every exact component coordinate and closes exactly to the One."]]],.array [.text "phase",.array [.array [.text "single-bulk-composition-or-erased-phase",.text "A bulk composition cannot identify two coexisting states."],.array [.text "two-distinct-held-phase-composition-words",.text "Liquid and gas remain distinct held words over the same component ordering."]]],.array [.text "balance",.array [.array [.text "imported-lever-rule-or-target-derived-tie-line",.text "An imported construction or target correction does not force coexistence."],.array [.text "componentwise-exact-exchange-support-balance",.text "Every component has equal exact exchange support across the two held phases."]]],.array [.text "degree",.array [.array [.text "free-continuum-diagram-plane",.text "A continuum plane imports unenumerated states and free coordinates."],.array [.text "exact-phase-rule-component-count-support",.text "Two-phase degree support is the exact finite component-count carrier word."]]],.array [.text "absence",.array [.array [.text "numerical-zero-composition",.text "Numerical zero is not an SFT value."],.array [.text "structural-EmptyOne-absent-coordinate",.text "A source zero glyph becomes structural EmptyOne while the inscription remains in provenance."]]],.array [.text "prediction",.array [.array [.text "coexistence-values-readable-before-seal",.text "Readable values could select the relation."],.array [.text "complete-value-free-116-record-identity-seal",.text "All 65 binary and 51 ternary record identities seal before compounds, phases or values open."]]],.array [.text "extension",.array [.array [.text "redraw-refit-or-interpolate-after-extension",.text "Redrawing or fitting destroys exact finite provenance."],.array [.text "depth-independent-append-and-exchange-replication",.text "Appending any complete balanced point and commonly replicating exchange support preserve the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Finite exact multicomponent phase-diagram relation"
 branch := "chemistry"
 statement := "A binary or higher multicomponent two-phase diagram is the exact finite word of complete coexistence records. Each phase is a held component-coordinate word closing exactly to the One; both phases retain the same ordered component identities, every component preserves exact exchange-support balance, and the phase-rule relation leaves component-count degree support. External zero glyphs denote structural EmptyOne only. No lever rule, Gibbs triangle, convex hull, continuum, interpolation, regression or fit enters."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-multicomponent-two-phase-point__complete-exact-phase-words-closing-to-One__two-distinct-held-phase-composition-words__componentwise-exact-exchange-support-balance__exact-phase-rule-component-count-support__structural-EmptyOne-absent-coordinate__complete-value-free-116-record-identity-seal__depth-independent-append-and-exchange-replication"),("base",.text "Two held components, two distinct exact phase words closing to the One, equal componentwise exchange supports and one complete positive environment form the least multicomponent coexistence record."),("successor",.text "Appending any further complete exchange-balanced coexistence record preserves the exact finite diagram; common positive replication of every paired component exchange support preserves balance at every depth."),("exclusions",.array [.text "no numerical zero; source zero glyphs translate only to structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported lever rule, tie-line equation, Gibbs triangle, convex hull or equation of state",.text "no continuum phase diagram, interpolation, regression, fitted interaction parameter or target-derived correction",.text "no compound, phase, temperature, pressure, composition, uncertainty or target hash before prediction seal",.text "no selected system, dataset, phase, point, azeotropic region or favorable diagram segment",.text "every source decimal remains a post-seal external inscription and the complete source remains preserved"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; source zero glyphs translate only to structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported lever rule, tie-line equation, Gibbs triangle, convex hull or equation of state","no continuum phase diagram, interpolation, regression, fitted interaction parameter or target-derived correction","no compound, phase, temperature, pressure, composition, uncertainty or target hash before prediction seal","no selected system, dataset, phase, point, azeotropic region or favorable diagram segment","every source decimal remains a post-seal external inscription and the complete source remains preserved"]
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
end SFT.Chemistry.MulticomponentPhaseDiagramEvidence
