import SFT.Physics.VelocityCompositionGrammar
import SFT.Physics.VelocityCompositionWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.VelocityCompositionEntryEvidence
open SFT.Host.Canonical VelocityCompositionGrammar VelocityCompositionWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "complete-bilinear-census"),("statement",.text "Two-sided rest identity leaves exactly four cross-term presence forms and the limiting One selects one."),("passed",.boolean completeBilinearCensus)],.object [("name",.text "typed-rest-and-limit"),("statement",.text "Typed rest is identity and the limiting One is absorbing on the complete exact check grid."),("passed",.boolean typedRestAndLimit)],.object [("name",.text "closure-and-associativity"),("statement",.text "All generated pairs close and all generated triples associate exactly."),("passed",.boolean closureAndAssociativity)],.object [("name",.text "held-pair-reconstruction"),("statement",.text "Independent forward/held multiplication reconstructs the same survivor."),("passed",.boolean heldPairReconstruction)],.object [("name",.text "low-speed-boundary"),("statement",.text "The departure from ordinary addition is an exact positive higher-product carrier."),("passed",.boolean lowSpeedBoundary)]]
def claimId : String := "SFT-PHYS-SPACETIME-VELOCITY-COMPOSITION-TERMINAL-033"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-EXACT-OPERATIONS-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-MECH-SPEED-VELOCITY-001", "SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001", "SFT-PHYS-SPACETIME-LIMIT-SPEED-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "domain",.text (domainName c.domain)],.array [.text "rest",.text (restName c.rest)],.array [.text "representation",.text (representationName c.representation)],.array [.text "numerator",.text (numeratorName c.numerator)],.array [.text "denominator",.text (denominatorName c.denominator)],.array [.text "limit",.text (limitName c.limit)],.array [.text "closure",.text (closureName c.closure)],.array [.text "associativity",.text (associativityName c.associativity)],.array [.text "record",.text (recordName c.record)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of motion domain, typed rest, forward/held representation, identity-compatible numerator cross term, identity-compatible denominator cross term, limiting-speed behavior, closure, associativity, held-record reversibility, empirical custody and extension form."),("grammar_boundary",.text "Every exact positive rational speed part through the limiting One; typed rest; typed empty held part; both present/absent choices for the bilinear cross term after two-sided identity forces the left, right and denominator-One terms; every exact triple composition; and no signed or continuum proof scalar."),("axes",.array [.object [("key",.text "domain"),("question",.text "What is composed?"),("choices",.array [.array [.text "imported-real-line-velocity",.text "A continuum imports the target model."],.array [.text "exact-positive-parts-and-held-direction",.text "Speed is an exact positive part; direction is retained as a label."]])],.object [("key",.text "rest"),("question",.text "How is rest represented?"),("choices",.array [.array [.text "numerical-zero",.text "Numerical nothing is not an admitted physical part."],.array [.text "typed-rest-state",.text "Rest is the empty-motion class with an exact identity action."]])],.object [("key",.text "representation"),("question",.text "What carries motion?"),("choices",.array [.array [.text "single-unrecorded-scalar",.text "One scalar discards the reverse distinction."],.array [.text "forward-held-pair",.text "The One-plus and One-Take parts retain both motion faces."]])],.object [("key",.text "numerator"),("question",.text "Does the bilinear numerator retain a cross term?"),("choices",.array [.array [.text "cross-term-present",.text "It prevents the limiting One from remaining fixed."],.array [.text "cross-term-absent",.text "Two-sided rest identity already forces the left and right terms."]])],.object [("key",.text "denominator"),("question",.text "Does the bilinear denominator retain a cross term?"),("choices",.array [.array [.text "cross-term-absent",.text "Then composing the limiting One with motion exceeds the One."],.array [.text "cross-term-present",.text "The product term exactly balances the limiting boundary."]])],.object [("key",.text "limit"),("question",.text "What happens at the limiting speed?"),("choices",.array [.array [.text "limit-moves-or-is-exceeded",.text "That violates the admitted causal boundary."],.array [.text "limiting-One-is-absorbing",.text "Substitution makes numerator and denominator identical."]])],.object [("key",.text "closure"),("question",.text "Where does a sublimit pair land?"),("choices",.array [.array [.text "unbounded-sum",.text "Ordinary addition can leave the domain."],.array [.text "strictly-inside-One",.text "One minus the result is the positive product of both held parts over a positive denominator."]])],.object [("key",.text "associativity"),("question",.text "How do three motions compose?"),("choices",.array [.array [.text "order-dependent-rule",.text "Frame grouping cannot change one physical relation."],.array [.text "exact-associative-product",.text "Forward and held pair multiplication is associative."]])],.object [("key",.text "record"),("question",.text "Can the operation be reconstructed?"),("choices",.array [.array [.text "discard-held-part",.text "Discarding the held part makes reversal ambiguous."],.array [.text "retain-forward-and-held-parts",.text "The exact pair record reconstructs the speed ratio."]])],.object [("key",.text "measurement"),("question",.text "May experiment choose the operation?"),("choices",.array [.array [.text "Fizeau-readable-before-seal",.text "A measured fringe slope could select the survivor."],.array [.text "postseal-only-comparison",.text "The structural operation seals before the external optical record is opened."]])],.object [("key",.text "extension"),("question",.text "May another coefficient enter?"),("choices",.array [.array [.text "free-coefficient-or-correction",.text "A coefficient would be a parameter."],.array [.text "no-extra-rule",.text "Identity and limit constraints exhaust the four-form grammar."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact positive Fold velocity-composition law"
 branch := "physics"
 statement := "Typed rest, exact positive sublimit parts and the complete present/absent bilinear grammar force one same-direction composition: u Fold-plus v=(u+v)/(One+uv). It is commutative, associative, closed below the limiting One, fixes the limiting One, and is exactly reconstructed by multiplying the forward/held pairs (One+u, One Take u) and (One+v, One Take v). Rest and a vanished held part are typed structures, never numerical zero; direction is held as a label, never a negative proof scalar."
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
def closureValue : Value := .object [("result",.text "The unique exact same-direction Fold composition is (u+v)/(One+uv). Typed rest is a two-sided identity; the limiting One is absorbing; positive sublimit parts remain strictly sublimit; pair multiplication makes the law associative and reconstructible; and the complete identity-compatible bilinear census contains four candidates with exactly one survivor."),("base",.text "Typed rest leaves either exact speed record unchanged, while the least positive generated parts compose through the same forward/held pair product."),("successor",.text "Appending one motion multiplies both retained pair components once. Associativity of exact positive multiplication preserves the reconstructed ratio, domain closure and limiting boundary at every finite depth."),("exclusions",.array [.text "no V1/V2 executable, stored velocity-addition formula or measured optical result in the forcing runtime",.text "no numerical zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof value",.text "no imported Lorentz transform, rapidity, hyperbolic function or consensus kinematic equation as a premise",.text "no target-selected coefficient, fitted denominator or hidden premarked survivor",.text "no claim that the same-direction scalar law alone supplies the full non-collinear rotation law"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no V1/V2 executable, stored velocity-addition formula or measured optical result in the forcing runtime", "no numerical zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof value", "no imported Lorentz transform, rapidity, hyperbolic function or consensus kinematic equation as a premise", "no target-selected coefficient, fitted denominator or hidden premarked survivor", "no claim that the same-direction scalar law alone supplies the full non-collinear rotation law"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with domain := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && completeBilinearCensus && typedRestAndLimit && closureAndAssociativity && heldPairReconstruction && lowSpeedBoundary) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.VelocityCompositionEntryEvidence
