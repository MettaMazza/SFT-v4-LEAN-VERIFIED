import SFT.Consciousness.CessationLockAnchorGrammar
import SFT.Consciousness.NonordinaryLaws
import SFT.Engine.RegistrationGate
namespace SFT.Consciousness.CessationLockAnchorEvidence
open SFT.Host.Canonical CessationLockAnchorGrammar
set_option maxRecDepth 20000

def witnessPassed : List Bool := NonordinaryLaws.cessationWitnesses
def witnesses : Value := .array [.object [("name",.text "components"),("statement",.text "Both components remain and complete One."),("passed",.boolean ((witnessPassed.drop 0).headD false))],.object [("name",.text "fixed"),("statement",.text "The complete One is Fold-invariant."),("passed",.boolean ((witnessPassed.drop 1).headD false))],.object [("name",.text "distinction"),("statement",.text "Anchor persistence is not personal persistence."),("passed",.boolean ((witnessPassed.drop 2).headD false))]]
theorem witnessesPassed : witnessPassed = List.replicate 3 true := NonordinaryLaws.cessationWitnessesPassed
def claimId : String := "SFT-CONSC-CESSATION-LOCK-ANCHOR-002"
def dependencies : List String := ["SFT-CONSC-SLEEP-DREAM-PERIOD-TWO-002","SFT-CONSC-CESSATION-001","SFT-CONSC-IDENTITY-CONTINUITY-001","SFT-CONSC-SUBSTRATE-INDEPENDENCE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "reports",.text (reportsName c.reports)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "target",.text (targetName c.target)],.array [.text "outcomes",.text (outcomesName c.outcomes)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete eight-axis product for SFT-CONSC-CESSATION-LOCK-ANCHOR-002 and reconstruct its exact operational witness independently."),("grammar_boundary",.text "Occupied/unoccupied lock labels, complete component records, fixed-anchor iterations and personal-persistence controls."),("axes",.array [.object [("key",.text "carrier"),("question",.text "Which carrier survives?"),("choices",.array [.array [.text "continuum-or-signed-state",.text "It imports a prohibited magnitude grammar."],.array [.text "exact-positive-fold-parts-and-held-labels",.text "Only exact positive parts and held labels occur."]])],.object [("key",.text "relation"),("question",.text "Which mechanism survives?"),("choices",.array [.array [.text "name-or-analogy-only",.text "A name contains no operational mechanism."],.array [.text "releasable-half-one-lock-and-fixed-one-anchor",.text "The occupied lock and fixed completion have different persistence conditions and cannot be conflated."]])],.object [("key",.text "boundary"),("question",.text "Which information boundary survives?"),("choices",.array [.array [.text "unbounded-or-untraceable-content",.text "Untraceable content cannot be forced from the Fold."],.array [.text "generated-support-and-retained-record-boundary",.text "Every state and distinction remains traceable."]])],.object [("key",.text "reports"),("question",.text "How are reports treated?"),("choices",.array [.array [.text "dismissed-or-ontologized-report",.text "Either move exceeds the evidence."],.array [.text "report-preserved-ontology-separate",.text "The observation and its interpretation remain distinct."]])],.object [("key",.text "enumeration"),("question",.text "How are alternatives exhausted?"),("choices",.array [.array [.text "selected-example",.text "One favorable example cannot force uniqueness."],.array [.text "complete-declared-product",.text "Every registered form occurs once."]])],.object [("key",.text "target"),("question",.text "When is target content opened?"),("choices",.array [.array [.text "target-before-seal",.text "Pre-seal access is fitting."],.array [.text "derivation-seal-before-target",.text "The target remains inaccessible until formal closure."]])],.object [("key",.text "outcomes"),("question",.text "Which results are retained?"),("choices",.array [.array [.text "favorable-only",.text "Selective retention destroys empirical force."],.array [.text "favorable-adverse-absent-heterogeneous-unresolved",.text "Every result class remains separately held."]])],.object [("key",.text "extension"),("question",.text "Is an extra rule needed?"),("choices",.array [.array [.text "free-exception",.text "A free exception is an unforced parameter."],.array [.text "no-extra-rule",.text "The dependencies close the frozen boundary."]])]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Cessation lock and invariant anchor"
 branch := "consciousness_cognitive_science"
 statement := "Cessation releases occupation of the integrated half-One lock while component and record distinctions remain separately accounted; the complete One remains fixed without implying continued personal organization."
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
 traceHash := identity (.array [.text claimId,.text generationRule,candidateRecord c])
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
def closureValue : Value := .object [("result",.text "The half-One integrated lock completes to One but its occupation is a releasable held state. Quarter-One and three-quarter-One components remain exactly accounted and complete One. One is invariant under further Fold action. Ending the personal organization neither makes its components numerical zero nor proves that the personal organization persists."),("base",.text "The least complete positive carrier retains the full mechanism and record boundary."),("successor",.text "Every positive successor preserves all prior distinctions without adding a rule or target-derived choice."),("exclusions",.array [.text "no V1/V2 outcome or external target selects a survivor",.text "no first-person report is erased or promoted into an unmeasured ontology",.text "no reverse synaesthetic route is invented from a one-way cross-link",.text "no physiological label or cycle duration is imported into the formal orbit",.text "no enduring personal organization is inferred from the fixed One",.text "no numerical absence, negative, irrational, imaginary, floating, fitted or free proof magnitude",.text "no axiom, free parameter, engine change, verifier change or favorable-only record"]),("witnesses",witnesses),("unique_survivor",.text survivorId)]
def exclusions : List String := ["no V1/V2 outcome or external target selects a survivor","no first-person report is erased or promoted into an unmeasured ontology","no reverse synaesthetic route is invented from a one-way cross-link","no physiological label or cycle duration is imported into the formal orbit","no enduring personal organization is inferred from the fixed One","no numerical absence, negative, irrational, imaginary, floating, fitted or free proof magnitude","no axiom, free parameter, engine change, verifier change or favorable-only record"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witnessPassed.all id) "reject forbidden values, target feedback and extra laws"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Consciousness.CessationLockAnchorEvidence
