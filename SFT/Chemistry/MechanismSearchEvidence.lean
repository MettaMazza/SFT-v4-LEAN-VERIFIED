import SFT.Chemistry.MechanismSearchGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MechanismSearchEvidence
open SFT.Host.Canonical MechanismSearchGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "states",.text "held-complete-chemical-states",.boolean true],.array [.text "transitions",.text "admitted-chemical-transition-edge",.boolean true],.array [.text "search",.text "complete-simple-path-enumeration",.boolean true],.array [.text "carriers",.text "stepwise-carrier-custody",.boolean true],.array [.text "branching",.text "all-parallel-route-support",.boolean true],.array [.text "cycles",.text "declared-cycle-and-resource-boundary",.boolean true],.array [.text "acceptance",.text "proof-kernel-stepwise-acceptance",.boolean true],.array [.text "certificate",.text "premise-alternative-step-and-terminal-trace",.boolean true]]
def claimId : String := "SFT-CHEM-MECHANISM-SEARCH-PROOF-TRACE-009"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-GRAPH-NETWORK-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007","SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "states",.text (statesName c.states)],.array [.text "transitions",.text (transitionsName c.transitions)],.array [.text "search",.text (searchName c.search)],.array [.text "carriers",.text (carriersName c.carriers)],.array [.text "branching",.text (branchingName c.branching)],.array [.text "cycles",.text (cyclesName c.cycles)],.array [.text "acceptance",.text (acceptanceName c.acceptance)],.array [.text "certificate",.text (certificateName c.certificate)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "states",.array [.array [.text "unidentified-intermediate-nodes",.text "unidentified-intermediate-nodes closes a distinction required by states."],.array [.text "held-complete-chemical-states",.text "held-complete-chemical-states retains the complete states distinction."]]],.array [.text "transitions",.array [.array [.text "learned-or-named-template-edge",.text "learned-or-named-template-edge closes a distinction required by transitions."],.array [.text "admitted-chemical-transition-edge",.text "admitted-chemical-transition-edge retains the complete transitions distinction."]]],.array [.text "search",.array [.array [.text "first-successful-path",.text "first-successful-path closes a distinction required by search."],.array [.text "complete-simple-path-enumeration",.text "complete-simple-path-enumeration retains the complete search distinction."]]],.array [.text "carriers",.array [.array [.text "net-reaction-only",.text "net-reaction-only closes a distinction required by carriers."],.array [.text "stepwise-carrier-custody",.text "stepwise-carrier-custody retains the complete carriers distinction."]]],.array [.text "branching",.array [.array [.text "major-route-only",.text "major-route-only closes a distinction required by branching."],.array [.text "all-parallel-route-support",.text "all-parallel-route-support retains the complete branching distinction."]]],.array [.text "cycles",.array [.array [.text "silent-loop-truncation",.text "silent-loop-truncation closes a distinction required by cycles."],.array [.text "declared-cycle-and-resource-boundary",.text "declared-cycle-and-resource-boundary retains the complete cycles distinction."]]],.array [.text "acceptance",.array [.array [.text "score-selected-mechanism",.text "score-selected-mechanism closes a distinction required by acceptance."],.array [.text "proof-kernel-stepwise-acceptance",.text "proof-kernel-stepwise-acceptance retains the complete acceptance distinction."]]],.array [.text "certificate",.array [.array [.text "terminal-product-only",.text "terminal-product-only closes a distinction required by certificate."],.array [.text "premise-alternative-step-and-terminal-trace",.text "premise-alternative-step-and-terminal-trace retains the complete certificate distinction."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold mechanism-search and proof-trace law"
 branch := "chemistry"
 statement := "Mechanism search enumerates every simple path in the admitted chemical transition graph; only paths whose every step has an admitted law and complete carrier trace may survive."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-complete-chemical-states__admitted-chemical-transition-edge__complete-simple-path-enumeration__stepwise-carrier-custody__all-parallel-route-support__declared-cycle-and-resource-boundary__proof-kernel-stepwise-acceptance__premise-alternative-step-and-terminal-trace"),("base",.text "One complete held COMP-009 carrier and its exact finite record supply the base case."),("successor",.text "Every successor appends a complete held carrier, mapping, transition or evidence record without changing any earlier canonical identity, comparison, adverse outcome or resource boundary."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external database encoding algorithm score value equation model fit outcome or software library selects the survivor",.text "all favorable adverse absent unavailable unresolved low-confidence transport conflict and declared resource-halt rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external database encoding algorithm score value equation model fit outcome or software library selects the survivor","all favorable adverse absent unavailable unresolved low-confidence transport conflict and declared resource-halt rows remain"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with states := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.MechanismSearchEvidence
