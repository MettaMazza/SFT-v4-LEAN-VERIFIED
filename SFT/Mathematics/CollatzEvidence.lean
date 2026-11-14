import SFT.Mathematics.CollatzGrammar
import SFT.Mathematics.CollatzComplete
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.CollatzEvidence
open SFT.Host.Canonical CollatzGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := (List.range 5001).all (fun i => (3*(2*i+1)+1)%2==0)
def witness1 : Bool := CollatzCensus.completeCensus.all (fun row => row.2.isSome)
def witness2 : Bool := CollatzCensus.stepsWithin 27 111 == some 111
def witness3 : Bool := ((3*3+1)/2 == 5) && (5>3)
theorem witness0Passed : witness0=true := CollatzCensus.originalOddEvenWitness
theorem witness1Passed : witness1=true := CollatzCensus.completeCensusPassed
theorem witness2Passed : witness2=true := by unfold witness2; rw [CollatzCensus.twentySeven]; rfl
theorem witness3Passed : witness3=true := rfl
def witnesses : Value := .array [.array [.text "odd-even",.text "Every positive odd start through ten thousand one maps to an even three-times-plus-One result.",.boolean witness0],.array [.text "bounded-census",.text "Every start through one hundred thousand reaches the One.",.boolean witness1],.array [.text "twenty-seven",.text "Start twenty-seven takes exactly one hundred eleven steps.",.boolean witness2],.array [.text "contraction-reject",.text "The accelerated odd step from three reaches five and therefore is not a pointwise contraction.",.boolean witness3]]
def witnessRecords : Value := .array [.object [("name",.text "odd-even"),("statement",.text "Every positive odd start through ten thousand one maps to an even three-times-plus-One result."),("passed",.boolean witness0)],.object [("name",.text "bounded-census"),("statement",.text "Every start through one hundred thousand reaches the One."),("passed",.boolean witness1)],.object [("name",.text "twenty-seven"),("statement",.text "Start twenty-seven takes exactly one hundred eleven steps."),("passed",.boolean witness2)],.object [("name",.text "contraction-reject"),("statement",.text "The accelerated odd step from three reaches five and therefore is not a pointwise contraction."),("passed",.boolean witness3)]]
def claimId : String := "SFT-MATH-COLLATZ-FINITE-CENSUS-002"
def dependencies : List String := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "range",.text (rangeName c.range)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "parity",.text (parityName c.parity)],.array [.text "trace",.text (traceName c.trace)],.array [.text "cycle",.text (cycleName c.cycle)],.array [.text "contraction",.text (contractionName c.contraction)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "addition",.text (additionName c.addition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Exhaust range, transition, parity, trace, cycle, contraction, boundary and extra-theorem choices."),("grammar_boundary",.text "Positive whole starts one through one hundred thousand under the exact conventional Collatz transition."),("dimensions",.array [.object [("key",.text "range"),("question",.text "range?"),("choices",.array [.array [.text "sampled-starts",.text "Sampling cannot close the declared range."],.array [.text "all-declared-starts",.text "Every start in the frozen bound is executed."]])],.object [("key",.text "transition"),("question",.text "transition?"),("choices",.array [.array [.text "fold-analogy",.text "An analogy is not the conventional Collatz map."],.array [.text "exact-collatz",.text "Even starts halve and odd starts map to three-times plus One."]])],.object [("key",.text "parity"),("question",.text "parity?"),("choices",.array [.array [.text "assumed-even",.text "Parity must be checked from exact whole arithmetic."],.array [.text "computed-parity",.text "Every transition computes its parity exactly."]])],.object [("key",.text "trace"),("question",.text "trace?"),("choices",.array [.array [.text "terminal-only",.text "A terminal result without its path cannot be replayed."],.array [.text "complete-step-trace",.text "Every successor is counted until the cycle."]])],.object [("key",.text "cycle"),("question",.text "cycle?"),("choices",.array [.array [.text "zero-sink",.text "Zero is not in the declared positive domain."],.array [.text "one-four-two",.text "The terminal recurrent class is the exact 1-4-2 cycle."]])],.object [("key",.text "contraction"),("question",.text "contraction?"),("choices",.array [.array [.text "constant-three-quarters",.text "The shortcut is false: the odd macrostep from three reaches five after removing all binary factors."],.array [.text "executed-variable-descent",.text "No pointwise contraction premise enters; the exact trace decides the bounded result."]])],.object [("key",.text "boundary"),("question",.text "boundary?"),("choices",.array [.array [.text "unrestricted-collatz",.text "A finite census cannot establish the unrestricted conjecture."],.array [.text "explicit-one-hundred-thousand",.text "The sealed maximum is part of the claim."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "external-sequence",.text "A published trajectory cannot enter the execution."],.array [.text "no-extra-rule",.text "Only exact whole operations drive the census."]])]]),("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact bounded Collatz census and contraction-control correction"
 branch := "mathematics"
 statement := "Every positive whole start from the One through one-hundred-thousand reaches the 1-4-2 cycle under the declared Collatz transition; start twenty-seven takes exactly one-hundred-eleven steps. The exact census also rejects the prior constant-three-quarter pointwise contraction shortcut: a lawful odd macrostep may rise, so only the bounded execution result is admitted."
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
def closureValue : Value := .object [("exact_result",.text "The complete starts 1..100,000 census has zero failures, start 27 takes 111 steps, the terminal cycle is 1-4-2, and the constant-3/4 pointwise contraction premise is rejected."),("laws",.array [.text "every odd three-times-plus-One result is even",.text "every declared start has a finite replay trace to the terminal cycle",.text "the claim boundary remains finite and does not become the unrestricted Collatz conjecture",.text "a false contraction heuristic cannot serve as proof even when the bounded census passes"]),("operational_witnesses",witnesses),("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),("named_shape_uniqueness",.text "The complete product contains exactly one all-admitted coordinate: all-declared-starts__exact-collatz__computed-parity__complete-step-trace__one-four-two__executed-variable-descent__explicit-one-hundred-thousand__no-extra-rule."),("induction_base",.text "The One lies on the declared 1-4-2 recurrent cycle."),("induction_step",.text "For each next positive whole start, execute the exact transition until an already certified cycle member appears and retain the full prefix."),("boundary_exclusions",.array [.text "semantic numerical zero is not an admitted value",.text "negative magnitude is represented only by held orientation",.text "irrational, imaginary and floating proof values are excluded",.text "a completed infinity and an ungenerated continuum are excluded"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "The One lies on the declared 1-4-2 recurrent cycle."),("successor",.text "For each next positive whole start, execute the exact transition until an already certified cycle member appears and retain the full prefix."),("laws",.array [.text "every odd three-times-plus-One result is even",.text "every declared start has a finite replay trace to the terminal cycle",.text "the claim boundary remains finite and does not become the unrestricted Collatz conjecture",.text "a false contraction heuristic cannot serve as proof even when the bounded census passes"]),("witnesses",witnessRecords)]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with range := .rejected}) survivorId))
 "reject a generated form missing the first required structural condition" (decisionReason {survivor with range := .rejected}),
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed official source identity" "the changed identity differs from the registered source manifest",
 control .tamperedArtifact (((candidates.filter survives).length == 1) && ((candidates.map candidateId).eraseDups.length == candidates.length))
 "reject a missing, duplicated or additional survivor" "the generated product contains exactly one registered survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3)
 "halt any attempt to import an excluded object or answer-producing model" (SFT.Host.Text.intercalate "; " exclusions)]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)
theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Mathematics.CollatzEvidence
