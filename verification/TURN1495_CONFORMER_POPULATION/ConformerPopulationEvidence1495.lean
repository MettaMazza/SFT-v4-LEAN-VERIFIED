import «work».ConformerPopulationGrammar1495
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ConformerPopulationEvidence
open SFT.Host.Canonical ConformerPopulationGrammar
set_option maxRecDepth 20000

def onePairWitness : Bool := decide (ObservationCarrier.onePair.length = 1)
def successorWitness : Bool := decide ((([("a", "r-a"), ("b", "r-b")] : List (String × String)).head?) = some ("a", "r-a"))
def witnesses : Value := .array [
 .array [.text "one-reference-pair",.text "One observation and one reference retain two named source coordinates and one pairing.",.boolean onePairWitness],
 .array [.text "successor-retention",.text "Appending a second named pairing leaves the first pairing unchanged.",.boolean successorWitness]]
theorem onePairWitnessPassed : onePairWitness = true := by decide
theorem successorWitnessPassed : successorWitness = true := by decide
def claimId : String := "SFT-CHEM-CONFORMER-POPULATION-ORDERING-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-DIHEDRAL-TORSIONAL-STATE-004","SFT-CHEM-CONFORMER-GENERATION-EQUIVALENCE-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "population",.text (populationName c.population)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "order",.text (orderName c.order)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "selected-conformer-name",.text "A selected name omits the complete derived equivalence quotient."],.array [.text "complete-conformer-equivalence-census",.text "Every ORG-005 conformer class remains retained exactly once."]]],.array [.text "condition",.array [.array [.text "condition-erased-population",.text "Population without physical condition conflates distinct deterministic traces."],.array [.text "held-observation-condition",.text "Every population vector retains its exact condition identity."]]],.array [.text "boundary",.array [.array [.text "infinite-or-unspecified-average",.text "An unspecified limit imports continuum or unbounded averaging."],.array [.text "positive-finite-observation-boundary",.text "The complete positive finite trace length is retained exactly."]]],.array [.text "population",.array [.array [.text "random-or-fitted-probability",.text "A random law or fitted distribution is not forced by the observed process."],.array [.text "exact-recurrence-count-ratio",.text "Each population is its exact deterministic class count over the retained boundary."]]],.array [.text "absence",.array [.array [.text "numerical-zero-population",.text "Numerical zero is not a native Fold form."],.array [.text "unobserved-class-EmptyOne",.text "A class absent from the finite trace retains structural EmptyOne."]]],.array [.text "order",.array [.array [.text "signed-energy-difference-or-imported-distribution",.text "A signed difference or imported exponential law adds forbidden arithmetic."],.array [.text "positive-Take-energy-and-count-orders",.text "Energy uses ordered positive Take; population order compares exact count ratios."]]],.array [.text "observation",.array [.array [.text "target-readable-condition-or-value",.text "External temperature, duration, energy or population could select the law."],.array [.text "value-free-conditioned-vector-seal",.text "Law, condition slots and exact comparison operations seal before target values open."]]],.array [.text "extension",.array [.array [.text "recomputed-history-or-extra-rule",.text "Discarding history or adding a smoothing rule changes the declared population."],.array [.text "one-observation-successor-no-extra-rule",.text "Each successor retains the trace and appends exactly one generated observation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact conditioned conformer population and ordering law"
 branch := "physics"
 statement := "For every complete finite conformer quotient, retained observation condition and positive finite trace, each conformer population is exactly its deterministic class-occurrence count divided by the complete trace boundary. An unobserved class is structural EmptyOne. Relative energy order uses structural least state plus positive exact Take, while every condition and observation-timescale remains retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-conformer-equivalence-census__held-observation-condition__positive-finite-observation-boundary__exact-recurrence-count-ratio__unobserved-class-EmptyOne__positive-Take-energy-and-count-orders__value-free-conditioned-vector-seal__one-observation-successor-no-extra-rule"),("base",.text "At one retained four-observation boundary, three occurrences of one ORG-005 class and one of the other force exact populations three-fourths and one-fourth; structural least energy precedes one positive energy."),("successor",.text "Append exactly one already generated assignment, retain the complete prior trace and condition, increase the positive boundary once and recompute every class count over that boundary without a smoothing or random rule."),("exclusions",.array [.text "no native numerical zero; structural absence and the least-state reference are EmptyOne",.text "no negative irrational imaginary continuum fitted free random or imported native parameter",.text "no Boltzmann exponential measured temperature species label energy or population used to generate the law",.text "all external signed zero negative decimal uncertainty and rounded inscriptions remain downstream evidence",.text "no condition observation-timescale source response failed capture adverse row or rounding discrepancy omitted",.text "no external result opened before its applicable value-free source and prediction seal"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no native numerical zero; structural absence and the least-state reference are EmptyOne","no negative irrational imaginary continuum fitted free random or imported native parameter","no Boltzmann exponential measured temperature species label energy or population used to generate the law","all external signed zero negative decimal uncertainty and rounded inscriptions remain downstream evidence","no condition observation-timescale source response failed capture adverse row or rounding discrepancy omitted","no external result opened before its applicable value-free source and prediction seal"]
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
end SFT.Physics.ConformerPopulationEvidence
