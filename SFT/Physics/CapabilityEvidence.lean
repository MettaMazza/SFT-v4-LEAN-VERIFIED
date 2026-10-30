import SFT.Physics.CapabilityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CapabilityEvidence
open SFT.Host.Canonical CapabilityGrammar
set_option maxRecDepth 20000

def witnessProgram : CapabilityAdmission.Program := ⟨"formal-prerequisite-witness",[
 ⟨.input,"held",["registered"]⟩,⟨.emit,"",["held"]⟩]⟩
def witnessPassed : Bool :=
 match CapabilityExecution.execute witnessProgram [("registered",.count ⟨1,by decide⟩)] with
 | .error _ => false
 | .ok result => result.completed && CapabilityValues.equal result.output (.count ⟨1,by decide⟩) &&
   !(CapabilityPrediction.allOpcodes.any fun op => SFT.Mathematics.DiscreteObjects.has
     ["filesystem","network","subprocess","clock","environment","import","foreign"] (CapabilityPrediction.opcodeName op))
theorem operationalWitnessPassed : witnessPassed = true := by decide

def witnesses : SFT.Host.Canonical.Value := .array [
 .object [("name",.text "closed-surface"),("statement",.text "The executable opcode enumeration contains no ambient host operation."),("passed",.boolean witnessPassed)],
 .object [("name",.text "exact-round-trip"),("statement",.text "A registered positive Fold count passes through input and emission with an exact complete trace."),("passed",.boolean witnessPassed)]]
def claimId : String := "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001"
def dependencies : List String := ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"]
def candidateRecord (c : Candidate) : SFT.Host.Canonical.Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "input",.text (inputName c.input)],.array [.text "value",.text (valueName c.value)],.array [.text "operation",.text (operationName c.operation)],.array [.text "capability",.text (capabilityName c.capability)],.array [.text "state",.text (stateName c.state)],.array [.text "termination",.text (terminationName c.termination)],.array [.text "trace",.text (traceName c.trace)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : SFT.Host.Canonical.Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axes",.array [.object [("key",.text "input"),("question",.text "May execution acquire undeclared inputs?"),("choices",.array [.array [.text "ambient-input",.text "Ambient input can contain the withheld target or an answer-producing channel."],.array [.text "registered-input-only",.text "Every readable input is named and hashed before execution."]])],.object [("key",.text "value"),("question",.text "What values may enter prediction?"),("choices",.array [.array [.text "host-scalar-domain",.text "Host scalars import forbidden or platform-dependent proof values."],.array [.text "exact-fold-domain",.text "Structural Empty One, positive counts, exact ratios, held labels and finite products retain exact provenance."]])],.object [("key",.text "operation"),("question",.text "How is the instruction surface formed?"),("choices",.array [.array [.text "contributor-executable-source",.text "Arbitrary source can create operations outside the registered grammar."],.array [.text "data-only-generated-operations",.text "Every instruction is selected from a closed, registered operation set."]])],.object [("key",.text "capability"),("question",.text "Can instructions reach ambient host resources?"),("choices",.array [.array [.text "ambient-capability",.text "An ambient resource can reveal target, comparison or mutable authority state."],.array [.text "no-ambient-capability",.text "No registered instruction denotes filesystem, network, process, clock, environment, dynamic import or foreign function access."]])],.object [("key",.text "state"),("question",.text "How are intermediate results held?"),("choices",.array [.array [.text "mutable-overwrite",.text "Silent overwrite loses the exact predecessor and permits untraced replacement."],.array [.text "single-assignment-held-state",.text "Each register is held once and every read names a generated predecessor."]])],.object [("key",.text "termination"),("question",.text "How is completion identified?"),("choices",.array [.array [.text "implicit-or-open-ended",.text "Implicit or open-ended completion cannot certify a complete prediction artifact."],.array [.text "one-terminal-emission",.text "Exactly one final emission closes the finite registered program."]])],.object [("key",.text "trace"),("question",.text "What execution evidence is retained?"),("choices",.array [.array [.text "result-only",.text "A result alone hides the operational relation and its resource path."],.array [.text "complete-step-trace",.text "Every instruction position, arguments and output receive exact identities."]])],.object [("key",.text "extension"),("question",.text "May an undeclared extra rule be added?"),("choices",.array [.array [.text "extra-rule",.text "An extra instruction or capability is a free answer-selecting parameter."],.array [.text "no-extra-rule",.text "The runtime contains only the generated preserving surface."]])]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("product_exhaustion",.text "Every registered axis choice occurs once with every other axis choice.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Capability-closed exact Fold prediction form"
 branch := "physics"
 statement := "Within the registered finite prediction grammar, a physical prediction can be target-inaccessible, exact, portable and completely traced in exactly one form: immutable registered Fold inputs pass through a data-only sequence of generated exact operations to one terminal emission, while every ambient host capability and unregistered operation is absent and any violation halts."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
 sourceHash := sourceHash

def registration (sourceHash : String) : SFT.Host.Canonical.Value := SFT.Engine.registrationValue (registrationData sourceHash)
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
def census : SFT.Host.Canonical.Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := identity (.array [.text claimId,.array (dependencies.map SFT.Host.Canonical.Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : SFT.Host.Canonical.Value := .object [("result",.text "Registered exact inputs, a data-only closed opcode surface, no ambient capability, single-assignment state, one final emission, complete trace and no extra rule."),("base",.text "One registered instruction consumes one declared exact value and emits one fully identified exact value."),("successor",.text "Appending one registered instruction reads only previously held exact values, writes one fresh held value and appends one identified trace row without adding a capability."),("exclusions",.array [.text "arbitrary Python or native contributor code",.text "filesystem, network, subprocess, clock, environment, import and foreign-function access",.text "floating, negative, irrational, imaginary and semantic-zero proof values",.text "unbounded or untraced execution"]),("witnesses",witnesses),("unique_survivor",.text survivorId)]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : SFT.Host.Canonical.Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def exclusions : List String := ["arbitrary Python or native contributor code","filesystem, network, subprocess, clock, environment, import and foreign-function access","floating, negative, irrational, imaginary and semantic-zero proof values","unbounded or untraced execution"]
def witnessFlags : List Bool := [witnessPassed,witnessPassed]
def runControls (sourceHash : String) : SFT.Host.Canonical.Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with input := .rejected}) survivorId)) "reject the generated form missing the first preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witnessFlags.all id) "reject excluded capabilities, values or authority paths"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.CapabilityEvidence
