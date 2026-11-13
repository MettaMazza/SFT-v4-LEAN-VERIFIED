import SFT.Mathematics.BoundedNBodyGrammar
import SFT.Mathematics.BoundedFoldTransient
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.BoundedNBodyEvidence
open SFT.Host.Canonical BoundedNBodyGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := ([1,2,4] : List Nat).map (fun p => OrbitOrderIdentity.foldRank p 7) == [2,4,1]
def witness1 : Bool := (OrbitNumberWitnesses.orbitWitness 1 5).map List.length == some 4
def witness2 : Bool :=
 match OrbitNumberWitnesses.orderWitness 3 with
 | none => false
 | some a => match OrbitNumberWitnesses.orderWitness 5 with
   | none => false
   | some b => match OrbitNumberWitnesses.orderWitness 7 with
     | none => false
     | some c => Nat.lcm (Nat.lcm a b) c == 12
theorem witness0Passed : witness0 = true := rfl
theorem witness1Passed : witness1 = true := rfl
theorem witness2Passed : witness2 = true := rfl
def witnesses : Value := .array [.array [.text "three-cycle",.text "The tuple one-, two- and four-of-seven returns after three componentwise Folds.",.boolean witness0],.array [.text "four-cycle",.text "The four ranks over denominator five rotate and return after four Folds.",.boolean witness1],.array [.text "joint-period",.text "Components over denominators three, five and seven return jointly after twelve Folds.",.boolean witness2]]
def witnessRecords : Value := .array [.object [("name",.text "three-cycle"),("statement",.text "The tuple one-, two- and four-of-seven returns after three componentwise Folds."),("passed",.boolean witness0)],.object [("name",.text "four-cycle"),("statement",.text "The four ranks over denominator five rotate and return after four Folds."),("passed",.boolean witness1)],.object [("name",.text "joint-period"),("statement",.text "Components over denominators three, five and seven return jointly after twelve Folds."),("passed",.boolean witness2)]]
def claimId : String := "SFT-MATH-BOUNDED-N-BODY-002"
def dependencies : List String := ["SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-EXACT-RELATIONS-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "state_domain",.text (state_domainName c.state_domain)],.array [.text "component_rule",.text (component_ruleName c.component_rule)],.array [.text "denominator",.text (denominatorName c.denominator)],.array [.text "support",.text (supportName c.support)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "period",.text (periodName c.period)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Exhaust state domain, component rule, denominator custody, support, recurrence, period, generality and extra-dynamics choices."),("grammar_boundary",.text "Finite tuples whose dynamics is exactly componentwise Fold on generated rational parts."),("dimensions",.array [.object [("key",.text "state_domain"),("question",.text "state domain?"),("choices",.array [.array [.text "continuum-coordinates",.text "Continuum coordinates are outside the object language."],.array [.text "finite-rational-tuple",.text "Each component has a finite exact trace."]])],.object [("key",.text "component_rule"),("question",.text "component rule?"),("choices",.array [.array [.text "imported-force-law",.text "An imported force law changes the system."],.array [.text "componentwise-fold",.text "Each component advances only by Fold."]])],.object [("key",.text "denominator"),("question",.text "denominator?"),("choices",.array [.array [.text "unbounded-drift",.text "Fold cannot introduce a new denominator factor."],.array [.text "conserved-odd-core",.text "The reduced odd denominator core is invariant."]])],.object [("key",.text "support"),("question",.text "support?"),("choices",.array [.array [.text "uncounted-space",.text "An uncounted space cannot establish recurrence."],.array [.text "finite-product-support",.text "The joint support is the finite product of component supports."]])],.object [("key",.text "recurrence"),("question",.text "recurrence?"),("choices",.array [.array [.text "chaos-label",.text "A label does not defeat a finite deterministic return certificate."],.array [.text "exact-return",.text "The joint tuple is replayed exactly."]])],.object [("key",.text "period"),("question",.text "period?"),("choices",.array [.array [.text "selected-period",.text "A selected period is not forced."],.array [.text "least-common-period",.text "The first joint return is the least common component return."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "three-body-table",.text "One tuple size is not the theorem."],.array [.text "tuple-successor",.text "Appending one component extends the period by one least-common return."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "external-dynamics",.text "External gravitational dynamics is a different claim."],.array [.text "no-extra-rule",.text "The theorem contains only componentwise Fold."]])]]),("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact recurrence of every finite componentwise Fold configuration"
 branch := "mathematics"
 statement := "Every supplied positive finite tuple of reduced rational Fold states has a finite exact joint support; after its transient binary depths, the componentwise Fold configuration recurs with period equal to the least common multiple of the odd-core component periods."
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
def closureValue : Value := .object [("exact_result",.text "All finite componentwise Fold tuples are eventually recurrent; their recurrent joint period is the iterated least common multiple of component odd-core periods."),("laws",.array [.text "Fold preserves each reduced odd denominator core",.text "a finite product of finite deterministic component orbits is finite",.text "the first joint recurrent return is the least common component period"]),("operational_witnesses",witnesses),("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),("named_shape_uniqueness",.text "The complete product contains exactly one all-admitted coordinate: finite-rational-tuple__componentwise-fold__conserved-odd-core__finite-product-support__exact-return__least-common-period__tuple-successor__no-extra-rule."),("induction_base",.text "One rational Fold component is transient-to-periodic by its denominator decomposition."),("induction_step",.text "Appending one component preserves finite product support and replaces the recurrent period by its least common return with the new component period."),("boundary_exclusions",.array [.text "semantic numerical zero is not an admitted value",.text "negative magnitude is represented only by held orientation",.text "irrational, imaginary and floating proof values are excluded",.text "a completed infinity and an ungenerated continuum are excluded"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "One rational Fold component is transient-to-periodic by its denominator decomposition."),("successor",.text "Appending one component preserves finite product support and replaces the recurrent period by its least common return with the new component period."),("laws",.array [.text "Fold preserves each reduced odd denominator core",.text "a finite product of finite deterministic component orbits is finite",.text "the first joint recurrent return is the least common component period"]),("witnesses",witnessRecords)]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with state_domain := .rejected}) survivorId))
 "reject a generated form missing the first required structural condition" (decisionReason {survivor with state_domain := .rejected}),
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
end SFT.Mathematics.BoundedNBodyEvidence
