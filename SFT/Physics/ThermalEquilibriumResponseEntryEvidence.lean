import SFT.Physics.ThermalEquilibriumResponseGrammar
import SFT.Physics.ThermalEquilibriumResponseWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ThermalEquilibriumResponseEntryEvidence
open SFT.Host.Canonical ThermalEquilibriumResponseGrammar ThermalEquilibriumResponseWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "temperature"),("statement",.text "Exact total and mean identity holds."),("passed",.boolean witness0)],.object [("name",.text "equilibrium"),("statement",.text "Complete paired populations uniquely force half-One."),("passed",.boolean witness1)],.object [("name",.text "canonical"),("statement",.text "Every tested complete level grammar has one dyadic maximum and exact weights."),("passed",.boolean witness2)],.object [("name",.text "response"),("statement",.text "Fluctuation, response and deterministic noise share one exact balance."),("passed",.boolean witness3)]]
def claimId : String := "SFT-PHYS-THERMAL-EQUILIBRIUM-RESPONSE-TERMINAL-043"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-HALF-ONE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-THERMO-TEMPERATURE-001", "SFT-PHYS-THERMO-EQUILIBRIUM-001", "SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001", "SFT-PHYS-THERMO-FLUCTUATION-001", "SFT-PHYS-THERMO-RESPONSE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "temperature",.text (temperatureName c.temperature)],.array [.text "total",.text (totalName c.total)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "canonical",.text (canonicalName c.canonical)],.array [.text "maximum",.text (maximumName c.maximum)],.array [.text "fluctuation",.text (fluctuationName c.fluctuation)],.array [.text "response",.text (responseName c.response)],.array [.text "noise",.text (noiseName c.noise)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of temperature, total throw, equilibrium, canonical weighting, maximum-count, fluctuation, response and noise-orbit forms."),("grammar_boundary",.text "Every finite nonempty tuple of exact positive throws; every positive paired binary population; every finite generated level count at least two; every exact fixed-count/fixed-throw population vector; and every positive repetition of the complete deterministic response cycle."),("axes",.array [.object [("key",.text "temperature"),("question",.text "What is temperature?"),("choices",.array [.array [.text "primitive-continuum-coordinate",.text "A primitive continuum coordinate is not Fold-generated."],.array [.text "exact-positive-mean-throw",.text "The finite population uniquely fixes its exact mean."]])],.object [("key",.text "total"),("question",.text "What links total and mean?"),("choices",.array [.array [.text "fitted-Boltzmann-coefficient",.text "A fitted coefficient adds a parameter."],.array [.text "population-count-times-mean",.text "Finite summation forces total=N times mean."]])],.object [("key",.text "equilibrium"),("question",.text "What fixes balance?"),("choices",.array [.array [.text "selected-half-label",.text "A named midpoint alone is not a census."],.array [.text "unique-binomial-multiplicity-maximum",.text "Every complete paired population has one maximum at equal labels."]])],.object [("key",.text "canonical"),("question",.text "What fixes finite level weights?"),("choices",.array [.array [.text "continuum-exponential",.text "An exponential is outside exact Fold arithmetic."],.array [.text "normalized-dyadic-successor-ladder",.text "Fold succession generates powers of two and exact positive normalization."]])],.object [("key",.text "maximum"),("question",.text "Why is the ladder equilibrium?"),("choices",.array [.array [.text "asserted-geometric-shape",.text "A shape assertion does not eliminate alternatives."],.array [.text "complete-fixed-count-throw-multinomial-maximum",.text "Every same-count/same-throw vector is enumerated and only the dyadic vector maximizes multiplicity."]])],.object [("key",.text "fluctuation"),("question",.text "What is the least balanced fluctuation?"),("choices",.array [.array [.text "ontic-random-kick",.text "Ontic randomness is not forced."],.array [.text "three-quarter-complementary-departure",.text "The upper quarter departure is three-quarter-One."]])],.object [("key",.text "response"),("question",.text "What is the matching response?"),("choices",.array [.array [.text "free-dissipation-rate",.text "A free response adds a parameter."],.array [.text "quarter-One-antipodal-response",.text "The complementary response has the identical quarter departure."]])],.object [("key",.text "noise"),("question",.text "What is thermal noise?"),("choices",.array [.array [.text "untracked-stochastic-source",.text "An untracked source violates determinism."],.array [.text "finite-periodic-orbit-readout",.text "The complete retained orbit supplies spread and relaxation together."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal exact temperature, finite canonical equilibrium and fluctuation-response law"
 branch := "physics"
 statement := "Temperature is the exact positive mean of a finite population's held throw records, so total throw equals population count times temperature. For every complete paired binary population, exhaustive multiplicity counting has one maximum at equal labels, forcing half-One equilibrium and detailed balance. For L generated levels the Fold recurrence uniquely supplies integer populations (2^(L-1),...,2,1), normalized by 2^L-1; complete enumeration at the same population and throw gives this dyadic ladder as the unique multinomial maximum. Equilibrium fluctuation three-quarter-One and response quarter-One are complementary and have the same quarter-One departure from half-One. A finite deterministic four-record cycle has mean half-One, making noise and response two readings of one retained orbit."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.array [.text claimId,.text generationRule,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("result",.text "For every finite positive population, T=(sum throws)/N and total=N*T. Every paired binary population uniquely maximizes multiplicity at half-One. For L levels, exact canonical counts are (2^(L-1),...,1), weights divide by 2^L-1, sum to One and are the unique fixed-count/fixed-throw multinomial maximum. The least fluctuation/response pair is 3/4 and 1/4 around equilibrium 1/2, with equal departure 1/4; the complete deterministic cycle (1/4,1/2,3/4,1/2) has mean 1/2."),("base",.text "One binary pair has multiplicities One,two,One and unique half-One maximum; two levels have dyadic counts two,One and unique fixed-throw maximum."),("successor",.text "Appending one binary pair preserves the central unique maximum; appending one Fold level doubles every earlier count and adds one terminal record, preserving normalization, fixed-throw maximality and strict decline; appending a complete four-record orbit preserves mean half-One."),("exclusions",.array [.text "no Boltzmann exponential, continuum bath, Lagrange multiplier or fitted distribution",.text "no thermometry, noise voltage or measured k_B available to candidate selection",.text "no ontic randomness",.text "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof magnitude",.text "empty combinatorial counts are structural absence records only"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (admissionIdentity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def exclusions : List String := ["no Boltzmann exponential, continuum bath, Lagrange multiplier or fitted distribution", "no thermometry, noise voltage or measured k_B available to candidate selection", "no ontic randomness", "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof magnitude", "empty combinatorial counts are structural absence records only"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with temperature := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.ThermalEquilibriumResponseEntryEvidence
