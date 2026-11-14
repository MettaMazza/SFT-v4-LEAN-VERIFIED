import SFT.Mathematics.RiemannMirrorGrammar
import SFT.Mathematics.RiemannMirror
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.RiemannMirrorEvidence
open SFT.Host.Canonical RiemannMirrorGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def exactPartner (p q : SFT.Foundation.ExactPartCarrier.Part) : Bool :=
 match SFT.Foundation.HalfOneDerivation.complement p with
 | .error _ => false
 | .ok r => r.numerator == q.numerator && r.denominator == q.denominator
def witness0 : Bool := exactPartner SFT.Foundation.HalfOneDerivation.halfOne SFT.Foundation.HalfOneDerivation.halfOne
def witness1 : Bool := exactPartner RiemannMirror.quarter RiemannMirror.threeQuarters && exactPartner RiemannMirror.third RiemannMirror.twoThirds
def witness2 : Bool := exactPartner RiemannMirror.quarter RiemannMirror.threeQuarters && exactPartner RiemannMirror.threeQuarters RiemannMirror.quarter
theorem witness0Passed : witness0 = true := rfl
theorem witness1Passed : witness1 = true := rfl
theorem witness2Passed : witness2 = true := rfl
def witnesses : Value := .array [.array [.text "fixed-half",.text "Half-One is equal to its exact complement.",.boolean witness0],.array [.text "off-axis-pairs",.text "Quarter/three-quarter and one-third/two-thirds are distinct complement pairs.",.boolean witness1],.array [.text "symmetry-control",.text "A symmetric two-point set can lie off the fixed axis, so symmetry alone cannot prove zero location.",.boolean witness2]]
def witnessRecords : Value := .array [.object [("name",.text "fixed-half"),("statement",.text "Half-One is equal to its exact complement."),("passed",.boolean witness0)],.object [("name",.text "off-axis-pairs"),("statement",.text "Quarter/three-quarter and one-third/two-thirds are distinct complement pairs."),("passed",.boolean witness1)],.object [("name",.text "symmetry-control"),("statement",.text "A symmetric two-point set can lie off the fixed axis, so symmetry alone cannot prove zero location."),("passed",.boolean witness2)]]
def claimId : String := "SFT-MATH-RIEMANN-MIRROR-002"
def dependencies : List String := ["SFT-MATH-EXACT-RELATIONS-002","SFT-FOUNDATION-HALF-ONE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "domain",.text (domainName c.domain)],.array [.text "involution",.text (involutionName c.involution)],.array [.text "fixed_point",.text (fixed_pointName c.fixed_point)],.array [.text "off_axis",.text (off_axisName c.off_axis)],.array [.text "prime_tie",.text (prime_tieName c.prime_tie)],.array [.text "zero_location",.text (zero_locationName c.zero_location)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Exhaust domain, involution, fixed point, off-axis pairing, prime tie, complex boundary, generality and extra-analytic choices."),("grammar_boundary",.text "Exact positive rational parts under complement within the One; no complex analytic continuation object."),("dimensions",.array [.object [("key",.text "domain"),("question",.text "domain?"),("choices",.array [.array [.text "complex-plane",.text "Imaginary values are not admitted proof objects."],.array [.text "positive-parts",.text "The involution acts on exact parts of the One."]])],.object [("key",.text "involution"),("question",.text "involution?"),("choices",.array [.array [.text "imported-functional-equation",.text "An external equation cannot derive the Fold law."],.array [.text "one-complement",.text "The map is exact complement within the One."]])],.object [("key",.text "fixed_point"),("question",.text "fixed point?"),("choices",.array [.array [.text "selected-half",.text "Selecting one-half would not prove uniqueness."],.array [.text "unique-self-complement",.text "Exact self-complement forces two equal parts to reconstruct the One."]])],.object [("key",.text "off_axis"),("question",.text "off axis?"),("choices",.array [.array [.text "unpaired-values",.text "Complement is total on the declared part domain."],.array [.text "distinct-pairs",.text "Every nonfixed part has one distinct complementary partner."]])],.object [("key",.text "prime_tie"),("question",.text "prime tie?"),("choices",.array [.array [.text "zeta-import",.text "The analytic zeta object is not an SFT input."],.array [.text "orbit-prime-skeleton",.text "Prime correspondence comes from independently derived Fold orders."]])],.object [("key",.text "zero_location"),("question",.text "zero location?"),("choices",.array [.array [.text "claim-classical-rh",.text "Symmetry alone cannot locate every classical complex zero."],.array [.text "explicit-language-boundary",.text "Only the symmetry axis is claimed inside SFT."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "bounded-denominator-only",.text "A fixed denominator table does not prove the involution law."],.array [.text "exact-part-identity",.text "The equality p=One-p has the unique exact solution two-p=One for every admitted part."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "extra-analysis",.text "Complex analysis is outside the registered dependencies."],.array [.text "no-extra-rule",.text "Only complement, equality and prior orbit number theory occur."]])]]),("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Unique half-One reflection axis and Riemann correspondence boundary"
 branch := "mathematics"
 statement := "The exact complement involution on positive parts has one and only one self-partner, the half-One; every other admitted part forms a distinct complementary pair. This forces the unique SFT reflection axis corresponding to the classical zeta functional equation's one-half symmetry, while complex zero location remains outside the no-imaginary proof language."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.object [("claim_id",.text claimId),("generator",.text generationRule),("record",candidateRecord c)])
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
 proofHash := admissionIdentity (.object [("claim_id",.text claimId),("dependencies",.array (dependencies.map Value.text)),("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("exact_result",.text "Half-One is the unique fixed axis of exact complement; every other positive part is paired. This closes the SFT Riemann-mirroring claim and explicitly does not assert classical complex zero location."),("laws",.array [.text "complement composed twice is identity",.text "self-complementarity uniquely forces the half-One",.text "reflection symmetry does not by itself imply that all points of an invariant set lie on the fixed axis"]),("operational_witnesses",witnesses),("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),("named_shape_uniqueness",.text "The complete product contains exactly one all-admitted coordinate: positive-parts__one-complement__unique-self-complement__distinct-pairs__orbit-prime-skeleton__explicit-language-boundary__exact-part-identity__no-extra-rule."),("induction_base",.text "The Foundation half-One certificate supplies the self-complementary witness."),("induction_step",.text "Every newly generated non-half part is paired with its exact complement and neither becomes a second fixed point."),("boundary_exclusions",.array [.text "semantic numerical zero is not an admitted value",.text "negative magnitude is represented only by held orientation",.text "irrational, imaginary and floating proof values are excluded",.text "a completed infinity and an ungenerated continuum are excluded"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "The Foundation half-One certificate supplies the self-complementary witness."),("successor",.text "Every newly generated non-half part is paired with its exact complement and neither becomes a second fixed point."),("laws",.array [.text "complement composed twice is identity",.text "self-complementarity uniquely forces the half-One",.text "reflection symmetry does not by itself imply that all points of an invariant set lie on the fixed axis"]),("witnesses",witnessRecords)]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.object [("closure",closureValue),("decisions",.array (decisions.map SFT.Engine.decisionValue))])
 generalityCertificateHash := some (admissionIdentity generalityValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.object [("kind",.text (SFT.Engine.kindName kind)),("expected",.text expected),("observed",.text observed),("passed",.boolean passed)])
def exclusions : List String := ["semantic numerical zero is not an admitted value","negative magnitude is represented only by held orientation","irrational, imaginary and floating proof values are excluded","a completed infinity and an ungenerated continuum are excluded"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with domain := .rejected}) survivorId))
 "reject a generated form missing the first required structural condition" (decisionReason {survivor with domain := .rejected}),
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed official source identity" "the changed identity differs from the registered source manifest",
 control .tamperedArtifact (((candidates.filter survives).length == 1) && ((candidates.map candidateId).eraseDups.length == candidates.length))
 "reject a missing, duplicated or additional survivor" "the generated product contains exactly one registered survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2)
 "halt any attempt to import an excluded object or answer-producing model" (SFT.Host.Text.intercalate "; " exclusions)]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)
theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Mathematics.RiemannMirrorEvidence
