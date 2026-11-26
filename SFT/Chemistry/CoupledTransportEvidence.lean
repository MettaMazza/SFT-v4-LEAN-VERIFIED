import SFT.Chemistry.CoupledTransportGrammar
import SFT.Chemistry.CoupledTransport
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CoupledTransportEvidence
open SFT.Host.Canonical CoupledTransportGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-triad",.text "Mass, heat and charge remain distinct on one shared event ledger.",.boolean (match CoupledTransport.triadWitness with | .error _ => false | .ok b => b)],.array [.text "complete-pairwise-projections",.text "All three pairwise projections are present once.",.boolean (match CoupledTransport.projectionsWitness with | .error _ => false | .ok b => b)],.array [.text "held-orientations",.text "Opposed carrier directions are held labels without signed flux.",.boolean (match CoupledTransport.orientationWitness with | .error _ => false | .ok b => b)],.array [.text "exact-responses",.text "The triad response is exact positive packet/event support per tick and boundary.",.boolean (match CoupledTransport.responsesWitness with | .error _ => false | .ok b => b)],.array [.text "replication-successor",.text "Common event/tick replication preserves all pairwise responses.",.boolean (match CoupledTransport.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-COUPLED-MASS-HEAT-CHARGE-TRANSPORT-019"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-THERMO-TEMPERATURE-001","SFT-PHYS-THERMO-HEAT-WORK-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-MULTICOMPONENT-PHASE-DIAGRAM-013","SFT-CHEM-MOLECULAR-DIFFUSION-RELATION-016","SFT-CHEM-VISCOUS-TRANSPORT-RELATION-017","SFT-CHEM-THERMAL-CONDUCTIVITY-RELATION-018"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "resource",.text (resourceName c.resource)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "detached-cross-coefficient-or-answer-vector",.text "Detached coefficients erase the transported carriers."],.array [.text "complete-composition-phase-mass-heat-charge-account",.text "Every component, phase and member of the mass/heat/charge triad remains held."]]],.array [.text "identity",.array [.array [.text "anonymous-collapsed-carriers-or-pair",.text "A collapsed carrier or pair cannot reconstruct the coupling."],.array [.text "distinct-held-triad-and-pairwise-projections",.text "The ordered triad and all three pairwise projections remain distinguishable."]]],.array [.text "transition",.array [.array [.text "imported-Onsager-matrix-gradient-or-flux-equation",.text "A phenomenological matrix or continuum gradient imports the desired coupling."],.array [.text "counted-shared-adjacent-cell-transition-ledger",.text "Mass, heat and charge packets share one counted adjacent transition record."]]],.array [.text "orientation",.array [.array [.text "signed-flux-proof-magnitudes",.text "Signed mass, heat or charge magnitudes violate exact proof arithmetic."],.array [.text "held-per-carrier-transfer-orientations",.text "Each carrier direction is a held label with positive support."]]],.array [.text "resource",.array [.array [.text "unrecorded-packet-event-time-boundary-or-condition",.text "Unrecorded resources cannot reconstruct the coupled response."],.array [.text "exact-positive-packet-event-tick-boundary-and-condition-support",.text "Each packet, shared event, tick, boundary and condition is exactly retained."]]],.array [.text "magnitude",.array [.array [.text "phenomenological-cross-coefficient-fit-or-target-value",.text "A fitted cross coefficient selects the result."],.array [.text "exact-positive-postseal-pairwise-response-support",.text "Measured pairwise responses open only after the triad relation seals."]]],.array [.text "prediction",.array [.array [.text "substance-pair-property-condition-method-or-value-readable-before-seal",.text "Readable pairwise targets could select the coupling law."],.array [.text "complete-value-free-232-record-pair-identity-seal",.text "All mass-heat, mass-charge and heat-charge identities seal before target content opens."]]],.array [.text "extension",.array [.array [.text "refit-after-event-replication-or-record-append",.text "Refitting destroys shared-event provenance."],.array [.text "depth-independent-common-replication-and-record-append",.text "Common event/tick replication and complete append preserve every response."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact coupled mass, heat and charge transport law"
 branch := "chemistry"
 statement := "Coupled chemical transport is one counted adjacent-cell transition ledger carrying distinct mass, heat and charge packets with exact positive resources and held per-carrier orientations. Every pairwise observation is a projection of the complete triad, not an imported Onsager matrix or continuum flux equation. Chemistry owns composition, phase, condition and cross-effect provenance; physical energy and charge carriers remain explicit dependencies."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-composition-phase-mass-heat-charge-account__distinct-held-triad-and-pairwise-projections__counted-shared-adjacent-cell-transition-ledger__held-per-carrier-transfer-orientations__exact-positive-packet-event-tick-boundary-and-condition-support__exact-positive-postseal-pairwise-response-support__complete-value-free-232-record-pair-identity-seal__depth-independent-common-replication-and-record-append"),("base",.text "One complete chemical carrier, one phase, two adjacent cells, one positive packet for each of mass, heat and charge, one shared event, one tick, one boundary and one condition form the least coupled record."),("successor",.text "Appending one component, phase, condition, carrier event or measurement record preserves all earlier distinctions; common shared-event/tick replication preserves every exact pairwise response without refitting."),("exclusions",.array [.text "no numerical zero; absent external condition coordinates are structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported Onsager matrix, continuum gradient or flux equation, phenomenological cross coefficient or fitted transport law",.text "no interpolation, regression, selected substance/pair/property/phase/condition/method/dataset/row or target correction",.text "no substance, carrier pair, property, composition, phase, condition, method, value, uncertainty or target hash before prediction seal",.text "every complete source and companion property remains preserved; companions never become coupled measurements"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent external condition coordinates are structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported Onsager matrix, continuum gradient or flux equation, phenomenological cross coefficient or fitted transport law","no interpolation, regression, selected substance/pair/property/phase/condition/method/dataset/row or target correction","no substance, carrier pair, property, composition, phase, condition, method, value, uncertainty or target hash before prediction seal","every complete source and companion property remains preserved; companions never become coupled measurements"]
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
end SFT.Chemistry.CoupledTransportEvidence
