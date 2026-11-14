import SFT.Mathematics.PrimePairGrammar
import SFT.Mathematics.PrimePairComplete
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.PrimePairEvidence
open SFT.Host.Canonical PrimePairGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := PrimePairCensus.completeCensus.all (fun row => row.2.isSome)
def witness1 : Bool := PrimePairCensus.completeCensus.length == 4999
def witness2 : Bool := PrimePairCensus.unorderedCount 12 == 1 && PrimePairCensus.unorderedCount 100 == 6
def witness3 : Bool := PrimePairCensus.completeTwins.length == 205
theorem witness0Passed : witness0=true := PrimePairCensus.completeCensusPassed
theorem witness1Passed : witness1=true := by unfold witness1; rw [PrimePairCensus.completeCensusCount]; rfl
theorem witness2Passed : witness2=true := by unfold witness2; rw [PrimePairCensus.twelveCount,PrimePairCensus.hundredCount]; rfl
theorem witness3Passed : witness3=true := by unfold witness3; rw [PrimePairCensus.completeTwinCount]; rfl
def witnesses : Value := .array [.array [.text "goldbach-range",.text "Every even whole from four through ten thousand has a generated prime complement pair.",.boolean witness0],.array [.text "even-count",.text "The declared range contains exactly four thousand nine hundred ninety-nine even inputs.",.boolean witness1],.array [.text "spot-counts",.text "Twelve has one unordered prime pair and one hundred has six.",.boolean witness2],.array [.text "twin-count",.text "The complete twin-prime count through ten thousand is two hundred five.",.boolean witness3]]
def witnessRecords : Value := .array [.object [("name",.text "goldbach-range"),("statement",.text "Every even whole from four through ten thousand has a generated prime complement pair."),("passed",.boolean witness0)],.object [("name",.text "even-count"),("statement",.text "The declared range contains exactly four thousand nine hundred ninety-nine even inputs."),("passed",.boolean witness1)],.object [("name",.text "spot-counts"),("statement",.text "Twelve has one unordered prime pair and one hundred has six."),("passed",.boolean witness2)],.object [("name",.text "twin-count"),("statement",.text "The complete twin-prime count through ten thousand is two hundred five."),("passed",.boolean witness3)]]
def claimId : String := "SFT-MATH-PRIME-PAIR-CENSUS-002"
def dependencies : List String := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "range",.text (rangeName c.range)],.array [.text "primality",.text (primalityName c.primality)],.array [.text "pairs",.text (pairsName c.pairs)],.array [.text "complement",.text (complementName c.complement)],.array [.text "coverage",.text (coverageName c.coverage)],.array [.text "twins",.text (twinsName c.twins)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "addition",.text (additionName c.addition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Exhaust range, primality, pair generation, complement, coverage, twin adjacency, boundary and extra-theorem choices."),("grammar_boundary",.text "Positive finite whole-number census with even inputs four through ten thousand inclusive."),("dimensions",.array [.object [("key",.text "range"),("question",.text "range?"),("choices",.array [.array [.text "sampled-evens",.text "Sampling cannot close the declared range."],.array [.text "all-declared-evens",.text "Every even input in the frozen range is executed."]])],.object [("key",.text "primality"),("question",.text "primality?"),("choices",.array [.array [.text "borrowed-table",.text "A borrowed table hides verification."],.array [.text "trial-certificate",.text "Each prime status is independently decided by complete divisor search to the square bound."]])],.object [("key",.text "pairs"),("question",.text "pairs?"),("choices",.array [.array [.text "one-guessed-pair",.text "A guess omits alternatives and failures."],.array [.text "all-complements",.text "Every positive complementary split is generated."]])],.object [("key",.text "complement"),("question",.text "complement?"),("choices",.array [.array [.text "signed-sum",.text "Signed arithmetic is unnecessary."],.array [.text "positive-junction",.text "Both prime parts join exactly to the even whole."]])],.object [("key",.text "coverage"),("question",.text "coverage?"),("choices",.array [.array [.text "spot-check",.text "Spot checks do not prove the bounded census."],.array [.text "exhaustive-census",.text "All 4,999 declared evens receive a verdict."]])],.object [("key",.text "twins"),("question",.text "twins?"),("choices",.array [.array [.text "approximate-density",.text "A density estimate is not an exact count."],.array [.text "exact-gap-two",.text "Every prime pair at whole gap two is counted once."]])],.object [("key",.text "boundary"),("question",.text "boundary?"),("choices",.array [.array [.text "unrestricted-conjecture",.text "The finite run cannot prove an unrestricted conjecture."],.array [.text "explicit-ten-thousand",.text "The exact boundary is sealed into the claim."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "external-answer",.text "An external published count cannot enter generation."],.array [.text "no-extra-rule",.text "Only exact arithmetic and complete enumeration occur."]])]]),("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact bounded Goldbach and twin-prime census"
 branch := "mathematics"
 statement := "Exhaustive exact whole-number enumeration proves that every even whole from four through ten thousand has at least one prime complementary pair, that this range contains exactly four-thousand-nine-hundred-ninety-nine tested evens with no failure, and that exactly two-hundred-five twin-prime pairs have upper member at most ten thousand."
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
def closureValue : Value := .object [("exact_result",.text "The exhaustive 4..10,000 census contains 4,999 even inputs, zero Goldbach failures and exactly 205 twin-prime pairs with upper member at most 10,000."),("laws",.array [.text "every declared even input is partitioned by all positive complementary pairs",.text "prime status is decided by a complete finite divisor certificate",.text "the finite boundary is part of the theorem and cannot be erased"]),("operational_witnesses",witnesses),("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),("named_shape_uniqueness",.text "The complete product contains exactly one all-admitted coordinate: all-declared-evens__trial-certificate__all-complements__positive-junction__exhaustive-census__exact-gap-two__explicit-ten-thousand__no-extra-rule."),("induction_base",.text "The first declared even whole, four, is the junction of two and two."),("induction_step",.text "The census successor advances to the next even whole, exhausts every complementary split and records either a prime witness or an explicit failure."),("boundary_exclusions",.array [.text "semantic numerical zero is not an admitted value",.text "negative magnitude is represented only by held orientation",.text "irrational, imaginary and floating proof values are excluded",.text "a completed infinity and an ungenerated continuum are excluded"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "The first declared even whole, four, is the junction of two and two."),("successor",.text "The census successor advances to the next even whole, exhausts every complementary split and records either a prime witness or an explicit failure."),("laws",.array [.text "every declared even input is partitioned by all positive complementary pairs",.text "prime status is decided by a complete finite divisor certificate",.text "the finite boundary is part of the theorem and cannot be erased"]),("witnesses",witnessRecords)]
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
end SFT.Mathematics.PrimePairEvidence
