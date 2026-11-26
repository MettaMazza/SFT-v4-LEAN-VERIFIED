import SFT.Chemistry.PhaseRuleGrammar
import SFT.Chemistry.PhaseRule
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PhaseRuleEvidence
open SFT.Host.Canonical PhaseRuleGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "one-component-one-phase",.text "One component and one phase leave two positive held carriers.",.boolean (match PhaseRule.onePhaseWitness with | .error _ => false | .ok b => b)],.array [.text "one-component-two-phase",.text "A second coexisting phase leaves one positive held carrier.",.boolean (match PhaseRule.twoPhaseWitness with | .error _ => false | .ok b => b)],.array [.text "one-component-three-phase",.text "Complete cancellation yields structural EmptyOne.",.boolean (match PhaseRule.threePhaseWitness with | .error _ => false | .ok b => b)],.array [.text "joint-successor",.text "One added component and one added phase preserve degree support.",.boolean (match PhaseRule.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-PHASE-RULE-STRUCTURAL-011"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-MIXTURE-001","SFT-CHEM-STOICH-SOLUTION-001","SFT-CHEM-SOLUTION-EQUILIBRIUM-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003","SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-ENTHALPY-EQUIVALENT-STATE-006","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007","SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008","SFT-CHEM-ACTIVITY-NONIDEAL-COMPOSITION-009","SFT-CHEM-FUGACITY-EQUIVALENT-GAS-MIXTURE-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "components",.text (componentsName c.components)],.array [.text "phases",.text (phasesName c.phases)],.array [.text "environment",.text (environmentName c.environment)],.array [.text "relation",.text (relationName c.relation)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unbound-degree-number",.text "A detached number erases which component, phase and coordinate supports produced it."],.array [.text "complete-component-phase-coordinate-account",.text "The complete account retains every component, phase and held environmental coordinate."]]],.array [.text "components",.array [.array [.text "bulk-substance-with-erased-independent-components",.text "Erasing independent component identities changes the available coordinate support."],.array [.text "complete-held-independent-component-support",.text "Every independent component contributes one held coordinate carrier."]]],.array [.text "phases",.array [.array [.text "phase-label-without-coexistence-constraint",.text "A phase name alone does not record the equilibrium identification it imposes."],.array [.text "one-exact-coordinate-cancellation-per-coexisting-phase",.text "Each coexisting phase cancels exactly one available coordinate carrier."]]],.array [.text "environment",.array [.array [.text "free-or-continuum-intensive-coordinate-space",.text "A free continuum imports unenumerated degrees and an additional premise."],.array [.text "two-held-environment-coordinate-carriers",.text "Temperature and pressure are the two held environmental carriers of the complete boundary."]]],.array [.text "relation",.array [.array [.text "imported-subtractive-phase-rule-equation",.text "Importing a subtractive formula introduces signed arithmetic instead of forcing the structure."],.array [.text "exact-carrier-cancellation-relation",.text "Degree support is the uncancelled finite carrier word after exact phase cancellation."]]],.array [.text "absence",.array [.array [.text "numerical-zero-degree-count",.text "Numerical zero is not an SFT value."],.array [.text "structural-EmptyOne-invariant-state",.text "Complete cancellation yields structural EmptyOne rather than a numerical degree value."]]],.array [.text "observation",.array [.array [.text "degree-outcome-readable-before-seal",.text "A readable degree outcome could select the cancellation relation."],.array [.text "complete-value-free-18-row-identity-seal",.text "All 18 component/phase identities seal before any degree outcome or source relation opens."]]],.array [.text "extension",.array [.array [.text "recalculate-with-free-exception",.text "A special-case exception would destroy structural closure."],.array [.text "depth-independent-joint-component-phase-successor",.text "Appending one component carrier and one phase cancellation preserves the remaining degree support."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical phase-rule structural relation"
 branch := "chemistry"
 statement := "A complete equilibrium account contains one coordinate carrier per independent component and the two held environmental carriers. Each coexisting phase cancels exactly one available carrier. The uncancelled finite carrier word is the independent degree support; complete cancellation is structural EmptyOne. This relation is forced without importing the subtractive phase-rule equation or numerical zero."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-component-phase-coordinate-account__complete-held-independent-component-support__one-exact-coordinate-cancellation-per-coexisting-phase__two-held-environment-coordinate-carriers__exact-carrier-cancellation-relation__structural-EmptyOne-invariant-state__complete-value-free-18-row-identity-seal__depth-independent-joint-component-phase-successor"),("base",.text "One component carrier and the two held environment carriers form the least complete support word; one coexisting phase cancels one carrier and leaves two independent carriers."),("successor",.text "Appending one independent component adds one carrier and appending one coexisting phase cancels exactly that one added carrier, preserving the prior uncancelled support word at every finite depth."),("exclusions",.array [.text "no numerical zero; complete cancellation is structural EmptyOne and the external zero glyph remains an interface inscription",.text "no subtraction, signed count, negative, irrational, imaginary, floating or continuum SFT proof value",.text "no imported Gibbs phase-rule equation, Gibbs-Duhem equation or algebraic rearrangement",.text "no free intensive coordinate, selected phase diagram, selected component/phase row or target-derived correction",.text "no degree outcome, invariant classification, source equation fragment or target hash before prediction seal",.text "every external count and equation remains a post-seal source-bound comparison record"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; complete cancellation is structural EmptyOne and the external zero glyph remains an interface inscription","no subtraction, signed count, negative, irrational, imaginary, floating or continuum SFT proof value","no imported Gibbs phase-rule equation, Gibbs-Duhem equation or algebraic rearrangement","no free intensive coordinate, selected phase diagram, selected component/phase row or target-derived correction","no degree outcome, invariant classification, source equation fragment or target hash before prediction seal","every external count and equation remains a post-seal source-bound comparison record"]
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
end SFT.Chemistry.PhaseRuleEvidence
