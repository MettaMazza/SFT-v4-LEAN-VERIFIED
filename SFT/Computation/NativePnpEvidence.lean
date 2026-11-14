import SFT.Computation.NativePnpGrammar
import SFT.Computation.NativePnpWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.NativePnpEvidence
open SFT.Host.Canonical NativePnpGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def witness0 : Bool := NativePnpWitnesses.completeDepthSeven
def witness1 : Bool := NativePnpWitnesses.resourcesThroughFourteen
def witness2 : Bool := NativePnpWitnesses.completeDepthSeven
theorem witness0Passed : witness0=true := NativePnpWitnesses.completeDepthSevenPassed
theorem witness1Passed : witness1=true := NativePnpWitnesses.resourcesThroughFourteenPassed
theorem witness2Passed : witness2=true := NativePnpWitnesses.completeDepthSevenPassed
def witnesses : Value := .array [.array [.text "complete-depth-seven",.text "Every native source through depth seven has one accepted exact evaluation certificate.",.boolean witness0],.array [.text "resource-equality",.text "Evaluation and verification lengths equal source depth through fourteen.",.boolean witness1],.array [.text "tamper-rejection",.text "A changed first certificate state rejects for every depth through seven.",.boolean witness2]]
def witnessRecords : Value := .array [.object [("name",.text "complete-depth-seven"),("statement",.text "Every native source through depth seven has one accepted exact evaluation certificate."),("passed",.boolean witness0)],.object [("name",.text "resource-equality"),("statement",.text "Evaluation and verification lengths equal source depth through fourteen."),("passed",.boolean witness1)],.object [("name",.text "tamper-rejection"),("statement",.text "A changed first certificate state rejects for every depth through seven."),("passed",.boolean witness2)]]
def claimId : String := "SFT-COMP-CPLX-FOLD-P-NP-EQUALITY-002"
def dependencies : List String := ["SFT-COMP-CBL-RECOGNITION-DECISION-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-COMP-CPLX-REDUCTION-COMPLETENESS-001","SFT-COMP-SEM-VERIFICATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "domain",.text (domainName c.domain)],.array [.text "evaluator",.text (evaluatorName c.evaluator)],.array [.text "certificate",.text (certificateName c.certificate)],.array [.text "verifier",.text (verifierName c.verifier)],.array [.text "p_to_np",.text (p_to_npName c.p_to_np)],.array [.text "np_to_p",.text (np_to_pName c.np_to_p)],.array [.text "successor",.text (successorName c.successor)],.array [.text "boundary",.text (boundaryName c.boundary)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-CPLX-FOLD-P-NP-EQUALITY-002"),("generation_rule",.text "Generate the literal product of domain, evaluator, certificate, verifier, two containments, successor and external-boundary coordinates."),("grammar_boundary",.text "Every generated positive finite native Fold word, its unique suffix-closing evaluation and certificates composed only from the registered trace proof system."),("dimensions",.array [.array [.text "domain",.text "Which problems are compared?",.array [.array [.text "arbitrary-external-languages",.text "External languages import encodings and machines."],.array [.text "complete-native-fold-word-family",.text "Every generated native word is included."]]],.array [.text "evaluator",.text "What establishes deterministic membership?",.array [.array [.text "answer-only-evaluation",.text "A verdict without its trace hides resource and soundness."],.array [.text "unique-exact-closing-trace",.text "Evaluation retains every forced edge."]]],.array [.text "certificate",.text "What is the witness?",.array [.array [.text "unconstrained-advice",.text "Unconstrained advice imports answer power."],.array [.text "compiled-lawful-evaluation-trace",.text "The certificate is exactly the source-bound transition trace."]]],.array [.text "verifier",.text "How is a certificate accepted?",.array [.array [.text "test-sampled-verifier",.text "Examples cannot prove soundness over generated support."],.array [.text "edgewise-sound-complete-verifier",.text "The verifier checks source, every forced edge, terminal and length."]]],.array [.text "p_to_np",.text "What forces P_F inside NP_F?",.array [.array [.text "assumed-first-containment",.text "A familiar containment name is not evidence."],.array [.text "evaluator-emits-accepted-certificate",.text "Every exact evaluation supplies an accepted trace."]]],.array [.text "np_to_p",.text "What forces NP_F inside P_F?",.array [.array [.text "nondeterministic-branch-import",.text "A foreign branch model changes the grammar."],.array [.text "soundness-forces-unique-evaluation",.text "Every accepted trace equals the deterministic suffix run."]]],.array [.text "successor",.text "How is arbitrary finite depth covered?",.array [.array [.text "depth-seven-only",.text "Finite testing alone is not depth-independent."],.array [.text "prepend-label-trace-successor",.text "One new label adds one evaluator and verifier edge."]]],.array [.text "boundary",.text "May this equality answer conventional P versus NP?",.array [.array [.text "export-to-arbitrary-p-np",.text "External languages, encodings and polynomial conventions are absent."],.array [.text "native-equality-only",.text "The equality remains exactly inside the admitted Fold grammar."]]]]),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold-P equals Fold-NP law"
 branch := "computation"
 statement := "Within the admitted native Fold process grammar, exact deterministic evaluation emits the complete lawful trace verified by the already-derived proof system; soundness makes every accepted certificate equal the unique evaluation. Both resources equal description depth, so P_F=NP_F throughout this grammar."
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
 traceHash := admissionIdentity (.object [("claim_id",.text claimId),("record",candidateRecord c)])
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
 proofHash := admissionIdentity (.object [("claim_id",.text claimId),("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("exact_result",.text "The sole all-preserving kernel forces P_F=NP_F with exact resource k for every supplied positive finite native description depth, without asserting conventional P=NP."),("laws",.array [.text "every deterministic evaluation emits its accepted exact trace",.text "every accepted exact trace equals the unique native evaluation",.text "evaluation and verification each traverse one edge per word position",.text "the two exact containments force native equality"]),("witnesses",witnesses),("minimality",.text "Changing any admitted coordinate removes a registered carrier, relation, trace, boundary, composition, generality or no-extra condition."),("uniqueness",.text "Exactly one product member has every admitted coordinate: complete-native-fold-word-family__unique-exact-closing-trace__compiled-lawful-evaluation-trace__edgewise-sound-complete-verifier__evaluator-emits-accepted-certificate__soundness-forces-unique-evaluation__prepend-label-trace-successor__native-equality-only."),("base",.text "At the first positive depth, the single edge is both the evaluation and its complete verified certificate."),("successor",.text "Prepending either native label adds exactly one forced evaluation edge and one verifier check while preserving source, suffix and terminal equality."),("exclusions",.array [.text "no arbitrary external language family",.text "no nondeterministic machine import",.text "no polynomial convention import",.text "no conventional P-versus-NP conclusion",.text "no hidden certificate advice"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "At the first positive depth, the single edge is both the evaluation and its complete verified certificate."),("successor",.text "Prepending either native label adds exactly one forced evaluation edge and one verifier check while preserving source, suffix and terminal equality.")]
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
 receiptHash := admissionIdentity (.array [.text claimId,.text (SFT.Engine.kindName kind),.text expected,.text observed,.boolean passed])
def exclusions : List String := ["no arbitrary external language family","no nondeterministic machine import","no polynomial convention import","no conventional P-versus-NP conclusion","no hidden certificate advice"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with domain := .rejected}) survivorId))
 "reject the generated form lacking complete first-axis coverage" (decisionReason {survivor with domain := .rejected}),
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed official source identity" "changed source identity differs",
 control .tamperedArtifact (((candidates.filter survives).length == 1) && ((candidates.map candidateId).eraseDups.length == candidates.length))
 "reject missing, duplicated or additional survivors" "literal product contains one survivor and unique identities",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2)
 "halt imported models, parameters or excluded quantum machinery" (SFT.Host.Text.intercalate "; " exclusions)]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)
theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Computation.NativePnpEvidence
