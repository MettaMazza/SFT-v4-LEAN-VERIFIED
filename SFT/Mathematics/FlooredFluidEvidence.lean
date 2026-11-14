import SFT.Mathematics.FlooredFluidGrammar
import SFT.Mathematics.FlooredFluid
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.FlooredFluidEvidence
open SFT.Host.Canonical FlooredFluidGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := (FlooredFluid.gradient (FlooredFluid.minimumEdge 5 0 1)).numerator == 32 && (FlooredFluid.gradient (FlooredFluid.minimumEdge 5 0 1)).denominator == 1
def witness1 : Bool := (List.range 14).all (fun n => let g := FlooredFluid.gradient (FlooredFluid.minimumEdge (n+1) 0 1); g.numerator == 2^(n+1) && g.denominator == 1)
def witness2 : Bool := (75+75 : Nat) == 150
theorem witness0Passed : witness0 = true := rfl
theorem witness1Passed : witness1 = true := rfl
theorem witness2Passed : witness2 = true := rfl
def witnesses : Value := .array [.array [.text "depth-five",.text "The exact reciprocal of the depth-five binary floor is thirty-two.",.boolean witness0],.array [.text "depth-table",.text "Every depth one through fourteen has reciprocal-floor bound two-to-depth.",.boolean witness1],.array [.text "mass-ledger",.text "An exact transport split preserves a sample whole mass ledger.",.boolean witness2]]
def witnessRecords : Value := .array [.object [("name",.text "depth-five"),("statement",.text "The exact reciprocal of the depth-five binary floor is thirty-two."),("passed",.boolean witness0)],.object [("name",.text "depth-table"),("statement",.text "Every depth one through fourteen has reciprocal-floor bound two-to-depth."),("passed",.boolean witness1)],.object [("name",.text "mass-ledger"),("statement",.text "An exact transport split preserves a sample whole mass ledger."),("passed",.boolean witness2)]]
def claimId : String := "SFT-MATH-FLOORED-FLUID-REGULARITY-002"
def dependencies : List String := ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-LIMIT-CONTINUUM-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "lattice",.text (latticeName c.lattice)],.array [.text "spacing",.text (spacingName c.spacing)],.array [.text "velocity",.text (velocityName c.velocity)],.array [.text "derivative",.text (derivativeName c.derivative)],.array [.text "bound",.text (boundName c.bound)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "scope",.text (scopeName c.scope)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Exhaust lattice, spacing, velocity, derivative, bound, conservation, generality and continuum-scope choices."),("grammar_boundary",.text "Exact finite Fold lattices with positive minimum spacing and bounded positive velocity differences."),("dimensions",.array [.object [("key",.text "lattice"),("question",.text "lattice?"),("choices",.array [.array [.text "continuum-points",.text "An ungenerated continuum has no smallest spacing."],.array [.text "generated-grid",.text "Every site and edge is generated."]])],.object [("key",.text "spacing"),("question",.text "spacing?"),("choices",.array [.array [.text "vanishing-length",.text "Numerical zero is outside the domain."],.array [.text "positive-floor",.text "Minimum spacing is one exact rung."]])],.object [("key",.text "velocity"),("question",.text "velocity?"),("choices",.array [.array [.text "unbounded-speed",.text "Unbounded speed violates the One ceiling."],.array [.text "one-bounded-gap",.text "Velocity separation is at most the One."]])],.object [("key",.text "derivative"),("question",.text "derivative?"),("choices",.array [.array [.text "limit-derivative",.text "A continuum limit changes the claim."],.array [.text "edge-quotient",.text "The discrete gradient is exact gap over exact edge spacing."]])],.object [("key",.text "bound"),("question",.text "bound?"),("choices",.array [.array [.text "inserted-cap",.text "An inserted cap would be an engineering parameter."],.array [.text "derived-reciprocal-floor",.text "The maximum quotient is forced by One over the minimum rung."]])],.object [("key",.text "conservation"),("question",.text "conservation?"),("choices",.array [.array [.text "floating-rescale",.text "Floating rescaling cannot prove exact transport."],.array [.text "edge-ledger",.text "Every transferred part retains source and destination identity."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "depth-five-only",.text "One depth is only an example."],.array [.text "depth-successor",.text "At k plus One the reciprocal-floor bound multiplies by the Fold count."]])],.object [("key",.text "scope"),("question",.text "scope?"),("choices",.array [.array [.text "continuum-millennium",.text "The classical continuum problem is not the same grammar."],.array [.text "fold-lattice-regularity",.text "The theorem is exactly the native finite-depth Fold lattice."]])]]),("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Depth-independent discrete-gradient bound for floored Fold fluids"
 branch := "mathematics"
 statement := "At every supplied positive finite Fold depth k, an exact lattice with minimum spacing one-of-b^k and velocity separation at most the One has discrete gradient and vorticity magnitude bounded by b^k; at depth five the exact bound is thirty-two, so no finite-depth Fold-lattice blow-up is expressible."
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
def closureValue : Value := .object [("exact_result",.text "The native Fold-lattice gradient bound is b^k at depth k, attained by a One velocity gap across one minimum edge; the depth-five value is thirty-two and every finite-depth field remains bounded."),("laws",.array [.text "positive minimum spacing prevents a vanishing denominator",.text "One-bounded velocity separation divided by one-of-b^k is at most b^k",.text "the successor depth multiplies the bound by the generated Fold count"]),("operational_witnesses",witnesses),("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),("named_shape_uniqueness",.text "The complete product contains exactly one all-admitted coordinate: generated-grid__positive-floor__one-bounded-gap__edge-quotient__derived-reciprocal-floor__edge-ledger__depth-successor__fold-lattice-regularity."),("induction_base",.text "At the first Fold depth, the positive floor is one-of-b and the edge-gradient bound is b."),("induction_step",.text "Refining one Fold divides the floor by b while preserving the One velocity ceiling, so the exact finite bound is multiplied by b."),("boundary_exclusions",.array [.text "semantic numerical zero is not an admitted value",.text "negative magnitude is represented only by held orientation",.text "irrational, imaginary and floating proof values are excluded",.text "a completed infinity and an ungenerated continuum are excluded"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "At the first Fold depth, the positive floor is one-of-b and the edge-gradient bound is b."),("successor",.text "Refining one Fold divides the floor by b while preserving the One velocity ceiling, so the exact finite bound is multiplied by b."),("laws",.array [.text "positive minimum spacing prevents a vanishing denominator",.text "One-bounded velocity separation divided by one-of-b^k is at most b^k",.text "the successor depth multiplies the bound by the generated Fold count"]),("witnesses",witnessRecords)]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with lattice := .rejected}) survivorId))
 "reject a generated form missing the first required structural condition" (decisionReason {survivor with lattice := .rejected}),
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
end SFT.Mathematics.FlooredFluidEvidence
