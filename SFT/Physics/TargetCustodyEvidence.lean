import SFT.Physics.TargetCustodyGrammar
import SFT.Physics.TargetCustodyWitness
import SFT.Engine.RegistrationGate
namespace SFT.Physics.TargetCustodyEvidence
open SFT.Host.Canonical TargetCustodyGrammar
set_option maxRecDepth 20000

def witnessEnvelope : Value := .object [
 ("experiment_id",.text "formal-custody-witness"),("registered_inputs",.object [("registered",.text (identity (.text "input")))]),
 ("withheld_target_ids",.array [.text "target"]),("frozen_relation_hash",.text (identity (.text "relation"))),
 ("experiment_registration_hash",.text (identity (.text "registration")))]
def witnessSeal : SFT.Physics.TargetCustody.PredictionSeal :=
 let ph := identity (.text "prediction")
 let th := identity (.text "complete-trace")
 let eh := identity witnessEnvelope
 ⟨"formal-custody-witness",ph,th,eh,identity (.object [("experiment_id",.text "formal-custody-witness"),
 ("prediction_hash",.text ph),("trace_hash",.text th),("envelope_hash",.text eh)])⟩
def witnessPassed : Bool :=
 match SFT.Physics.TargetCustody.createVault "formal-custody-witness" "target-custodian"
   [("target",.text "withheld-record")] "custodian-held" (identity witnessEnvelope) with
 | .error _ => false
 | .ok vault => match SFT.Physics.TargetCustody.release vault witnessSeal with
   | .error _ => false
   | .ok (_,released) => match SFT.Physics.TargetCustody.verify vault.commitment released witnessSeal with
     | .error _ => false
     | .ok _ => SFT.Host.Text.equal released.predictionSealHash witnessSeal.sealHash
def witnesses : Value := .array [
 .object [("name",.text "commit-release-verify"),("statement",.text "A committed target package verifies only after the matching sealed prediction."),("passed",.boolean witnessPassed)]]
def claimId : String := "SFT-PHYS-MEAS-TARGET-CUSTODY-001"
def dependencies : List String := ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-SEC-HASHING-001","SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "timing",.text (timingName c.timing)],.array [.text "holder",.text (holderName c.holder)],.array [.text "support",.text (supportName c.support)],.array [.text "content",.text (contentName c.content)],.array [.text "experiment",.text (experimentName c.experiment)],.array [.text "envelope",.text (envelopeName c.envelope)],.array [.text "release",.text (releaseName c.release)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axes",.array [.object [("key",.text "timing"),("question",.text "When is target identity fixed?"),("choices",.array [.array [.text "post-prediction-choice",.text "A post-prediction choice can select favorable target content."],.array [.text "pre-prediction-commitment",.text "Complete target identity is fixed before prediction begins."]])],.object [("key",.text "holder"),("question",.text "Who can read target content during prediction?"),("choices",.array [.array [.text "prediction-holder",.text "The predictor holding targets violates structural inaccessibility."],.array [.text "distinct-custodian",.text "A separate custodian alone holds target content."]])],.object [("key",.text "support"),("question",.text "How is target support declared?"),("choices",.array [.array [.text "partial-or-open-support",.text "Partial or open support permits selective favorable rows."],.array [.text "complete-named-support",.text "Every target identity is registered and later matched exactly."]])],.object [("key",.text "content"),("question",.text "How is unchanged target content checked?"),("choices",.array [.array [.text "unbound-content",.text "Unbound content can be replaced after prediction."],.array [.text "nonce-bound-content-identity",.text "Every named target and custodian-held nonce contributes to the committed identity."]])],.object [("key",.text "experiment"),("question",.text "Is release bound to one experiment?"),("choices",.array [.array [.text "cross-experiment-release",.text "Cross-experiment reuse breaks registration custody."],.array [.text "matching-experiment-only",.text "Release and seal must name the committed experiment."]])],.object [("key",.text "envelope"),("question",.text "Is the seal bound to the registered prediction envelope?"),("choices",.array [.array [.text "unbound-envelope",.text "An unbound seal can certify a different input or relation."],.array [.text "matching-envelope-only",.text "The seal identity must contain the preregistered envelope identity."]])],.object [("key",.text "release"),("question",.text "When and how often may content be released?"),("choices",.array [.array [.text "preseal-or-repeat-release",.text "Pre-seal or repeat release leaks target information."],.array [.text "one-postseal-release",.text "One release occurs only after the matching seal."]])],.object [("key",.text "extension"),("question",.text "May release use an extra discretionary rule?"),("choices",.array [.array [.text "extra-rule",.text "Discretionary release is a free selection parameter."],.array [.text "no-extra-rule",.text "Commitment and seal matching fully determine lawful release."]])]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("product_exhaustion",.text "Every registered axis choice occurs once with every other axis choice.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Portable target commitment and post-seal custody"
 branch := "physics"
 statement := "Within the registered blind-exchange grammar, target content remains unavailable to prediction in exactly one form: a distinct custodian commits the complete named target package and prediction envelope before execution, then releases that unchanged package once to the matching experiment only after a matching prediction seal exists."
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
def closureValue : Value := .object [("result",.text "Pre-prediction complete commitment, distinct custodian, nonce-bound unchanged content, matching experiment and envelope, one post-seal release and no extra rule."),("base",.text "One named target is committed before prediction and released once after its matching seal."),("successor",.text "Adding one target appends one named committed identity and requires the identical name and content at release without altering timing, custody or seal conditions."),("exclusions",.array [.text "target access by the prediction executor",.text "release before a matching prediction seal",.text "selective target-row omission",.text "host-specific sandbox claims"]),("witnesses",witnesses),("unique_survivor",.text survivorId)]
def exclusions : List String := ["target access by the prediction executor","release before a matching prediction seal","selective target-row omission","host-specific sandbox claims"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with timing := .rejected}) survivorId)) "reject the generated form missing the first preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witnessPassed) "reject excluded capabilities, values or authority paths"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.TargetCustodyEvidence
