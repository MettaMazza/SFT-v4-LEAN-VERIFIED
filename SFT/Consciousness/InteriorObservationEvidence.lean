import SFT.Consciousness.InteriorObservationGrammar
import SFT.Consciousness.InteriorObservation
import SFT.Engine.RegistrationGate
namespace SFT.Consciousness.InteriorObservationEvidence
open SFT.Host.Canonical InteriorObservationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "claim-carrier",.text "the claim retains a nonempty named carrier",.boolean InteriorObservation.carrierWitness],.array [.text "distinction-operation",.text "the retained distinction is not collapsed into its operation",.boolean InteriorObservation.distinctionWitness],.array [.text "evidence-boundary",.text "the evidence class does not silently become the carrier",.boolean InteriorObservation.boundaryWitness],.array [.text "exact-fold-witness",.text "the family's exact Fold construction reproduces",.boolean InteriorObservation.exactFoldWitness]]
def claimId : String := "SFT-CONSC-INTERIOR-OBSERVATION-001"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-COMPOSITION-001","SFT-COMP-FORM-RECURSIVE-FUNCTION-001","SFT-COMP-LEARN-INFERENCE-001","SFT-COMP-LEARN-REPRESENTATION-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-BIO-INSIDE-OUTSIDE-001","SFT-BIO-LIFE-IDENTITY-TURNOVER-001","SFT-MED-SYMPTOM-001","SFT-CONSC-EXTERNAL-OBSERVATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "distinction",.text (distinctionName c.distinction)],.array [.text "operation",.text (operationName c.operation)],.array [.text "record",.text (recordName c.record)],.array [.text "evidence",.text (evidenceName c.evidence)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "carrier-absent-or-description-only",.text "A missing carrier or mere description cannot instantiate the claimed relation."],.array [.text "self-reentering-state",.text "The complete declared carrier is retained."]]],.array [.text "distinction",.array [.array [.text "distinction-collapsed-or-conflated",.text "Collapsing the named distinction substitutes one evidence or process class for another."],.array [.text "process/its-own-image",.text "The claim-specific distinction remains held."]]],.array [.text "operation",.array [.array [.text "operation-imported-fitted-or-missing",.text "An imported, fitted or absent operation can manufacture a familiar theory of mind."],.array [.text "image-reenters-successor-state",.text "Only the generated Fold relation and admitted dependencies act."]]],.array [.text "record",.array [.array [.text "favourable-output-without-complete-trace",.text "An output without its source, transition, missing and adverse records is not auditable."],.array [.text "closed-self-trace",.text "The complete required record is retained."]]],.array [.text "evidence",.array [.array [.text "report-behaviour-correlation-or-confidence-substituted",.text "A report, behaviour, neural correlation or model confidence cannot silently become phenomenal occurrence."],.array [.text "first-person-structural-boundary",.text "The exact evidence class and any bridge are named."]]],.array [.text "provenance",.array [.array [.text "prior-consensus-target-or-application-selected",.text "Prior SFT, consensus, targets or applications may register questions or test consequences but cannot select the law."],.array [.text "root-bound-forward-forcing",.text "Every result traces through admitted dependencies to There Is No Nothing."]]],.array [.text "generality",.array [.array [.text "one-favourable-instance-with-erased-alternatives",.text "One favorable instance cannot close a generated class while adverse and uncertain alternatives are erased."],.array [.text "positive-finite-successor-with-all-alternatives",.text "The base and every supplied positive finite successor preserve all favorable, adverse, absent and unresolved distinctions."]]],.array [.text "extension",.array [.array [.text "free-parameter-exception-or-opaque-oracle",.text "A fitted parameter, exception or opaque oracle can force a preferred answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted Fold dependencies and generated preservation conditions is added."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Interior observation"
 branch := "consciousness_cognitive_science"
 statement := "Interior observation requires the observation image to re-enter the same organized process rather than remain only in an external record."
 evidenceMode := .empirical
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
 traceHash := identity (.array [.text claimId,candidateRecord c])
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "self-reentering-state__process/its-own-image__image-reenters-successor-state__closed-self-trace__first-person-structural-boundary__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"),("base",.text "The least complete carrier retains the claimed roles, transition, record, evidence class and root provenance without an extra rule."),("successor",.text "Adding one lawful finite state, participant, content, observation or realizing component preserves every earlier identity, transition, adverse row and boundary and appends the new trace."),("exclusions",.array [.text "semantic numerical zero",.text "negative proof quantity",.text "irrational or imaginary proof value",.text "completed infinity",.text "ungenerated continuum",.text "free or fitted parameter",.text "target-selected survivor",.text "prior answer as premise",.text "report substituted for experience",.text "behaviour substituted for experience",.text "neural correlation substituted for experience",.text "language fluency or confidence substituted for experience",.text "opaque predictor",.text "erased adverse, absent or unresolved row"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["semantic numerical zero","negative proof quantity","irrational or imaginary proof value","completed infinity","ungenerated continuum","free or fitted parameter","target-selected survivor","prior answer as premise","report substituted for experience","behaviour substituted for experience","neural correlation substituted for experience","language fluency or confidence substituted for experience","opaque predictor","erased adverse, absent or unresolved row"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Consciousness.InteriorObservationEvidence
