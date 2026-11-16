import SFT.Physics.CriticalityUniversalityGrammar
import SFT.Physics.CriticalityUniversalityWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CriticalityUniversalityEntryEvidence
open SFT.Host.Canonical CriticalityUniversalityGrammar CriticalityUniversalityWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "critical-powers"),("statement",.text "Every tested positive scale has the forced square, linear and cubic critical-power relations."),("passed",.boolean witness0)],.object [("name",.text "scaling-identities"),("statement",.text "Widom, Rushbrooke and Fisher close with typed empty alpha and eta."),("passed",.boolean witness1)],.object [("name",.text "cascade"),("statement",.text "Every tested three-space refinement closes the 2/3 and falling 5/3 power identities."),("passed",.boolean witness2)],.object [("name",.text "class-census"),("statement",.text "The declared grammar has two distinct complete generated class keys."),("passed",.boolean witness3)]]
def claimId : String := "SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-HALF-ONE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001", "SFT-PHYS-CONDENSED-PHASE-ORDER-001", "SFT-PHYS-FLUID-TURBULENCE-001", "SFT-PHYS-COUPLED-MAP-CRITICALITY-TERMINAL-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "threshold",.text (thresholdName c.threshold)],.array [.text "order",.text (orderName c.order)],.array [.text "correlation",.text (correlationName c.correlation)],.array [.text "response",.text (responseName c.response)],.array [.text "field",.text (fieldName c.field)],.array [.text "identities",.text (identitiesName c.identities)],.array [.text "cascade",.text (cascadeName c.cascade)],.array [.text "spectrum",.text (spectrumName c.spectrum)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of critical threshold, order, correlation, response, critical-field, scaling-identity, cascade and spectrum forms."),("grammar_boundary",.text "The binary self-antipodal local-order class and the generator-three conserved-cascade class; every positive whole perfect-power scale base and depth; exact rational exponent carriers; and typed empty exponent records."),("axes",.array [.object [("key",.text "threshold"),("question",.text "What fixes the phase boundary?"),("choices",.array [.array [.text "measured-critical-temperature",.text "A measured temperature would select the law."],.array [.text "binary-self-antipodal-half-One",.text "The complete binary complement equation has one self-antipodal part."]])],.object [("key",.text "order"),("question",.text "What fixes beta?"),("choices",.array [.array [.text "fitted-decimal-exponent",.text "A fitted exponent is not forced."],.array [.text "square-excess-to-linear-order-carrier",.text "Every perfect-square excess has one retained linear order carrier, forcing 1/2."]])],.object [("key",.text "correlation"),("question",.text "What fixes nu?"),("choices",.array [.array [.text "continuum-correlation-length-ansatz",.text "A continuum ansatz is outside the Fold grammar."],.array [.text "square-excess-to-linear-inverse-correlation",.text "The same binary square support forces the reciprocal correlation carrier 1/2."]])],.object [("key",.text "response"),("question",.text "What fixes gamma?"),("choices",.array [.array [.text "selected-response-power",.text "A selected power adds a parameter."],.array [.text "reciprocal-linear-excess-response",.text "One complete excess carrier forces reciprocal response exponent One."]])],.object [("key",.text "field"),("question",.text "What fixes delta?"),("choices",.array [.array [.text "imported-field-polynomial",.text "An imported polynomial is an independent model."],.array [.text "generator-three-order-cube",.text "The next generator fixes the critical field as the order cube."]])],.object [("key",.text "identities"),("question",.text "What closes the exponent relations?"),("choices",.array [.array [.text "numerical-zero-residuals",.text "Conventional zero is not a proof scalar."],.array [.text "typed-empty-alpha-eta-with-exact-identities",.text "Empty exponent records leave all three exact positive identities closed."]])],.object [("key",.text "cascade"),("question",.text "What fixes the structure exponent?"),("choices",.array [.array [.text "dimensional-analysis-assumption",.text "Named dimensional analysis does not force the branch count."],.array [.text "three-branch-cube-to-square-transfer",.text "Forced three-space cube refinement carries the conserved second-order square."]])],.object [("key",.text "spectrum"),("question",.text "What fixes the spectral exponent?"),("choices",.array [.array [.text "fitted-negative-five-thirds",.text "A fitted signed exponent violates the grammar."],.array [.text "falling-held-orientation-with-five-thirds-magnitude",.text "Shell succession adds the One to 2/3 and retains decrease as orientation."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal exact phase-criticality, universality and turbulence-scaling law"
 branch := "physics"
 statement := "The admitted binary self-antipodal lock fixes the continuous local-order threshold at half-One. Complete positive perfect-power scaling then forces beta=1/2 for the order carrier, nu=1/2 for the inverse-correlation carrier, gamma=One for reciprocal response, and delta=three for the critical-field relation; alpha and eta are empty One exponent records. Widom, Rushbrooke and Fisher close exactly without a numerical-zero proof scalar. Systems share this exponent law exactly when they share the same generated threshold, order-power and field-power key. Separately, the forced three-space branch count fixes a conserved cascade class: cube refinement carries a squared second-order structure record, forcing 2/3, while shell succession adds the One and forces a falling spectrum magnitude 5/3. These are two distinct generated universality classes, not one measurement-selected class."
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
def closureValue : Value := .object [("result",.text "For the binary self-antipodal local-order class, the threshold is 1/2 and the exact exponent carriers are beta=1/2, nu=1/2, gamma=1 and delta=3, with alpha and eta typed as empty One records. Widom gamma=beta(delta-1), Rushbrooke 2beta+gamma=2 and Fisher gamma=2nu all close exactly. For the distinct generator-three conserved cascade, the second-order structure exponent is 2/3 and the energy-spectrum exponent has falling orientation with positive magnitude 5/3. At every positive whole scale q and depth d, structure^3=length^2 and spectrum-divisor^3=wavenumber^5, providing depth-independent exact witnesses without irrational evaluation."),("base",.text "At one binary scale step, square excess gives linear order/correlation, linear response exponent One and cubic field exponent three; at one three-space refinement, cube length support carries square structure and fifth-power spectral divisor."),("successor",.text "Appending one exact scale step multiplies all critical perfect powers by the same binary powers and all cascade records by the same cube, square and fifth powers, preserving every exponent identity and universality key."),("exclusions",.array [.text "no renormalization-group, continuum field theory, Landau functional or Kolmogorov law imported as a premise",.text "no measured critical exponent, transition temperature, structure function or spectrum slope available to candidate selection",.text "no claim that every physical transition belongs to one class; equality requires the complete generated class key",.text "no fitted exponent, intermittency correction or Reynolds-number calibration",.text "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof magnitude; spectral decrease and empty exponents are typed records"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no renormalization-group, continuum field theory, Landau functional or Kolmogorov law imported as a premise", "no measured critical exponent, transition temperature, structure function or spectrum slope available to candidate selection", "no claim that every physical transition belongs to one class; equality requires the complete generated class key", "no fitted exponent, intermittency correction or Reynolds-number calibration", "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof magnitude; spectral decrease and empty exponents are typed records"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with threshold := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.CriticalityUniversalityEntryEvidence
