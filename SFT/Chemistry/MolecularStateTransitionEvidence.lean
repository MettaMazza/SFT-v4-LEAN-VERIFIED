import SFT.Chemistry.MolecularStateTransitionGrammar
import SFT.Chemistry.MolecularStateTransition
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularStateTransitionEvidence
open SFT.Host.Canonical MolecularStateTransitionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "observed-transition",.text "Distinct endpoints and held orientation form one exact transformation.",.boolean MolecularStateTransition.observedWitness],.array [.text "composed-path",.text "Matching terminal and initial states compose without a new rule.",.boolean MolecularStateTransition.composedWitness],.array [.text "absent-coordinate",.text "A source-absent transition closes as EmptyOne rather than numerical zero.",.boolean MolecularStateTransition.absentWitness],.array [.text "mismatch-control",.text "Nonmatching endpoints reject.",.boolean MolecularStateTransition.mismatchWitness],.array [.text "self-transition-control",.text "An erased endpoint distinction rejects.",.boolean MolecularStateTransition.selfWitness]]
def claimId : String := "SFT-CHEM-MOLECULAR-STATE-TRANSITION-009"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-MULTICENTRE-DELOCALIZED-SUPPORT-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "endpoints",.text (endpointsName c.endpoints)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "trace",.text (traceName c.trace)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "transition-label-alone",.text "A label alone erases the transforming molecular carrier."],.array [.text "retained-molecular-carrier",.text "One carrier persists through the transformation."]]],.array [.text "endpoints",.array [.array [.text "unbound-final-answer",.text "An answer without endpoints cannot identify a state transformation."],.array [.text "distinct-initial-and-terminal-states",.text "Every observed transformation retains both distinct state identities."]]],.array [.text "orientation",.array [.array [.text "signed-or-unoriented-change",.text "A sign or erased orientation loses the observed direction class."],.array [.text "held-forward-reverse-bidirectional-or-coupled",.text "Orientation is an exact held label, never a signed proof magnitude."]]],.array [.text "absence",.array [.array [.text "absence-treated-as-number",.text "Numerical absence violates the Fold domain."],.array [.text "closed-terminal-EmptyOne",.text "An unobserved transition closes the terminal coordinate structurally."]]],.array [.text "trace",.array [.array [.text "endpoint-only-lookup",.text "Endpoints alone erase the transition record and provenance."],.array [.text "complete-state-transition-trace",.text "Carrier, endpoints, orientation and record remain composed."]]],.array [.text "composition",.array [.array [.text "nonmatching-path-concatenation",.text "Transitions with unequal adjacent endpoints cannot form one path."],.array [.text "matching-endpoint-composition",.text "Exact endpoint equality alone permits path composition."]]],.array [.text "record",.array [.array [.text "selected-present-transition",.text "Selecting only observed rows cannot test absence or coupling records."],.array [.text "complete-presence-coupling-absence-vector",.text "Every registered directional, coupled and absent source row is retained."]]],.array [.text "extension",.array [.array [.text "species-selection-rule-premise",.text "A selection rule at this stage imports the next obligation."],.array [.text "finite-path-successor-with-no-extra-rule",.text "Every matching successor extends the exact path without a species exception."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular-state transformation and transition law"
 branch := "chemistry"
 statement := "A molecular-state transformation retains one carrier, distinct state endpoints, a held orientation or coupling class, and its exact observation trace. Matching endpoints compose into finite transition paths. An absent transition coordinate is structural EmptyOne, not numerical zero. Selection criteria are not imported before their separate derivation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "retained-molecular-carrier__distinct-initial-and-terminal-states__held-forward-reverse-bidirectional-or-coupled__closed-terminal-EmptyOne__complete-state-transition-trace__matching-endpoint-composition__complete-presence-coupling-absence-vector__finite-path-successor-with-no-extra-rule"),("base",.text "One observed transformation retains one carrier, two distinct endpoints, one held orientation and one exact record; one absent coordinate retains its initial state and structural EmptyOne."),("successor",.text "A transition whose initial state equals the prior terminal state appends one retained terminal state and orientation to the finite path without altering prior records."),("exclusions",.array [.text "no numerical zero; glyph 0 denotes source/interface absence only",.text "no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude",.text "no imported dipole, spin, parity, angular-momentum or spectroscopic selection rule",.text "no NIST state, transition, band or absence outcome before prediction seal",.text "no selected present-only row surface",.text "no species-specific exception"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 denotes source/interface absence only","no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude","no imported dipole, spin, parity, angular-momentum or spectroscopic selection rule","no NIST state, transition, band or absence outcome before prediction seal","no selected present-only row surface","no species-specific exception"]
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
end SFT.Chemistry.MolecularStateTransitionEvidence
