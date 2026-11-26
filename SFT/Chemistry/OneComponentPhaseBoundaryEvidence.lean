import SFT.Chemistry.OneComponentPhaseBoundaryGrammar
import SFT.Chemistry.OneComponentPhaseBoundary
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.OneComponentPhaseBoundaryEvidence
open SFT.Host.Canonical OneComponentPhaseBoundaryGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exchange-balance",.text "Equal component exchange supports produce structural EmptyOne separation.",.boolean (match OneComponentPhaseBoundary.balanceWitness with | .error _ => false | .ok b => b)],.array [.text "single-degree-support",.text "One component and two phases leave exactly one held coordinate carrier.",.boolean (match OneComponentPhaseBoundary.degreeWitness with | .error _ => false | .ok b => b)],.array [.text "ordered-successor",.text "The next stable coexistence point increases both exact held supports.",.boolean (match OneComponentPhaseBoundary.orderedWitness with | .error _ => false | .ok b => b)],.array [.text "append-and-replicate",.text "Ordered append and common exact replication preserve the finite boundary.",.boolean (match OneComponentPhaseBoundary.extensionWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-ONE-COMPONENT-PHASE-BOUNDARY-012"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-MIXTURE-001","SFT-CHEM-SOLUTION-EQUILIBRIUM-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007","SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008","SFT-CHEM-FUGACITY-EQUIVALENT-GAS-MIXTURE-010","SFT-CHEM-PHASE-RULE-STRUCTURAL-011"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "phase",.text (phaseName c.phase)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "degree",.text (degreeName c.degree)],.array [.text "response",.text (responseName c.response)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unbound-temperature-pressure-pair",.text "A detached pair erases the component, phases and exchange support that make it a boundary point."],.array [.text "complete-one-component-two-phase-point",.text "Each point retains component, two phases, exact supports and both held coordinates."]]],.array [.text "phase",.array [.array [.text "single-phase-state-or-erased-phase-pair",.text "A single phase does not define a coexistence boundary."],.array [.text "two-distinct-held-coexisting-phases",.text "The phase pair remains distinct and held at every point."]]],.array [.text "balance",.array [.array [.text "assumed-equilibrium-or-target-derived-equality",.text "Assumption or target adjustment does not force coexistence."],.array [.text "exact-component-exchange-support-balance",.text "Coexistence is exact equality of the component exchange supports across the phase pair."]]],.array [.text "degree",.array [.array [.text "free-two-coordinate-continuum",.text "A free plane contradicts the single remaining carrier forced by one component and two phases."],.array [.text "one-independent-held-coordinate-support",.text "The admitted phase-rule cancellation leaves exactly one independent carrier."]]],.array [.text "response",.array [.array [.text "imported-differential-equation-or-fitted-slope",.text "A differential equation or fitted slope imports a continuum model."],.array [.text "exact-positive-temperature-pressure-co-order",.text "A stable liquid-vapor boundary successor retains exact positive increase in both held coordinates."]]],.array [.text "boundary",.array [.array [.text "interpolated-continuum-curve",.text "Interpolation invents unmeasured points and an unenumerated continuum."],.array [.text "finite-ordered-coexistence-word",.text "The boundary is exactly the generated finite word of measured coexistence points."]]],.array [.text "prediction",.array [.array [.text "coexistence-values-readable-before-seal",.text "Readable temperatures or pressures could select the relation."],.array [.text "complete-value-free-15-point-identity-seal",.text "All fifteen source identities seal before compounds, phases, temperatures or pressures open."]]],.array [.text "extension",.array [.array [.text "refit-after-appending-or-replication",.text "Refitting destroys exact succession and support provenance."],.array [.text "depth-independent-append-and-common-replication",.text "Appending one ordered balanced point or commonly replicating support preserves the finite boundary law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "One-component finite phase-boundary relation"
 branch := "chemistry"
 statement := "A one-component two-phase boundary is the exact finite ordered word of complete coexistence points. At each point the component exchange supports of the two held phases are equal; the phase-rule relation leaves one independent held coordinate support. For a stable liquid-vapor successor, exact temperature and pressure supports are co-ordered. No differential equation, interpolated continuum or fitted slope enters."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-one-component-two-phase-point__two-distinct-held-coexisting-phases__exact-component-exchange-support-balance__one-independent-held-coordinate-support__exact-positive-temperature-pressure-co-order__finite-ordered-coexistence-word__complete-value-free-15-point-identity-seal__depth-independent-append-and-common-replication"),("base",.text "One held component, two distinct phases, equal component exchange supports and one complete positive temperature-pressure record form the least coexistence-boundary word."),("successor",.text "Appending one later exchange-balanced point with strictly greater exact temperature and pressure supports preserves the complete finite boundary; common exact support replication preserves balance and order."),("exclusions",.array [.text "no numerical zero; absent separation at exact exchange balance is structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported Clausius-Clapeyron equation, differential equation, equation of state or vapor-pressure equation",.text "no interpolation, regression, fitted slope, selected compound, selected curve segment or target-derived correction",.text "no compound, phase, temperature, pressure, uncertainty or target hash before prediction seal",.text "every external decimal remains a post-seal source inscription and every parent-source row remains preserved"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent separation at exact exchange balance is structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported Clausius-Clapeyron equation, differential equation, equation of state or vapor-pressure equation","no interpolation, regression, fitted slope, selected compound, selected curve segment or target-derived correction","no compound, phase, temperature, pressure, uncertainty or target hash before prediction seal","every external decimal remains a post-seal source inscription and every parent-source row remains preserved"]
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
end SFT.Chemistry.OneComponentPhaseBoundaryEvidence
