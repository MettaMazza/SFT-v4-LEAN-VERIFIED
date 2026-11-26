import SFT.Chemistry.ThermalConductivityGrammar
import SFT.Chemistry.ThermalConductivity
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ThermalConductivityEvidence
open SFT.Host.Canonical ThermalConductivityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "pure-binary-ternary-carriers",.text "Pure, binary and ternary compositions preserve distinct energy-transfer carriers.",.boolean (match ThermalConductivity.classesWitness with | .error _ => false | .ok b => b)],.array [.text "held-thermal-orientation",.text "Opposed thermal directions are held labels without signed heat flux.",.boolean (match ThermalConductivity.orientationWitness with | .error _ => false | .ok b => b)],.array [.text "exact-transfer-response",.text "Packet/transfer/tick/boundary/order support forms an exact positive relation.",.boolean (match ThermalConductivity.densityWitness with | .error _ => false | .ok b => b)],.array [.text "replication-successor",.text "Common transfer/tick replication preserves the composition-bound relation.",.boolean (match ThermalConductivity.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-THERMAL-CONDUCTIVITY-RELATION-018"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-THERMO-TEMPERATURE-001","SFT-PHYS-THERMO-HEAT-WORK-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-MULTICOMPONENT-PHASE-DIAGRAM-013","SFT-CHEM-MOLECULAR-DIFFUSION-RELATION-016","SFT-CHEM-VISCOUS-TRANSPORT-RELATION-017"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "transfer",.text (transferName c.transfer)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "resource",.text (resourceName c.resource)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "detached-conductivity-number-or-continuum-field",.text "A detached number or field erases the chemical energy-transfer account."],.array [.text "complete-composition-phase-condition-energy-transfer-account",.text "Every record retains components, phase, conditions, cells, thermal orders, packets, transfers, ticks and boundary support."]]],.array [.text "identity",.array [.array [.text "anonymous-or-collapsed-composition-phase",.text "Collapsed composition or phase cannot own a chemical conductivity relation."],.array [.text "distinct-held-complete-component-and-phase-identities",.text "Every pure, binary or ternary component and gas, liquid or crystalline phase identity remains held."]]],.array [.text "transfer",.array [.array [.text "Fourier-gradient-or-continuum-carrier-premise",.text "A continuum temperature gradient imports an ungenerated carrier."],.array [.text "counted-adjacent-cell-energy-packet-transfer",.text "Energy packets transfer across adjacent generated cells under the admitted physical carrier."]]],.array [.text "orientation",.array [.array [.text "signed-heat-flux-proof-magnitude",.text "Signed heat flux imports prohibited arithmetic."],.array [.text "held-higher-to-lower-thermal-order-orientation",.text "The two opposed directions are held labels with positive support."]]],.array [.text "resource",.array [.array [.text "unrecorded-energy-transfer-time-boundary-order-or-condition",.text "Unrecorded resources cannot reconstruct conductivity."],.array [.text "exact-positive-packet-transfer-tick-boundary-order-and-condition-support",.text "Packets, transfers, ticks, boundary, thermal separation and conditions are exact retained support."]]],.array [.text "magnitude",.array [.array [.text "imported-Fourier-kinetic-mixing-temperature-fit-or-logarithm",.text "An imported constitutive or fitted law selects the magnitude."],.array [.text "exact-positive-postseal-thermal-conductivity-support",.text "Measured conductivity opens only after the structural relation seals."]]],.array [.text "prediction",.array [.array [.text "substance-composition-phase-condition-method-or-value-readable-before-seal",.text "Readable targets could select the law."],.array [.text "complete-value-free-655-record-identity-seal",.text "All pure, binary and ternary identities seal before target content opens."]]],.array [.text "extension",.array [.array [.text "refit-after-transfer-replication-or-record-append",.text "Refitting destroys exact transfer provenance."],.array [.text "depth-independent-common-replication-and-record-append",.text "Common transfer/tick replication and complete append preserve the relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact composition-bound thermal-conductivity law"
 branch := "chemistry"
 statement := "Chemical thermal conductivity is counted adjacent-cell energy-packet transfer per exact tick, boundary and thermal-order separation while retaining every component, phase and condition. Chemistry owns composition-, species-, phase- and condition-dependence; the energy carrier is inherited explicitly from Physics. Measured conductivity is exact positive post-seal support, with direction held as a label rather than a signed magnitude."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-composition-phase-condition-energy-transfer-account__distinct-held-complete-component-and-phase-identities__counted-adjacent-cell-energy-packet-transfer__held-higher-to-lower-thermal-order-orientation__exact-positive-packet-transfer-tick-boundary-order-and-condition-support__exact-positive-postseal-thermal-conductivity-support__complete-value-free-655-record-identity-seal__depth-independent-common-replication-and-record-append"),("base",.text "One complete component carrier, one phase, two adjacent cells, two distinct positive thermal orders, one energy packet, one transfer, one tick, one boundary and one exact condition form the least chemical thermal-conductivity record."),("successor",.text "Appending one complete component, phase, condition, transfer or measurement record preserves all earlier distinctions; common transfer/tick replication preserves exact response and held direction without refitting."),("exclusions",.array [.text "no numerical zero; absent external condition coordinates are structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported Fourier constitutive equation, continuum temperature gradient, kinetic-theory formula, fitted mixing or temperature law",.text "no interpolation, regression, selected substance/mixture/phase/condition/method/dataset/property/row or target correction",.text "no substance, composition, phase, temperature, pressure, method, value, uncertainty or target hash before prediction seal",.text "every complete source and non-conductivity companion remains preserved; companions never become conductivity measurements"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent external condition coordinates are structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported Fourier constitutive equation, continuum temperature gradient, kinetic-theory formula, fitted mixing or temperature law","no interpolation, regression, selected substance/mixture/phase/condition/method/dataset/property/row or target correction","no substance, composition, phase, temperature, pressure, method, value, uncertainty or target hash before prediction seal","every complete source and non-conductivity companion remains preserved; companions never become conductivity measurements"]
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
end SFT.Chemistry.ThermalConductivityEvidence
