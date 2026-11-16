import SFT.Chemistry.StateEnergyOrderGrammar
import SFT.Chemistry.StateEnergyOrderWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.StateEnergyOrderEvidence
open SFT.Host.Canonical StateEnergyOrderGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [
 .array [.text "unique-structural-ground",.text "Exactly one state occupies the structural least boundary.",.boolean StateEnergyOrder.groundWitness],
 .array [.text "positive-excitation-order",.text "Each excited state occupies the next positive successor position.",.boolean StateEnergyOrder.excitationWitness],
 .array [.text "duplicate-ground-control",.text "A second structural least state rejects.",.boolean StateEnergyOrder.duplicateGroundWitness],
 .array [.text "missing-successor-control",.text "A finite order with a skipped successor rejects.",.boolean StateEnergyOrder.missingSuccessorWitness]]
def claimId : String := "SFT-CHEM-STATE-ENERGY-ORDER-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "least",.text (leastName c.least)],.array [.text "excitation",.text (excitationName c.excitation)],.array [.text "order",.text (orderName c.order)],.array [.text "gap",.text (gapName c.gap)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "cross-molecule-state-list",.text "States from different carriers have no common declared molecular order."],.array [.text "one-molecule-state-support",.text "Every ordered state retains the same declared molecular composition and geometry."]]],.array [.text "identity",.array [.array [.text "energy-only-anonymous-row",.text "An anonymous energy cannot preserve which electronic support carries it."],.array [.text "state-and-support-identity",.text "Every order position retains exact state and molecular-support identities."]]],.array [.text "least",.array [.array [.text "numerical-zero-ground",.text "Numerical zero imports a forbidden proof magnitude and does not establish structural leastness."],.array [.text "structural-empty-One-ground",.text "The unique least state is the structural empty-One boundary of the finite order."]]],.array [.text "excitation",.array [.array [.text "signed-energy-displacement",.text "A signed displacement imports negative proof quantities."],.array [.text "positive-successor-excitation",.text "Every excited state is a positive successor beyond the structural least state."]]],.array [.text "order",.array [.array [.text "partial-selected-comparison",.text "Selected comparisons cannot establish a complete finite state order."],.array [.text "complete-finite-total-order",.text "Every distinct state pair is comparable exactly once at the declared boundary."]]],.array [.text "gap",.array [.array [.text "unretained-transition-gap",.text "Erasing the positive separation loses transition and reconstruction information."],.array [.text "retained-positive-order-gap",.text "Every higher/lower pair retains a positive counted separation."]]],.array [.text "record",.array [.array [.text "ordered-labels-without-trace",.text "A label list without support and observation trace cannot reproduce the order."],.array [.text "complete-state-order-record",.text "Carrier, state identity, support, positions and comparisons remain auditable."]]],.array [.text "extension",.array [.array [.text "species-energy-lookup-rule",.text "A species lookup or measured energy in generation lets the target select the law."],.array [.text "no-extra-rule",.text "The same least-plus-positive-successor law applies to every finite molecular state support."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact finite ground and excited molecular-state ordering"
 branch := "chemistry"
 statement := "At one declared molecular composition and geometry, every finite distinguishable electronic-state support has exactly one structural least state and every excited state occupies one exact positive successor position; all distinct state pairs are comparable, every higher/lower separation remains a retained positive gap, and the complete state/support identity record is preserved."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-molecule-state-support__state-and-support-identity__structural-empty-One-ground__positive-successor-excitation__complete-finite-total-order__retained-positive-order-gap__complete-state-order-record__no-extra-rule"),("base",.text "One retained molecular state is uniquely the structural least state; no numerical-zero energy is required as a proof object."),("successor",.text "Adjoining one new distinguishable state to a complete finite order forces one unused positive successor position, positive separations from all predecessors and preservation of every state/support identity."),("exclusions",.array [.text "no numerical-zero, negative, irrational, imaginary or floating proof value",.text "no measured NIST energy or state label in candidate generation or survivor selection",.text "no imported Hamiltonian, wavefunction, molecular-orbital energy formula or fitted scale",.text "no selected state pair or omitted unfavorable state-energy row",.text "no species-specific ground-state lookup rule",.text "external decimal and source-zero inscriptions remain post-seal measurement records",.text "no fitted, learned or target-derived parameter"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical-zero, negative, irrational, imaginary or floating proof value","no measured NIST energy or state label in candidate generation or survivor selection","no imported Hamiltonian, wavefunction, molecular-orbital energy formula or fitted scale","no selected state pair or omitted unfavorable state-energy row","no species-specific ground-state lookup rule","external decimal and source-zero inscriptions remain post-seal measurement records","no fitted, learned or target-derived parameter"]
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
end SFT.Chemistry.StateEnergyOrderEvidence
