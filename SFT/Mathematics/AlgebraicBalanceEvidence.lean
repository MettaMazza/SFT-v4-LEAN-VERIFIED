import SFT.Mathematics.AlgebraicBalanceGrammar
import SFT.Mathematics.AlgebraicSeparation
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.AlgebraicBalanceEvidence
open SFT.Host.Canonical AlgebraicBalanceGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 := AlgebraicBalance.squareBalance
def witness1 := AlgebraicBalance.twentyRefinementWitness
def witness2 : Bool :=
 (AlgebraicBalance.vietaSum == SFT.Physics.LeptonIntervals.normalize 1 1 (by decide)) &&
 (AlgebraicBalance.vietaPairs == SFT.Physics.LeptonIntervals.normalize 11 36 (by decide))
theorem witness0Passed : witness0 = true := AlgebraicBalance.squareBalancePassed
theorem witness1Passed : witness1 = true := AlgebraicBalance.twentyRefinementsExact
theorem witness2Passed : witness2 = true := rfl
def witnesses : Value := .array [.array [.text "square-balance",.text "The positive sides x squared and two swap order across seven-of-five and three-of-two.",.boolean witness0],.array [.text "exact-midpoints",.text "Twenty bisections of that bracket retain exact rational endpoints and an order swap.",.boolean witness1],.array [.text "vieta-rational",.text "The polynomial with roots one-of-two, one-of-three and one-of-six has exact sum One and exact pair sum eleven-of-thirty-six.",.boolean witness2]]
def witnessRecords : Value := .array [.object [("name",.text "square-balance"),("statement",.text "The positive sides x squared and two swap order across seven-of-five and three-of-two."),("passed",.boolean witness0)],.object [("name",.text "exact-midpoints"),("statement",.text "Twenty bisections of that bracket retain exact rational endpoints and an order swap."),("passed",.boolean witness1)],.object [("name",.text "vieta-rational"),("statement",.text "The polynomial with roots one-of-two, one-of-three and one-of-six has exact sum One and exact pair sum eleven-of-thirty-six."),("passed",.boolean witness2)]]
def claimId : String := "SFT-MATH-ALGEBRAIC-BALANCE-002"
def dependencies : List String := ["SFT-MATH-ALGEBRA-001","SFT-MATH-ORDER-LATTICE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "representation",.text (representationName c.representation)],.array [.text "coefficients",.text (coefficientsName c.coefficients)],.array [.text "enclosure",.text (enclosureName c.enclosure)],.array [.text "refinement",.text (refinementName c.refinement)],.array [.text "identity",.text (identityName c.identity)],.array [.text "reconstruction",.text (reconstructionName c.reconstruction)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Exhaust representation, coefficients, enclosure, refinement, identity, reconstruction, generality and extra-rule choices."),("grammar_boundary",.text "Positive polynomial-side evaluations and exact rational brackets at supplied finite refinement depth."),("dimensions",.array [.object [("key",.text "representation"),("question",.text "representation?"),("choices",.array [.array [.text "irrational-scalar",.text "The scalar is forbidden as a proof value."],.array [.text "balance-certificate",.text "The object is the equality condition between two positive sides."]])],.object [("key",.text "coefficients"),("question",.text "coefficients?"),("choices",.array [.array [.text "signed-polynomial",.text "Negative coefficients import signed magnitude."],.array [.text "positive-separated-sides",.text "Terms are moved to two positive sides with held orientation."]])],.object [("key",.text "enclosure"),("question",.text "enclosure?"),("choices",.array [.array [.text "decimal-guess",.text "A decimal guess is not exact."],.array [.text "rational-order-swap",.text "Exact endpoint comparisons bracket the balance."]])],.object [("key",.text "refinement"),("question",.text "refinement?"),("choices",.array [.array [.text "floating-iteration",.text "Floating iteration loses exact provenance."],.array [.text "exact-bisection",.text "Each midpoint is an exact rational part."]])],.object [("key",.text "identity"),("question",.text "identity?"),("choices",.array [.array [.text "approximate-equality",.text "Tolerance cannot define the algebraic object."],.array [.text "polynomial-balance",.text "The defining identity is exact equality of the two sides."]])],.object [("key",.text "reconstruction"),("question",.text "reconstruction?"),("choices",.array [.array [.text "unverified-root",.text "An asserted root has no certificate."],.array [.text "bracket-trace",.text "The full nested bracket trace reconstructs every decision."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "named-radicals",.text "A radical list omits higher-degree forms."],.array [.text "finite-polynomial-induction",.text "Each supplied finite polynomial pair is evaluated by the same exact trace law."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "extra-field",.text "An algebraic field is not supplied by Foundation."],.array [.text "no-extra-rule",.text "Only arithmetic, order and exact parts occur."]])]]),("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Positive polynomial-balance certificates for algebraic magnitudes"
 branch := "mathematics"
 statement := "A magnitude not itself admitted as an irrational value may be identified by two positive-coefficient polynomial sides, an exact rational bracket in which their order swaps, and a generated bisection trace that narrows that bracket without ever importing the root as a proof value."
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
def closureValue : Value := .object [("exact_result",.text "The unique admitted algebraic-magnitude representation is a positive polynomial-balance identity with exact rational order-swap bracket and replayable bisection trace; the irrational root is never a proof value."),("laws",.array [.text "separating signed terms into two positive sides preserves the defining balance",.text "an endpoint order swap plus exact bisection yields nested rational enclosures",.text "Vieta relations provide an implementation-distinct coefficient cross-check for a bracketed root family"]),("operational_witnesses",witnesses),("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),("named_shape_uniqueness",.text "The complete product contains exactly one all-admitted coordinate: balance-certificate__positive-separated-sides__rational-order-swap__exact-bisection__polynomial-balance__bracket-trace__finite-polynomial-induction__no-extra-rule."),("induction_base",.text "One exact rational bracket with opposite side order is a complete first enclosure."),("induction_step",.text "The exact midpoint retains the order swap in exactly one half-bracket unless it is itself the exact balance, so the certificate narrows at every supplied finite step."),("boundary_exclusions",.array [.text "semantic numerical zero is not an admitted value",.text "negative magnitude is represented only by held orientation",.text "irrational, imaginary and floating proof values are excluded",.text "a completed infinity and an ungenerated continuum are excluded"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "One exact rational bracket with opposite side order is a complete first enclosure."),("successor",.text "The exact midpoint retains the order swap in exactly one half-bracket unless it is itself the exact balance, so the certificate narrows at every supplied finite step."),("laws",.array [.text "separating signed terms into two positive sides preserves the defining balance",.text "an endpoint order swap plus exact bisection yields nested rational enclosures",.text "Vieta relations provide an implementation-distinct coefficient cross-check for a bracketed root family"]),("witnesses",witnessRecords)]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with representation := .rejected}) survivorId))
 "reject a generated form missing the first required structural condition" (decisionReason {survivor with representation := .rejected}),
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
end SFT.Mathematics.AlgebraicBalanceEvidence
